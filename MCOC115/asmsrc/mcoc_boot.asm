// ================================
// Moscovium boot loader
//		(c) 2021	1YEN Toru
//
//		2023/07/08	ver.1.06
//			lsfti -> lsli / lsri
//
//		2021/11/06	ver.1.04
//			corresponding to baud rate detection
//
//		2021/08/14	ver.1.02
//			corresponding to bi-directional port
//
//		2021/06/12	ver.1.00
//
// ================================
asm		"rom_boot_mat.v"
romsiz	256
incl	"mcoc115.incl"
# ================================
# string macros
def		p,""							// pilot led: ""=use / "#"=do not use
def		d,""							// detect baud: ""=use / "#"=do not use
# constants
equ		prog_vers,0x0106				// program version (bcd)
equ		max_lbuf,254					// size of lbuf (<256 & even)
equ		baud,9600						// baud rate
equ		uart_baud,fcpu/baud-1			// uartbaud setting
equ		chr_tab,0x09					// tab code
equ		chr_lf,0x0a						// lf code
equ		chr_cr,0x0d						// cr code
equ		chr_spc,0x20					// space ' ' code
equ		chr_atm,0x40					// at-mark '@' code
# ================================

// register mapping
//		r0: general data
//		r1: read / write pointer for line buffer
//		r2: temporary data for xtoi subroutine
//		r3: temporary data
//		r6: write pointer for writable rom
//		r7: general address pointer
//		sp: pointer to line buffer, stack pointer

// version
bra		pcnt+2
datw	prog_vers

// set sp to the bottom of ram area
ldwi	r7,idrgramt						// idrg: ram top addr.
ldw		r0,[r7]
ldbil	r7,idrgrams						// idrg: ram size
ldw		r7,[r7]
add		r0,r7
subi	r0,max_lbuf						// allocate lbuf
movtc	sp,r0

// uart setting: RXE, baud rate
ldwi	r7,uartbaud
ldwi	r0,uart_baud
stw		[r7],r0
ldbil	r7,uartctl
ldbiu	r0,uart_rxe
stw		[r7],r0


// ================================
// rom data download
ldbiu	r6,0							// reset wptr(=r6)
loop:
$(p)// pilot led
$(p)mov		r3,r6
$(p)lsri	r3,1
$(p)eori	r3,~led_builtin_b
$(p)andi	r3,led_builtin
$(p)ldwi	r2,porout
$(p)stw		[r2],r3
$(p)ldbil	r2,pordir
$(p)ldw		r3,[r2]
$(p)andi	r3,~led_builtin
$(p)stw		[r2],r3

// ================================
// get line from uart
movfc	r1,sp							// r1=lbuf
ldbih	r7,uartctl>>8
gl_loop:
$(d)// check if BRDF=1
$(d)ldbil	r7,uartctl
$(d)ldw		r0,[r7]
$(d)stw		[r7],r0						// clear brdf
$(d)andi	r0,uart_brdf
$(d)beq		gl_not_brdf
$(d)// detected
$(d)ldbil	r7,uartbres
$(d)ldw		r0,[r7]
$(d)ldbil	r7,uartbaud
$(d)ldw		r3,[r7]
$(d)// margin
$(d)mov		r2,r3
$(d)lsri	r2,6
$(d)// r3=abs (r3 - r0)
$(d)sub		r3,r0
$(d)bpl		gl_plus
$(d)neg		r3
$(d)gl_plus:
$(d)cmp		r3,r2
$(d)blo		gl_not_brdf
$(d)// update uartbaud
$(d)stw		[r7],r0
$(d)$(p)// pilot led (detect=red)
$(d)$(p)ldbiu	r3,~led_builtin_r
$(d)$(p)ldwi	r2,porout
$(d)$(p)stw		[r2],r3
$(d)gl_not_brdf:
// polling until RAVL=1
ldbil	r7,uartctl
ldw		r0,[r7]
andi	r0,uart_ravl
beq		gl_loop
// get byte
ldbil	r7,uartrdat
ldw		r0,[r7]
stb		[r1],r0
addi	r1,1
// LF code check
cmpi	r0,chr_lf
beq		gl_got
// size check
movfc	r0,sp
addi	r0,max_lbuf
cmp		r1,r0
blo		gl_loop
subi	r1,1
bra		gl_loop
// got line
gl_got:
// string terminate
ldbiu	r0,0
subi	r1,1
stb		[r1],r0

// ================================
// analyze line buffer
movfc	r1,sp							// r1=lbuf
ldwi	r7,lab_xtoi
loop2:
// skip space
ldb		r0,[r1]
addi	r1,1
cmpi	r0,chr_tab
beq		loop2
cmpi	r0,chr_spc
beq		loop2
mov		r0,r0
beq		loop

// ================================
// @<address>
cmpi	r0,chr_atm
bne		not_atm

// address
jalw	r7								// xtoi()
// set wptr(=r6)
lsli	r0,1
mov		r6,r0
bra		loop2

not_atm:
// ================================
// <word_data>
subi	r1,1
mov		r3,r1
jalw	r7								// xtoi()
cmp		r1,r3
beq		loop							// unrecognized characters

// write data
stw		[r6],r0
// update wdat(=r6)
addi	r6,2
bra		loop2

// ================================
// hexadecimal to integer: r0=xtoi (r1) ; disturbed r1,r2
// ================================
xtoi:
ldbiu	r0,0
// r2=[r1]-'0'
ldb		r2,[r1]
subi	r2,0a0
blo		x2i_finish						// [r1]<'0'
cmpi	r2,10
blo		x2i_next						// [r1]<='9'
subi	r2,(0aA-0x20)-0a0-10
blo		x2i_finish						// [r1]<'A'
cmpi	r2,16
blo		x2i_next						// [r1]<='F'
subi	r2,0aa-(0aA-0x20)
blo		x2i_finish						// [r1]<'a'
cmpi	r2,16
bhs		x2i_finish						// [r1]>'f'
x2i_next:
// r0=16*r0+r2
lsli	r0,4
add		r0,r2
// end of loop
addi	r1,1
bra		xtoi+2
x2i_finish:
rtnw

