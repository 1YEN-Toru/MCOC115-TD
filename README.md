--------
# MCOC115-TD
 This is Moscovium series MCU projects for Sipeed Lichee Tang Primer FPGA board.

- Anlogic TD IDE project
- Development on this FPGA board (**Primer**) has been **frozen**.
	- Development is **progressing** on another FPGA board (**Cmod A7**).
	- See [MCOC115-VD](https://github.com/1YEN-Toru/MCOC115-VD) repository.
- MCOC: Moscovium (Mc) On Chip
	- 115 is the atomic number of Mc (Moscovium).
	- 117 for Ts (Tennessine), 113 for Nh (Nihonium).

## Moscovium series
 Moscovium is an original 16 bit CPU core.

 More options for the Moscovium series here:

1. Tennessine
	- 8 bit data path
2. Moscovium
	- 16 bit data path
3. Moscovium-SS
	- 16 bit data path x2
	- Super Scalar
4. Nihonium
	- 32 bit data path
5. Nihonium-SS
	- 32 bit data path x2
	- Super Scalar

 Moscovium series CPU cores are scalable from 8 ~ 32 bit data paths.

- The order listed above is roughly a trade-off between performance and size (LUTs).
	- Lower performance takes smaller size.
	- Higher performance takes larger size.

--------
# Directories and Files

- README.md
	- This article.
- [MCOC115](MCOC115)/
	- Anlogic TD IDE's project directory
		- al_ip/
			- Anlogic IP files
		- asmsrc/
			- Assembler and sample sources
		- ip/
			- IP units
		- simulation/
			- Test bench for logic simulation
		- top/
			- Top level modules
		- *.al
			- TD IDE's project file
			- See MCU edition table [MCOC_edition.png](MCOC_edition.png).
- [LIBAL](LIBAL)/
	- Anlogic TD IDE cell library
		- al/
		- ef2/
		- ef3/
		- eg/
		- elf/

## Anlogic TD IDE cell library

### Copy:
 Copy all the files under "sim/" in the TD IDE installation directory to "LIBAL/" by yourself.

- \<InstallDir\>/Anlogic/TD4.6.4/sim/  ==copy=>  LIBAL/
	- al/
	- ef2/
	- ef3/
	- eq/
	- elf/

 For details in Japanese, please see the following URL.

- http://hello.world.coocan.jp/ARDUINO15/arduino15_8.html#SIMCT

### Modify:
 Comment out "`resetall" directive at the beginning of following files.

- LIBAL/al/al_map_addr.v
- LIBAL/al/al_map_mux4.v

--------
# IP Units
 See MCU edition table [MCOC_edition.png](MCOC_edition.png) first.

 All links point to Japanese pages.

## CPU core
- [Moscovium](http://hello.world.coocan.jp/ARDUINO/index.html#RI_MCVM)
	- Original 16 bit CPU core
- [Moscovium-SS](http://hello.world.coocan.jp/ARDUINO/index.html#RI_SPRSCL)
	- Original 16 bit CPU core
	- Super Scalar edition
- [Nihonium](http://hello.world.coocan.jp/ARDUINO/index.html#RI_NIHO)
	- Original 32 bit CPU core
- [Nihonium-SS](http://hello.world.coocan.jp/ARDUINO/index.html#RI_SPRSCL)
	- Original 32 bit CPU core
	- Super Scalar edition
- [Tennessine](http://hello.world.coocan.jp/ARDUINO/index.html#RI_TNSN)
	- Original 8 bit CPU core

## Coprocessor
- [MULC16](http://hello.world.coocan.jp/ARDUINO16/arduino16_2.html#FLSHMUL)
	- Multiply coprocessor
		- for Moscovium / Moscovium-SS
	- 16 * 16 = 32 bit multiply, signed and unsigned
- [DIVC32](http://hello.world.coocan.jp/ARDUINO16/arduino16_3.html#HYBDIV)
	- Divide coprocessor
		- for Moscovium / Moscovium-SS
	- 16 / 16 = 16 ... 16 bit divide, signed and unsigned
	- 32 / 32 = 32 ... 32 bit divide, signed and unsigned
- [HALFPU](http://hello.world.coocan.jp/ARDUINO16/arduino16_5.html)
	- 16 bit half precision Floating Point Unit (FPU)
		- for Moscovium / Moscovium-SS / Nihonium / Nihonium-SS
- [SGLFPU](http://hello.world.coocan.jp/ARDUINO24/arduino24_5.html)
	- 32 bit single precision Floating Point Unit (FPU)
		- for Nihonium / Nihonium-SS

## System units
- [BUSC2040DL](http://hello.world.coocan.jp/ARDUINO17/arduino17_1.html#DUALBUSC)
	- Bus state controller
	- 24 bit address area, 16 / 32 bit data bus
- [INTC322DVL](http://hello.world.coocan.jp/ARDUINO23/arduino23_2.html#INTC322DVL)
	- Interrupt controller
	- 4 level vector interrupt
- [CACHE2W4K](http://hello.world.coocan.jp/ARDUINO20/arduino20_1.html)
	- Cache memory controller
	- 2 way set associative, 4K byte, LFU, write through

## Timer units
- [SYSTIM](http://hello.world.coocan.jp/ARDUINO15/arduino15_7.html#MCOCSYTM)
	- System timer unit
	- Millisecond, microsecond and clock counter
- [TIM162](http://hello.world.coocan.jp/ARDUINO15/arduino15_a.html#TIM16)
	- 16 bit PWM timer unit
	- 2 PWM output
- [RTC400](http://hello.world.coocan.jp/ARDUINO22/arduino22_a.html#RTC400)
	- Real time clock unit
	- Full 400 years of leap year support

## Communication units
- [UART8N1](http://hello.world.coocan.jp/ARDUINO15/arduino15_7.html#MCOCUART)
	- UART unit
	- Format: 8N1 (8 bit data, no parity, 1 stop bit)
- [STWSER](http://hello.world.coocan.jp/ARDUINO17/arduino17_5.html#STWSER)
	- Synchronous two wire serial unit (I2C)
	- Master and slave communication

## I/O units
- [PORT8I8O](http://hello.world.coocan.jp/ARDUINO15/arduino15_7.html#MCOCPORT)
	- General I/O port unit
- [IOMEM16](http://hello.world.coocan.jp/ARDUINO24/arduino24_9.html#IOMEM16)
	- 16 byte I/O memory (RAM) unit
- [SEMPH5R9U](http://hello.world.coocan.jp/ARDUINO17/arduino17_2.html#SEMPH5R12U)
	- Semaphore unit
- [ICFF16](http://hello.world.coocan.jp/ARDUINO17/arduino17_3.html#ICFF16)
	- Intercommunication FIFO unit
- [LOGA8CH](http://hello.world.coocan.jp/ARDUINO16/arduino16_4.html#LOGA8CH)
	- Logic analyzer accelerator unit
- [FONTJP](http://hello.world.coocan.jp/ARDUINO18/arduino18_4.html#FONTJP)
	- Japanese font unit
- [ADC124](http://hello.world.coocan.jp/ARDUINO19/arduino19_6.html#ADC124)
	- 12 bit SAR A/D converter unit
- [DAC121](http://hello.world.coocan.jp/ARDUINO24/arduino24_2.html#DAC121)
	- 12 bit delta-sigma D/A converter unit
- [UNISJI](http://hello.world.coocan.jp/ARDUINO22/arduino22_1.html#UNISJI)
	- Unicode and S-JIS conversion unit
- [DISTUS](http://hello.world.coocan.jp/ARDUINO22/arduino22_4.html#DISTUS)
	- Distance measuring by ultrasonic sensor unit

## Memory units
- [ROM](http://hello.world.coocan.jp/ARDUINO20/arduino20_8.html#ROM32)
	- Instruction ROM unit
- [IRAM](http://hello.world.coocan.jp/ARDUINO18/arduino18_7.html#IRAM)
	- Instruction RAM unit
- [RAM](http://hello.world.coocan.jp/ARDUINO24/arduino24_9.html#RAMMCR)
	- Main memory (RAM) unit
- [SDRAM8M](http://hello.world.coocan.jp/ARDUINO19/arduino19_9.html)
	- Builtin SDRAM unit

--------
# Download
 Select "<>Code => Local => Download ZIP".

 Unzip down loaded file.

--------
# Documents
 You can see documentation in Japanese from links below.

1. Moscovium series MCU (http://hello.world.coocan.jp/ARDUINO15/a153_instset.html#LINEUP)
	- Instruction set manual (http://hello.world.coocan.jp/ARDUINO15/a153_instset.html#MANTOP)
	- FPGA board pin assignment (http://hello.world.coocan.jp/ARDUINO15/a153_mcoc115.html)
	- Simulation (http://hello.world.coocan.jp/ARDUINO15/arduino15_1.html#VERILOG)
	- Programming \(configure\) to FPGA board (http://hello.world.coocan.jp/ARDUINO15/a153_design.html#BURNFPGA)
2. FPGA board
	- Sipeed Lichee Tang Primer (https://tang.sipeed.com/en/)
	- Anlogic EG4S20 FPGA chip (https://tang.sipeed.com/en/hardware-overview/lichee-tang/)

--------
# Disclaimer
 All data in this repository are unsupported and unguaranteed.

 Use at your own risk.

--------
