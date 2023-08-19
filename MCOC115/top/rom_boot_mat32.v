module	rom_boot_mat32 (
	fcmdl,
	adr,
	dat,
	romsiz);

// boot rom 32 bit
input	fcmdl;
input	[7:0]	adr;
output	[31:0]	dat;
output	[15:0]	romsiz;


wire	[15:0]	rom_dath;
wire	[15:0]	rom_datl;
wire	[15:0]	romsiz_open;


`ifdef		MCOC_CORE_TS
// boot rom: 16 bit * 2
rom_boot_mat_ts		rombt_h (
	.adr(adr[7:0] & (~8'h1)),	// Input
	.dat(rom_dath[15:0]),	// Output
	.romsiz(romsiz_open[15:0])	// Output
);

rom_boot_mat_ts		rombt_l (
	.adr(adr[7:0] | ((fcmdl)? 8'h1: 8'h0)),	// Input
	.dat(rom_datl[15:0]),	// Output
	.romsiz(romsiz[15:0])	// Output
);
`else	//	MCOC_CORE_TS
// boot rom: 16 bit * 2
rom_boot_mat	rombt_h (
	.adr(adr[6:0] & (~7'h1)),	// Input
	.dat(rom_dath[15:0]),	// Output
	.romsiz(romsiz_open[15:0])	// Output
);

rom_boot_mat	rombt_l (
	.adr(adr[6:0] | ((fcmdl)? 7'h1: 7'h0)),	// Input
	.dat(rom_datl[15:0]),	// Output
	.romsiz(romsiz[15:0])	// Output
);
`endif	//	MCOC_CORE_TS

// rom data
assign	dat[31:0]=(fcmdl)?
		{ rom_dath[15:0],rom_datl[15:0] }:
		{ 16'h0,rom_datl[15:0] };

endmodule
