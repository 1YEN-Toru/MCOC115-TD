`timescale	1ns / 1ns


`define		SIMULATION
`define		SIM_CORE_TS
//`define		SIM_CORE_NH
//`define		SIM_CORE_NHSS				// need "`define SIM_CORE_NH" too
//`define		SIM_CORE_MCSS
//`define		SIM_CORE_RMDC				// $readmemh() for dual core
//`define		SIM_FNJP_ROM
//`define		SIM_UNSJ_ROM


module	test;

reg		clk;
reg		reset_n;
reg		bootr_n;
reg		uart_rxd;
reg		uar1_rxd;
reg		uar1_cts;
reg		intc_int0;
reg		intc_int1;
reg		[15:0]	port_iop_d;
reg		[15:0]	user_iop_d;
wire	[15:0]	port_iop=port_iop_d[15:0];
wire	[15:0]	user_iop=user_iop_d[15:0];
tri1	stws_scl;
tri1	stws_sda;


// toggle clk every 20ns
always
	begin
		clk=1'b1;
		#20;
		clk=1'b0;
		#20;
	end

// stimulus
initial
	begin
`ifdef		SIM_CORE_TS
		$dumpfile ("test_ts.vcd");
`elsif		SIM_CORE_NHSS
		$dumpfile ("test_ss.vcd");
`elsif		SIM_CORE_NH
		$dumpfile ("test_nh.vcd");
`elsif		SIM_CORE_MCSS
		$dumpfile ("test_ms.vcd");
`else
		$dumpfile ("test.vcd");
`endif
		$dumpvars (0, test);
		$readmemh ("mcoc_irom.mem", top.rom.romwr.inst.memory);
`ifdef		SIM_CORE_RMDC
		$readmemh ("mcoc_irom.mem", top.rom.romwr2.inst.memory);
`endif	//	SIM_CORE_RMDC
`ifdef		SIM_FNJP_ROM
		$readmemh ("fontjp.mem", top.fnjp.from.inst.memory);
`endif	//	SIM_FNJP_ROM
`ifdef		SIM_UNSJ_ROM
		$readmemh ("unisji.mem", top.unsj.ulut.inst.memory);
`endif	//	SIM_UNSJ_ROM
		$timeformat (-9,0,"",8);

		// init
		bootr_n=1'b1;
		intc_int0=1'b1;
		intc_int1=1'b1;
		uart_rxd=1'b1;
		uar1_rxd=1'b1;
		uar1_cts=1'b1;
		port_iop_d[15:0]=16'hz;
		user_iop_d[15:0]=16'hz;

		// reset
		reset_n=1'b0;
		#250;
		reset_n=1'b1;
		#250;

		// simulation continues until writing bdatw[15]=1 to badr=16'hf028
		repeat (8)
			@(posedge clk);
		while (top.badr[15:0]!=16'hf028 || top.bdatw[15]!=1'b1)
			@(posedge clk);
		// confirm pass code
		if (top.bdatw[7:0]==8'h06)
			$display ("Test Pass");
		else if (top.bdatw[7:0]==8'h33)
			$display ("Test Finish, you need verify waveform.");
		else
			$display ("Test Fail");

		// finish simulation
		repeat (8)
			@(posedge clk);
		$display ("finish: %t ns",$stime);
		$finish;
	end

// simulation control
reg		[15:0]	simctrl;
always	@(posedge clk)
	begin
		if (!reset_n)
			simctrl[15:0]<=16'h0;
		else if (top.brdy && top.bcmd[1] && top.badr[15:0]==16'hf00a)
			simctrl[15:0]<=top.bdatw[15:0];
	end

// force simulation stop by time out
always
	begin
		repeat (10_000)
			@(posedge clk);
		if (!simctrl[0])
			begin
				$display ("Simulation stop due to time out");
				$finish;
			end
	end

// uart local loop back
always	@uart_txd
	uart_rxd<=uart_txd;

// interrupt request
reg		[3:0]	irq_pin;
reg		[7:0]	irq_wait;
always	@(posedge clk)
	begin
		irq_pin[3:0]<={ top.bdatw[13:12],top.bdatw[9:8] };
		irq_wait[7:0]<=top.bdatw[7:0];
		if (top.brdy && top.bcmd[1] && top.badr[15:0]==16'hf000)
			begin
				@(posedge clk);
				repeat (irq_wait[7:0])
					@(posedge clk);
				if (irq_pin[3])
					intc_int1<=irq_pin[1];
				if (irq_pin[2])
					intc_int0<=irq_pin[0];
			end
	end

// i/o port driver
reg		port_chg;
reg		user_chg;
reg		[15:0]	port_dir;
reg		[15:0]	port_ind;
reg		[15:0]	user_dir;
reg		[15:0]	user_ind;
initial
	begin
		port_dir[15:0]=16'h0;
		port_ind[15:0]=16'h0;
		user_dir[15:0]=16'h0;
		user_ind[15:0]=16'h0;
	end
always	@(posedge clk)
	begin
		port_chg=1'b0;
		// port direction
		if (top.brdy && top.bcmd[1] && top.badr[15:0]==16'hf002)
			begin
				port_chg=1'b1;
				port_dir[15:0]<=top.bdatw[15:0];
			end
		// port input
		if (top.brdy && top.bcmd[1] && top.badr[15:0]==16'hf004)
			begin
				port_chg=1'b1;
				port_ind[15:0]<=top.bdatw[15:0];
			end
		// user direction
		if (top.brdy && top.bcmd[1] && top.badr[15:0]==16'hf006)
			begin
				user_chg=1'b1;
				user_dir[15:0]<=top.bdatw[15:0];
			end
		// user input
		if (top.brdy && top.bcmd[1] && top.badr[15:0]==16'hf008)
			begin
				user_chg=1'b1;
				user_ind[15:0]<=top.bdatw[15:0];
			end

		// driver
		if (port_chg)
			begin
				#1;
				port_iop_d[15]<=(port_dir[15])? port_ind[15]: 1'bz;
				port_iop_d[14]<=(port_dir[14])? port_ind[14]: 1'bz;
				port_iop_d[13]<=(port_dir[13])? port_ind[13]: 1'bz;
				port_iop_d[12]<=(port_dir[12])? port_ind[12]: 1'bz;
				port_iop_d[11]<=(port_dir[11])? port_ind[11]: 1'bz;
				port_iop_d[10]<=(port_dir[10])? port_ind[10]: 1'bz;
				port_iop_d[9]<=(port_dir[9])? port_ind[9]: 1'bz;
				port_iop_d[8]<=(port_dir[8])? port_ind[8]: 1'bz;
				port_iop_d[7]<=(port_dir[7])? port_ind[7]: 1'bz;
				port_iop_d[6]<=(port_dir[6])? port_ind[6]: 1'bz;
				port_iop_d[5]<=(port_dir[5])? port_ind[5]: 1'bz;
				port_iop_d[4]<=(port_dir[4])? port_ind[4]: 1'bz;
				port_iop_d[3]<=(port_dir[3])? port_ind[3]: 1'bz;
				port_iop_d[2]<=(port_dir[2])? port_ind[2]: 1'bz;
				port_iop_d[1]<=(port_dir[1])? port_ind[1]: 1'bz;
				port_iop_d[0]<=(port_dir[0])? port_ind[0]: 1'bz;
			end
		if (user_chg)
			begin
				#1;
				user_iop_d[15]<=(user_dir[15])? user_ind[15]: 1'bz;
				user_iop_d[14]<=(user_dir[14])? user_ind[14]: 1'bz;
				user_iop_d[13]<=(user_dir[13])? user_ind[13]: 1'bz;
				user_iop_d[12]<=(user_dir[12])? user_ind[12]: 1'bz;
				user_iop_d[11]<=(user_dir[11])? user_ind[11]: 1'bz;
				user_iop_d[10]<=(user_dir[10])? user_ind[10]: 1'bz;
				user_iop_d[9]<=(user_dir[9])? user_ind[9]: 1'bz;
				user_iop_d[8]<=(user_dir[8])? user_ind[8]: 1'bz;
				user_iop_d[7]<=(user_dir[7])? user_ind[7]: 1'bz;
				user_iop_d[6]<=(user_dir[6])? user_ind[6]: 1'bz;
				user_iop_d[5]<=(user_dir[5])? user_ind[5]: 1'bz;
				user_iop_d[4]<=(user_dir[4])? user_ind[4]: 1'bz;
				user_iop_d[3]<=(user_dir[3])? user_ind[3]: 1'bz;
				user_iop_d[2]<=(user_dir[2])? user_ind[2]: 1'bz;
				user_iop_d[1]<=(user_dir[1])? user_ind[1]: 1'bz;
				user_iop_d[0]<=(user_dir[0])? user_ind[0]: 1'bz;
			end
	end

// half handling
real	rx;
task	fpu_half2real;
input	[15:0]	hx;
reg		sx;
reg		signed	[4:0]	ex;
reg		[10:0]	fx;
real	rinf;
real	rnan;
	begin
		// half hx[15:0] to real rx conversion
		rinf=1.0/0.0;
		rnan=0.0/0.0;

		// conversion
		if (hx[14:10]==5'h0)
			begin
				// zero
				rx=0.0;
			end
		else if (hx[14:10]==5'h1f)
			begin
				// inf or nan
				if (hx[9:0]==10'h0)
					rx=rinf;
				else
					rx=rnan;
			end
		else
			begin
				// not zero
				sx=hx[15];
				ex[4:0]=hx[14:10] - 5'd15;
				fx[10:0]={ 1'b1,hx[9:0] };
				rx=fx[10:0];
				if (ex<5'sd0)
					rx=rx/32'h400/(32'h1<<(-ex));
				else
					rx=rx/32'h400*(32'h1<<ex);
			end
		if (hx[15])
			rx=-rx;
	end
endtask

// float handling
task	fpu_sngl2real;
input	[31:0]	hx;
reg		sx;
reg		signed	[7:0]	ex;
reg		[23:0]	fx;
real	rinf;
real	rnan;
	begin
		// float hx[31:0] to real rx conversion
		rinf=1.0/0.0;
		rnan=0.0/0.0;

		// conversion
		if (hx[30:23]==8'h0)
			begin
				// zero
				rx=0.0;
			end
		else if (hx[30:23]==8'hff)
			begin
				// inf or nan
				if (hx[22:0]==23'h0)
					rx=rinf;
				else
					rx=rnan;
			end
		else
			begin
				// not zero
				sx=hx[31];
				ex[7:0]=hx[30:23] - 8'd127;
				fx[23:0]={ 1'b1,hx[22:0] };
				rx=fx[23:0];
				rx=rx/32'h0080_0000*(2.0**ex);
			end
		if (hx[31])
			rx=-rx;
	end
endtask

// print unit
reg		[15:0]	prin_ctl;				// [term chr], -,-,-,-, -,FLT,DEC,NLD
reg		[15:0]	prin_hxlh;
always	@(posedge clk)
	begin
		if (!reset_n)
			prin_ctl[15:0]=16'h0;
		else if (top.brdy && top.bcmd[1])
			begin
				if (top.badr[15:0]==16'hfff0)
					begin
						// print control
						if (top.bcmd[2])
							begin
								prin_ctl[15:8]=top.bdatw[15:8];
								if (prin_ctl[15:8]!=8'h0)
									prin_ctl[0]=1'b1;
							end
						else
							prin_ctl[15:0]=top.bdatw[15:0];
					end
				else if (top.badr[15:0]==16'hfff2)
					begin
						// print character
						if (top.bdatw[7:0]!=8'h0 && top.bdatw[7:0]!=8'h0d)
							$write ("%s",top.bdatw[7:0]);
					end
				else if (top.badr[15:0]==16'hfff4)
					begin
						// print decimal
						if (top.bcmd[2])
							$write ("%d",top.bdatw[7:0]);
						else
							$write ("%d",top.bdatw[15:0]);
						if (prin_ctl[15:8]!=8'h0)
							$write ("%s",prin_ctl[15:8]);
						if (!prin_ctl[0])
							$display ("");
					end
				else if (top.badr[15:0]==16'hfff6)
					begin
						// print hexadecimal
						if (top.bcmd[2])
							$write ("%h",top.bdatw[7:0]);
						else
							$write ("%h",top.bdatw[15:0]);
						if (prin_ctl[15:8]!=8'h0)
							$write ("%s",prin_ctl[15:8]);
						if (!prin_ctl[0])
							$display ("");
					end
				else if (top.badr[15:0]==16'hfff8)
					begin
						if (prin_ctl[3:2])
							begin
								// print float high
								prin_hxlh[15:0]=top.bdatw[15:0];
							end
						else
							begin
								// print half floating point
								fpu_half2real (top.bdatw[15:0]);
								if (top.bdatw[15:0]==16'h8000)
									$write ("-0.000000");
								else
									$write ("%f",rx);
								if (prin_ctl[15:8]!=8'h0)
									$write ("%s",prin_ctl[15:8]);
								if (!prin_ctl[0])
									$display ("");
							end
					end
				else if (top.badr[15:0]==16'hfffa)
					begin
						// print float
						fpu_sngl2real ({ prin_hxlh[15:0],top.bdatw[15:0] });
						if (prin_hxlh[15:0]==16'h8000)
							$write ("-0.000000");
						else if (prin_ctl[3:2]==2'b01)
							$write ("%f",rx);
						else if (prin_ctl[3:2]==2'b10)
							$write ("%e",rx);
						else if (prin_ctl[3:2]==2'b11)
							$write ("%g",rx);
						else	// never occure
							$write ("%h",{ prin_hxlh[15:0],top.bdatw[15:0] });
						if (prin_ctl[15:8]!=8'h0)
							$write ("%s",prin_ctl[15:8]);
						if (!prin_ctl[0])
							$display ("");
					end
				else if (top.badr[15:0]==16'hfffc)
					begin
						// print hexadecimal long high
						prin_hxlh[15:0]=top.bdatw[15:0];
					end
				else if (top.badr[15:0]==16'hfffe)
					begin
						// print hexadecimal long
						if (prin_ctl[1])
							$write ("%d",{ prin_hxlh[15:0],top.bdatw[15:0] });
						else
							$write ("%h",{ prin_hxlh[15:0],top.bdatw[15:0] });
						if (prin_ctl[15:8]!=8'h0)
							$write ("%s",prin_ctl[15:8]);
						if (!prin_ctl[0])
							$display ("");
					end
			end
	end

// rtc external clock input
parameter	rtc_clk_half=40*80/2;
always
	begin
		if (simctrl[1]===1'b1)
			begin
				port_iop_d[3]<=1'b1;
				#(rtc_clk_half);
				port_iop_d[3]<=1'b0;
				#(rtc_clk_half);
			end
		else
			begin
				@(posedge clk);
				port_iop_d[3]<=1'bz;
			end
	end


// DUT
`ifdef		SIM_CORE_TS
tsoc117mn0408	top (
`elsif		SIM_CORE_NHSS
nsoc113md0816	top (
`elsif		SIM_CORE_NH
nhoc113lb4408	top (
`elsif		SIM_CORE_MCSS
`ifdef		SIM_CORE_RMDC
msoc115dc0416	top (
`else	//	SIM_CORE_RMDC
msoc115ls0808	top (
`endif	//	SIM_CORE_RMDC
`else
`ifdef		SIM_CORE_RMDC
mcoc115dc0416	top (
`else	//	SIM_CORE_RMDC
mcoc115cp0408	top (
`endif	//	SIM_CORE_RMDC
`endif
	.clk(clk),	// Input
	.reset_n(reset_n),	// Input
	.bootr_n(bootr_n),	// Input
	.uart_rxd(uart_rxd),	// Input
	.uar1_rxd(uar1_rxd),	// Input
	.uar1_cts(uar1_cts),	// Input
	.intc_int0(intc_int0),	// Input
	.intc_int1(intc_int1),	// Input
	.stws_scl(stws_scl),	// Inout
	.stws_sda(stws_sda),	// Inout
	.port_iop(port_iop[15:0]),	// Inout
	.user_iop(user_iop[15:0]),	// Inout
	.uart_txd(uart_txd),	// Output
	.uar1_txd(uar1_txd),	// Output
	.uar1_rts(uar1_rts),	// Output
	.tim0_pwma(tim0_pwma),	// Output
	.tim0_pwmb(tim0_pwmb),	// Output
	.tim1_pwma(tim1_pwma),	// Output
	.tim1_pwmb(tim1_pwmb)	// Output
);


// simulation convenience
`ifdef		SIM_CORE_TS
// Tennessine general register value
wire	[15:0]	r0=top.cpu.core.\rgf/bank/gr00 [15:0];
wire	[15:0]	r1=top.cpu.core.\rgf/bank/gr01 [15:0];
wire	[15:0]	r2=top.cpu.core.\rgf/bank/gr02 [15:0];
wire	[15:0]	r3=top.cpu.core.\rgf/bank/gr03 [15:0];
wire	[15:0]	r4=top.cpu.core.\rgf/bank/gr04 [15:0];
wire	[15:0]	r5=top.cpu.core.\rgf/bank/gr05 [15:0];
wire	[15:0]	r6=top.cpu.core.\rgf/bank/gr06 [15:0];
wire	[15:0]	r7=top.cpu.core.\rgf/bank/gr07 [15:0];
`elsif		SIM_CORE_NH
// Nihonium general register value with bank selection
wire	[1:0]	bank=top.cpu.core.\rgf/sr_bank [1:0];
wire	[31:0]	r0=
		(bank[0]===1'b0)? {
			top.cpu.core.\rgf/bank02/gr20 [15:0],
			top.cpu.core.\rgf/bank02/gr00 [15:0] }:
		(bank[0]===1'b1)? {
			top.cpu.core.\rgf/bank13/gr20 [15:0],
			top.cpu.core.\rgf/bank13/gr00 [15:0] }:
		32'hx;
wire	[31:0]	r1=
		(bank[0]===1'b0)? {
			top.cpu.core.\rgf/bank02/gr21 [15:0],
			top.cpu.core.\rgf/bank02/gr01 [15:0] }:
		(bank[0]===1'b1)? {
			top.cpu.core.\rgf/bank13/gr21 [15:0],
			top.cpu.core.\rgf/bank13/gr01 [15:0] }:
		32'hx;
wire	[31:0]	r2=
		(bank[0]===1'b0)? {
			top.cpu.core.\rgf/bank02/gr22 [15:0],
			top.cpu.core.\rgf/bank02/gr02 [15:0] }:
		(bank[0]===1'b1)? {
			top.cpu.core.\rgf/bank13/gr22 [15:0],
			top.cpu.core.\rgf/bank13/gr02 [15:0] }:
		32'hx;
wire	[31:0]	r3=
		(bank[0]===1'b0)? {
			top.cpu.core.\rgf/bank02/gr23 [15:0],
			top.cpu.core.\rgf/bank02/gr03 [15:0] }:
		(bank[0]===1'b1)? {
			top.cpu.core.\rgf/bank13/gr23 [15:0],
			top.cpu.core.\rgf/bank13/gr03 [15:0] }:
		32'hx;
wire	[31:0]	r4=
		(bank[0]===1'b0)? {
			top.cpu.core.\rgf/bank02/gr24 [15:0],
			top.cpu.core.\rgf/bank02/gr04 [15:0] }:
		(bank[0]===1'b1)? {
			top.cpu.core.\rgf/bank13/gr24 [15:0],
			top.cpu.core.\rgf/bank13/gr04 [15:0] }:
		32'hx;
wire	[31:0]	r5=
		(bank[0]===1'b0)? {
			top.cpu.core.\rgf/bank02/gr25 [15:0],
			top.cpu.core.\rgf/bank02/gr05 [15:0] }:
		(bank[0]===1'b1)? {
			top.cpu.core.\rgf/bank13/gr25 [15:0],
			top.cpu.core.\rgf/bank13/gr05 [15:0] }:
		32'hx;
wire	[31:0]	r6=
		(bank[0]===1'b0)? {
			top.cpu.core.\rgf/bank02/gr26 [15:0],
			top.cpu.core.\rgf/bank02/gr06 [15:0] }:
		(bank[0]===1'b1)? {
			top.cpu.core.\rgf/bank13/gr26 [15:0],
			top.cpu.core.\rgf/bank13/gr06 [15:0] }:
		32'hx;
wire	[31:0]	r7=
		(bank[0]===1'b0)? {
			top.cpu.core.\rgf/bank02/gr27 [15:0],
			top.cpu.core.\rgf/bank02/gr07 [15:0] }:
		(bank[0]===1'b1)? {
			top.cpu.core.\rgf/bank13/gr27 [15:0],
			top.cpu.core.\rgf/bank13/gr07 [15:0] }:
		32'hx;
`else
// Moscovium general register value with bank selection
wire	[1:0]	bank=top.cpu.core.\rgf/sr_bank [1:0];
wire	[15:0]	r0=
		(bank[1:0]===2'h0)? top.cpu.core.\rgf/bank02/gr00 [15:0]:
		(bank[1:0]===2'h1)? top.cpu.core.\rgf/bank13/gr00 [15:0]:
		(bank[1:0]===2'h2)? top.cpu.core.\rgf/bank02/gr20 [15:0]:
		(bank[1:0]===2'h3)? top.cpu.core.\rgf/bank13/gr20 [15:0]:
		16'hx;
wire	[15:0]	r1=
		(bank[1:0]===2'h0)? top.cpu.core.\rgf/bank02/gr01 [15:0]:
		(bank[1:0]===2'h1)? top.cpu.core.\rgf/bank13/gr01 [15:0]:
		(bank[1:0]===2'h2)? top.cpu.core.\rgf/bank02/gr21 [15:0]:
		(bank[1:0]===2'h3)? top.cpu.core.\rgf/bank13/gr21 [15:0]:
		16'hx;
wire	[15:0]	r2=
		(bank[1:0]===2'h0)? top.cpu.core.\rgf/bank02/gr02 [15:0]:
		(bank[1:0]===2'h1)? top.cpu.core.\rgf/bank13/gr02 [15:0]:
		(bank[1:0]===2'h2)? top.cpu.core.\rgf/bank02/gr22 [15:0]:
		(bank[1:0]===2'h3)? top.cpu.core.\rgf/bank13/gr22 [15:0]:
		16'hx;
wire	[15:0]	r3=
		(bank[1:0]===2'h0)? top.cpu.core.\rgf/bank02/gr03 [15:0]:
		(bank[1:0]===2'h1)? top.cpu.core.\rgf/bank13/gr03 [15:0]:
		(bank[1:0]===2'h2)? top.cpu.core.\rgf/bank02/gr23 [15:0]:
		(bank[1:0]===2'h3)? top.cpu.core.\rgf/bank13/gr23 [15:0]:
		16'hx;
wire	[15:0]	r4=
		(bank[1:0]===2'h0)? top.cpu.core.\rgf/bank02/gr04 [15:0]:
		(bank[1:0]===2'h1)? top.cpu.core.\rgf/bank13/gr04 [15:0]:
		(bank[1:0]===2'h2)? top.cpu.core.\rgf/bank02/gr24 [15:0]:
		(bank[1:0]===2'h3)? top.cpu.core.\rgf/bank13/gr24 [15:0]:
		16'hx;
wire	[15:0]	r5=
		(bank[1:0]===2'h0)? top.cpu.core.\rgf/bank02/gr05 [15:0]:
		(bank[1:0]===2'h1)? top.cpu.core.\rgf/bank13/gr05 [15:0]:
		(bank[1:0]===2'h2)? top.cpu.core.\rgf/bank02/gr25 [15:0]:
		(bank[1:0]===2'h3)? top.cpu.core.\rgf/bank13/gr25 [15:0]:
		16'hx;
wire	[15:0]	r6=
		(bank[1:0]===2'h0)? top.cpu.core.\rgf/bank02/gr06 [15:0]:
		(bank[1:0]===2'h1)? top.cpu.core.\rgf/bank13/gr06 [15:0]:
		(bank[1:0]===2'h2)? top.cpu.core.\rgf/bank02/gr26 [15:0]:
		(bank[1:0]===2'h3)? top.cpu.core.\rgf/bank13/gr26 [15:0]:
		16'hx;
wire	[15:0]	r7=
		(bank[1:0]===2'h0)? top.cpu.core.\rgf/bank02/gr07 [15:0]:
		(bank[1:0]===2'h1)? top.cpu.core.\rgf/bank13/gr07 [15:0]:
		(bank[1:0]===2'h2)? top.cpu.core.\rgf/bank02/gr27 [15:0]:
		(bank[1:0]===2'h3)? top.cpu.core.\rgf/bank13/gr27 [15:0]:
		16'hx;
`endif

// bus master (cpu id)
wire	[31:0]		cpuid=
		(top.brdy && top.bcmd[1:0]!=2'b00)?
			((top.bmst)?
				32'h43505532:
				32'h43505530 + top.cpuid1[1:0]):
			32'h0;

endmodule

