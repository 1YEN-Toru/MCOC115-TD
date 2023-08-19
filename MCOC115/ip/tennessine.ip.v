
`timescale 1ns / 1ps
module tennessine  // rtl/tennessine.v(1)
  (
  bdatr,
  brdy,
  clk,
  cpuid,
  fdat,
  irq,
  irq_lev,
  irq_vec,
  rst_n,
  badr,
  bcmd,
  bdatw,
  fadr
  );
//
//	Tennessine 8 bit CPU core
//		(c) 2023	1YEN Toru
//
//
//	2023/07/08	ver.1.00
//

  input [15:0] bdatr;  // rtl/tennessine.v(25)
  input brdy;  // rtl/tennessine.v(19)
  input clk;  // rtl/tennessine.v(17)
  input [1:0] cpuid;  // rtl/tennessine.v(21)
  input [15:0] fdat;  // rtl/tennessine.v(24)
  input irq;  // rtl/tennessine.v(20)
  input [1:0] irq_lev;  // rtl/tennessine.v(22)
  input [5:0] irq_vec;  // rtl/tennessine.v(23)
  input rst_n;  // rtl/tennessine.v(18)
  output [15:0] badr;  // rtl/tennessine.v(28)
  output [2:0] bcmd;  // rtl/tennessine.v(27)
  output [15:0] bdatw;  // rtl/tennessine.v(29)
  output [15:0] fadr;  // rtl/tennessine.v(26)

  wire [15:0] abus;  // rtl/tennessine.v(55)
  wire [3:0] \alu/alu_sr_flag_art ;  // rtl/tnsn_alu.v(20)
  wire [3:0] \alu/art/alu_sr_flag_add ;  // rtl/tnsn_alu.v(146)
  wire [3:0] \alu/art/alu_sr_flag_ihz ;  // rtl/tnsn_alu.v(177)
  wire [8:0] \alu/art/inb ;  // rtl/tnsn_alu.v(144)
  wire [15:0] \alu/art/n13 ;
  wire [7:0] \alu/art/n4 ;
  wire [7:0] \alu/art/out ;  // rtl/tnsn_alu.v(145)
  wire  \alu/log/sel0_b10/B3 ;
  wire  \alu/log/sel0_b13/B1 ;
  wire  \alu/log/sel0_b13/B4 ;
  wire  \alu/log/sel0_b14/B1 ;
  wire  \alu/log/sel0_b9/B1 ;
  wire  \alu/log/sel0_b9/B4 ;
  wire [16:0] \alu/mul/ina ;  // rtl/tnsn_alu.v(412)
  wire [16:0] \alu/mul/inb ;  // rtl/tnsn_alu.v(414)
  wire [16:0] \alu/mul/out ;  // rtl/tnsn_alu.v(416)
  wire [3:0] \alu/sft/babs ;  // rtl/tnsn_alu.v(311)
  wire [8:0] \alu/sft/lsl2 ;  // rtl/tnsn_alu.v(334)
  wire [8:0] \alu/sft/lsr2 ;  // rtl/tnsn_alu.v(329)
  wire [3:0] \alu/sft/n27 ;
  wire  \alu/sft/sel0_b0/B8 ;
  wire  \alu/sft/sel0_b7/B2 ;
  wire  \alu/sft/sel0_b7/B9 ;
  wire [15:0] bbus;  // rtl/tennessine.v(56)
  wire [15:0] bbus_fch;  // rtl/tennessine.v(60)
  wire [15:0] cbus;  // rtl/tennessine.v(57)
  wire [15:0] cbus_mem;  // rtl/tennessine.v(61)
  wire  \ctl/sel0_b0/B31 ;
  wire [2:0] \ctl/stat ;  // rtl/tnsn_fsm.v(165)
  wire [2:0] ctl_sela;  // rtl/tennessine.v(44)
  wire [15:0] \fch/eir ;  // rtl/tnsn_fch.v(69)
  wire [15:0] \fch/n10 ;
  wire [14:0] \fch/n12 ;
  wire [15:0] \fch/n4 ;
  wire [15:0] fch_ir;  // rtl/tennessine.v(42)
  wire [1:0] fch_irq_lev;  // rtl/tennessine.v(41)
  wire [15:0] \mem/babf/n1 ;
  wire [2:0] \mem/read_cyc ;  // rtl/tnsn_mem.v(36)
  wire [14:0] n0;
  wire [15:0] \rgf/abus_iv ;  // rtl/tnsn_rgf.v(63)
  wire [7:0] \rgf/abus_sel ;  // rtl/tnsn_rgf.v(70)
  wire [5:0] \rgf/abus_sel_cr ;  // rtl/tnsn_rgf.v(73)
  wire [15:0] \rgf/abus_sp ;  // rtl/tnsn_rgf.v(62)
  wire [15:0] \rgf/bank/abuso/gr0_bus ;  // rtl/tnsn_rgf.v(617)
  wire [15:0] \rgf/bank/abuso/gr1_bus ;  // rtl/tnsn_rgf.v(618)
  wire [15:0] \rgf/bank/abuso/gr2_bus ;  // rtl/tnsn_rgf.v(619)
  wire [15:0] \rgf/bank/abuso/gr3_bus ;  // rtl/tnsn_rgf.v(620)
  wire [15:0] \rgf/bank/abuso/gr4_bus ;  // rtl/tnsn_rgf.v(621)
  wire [15:0] \rgf/bank/abuso/gr5_bus ;  // rtl/tnsn_rgf.v(622)
  wire [15:0] \rgf/bank/abuso/gr6_bus ;  // rtl/tnsn_rgf.v(623)
  wire [15:0] \rgf/bank/abuso/gr7_bus ;  // rtl/tnsn_rgf.v(624)
  wire [15:0] \rgf/bank/abuso/n10 ;
  wire [15:0] \rgf/bank/abuso/n8 ;
  wire [15:0] \rgf/bank/bbuso/gr0_bus ;  // rtl/tnsn_rgf.v(617)
  wire [15:0] \rgf/bank/bbuso/gr1_bus ;  // rtl/tnsn_rgf.v(618)
  wire [15:0] \rgf/bank/bbuso/gr2_bus ;  // rtl/tnsn_rgf.v(619)
  wire [15:0] \rgf/bank/bbuso/gr3_bus ;  // rtl/tnsn_rgf.v(620)
  wire [15:0] \rgf/bank/bbuso/gr4_bus ;  // rtl/tnsn_rgf.v(621)
  wire [15:0] \rgf/bank/bbuso/gr5_bus ;  // rtl/tnsn_rgf.v(622)
  wire [15:0] \rgf/bank/bbuso/gr6_bus ;  // rtl/tnsn_rgf.v(623)
  wire [15:0] \rgf/bank/bbuso/gr7_bus ;  // rtl/tnsn_rgf.v(624)
  wire [15:0] \rgf/bank/bbuso/n13 ;
  wire [15:0] \rgf/bank/gr00 ;  // rtl/tnsn_rgf.v(468)
  wire [15:0] \rgf/bank/gr01 ;  // rtl/tnsn_rgf.v(469)
  wire [15:0] \rgf/bank/gr02 ;  // rtl/tnsn_rgf.v(470)
  wire [15:0] \rgf/bank/gr03 ;  // rtl/tnsn_rgf.v(471)
  wire [15:0] \rgf/bank/gr04 ;  // rtl/tnsn_rgf.v(472)
  wire [15:0] \rgf/bank/gr05 ;  // rtl/tnsn_rgf.v(473)
  wire [15:0] \rgf/bank/gr06 ;  // rtl/tnsn_rgf.v(474)
  wire [15:0] \rgf/bank/gr07 ;  // rtl/tnsn_rgf.v(475)
  wire [15:0] \rgf/bbus_iv ;  // rtl/tnsn_rgf.v(68)
  wire [15:0] \rgf/bbus_pc ;  // rtl/tnsn_rgf.v(66)
  wire [7:0] \rgf/bbus_sel ;  // rtl/tnsn_rgf.v(71)
  wire [5:0] \rgf/bbus_sel_cr ;  // rtl/tnsn_rgf.v(74)
  wire [15:0] \rgf/bbus_sp ;  // rtl/tnsn_rgf.v(67)
  wire [15:0] \rgf/bbus_sr ;  // rtl/tnsn_rgf.v(65)
  wire [5:0] \rgf/cbus_sel_cr ;  // rtl/tnsn_rgf.v(75)
  wire [15:0] \rgf/ivec/iv ;  // rtl/tnsn_rgf.v(858)
  wire [15:0] \rgf/pcnt/n2 ;
  wire [15:0] \rgf/sptr/abus1 ;  // rtl/tnsn_rgf.v(822)
  wire [15:0] \rgf/sptr/abus2 ;  // rtl/tnsn_rgf.v(823)
  wire [15:0] \rgf/sptr/bbus1 ;  // rtl/tnsn_rgf.v(827)
  wire [15:0] \rgf/sptr/bbus2 ;  // rtl/tnsn_rgf.v(828)
  wire [15:0] \rgf/sptr/n2 ;
  wire [15:0] \rgf/sptr/sp ;  // rtl/tnsn_rgf.v(804)
  wire [15:0] \rgf/sptr/sp_inc ;  // rtl/tnsn_rgf.v(799)
  wire [15:0] \rgf/sreg/n7 ;
  wire [15:0] \rgf/sreg/n8 ;
  wire [15:0] \rgf/sreg/sr ;  // rtl/tnsn_rgf.v(688)
  wire [15:0] rgf_pc;  // rtl/tennessine.v(53)
  wire [3:0] rgf_sr_flag;  // rtl/tennessine.v(51)
  wire [1:0] rgf_sr_ie;  // rtl/tennessine.v(50)
  wire _al_u1000_o;
  wire _al_u1002_o;
  wire _al_u1005_o;
  wire _al_u1007_o;
  wire _al_u1010_o;
  wire _al_u1012_o;
  wire _al_u1015_o;
  wire _al_u1016_o;
  wire _al_u1017_o;
  wire _al_u1018_o;
  wire _al_u1019_o;
  wire _al_u1020_o;
  wire _al_u1021_o;
  wire _al_u1022_o;
  wire _al_u1023_o;
  wire _al_u1024_o;
  wire _al_u1026_o;
  wire _al_u1027_o;
  wire _al_u1028_o;
  wire _al_u1029_o;
  wire _al_u1030_o;
  wire _al_u1031_o;
  wire _al_u1032_o;
  wire _al_u1033_o;
  wire _al_u1034_o;
  wire _al_u1036_o;
  wire _al_u1037_o;
  wire _al_u1038_o;
  wire _al_u1039_o;
  wire _al_u1040_o;
  wire _al_u1041_o;
  wire _al_u1042_o;
  wire _al_u1043_o;
  wire _al_u1044_o;
  wire _al_u1045_o;
  wire _al_u1046_o;
  wire _al_u1048_o;
  wire _al_u1049_o;
  wire _al_u1050_o;
  wire _al_u1051_o;
  wire _al_u1052_o;
  wire _al_u1053_o;
  wire _al_u1054_o;
  wire _al_u1055_o;
  wire _al_u1056_o;
  wire _al_u1057_o;
  wire _al_u1058_o;
  wire _al_u1059_o;
  wire _al_u1061_o;
  wire _al_u1063_o;
  wire _al_u1065_o;
  wire _al_u1067_o;
  wire _al_u1068_o;
  wire _al_u1069_o;
  wire _al_u1070_o;
  wire _al_u1072_o;
  wire _al_u1074_o;
  wire _al_u1078_o;
  wire _al_u1079_o;
  wire _al_u1080_o;
  wire _al_u1083_o;
  wire _al_u1084_o;
  wire _al_u1086_o;
  wire _al_u1087_o;
  wire _al_u1088_o;
  wire _al_u1089_o;
  wire _al_u1091_o;
  wire _al_u1092_o;
  wire _al_u1094_o;
  wire _al_u1095_o;
  wire _al_u1096_o;
  wire _al_u1099_o;
  wire _al_u1100_o;
  wire _al_u1103_o;
  wire _al_u1105_o;
  wire _al_u1106_o;
  wire _al_u1109_o;
  wire _al_u1111_o;
  wire _al_u1112_o;
  wire _al_u1113_o;
  wire _al_u1114_o;
  wire _al_u1116_o;
  wire _al_u1117_o;
  wire _al_u1119_o;
  wire _al_u1120_o;
  wire _al_u1121_o;
  wire _al_u1122_o;
  wire _al_u1123_o;
  wire _al_u1124_o;
  wire _al_u1127_o;
  wire _al_u1128_o;
  wire _al_u1129_o;
  wire _al_u1131_o;
  wire _al_u1132_o;
  wire _al_u1133_o;
  wire _al_u1134_o;
  wire _al_u1135_o;
  wire _al_u1138_o;
  wire _al_u1140_o;
  wire _al_u1141_o;
  wire _al_u1142_o;
  wire _al_u1143_o;
  wire _al_u1144_o;
  wire _al_u1145_o;
  wire _al_u1146_o;
  wire _al_u1148_o;
  wire _al_u1149_o;
  wire _al_u1151_o;
  wire _al_u1153_o;
  wire _al_u1154_o;
  wire _al_u1156_o;
  wire _al_u1158_o;
  wire _al_u1159_o;
  wire _al_u1160_o;
  wire _al_u1162_o;
  wire _al_u1163_o;
  wire _al_u1164_o;
  wire _al_u1165_o;
  wire _al_u1167_o;
  wire _al_u1169_o;
  wire _al_u1170_o;
  wire _al_u1171_o;
  wire _al_u1173_o;
  wire _al_u1177_o;
  wire _al_u1179_o;
  wire _al_u1180_o;
  wire _al_u1181_o;
  wire _al_u1182_o;
  wire _al_u1184_o;
  wire _al_u1185_o;
  wire _al_u1186_o;
  wire _al_u1187_o;
  wire _al_u1190_o;
  wire _al_u1191_o;
  wire _al_u1192_o;
  wire _al_u1194_o;
  wire _al_u1195_o;
  wire _al_u1196_o;
  wire _al_u1197_o;
  wire _al_u1200_o;
  wire _al_u1201_o;
  wire _al_u1202_o;
  wire _al_u1204_o;
  wire _al_u1206_o;
  wire _al_u1207_o;
  wire _al_u1208_o;
  wire _al_u1211_o;
  wire _al_u1212_o;
  wire _al_u1214_o;
  wire _al_u1216_o;
  wire _al_u1218_o;
  wire _al_u1219_o;
  wire _al_u1221_o;
  wire _al_u1222_o;
  wire _al_u1223_o;
  wire _al_u1225_o;
  wire _al_u1226_o;
  wire _al_u1227_o;
  wire _al_u1229_o;
  wire _al_u1230_o;
  wire _al_u1231_o;
  wire _al_u1232_o;
  wire _al_u1233_o;
  wire _al_u1235_o;
  wire _al_u1236_o;
  wire _al_u1238_o;
  wire _al_u1239_o;
  wire _al_u1241_o;
  wire _al_u1242_o;
  wire _al_u1243_o;
  wire _al_u1246_o;
  wire _al_u1248_o;
  wire _al_u1249_o;
  wire _al_u1251_o;
  wire _al_u1252_o;
  wire _al_u1254_o;
  wire _al_u1255_o;
  wire _al_u1256_o;
  wire _al_u1257_o;
  wire _al_u1258_o;
  wire _al_u1259_o;
  wire _al_u1262_o;
  wire _al_u1264_o;
  wire _al_u1265_o;
  wire _al_u1266_o;
  wire _al_u1267_o;
  wire _al_u1269_o;
  wire _al_u1270_o;
  wire _al_u1271_o;
  wire _al_u1272_o;
  wire _al_u1274_o;
  wire _al_u1275_o;
  wire _al_u1276_o;
  wire _al_u1277_o;
  wire _al_u1278_o;
  wire _al_u1279_o;
  wire _al_u1280_o;
  wire _al_u1282_o;
  wire _al_u1283_o;
  wire _al_u1286_o;
  wire _al_u1287_o;
  wire _al_u1292_o;
  wire _al_u1293_o;
  wire _al_u1294_o;
  wire _al_u1295_o;
  wire _al_u1297_o;
  wire _al_u1298_o;
  wire _al_u1299_o;
  wire _al_u1300_o;
  wire _al_u1303_o;
  wire _al_u1305_o;
  wire _al_u1306_o;
  wire _al_u1307_o;
  wire _al_u1308_o;
  wire _al_u1318_o;
  wire _al_u1320_o;
  wire _al_u1327_o;
  wire _al_u1328_o;
  wire _al_u1330_o;
  wire _al_u1336_o;
  wire _al_u1337_o;
  wire _al_u1340_o;
  wire _al_u1342_o;
  wire _al_u1343_o;
  wire _al_u1344_o;
  wire _al_u1345_o;
  wire _al_u1348_o;
  wire _al_u1349_o;
  wire _al_u1350_o;
  wire _al_u1353_o;
  wire _al_u1354_o;
  wire _al_u1355_o;
  wire _al_u1358_o;
  wire _al_u1360_o;
  wire _al_u1361_o;
  wire _al_u1366_o;
  wire _al_u1367_o;
  wire _al_u1370_o;
  wire _al_u1371_o;
  wire _al_u1372_o;
  wire _al_u1375_o;
  wire _al_u1376_o;
  wire _al_u1377_o;
  wire _al_u1380_o;
  wire _al_u1381_o;
  wire _al_u1382_o;
  wire _al_u1386_o;
  wire _al_u1388_o;
  wire _al_u1392_o;
  wire _al_u1395_o;
  wire _al_u1398_o;
  wire _al_u1401_o;
  wire _al_u1404_o;
  wire _al_u1407_o;
  wire _al_u1410_o;
  wire _al_u1414_o;
  wire _al_u1416_o;
  wire _al_u1417_o;
  wire _al_u1418_o;
  wire _al_u1419_o;
  wire _al_u1420_o;
  wire _al_u1421_o;
  wire _al_u1423_o;
  wire _al_u1424_o;
  wire _al_u1427_o;
  wire _al_u1428_o;
  wire _al_u1429_o;
  wire _al_u1430_o;
  wire _al_u1431_o;
  wire _al_u1432_o;
  wire _al_u1434_o;
  wire _al_u1435_o;
  wire _al_u1436_o;
  wire _al_u1437_o;
  wire _al_u1440_o;
  wire _al_u1441_o;
  wire _al_u1442_o;
  wire _al_u1443_o;
  wire _al_u1445_o;
  wire _al_u1446_o;
  wire _al_u1449_o;
  wire _al_u1450_o;
  wire _al_u1451_o;
  wire _al_u1452_o;
  wire _al_u1454_o;
  wire _al_u1455_o;
  wire _al_u1456_o;
  wire _al_u1457_o;
  wire _al_u1459_o;
  wire _al_u1460_o;
  wire _al_u1461_o;
  wire _al_u1462_o;
  wire _al_u1463_o;
  wire _al_u1466_o;
  wire _al_u1467_o;
  wire _al_u1468_o;
  wire _al_u1469_o;
  wire _al_u1470_o;
  wire _al_u1472_o;
  wire _al_u1473_o;
  wire _al_u1474_o;
  wire _al_u1475_o;
  wire _al_u1476_o;
  wire _al_u1477_o;
  wire _al_u1479_o;
  wire _al_u1480_o;
  wire _al_u1483_o;
  wire _al_u1484_o;
  wire _al_u1485_o;
  wire _al_u1487_o;
  wire _al_u1488_o;
  wire _al_u1489_o;
  wire _al_u1490_o;
  wire _al_u1491_o;
  wire _al_u1492_o;
  wire _al_u1493_o;
  wire _al_u1494_o;
  wire _al_u1495_o;
  wire _al_u1496_o;
  wire _al_u1497_o;
  wire _al_u1498_o;
  wire _al_u1499_o;
  wire _al_u1500_o;
  wire _al_u1501_o;
  wire _al_u1502_o;
  wire _al_u1505_o;
  wire _al_u1506_o;
  wire _al_u1507_o;
  wire _al_u1508_o;
  wire _al_u1509_o;
  wire _al_u1510_o;
  wire _al_u1511_o;
  wire _al_u1512_o;
  wire _al_u1513_o;
  wire _al_u1514_o;
  wire _al_u1515_o;
  wire _al_u1516_o;
  wire _al_u1517_o;
  wire _al_u1519_o;
  wire _al_u1520_o;
  wire _al_u1521_o;
  wire _al_u1522_o;
  wire _al_u1525_o;
  wire _al_u1526_o;
  wire _al_u1527_o;
  wire _al_u1528_o;
  wire _al_u1529_o;
  wire _al_u1530_o;
  wire _al_u1531_o;
  wire _al_u1533_o;
  wire _al_u1534_o;
  wire _al_u1535_o;
  wire _al_u1536_o;
  wire _al_u1538_o;
  wire _al_u1539_o;
  wire _al_u1540_o;
  wire _al_u1541_o;
  wire _al_u1542_o;
  wire _al_u1543_o;
  wire _al_u1544_o;
  wire _al_u1545_o;
  wire _al_u1546_o;
  wire _al_u1547_o;
  wire _al_u1548_o;
  wire _al_u1550_o;
  wire _al_u1551_o;
  wire _al_u1552_o;
  wire _al_u1553_o;
  wire _al_u1554_o;
  wire _al_u1556_o;
  wire _al_u1557_o;
  wire _al_u1558_o;
  wire _al_u1561_o;
  wire _al_u1562_o;
  wire _al_u1563_o;
  wire _al_u1564_o;
  wire _al_u1565_o;
  wire _al_u1566_o;
  wire _al_u1567_o;
  wire _al_u1568_o;
  wire _al_u1569_o;
  wire _al_u1570_o;
  wire _al_u1571_o;
  wire _al_u1572_o;
  wire _al_u1573_o;
  wire _al_u1574_o;
  wire _al_u1577_o;
  wire _al_u1578_o;
  wire _al_u1579_o;
  wire _al_u1580_o;
  wire _al_u1581_o;
  wire _al_u1582_o;
  wire _al_u1583_o;
  wire _al_u1584_o;
  wire _al_u1585_o;
  wire _al_u1586_o;
  wire _al_u1587_o;
  wire _al_u1588_o;
  wire _al_u1592_o;
  wire _al_u1595_o;
  wire _al_u1596_o;
  wire _al_u1599_o;
  wire _al_u1603_o;
  wire _al_u1606_o;
  wire _al_u1610_o;
  wire _al_u1613_o;
  wire _al_u1614_o;
  wire _al_u1615_o;
  wire _al_u1616_o;
  wire _al_u1617_o;
  wire _al_u1618_o;
  wire _al_u1619_o;
  wire _al_u1620_o;
  wire _al_u1621_o;
  wire _al_u1622_o;
  wire _al_u1624_o;
  wire _al_u1626_o;
  wire _al_u1629_o;
  wire _al_u1632_o;
  wire _al_u1633_o;
  wire _al_u1635_o;
  wire _al_u1636_o;
  wire _al_u1637_o;
  wire _al_u1639_o;
  wire _al_u1640_o;
  wire _al_u1641_o;
  wire _al_u1642_o;
  wire _al_u1643_o;
  wire _al_u1644_o;
  wire _al_u1645_o;
  wire _al_u1646_o;
  wire _al_u1647_o;
  wire _al_u1648_o;
  wire _al_u1649_o;
  wire _al_u1651_o;
  wire _al_u1652_o;
  wire _al_u1653_o;
  wire _al_u1654_o;
  wire _al_u1655_o;
  wire _al_u1656_o;
  wire _al_u1657_o;
  wire _al_u321_o;
  wire _al_u338_o;
  wire _al_u339_o;
  wire _al_u340_o;
  wire _al_u341_o;
  wire _al_u342_o;
  wire _al_u343_o;
  wire _al_u345_o;
  wire _al_u346_o;
  wire _al_u347_o;
  wire _al_u348_o;
  wire _al_u349_o;
  wire _al_u350_o;
  wire _al_u351_o;
  wire _al_u352_o;
  wire _al_u354_o;
  wire _al_u355_o;
  wire _al_u356_o;
  wire _al_u357_o;
  wire _al_u358_o;
  wire _al_u360_o;
  wire _al_u361_o;
  wire _al_u362_o;
  wire _al_u363_o;
  wire _al_u364_o;
  wire _al_u366_o;
  wire _al_u367_o;
  wire _al_u368_o;
  wire _al_u369_o;
  wire _al_u371_o;
  wire _al_u372_o;
  wire _al_u373_o;
  wire _al_u374_o;
  wire _al_u376_o;
  wire _al_u378_o;
  wire _al_u379_o;
  wire _al_u380_o;
  wire _al_u381_o;
  wire _al_u382_o;
  wire _al_u384_o;
  wire _al_u386_o;
  wire _al_u387_o;
  wire _al_u388_o;
  wire _al_u389_o;
  wire _al_u392_o;
  wire _al_u393_o;
  wire _al_u394_o;
  wire _al_u395_o;
  wire _al_u397_o;
  wire _al_u400_o;
  wire _al_u401_o;
  wire _al_u402_o;
  wire _al_u403_o;
  wire _al_u404_o;
  wire _al_u405_o;
  wire _al_u406_o;
  wire _al_u407_o;
  wire _al_u408_o;
  wire _al_u410_o;
  wire _al_u411_o;
  wire _al_u430_o;
  wire _al_u431_o;
  wire _al_u432_o;
  wire _al_u433_o;
  wire _al_u434_o;
  wire _al_u435_o;
  wire _al_u436_o;
  wire _al_u438_o;
  wire _al_u440_o;
  wire _al_u441_o;
  wire _al_u442_o;
  wire _al_u443_o;
  wire _al_u446_o;
  wire _al_u447_o;
  wire _al_u448_o;
  wire _al_u449_o;
  wire _al_u450_o;
  wire _al_u451_o;
  wire _al_u453_o;
  wire _al_u454_o;
  wire _al_u455_o;
  wire _al_u458_o;
  wire _al_u460_o;
  wire _al_u461_o;
  wire _al_u463_o;
  wire _al_u464_o;
  wire _al_u465_o;
  wire _al_u466_o;
  wire _al_u467_o;
  wire _al_u468_o;
  wire _al_u469_o;
  wire _al_u471_o;
  wire _al_u472_o;
  wire _al_u475_o;
  wire _al_u477_o;
  wire _al_u478_o;
  wire _al_u481_o;
  wire _al_u482_o;
  wire _al_u484_o;
  wire _al_u486_o;
  wire _al_u487_o;
  wire _al_u489_o;
  wire _al_u492_o;
  wire _al_u494_o;
  wire _al_u496_o;
  wire _al_u497_o;
  wire _al_u498_o;
  wire _al_u499_o;
  wire _al_u500_o;
  wire _al_u502_o;
  wire _al_u505_o;
  wire _al_u507_o;
  wire _al_u510_o;
  wire _al_u512_o;
  wire _al_u513_o;
  wire _al_u515_o;
  wire _al_u518_o;
  wire _al_u519_o;
  wire _al_u520_o;
  wire _al_u521_o;
  wire _al_u523_o;
  wire _al_u524_o;
  wire _al_u525_o;
  wire _al_u526_o;
  wire _al_u527_o;
  wire _al_u528_o;
  wire _al_u530_o;
  wire _al_u531_o;
  wire _al_u532_o;
  wire _al_u533_o;
  wire _al_u534_o;
  wire _al_u535_o;
  wire _al_u538_o;
  wire _al_u539_o;
  wire _al_u542_o;
  wire _al_u543_o;
  wire _al_u544_o;
  wire _al_u545_o;
  wire _al_u546_o;
  wire _al_u547_o;
  wire _al_u548_o;
  wire _al_u549_o;
  wire _al_u550_o;
  wire _al_u551_o;
  wire _al_u552_o;
  wire _al_u553_o;
  wire _al_u554_o;
  wire _al_u555_o;
  wire _al_u556_o;
  wire _al_u559_o;
  wire _al_u561_o;
  wire _al_u562_o;
  wire _al_u563_o;
  wire _al_u564_o;
  wire _al_u565_o;
  wire _al_u566_o;
  wire _al_u567_o;
  wire _al_u568_o;
  wire _al_u569_o;
  wire _al_u570_o;
  wire _al_u571_o;
  wire _al_u572_o;
  wire _al_u573_o;
  wire _al_u574_o;
  wire _al_u575_o;
  wire _al_u576_o;
  wire _al_u577_o;
  wire _al_u579_o;
  wire _al_u580_o;
  wire _al_u583_o;
  wire _al_u584_o;
  wire _al_u588_o;
  wire _al_u589_o;
  wire _al_u590_o;
  wire _al_u591_o;
  wire _al_u592_o;
  wire _al_u593_o;
  wire _al_u594_o;
  wire _al_u595_o;
  wire _al_u596_o;
  wire _al_u598_o;
  wire _al_u599_o;
  wire _al_u600_o;
  wire _al_u601_o;
  wire _al_u602_o;
  wire _al_u603_o;
  wire _al_u604_o;
  wire _al_u605_o;
  wire _al_u606_o;
  wire _al_u607_o;
  wire _al_u608_o;
  wire _al_u609_o;
  wire _al_u610_o;
  wire _al_u611_o;
  wire _al_u613_o;
  wire _al_u614_o;
  wire _al_u615_o;
  wire _al_u616_o;
  wire _al_u617_o;
  wire _al_u618_o;
  wire _al_u619_o;
  wire _al_u620_o;
  wire _al_u621_o;
  wire _al_u623_o;
  wire _al_u624_o;
  wire _al_u625_o;
  wire _al_u626_o;
  wire _al_u627_o;
  wire _al_u628_o;
  wire _al_u629_o;
  wire _al_u630_o;
  wire _al_u631_o;
  wire _al_u632_o;
  wire _al_u633_o;
  wire _al_u634_o;
  wire _al_u635_o;
  wire _al_u636_o;
  wire _al_u637_o;
  wire _al_u638_o;
  wire _al_u640_o;
  wire _al_u642_o;
  wire _al_u644_o;
  wire _al_u645_o;
  wire _al_u646_o;
  wire _al_u648_o;
  wire _al_u653_o;
  wire _al_u656_o;
  wire _al_u665_o;
  wire _al_u666_o;
  wire _al_u667_o;
  wire _al_u668_o;
  wire _al_u669_o;
  wire _al_u670_o;
  wire _al_u671_o;
  wire _al_u672_o;
  wire _al_u674_o;
  wire _al_u677_o;
  wire _al_u678_o;
  wire _al_u679_o;
  wire _al_u680_o;
  wire _al_u681_o;
  wire _al_u683_o;
  wire _al_u685_o;
  wire _al_u686_o;
  wire _al_u687_o;
  wire _al_u688_o;
  wire _al_u689_o;
  wire _al_u690_o;
  wire _al_u691_o;
  wire _al_u692_o;
  wire _al_u693_o;
  wire _al_u696_o;
  wire _al_u698_o;
  wire _al_u699_o;
  wire _al_u700_o;
  wire _al_u704_o;
  wire _al_u705_o;
  wire _al_u706_o;
  wire _al_u707_o;
  wire _al_u708_o;
  wire _al_u709_o;
  wire _al_u710_o;
  wire _al_u712_o;
  wire _al_u713_o;
  wire _al_u716_o;
  wire _al_u717_o;
  wire _al_u719_o;
  wire _al_u720_o;
  wire _al_u721_o;
  wire _al_u722_o;
  wire _al_u723_o;
  wire _al_u724_o;
  wire _al_u725_o;
  wire _al_u726_o;
  wire _al_u727_o;
  wire _al_u728_o;
  wire _al_u729_o;
  wire _al_u730_o;
  wire _al_u731_o;
  wire _al_u733_o;
  wire _al_u734_o;
  wire _al_u737_o;
  wire _al_u740_o;
  wire _al_u741_o;
  wire _al_u742_o;
  wire _al_u743_o;
  wire _al_u744_o;
  wire _al_u746_o;
  wire _al_u747_o;
  wire _al_u748_o;
  wire _al_u749_o;
  wire _al_u751_o;
  wire _al_u752_o;
  wire _al_u753_o;
  wire _al_u755_o;
  wire _al_u757_o;
  wire _al_u760_o;
  wire _al_u761_o;
  wire _al_u762_o;
  wire _al_u763_o;
  wire _al_u764_o;
  wire _al_u765_o;
  wire _al_u766_o;
  wire _al_u767_o;
  wire _al_u768_o;
  wire _al_u769_o;
  wire _al_u771_o;
  wire _al_u777_o;
  wire _al_u778_o;
  wire _al_u779_o;
  wire _al_u780_o;
  wire _al_u782_o;
  wire _al_u783_o;
  wire _al_u784_o;
  wire _al_u785_o;
  wire _al_u786_o;
  wire _al_u788_o;
  wire _al_u790_o;
  wire _al_u794_o;
  wire _al_u796_o;
  wire _al_u797_o;
  wire _al_u799_o;
  wire _al_u800_o;
  wire _al_u801_o;
  wire _al_u804_o;
  wire _al_u805_o;
  wire _al_u806_o;
  wire _al_u807_o;
  wire _al_u808_o;
  wire _al_u809_o;
  wire _al_u810_o;
  wire _al_u811_o;
  wire _al_u812_o;
  wire _al_u813_o;
  wire _al_u814_o;
  wire _al_u815_o;
  wire _al_u816_o;
  wire _al_u818_o;
  wire _al_u819_o;
  wire _al_u820_o;
  wire _al_u821_o;
  wire _al_u823_o;
  wire _al_u824_o;
  wire _al_u825_o;
  wire _al_u826_o;
  wire _al_u828_o;
  wire _al_u833_o;
  wire _al_u834_o;
  wire _al_u835_o;
  wire _al_u836_o;
  wire _al_u837_o;
  wire _al_u838_o;
  wire _al_u839_o;
  wire _al_u840_o;
  wire _al_u841_o;
  wire _al_u842_o;
  wire _al_u843_o;
  wire _al_u845_o;
  wire _al_u846_o;
  wire _al_u849_o;
  wire _al_u851_o;
  wire _al_u852_o;
  wire _al_u853_o;
  wire _al_u854_o;
  wire _al_u856_o;
  wire _al_u857_o;
  wire _al_u858_o;
  wire _al_u859_o;
  wire _al_u860_o;
  wire _al_u861_o;
  wire _al_u863_o;
  wire _al_u864_o;
  wire _al_u865_o;
  wire _al_u866_o;
  wire _al_u867_o;
  wire _al_u868_o;
  wire _al_u869_o;
  wire _al_u870_o;
  wire _al_u871_o;
  wire _al_u872_o;
  wire _al_u873_o;
  wire _al_u874_o;
  wire _al_u875_o;
  wire _al_u879_o;
  wire _al_u880_o;
  wire _al_u881_o;
  wire _al_u882_o;
  wire _al_u883_o;
  wire _al_u884_o;
  wire _al_u885_o;
  wire _al_u886_o;
  wire _al_u887_o;
  wire _al_u889_o;
  wire _al_u891_o;
  wire _al_u892_o;
  wire _al_u893_o;
  wire _al_u894_o;
  wire _al_u896_o;
  wire _al_u897_o;
  wire _al_u898_o;
  wire _al_u899_o;
  wire _al_u900_o;
  wire _al_u902_o;
  wire _al_u903_o;
  wire _al_u905_o;
  wire _al_u906_o;
  wire _al_u908_o;
  wire _al_u911_o;
  wire _al_u912_o;
  wire _al_u913_o;
  wire _al_u915_o;
  wire _al_u917_o;
  wire _al_u918_o;
  wire _al_u920_o;
  wire _al_u921_o;
  wire _al_u922_o;
  wire _al_u923_o;
  wire _al_u924_o;
  wire _al_u926_o;
  wire _al_u927_o;
  wire _al_u928_o;
  wire _al_u929_o;
  wire _al_u930_o;
  wire _al_u931_o;
  wire _al_u932_o;
  wire _al_u933_o;
  wire _al_u934_o;
  wire _al_u935_o;
  wire _al_u936_o;
  wire _al_u937_o;
  wire _al_u938_o;
  wire _al_u939_o;
  wire _al_u941_o;
  wire _al_u942_o;
  wire _al_u943_o;
  wire _al_u944_o;
  wire _al_u945_o;
  wire _al_u946_o;
  wire _al_u947_o;
  wire _al_u948_o;
  wire _al_u954_o;
  wire _al_u956_o;
  wire _al_u957_o;
  wire _al_u958_o;
  wire _al_u959_o;
  wire _al_u961_o;
  wire _al_u962_o;
  wire _al_u963_o;
  wire _al_u964_o;
  wire _al_u965_o;
  wire _al_u966_o;
  wire _al_u980_o;
  wire _al_u991_o;
  wire _al_u992_o;
  wire \alu/art/add/add0_2/c0 ;
  wire \alu/art/add/add0_2/c1 ;
  wire \alu/art/add/add0_2/c2 ;
  wire \alu/art/add/add0_2/c3 ;
  wire \alu/art/add/add0_2/c4 ;
  wire \alu/art/add/add0_2/c5 ;
  wire \alu/art/add/add0_2/c6 ;
  wire \alu/art/add/add0_2/c7 ;
  wire \alu/art/add/add0_2/c8 ;
  wire \alu/art/add/add0_2/c9 ;
  wire \alu/art/add0/c0 ;
  wire \alu/art/add0/c1 ;
  wire \alu/art/add0/c10 ;
  wire \alu/art/add0/c11 ;
  wire \alu/art/add0/c12 ;
  wire \alu/art/add0/c13 ;
  wire \alu/art/add0/c14 ;
  wire \alu/art/add0/c15 ;
  wire \alu/art/add0/c2 ;
  wire \alu/art/add0/c3 ;
  wire \alu/art/add0/c4 ;
  wire \alu/art/add0/c5 ;
  wire \alu/art/add0/c6 ;
  wire \alu/art/add0/c7 ;
  wire \alu/art/add0/c8 ;
  wire \alu/art/add0/c9 ;
  wire \alu/art/cin ;  // rtl/tnsn_alu.v(154)
  wire \alu/art/drv_lutinv ;  // rtl/tnsn_alu.v(169)
  wire \alu/art/eq4/or_xor_i0[2]_i1[2]_o_o_lutinv ;
  wire \alu/art/n2_lutinv ;
  wire \alu/log/eq3/or_xor_i0[3]_i1[3]_o_o_lutinv ;
  wire \alu/log/n11_lutinv ;
  wire \alu/log/n12_lutinv ;
  wire \alu/log/n13_lutinv ;
  wire \alu/log/n14_lutinv ;
  wire \alu/log/n8_lutinv ;
  wire \alu/log/n9_lutinv ;
  wire \alu/sft/add0/c0 ;
  wire \alu/sft/add0/c1 ;
  wire \alu/sft/add0/c2 ;
  wire \alu/sft/add0/c3 ;
  wire \alu/sft/mux18_b1_sel_is_1_o ;
  wire \alu/sft/n28_lutinv ;
  wire \alu/sft/n30_lutinv ;
  wire \alu/sft/n31_lutinv ;
  wire \alu/sft/n33_lutinv ;
  wire \alu/sft/n34_lutinv ;
  wire \alu/sft/n36_lutinv ;
  wire \alu/sft/n40_lutinv ;
  wire \alu/sft/n41_lutinv ;
  wire \alu/sft/n42_lutinv ;
  wire \alu/sft/n44_lutinv ;
  wire \alu/sft/n48_lutinv ;
  wire \ctl/mux4_b0_sel_is_3_o ;
  wire \ctl/mux4_b1_sel_is_3_o ;
  wire \ctl/mux4_b2_sel_is_3_o ;
  wire \ctl/n119_lutinv ;
  wire \ctl/n120_lutinv ;
  wire \ctl/n121_lutinv ;
  wire \ctl/n169_lutinv ;
  wire \ctl/n1916_lutinv ;
  wire \ctl/n192_lutinv ;
  wire \ctl/n204_lutinv ;
  wire \ctl/n220_lutinv ;
  wire \ctl/n232_lutinv ;
  wire \ctl/n239_lutinv ;
  wire \ctl/n246_lutinv ;
  wire \ctl/n248_lutinv ;
  wire \ctl/n251_lutinv ;
  wire \ctl/n258_lutinv ;
  wire \ctl/n270_lutinv ;
  wire \ctl/n298_lutinv ;
  wire \ctl/n302_lutinv ;
  wire \ctl/n307_lutinv ;
  wire \ctl/n313_lutinv ;
  wire \ctl/n321_lutinv ;
  wire \ctl/n338_lutinv ;
  wire \ctl/n358_lutinv ;
  wire \ctl/n365_lutinv ;
  wire \ctl/n379_lutinv ;
  wire \ctl/n433_lutinv ;
  wire \ctl/n511_lutinv ;
  wire \ctl/n518_lutinv ;
  wire \ctl/n525_lutinv ;
  wire \ctl/n533_lutinv ;
  wire \ctl/n541_lutinv ;
  wire \ctl/n550_lutinv ;
  wire \ctl/n561_lutinv ;
  wire \ctl/n602_lutinv ;
  wire \ctl/n633_lutinv ;
  wire \ctl/n644_lutinv ;
  wire \ctl/n654_lutinv ;
  wire \ctl/n743_lutinv ;
  wire \ctl/n754_lutinv ;
  wire \ctl/n755_lutinv ;
  wire \ctl/n856_lutinv ;
  wire \ctl/n867_lutinv ;
  wire \ctl/n875_lutinv ;
  wire \ctl/n901_lutinv ;
  wire \ctl/n936 ;
  wire \ctl/sel0_b0/or_B108_B109_o_lutinv ;
  wire \ctl/sel0_b2/or_or_B0_or_B1_B2_o__o_lutinv ;
  wire \ctl/sel2_b0/or_or_or_B110_B111_o_o_lutinv ;
  wire ctl_bcmdb;  // rtl/tennessine.v(79)
  wire ctl_bcmdr;  // rtl/tennessine.v(77)
  wire ctl_bcmdw;  // rtl/tennessine.v(78)
  wire ctl_fetch_ext_lutinv;  // rtl/tennessine.v(75)
  wire \ctl_sela_rn[0]_neg_lutinv ;
  wire \ctl_sela_rn[1]_neg_lutinv ;
  wire \ctl_sela_rn[2]_neg_lutinv ;
  wire \ctl_selb[0]_neg_lutinv ;
  wire \ctl_selb[1]_neg_lutinv ;
  wire \ctl_selb_rn[0]_neg_lutinv ;
  wire ctl_sp_inc_neg_lutinv;
  wire ctl_sr_upd_neg_lutinv;
  wire \fch/add0/c0 ;
  wire \fch/add0/c1 ;
  wire \fch/add0/c10 ;
  wire \fch/add0/c11 ;
  wire \fch/add0/c12 ;
  wire \fch/add0/c13 ;
  wire \fch/add0/c14 ;
  wire \fch/add0/c2 ;
  wire \fch/add0/c3 ;
  wire \fch/add0/c4 ;
  wire \fch/add0/c5 ;
  wire \fch/add0/c6 ;
  wire \fch/add0/c7 ;
  wire \fch/add0/c8 ;
  wire \fch/add0/c9 ;
  wire \fch/lt0/o_0_lutinv ;
  wire \fch/n1 ;
  wire \fch/n8 ;
  wire \mem/bwbf/n1 ;
  wire \mem/bwbf/n2 ;
  wire \rgf/bank/grn00/mux0_b0_sel_is_0_o ;
  wire \rgf/bank/grn00/n1 ;
  wire \rgf/bank/grn01/mux0_b0_sel_is_0_o ;
  wire \rgf/bank/grn01/n1 ;
  wire \rgf/bank/grn02/mux0_b0_sel_is_0_o ;
  wire \rgf/bank/grn02/n1 ;
  wire \rgf/bank/grn03/mux0_b0_sel_is_0_o ;
  wire \rgf/bank/grn03/n1 ;
  wire \rgf/bank/grn04/mux0_b0_sel_is_0_o ;
  wire \rgf/bank/grn04/n1 ;
  wire \rgf/bank/grn05/mux0_b0_sel_is_0_o ;
  wire \rgf/bank/grn05/n1 ;
  wire \rgf/bank/grn06/mux0_b0_sel_is_0_o ;
  wire \rgf/bank/grn06/n1 ;
  wire \rgf/bank/grn07/mux0_b0_sel_is_0_o ;
  wire \rgf/bank/grn07/n1 ;
  wire \rgf/pcnt/mux0_b10_sel_is_1_o ;
  wire \rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ;
  wire \rgf/rctl/eq16/or_xor_i0[3]_i1[3]_o_o_lutinv ;
  wire \rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ;
  wire \rgf/sptr/add0/c0 ;
  wire \rgf/sptr/add0/c1 ;
  wire \rgf/sptr/add0/c10 ;
  wire \rgf/sptr/add0/c11 ;
  wire \rgf/sptr/add0/c12 ;
  wire \rgf/sptr/add0/c13 ;
  wire \rgf/sptr/add0/c14 ;
  wire \rgf/sptr/add0/c2 ;
  wire \rgf/sptr/add0/c3 ;
  wire \rgf/sptr/add0/c4 ;
  wire \rgf/sptr/add0/c5 ;
  wire \rgf/sptr/add0/c6 ;
  wire \rgf/sptr/add0/c7 ;
  wire \rgf/sptr/add0/c8 ;
  wire \rgf/sptr/add0/c9 ;
  wire \rgf/sptr/sub0/c0 ;
  wire \rgf/sptr/sub0/c1 ;
  wire \rgf/sptr/sub0/c10 ;
  wire \rgf/sptr/sub0/c11 ;
  wire \rgf/sptr/sub0/c12 ;
  wire \rgf/sptr/sub0/c13 ;
  wire \rgf/sptr/sub0/c14 ;
  wire \rgf/sptr/sub0/c2 ;
  wire \rgf/sptr/sub0/c3 ;
  wire \rgf/sptr/sub0/c4 ;
  wire \rgf/sptr/sub0/c5 ;
  wire \rgf/sptr/sub0/c6 ;
  wire \rgf/sptr/sub0/c7 ;
  wire \rgf/sptr/sub0/c8 ;
  wire \rgf/sptr/sub0/c9 ;
  wire \rgf/sreg/mux2_b2_sel_is_2_o ;
  wire \rgf/sreg/mux3_b4_sel_is_0_o ;
  wire rgf_iv_ve;  // rtl/tennessine.v(70)

  assign badr[15] = \mem/babf/n1 [15];
  assign badr[14] = \mem/babf/n1 [14];
  assign badr[13] = \mem/babf/n1 [13];
  assign badr[12] = \mem/babf/n1 [12];
  assign badr[11] = \mem/babf/n1 [11];
  assign badr[10] = \mem/babf/n1 [10];
  assign badr[9] = \mem/babf/n1 [9];
  assign badr[8] = \mem/babf/n1 [8];
  assign badr[7] = \mem/babf/n1 [7];
  assign badr[6] = \mem/babf/n1 [6];
  assign badr[5] = \mem/babf/n1 [5];
  assign badr[4] = \mem/babf/n1 [4];
  assign badr[3] = \mem/babf/n1 [3];
  assign badr[2] = \mem/babf/n1 [2];
  assign badr[1] = \mem/babf/n1 [1];
  assign badr[0] = \mem/babf/n1 [0];
  assign bcmd[2] = ctl_bcmdb;
  assign bcmd[1] = ctl_bcmdw;
  assign bcmd[0] = ctl_bcmdr;
  assign fadr[15] = rgf_pc[15];
  assign fadr[14] = rgf_pc[14];
  assign fadr[13] = rgf_pc[13];
  assign fadr[12] = rgf_pc[12];
  assign fadr[11] = rgf_pc[11];
  assign fadr[10] = rgf_pc[10];
  assign fadr[9] = rgf_pc[9];
  assign fadr[8] = rgf_pc[8];
  assign fadr[7] = rgf_pc[7];
  assign fadr[6] = rgf_pc[6];
  assign fadr[5] = rgf_pc[5];
  assign fadr[4] = rgf_pc[4];
  assign fadr[3] = rgf_pc[3];
  assign fadr[2] = rgf_pc[2];
  assign fadr[1] = rgf_pc[1];
  assign fadr[0] = rgf_pc[0];
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u1000 (
    .a(\rgf/bank/bbuso/gr3_bus [3]),
    .b(_al_u704_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(rgf_sr_ie[1]),
    .o(_al_u1000_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u1001 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u710_o),
    .c(\rgf/bank/gr07 [3]),
    .o(\rgf/bank/bbuso/gr7_bus [3]));
  AL_MAP_LUT4 #(
    .EQN("(~B*~(D*C*A))"),
    .INIT(16'h1333))
    _al_u1002 (
    .a(_al_u737_o),
    .b(\rgf/bank/bbuso/gr7_bus [3]),
    .c(_al_u704_o),
    .d(\rgf/bank/gr00 [3]),
    .o(_al_u1002_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1003 (
    .a(_al_u713_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .o(\rgf/bbus_sel_cr [5]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1004 (
    .a(_al_u743_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .c(\rgf/ivec/iv [3]),
    .o(\rgf/bbus_iv [3]));
  AL_MAP_LUT5 #(
    .EQN("(~D*B*A*~(E*C))"),
    .INIT(32'h00080088))
    _al_u1005 (
    .a(_al_u1000_o),
    .b(_al_u1002_o),
    .c(\rgf/bbus_sel_cr [5]),
    .d(\rgf/bbus_iv [3]),
    .e(n0[2]),
    .o(_al_u1005_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C*B*A))"),
    .INIT(16'h7f00))
    _al_u1006 (
    .a(_al_u1005_o),
    .b(_al_u924_o),
    .c(_al_u922_o),
    .d(ctl_bcmdw),
    .o(bdatw[3]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C*B*A))"),
    .INIT(16'h7f00))
    _al_u1007 (
    .a(_al_u794_o),
    .b(_al_u797_o),
    .c(_al_u799_o),
    .d(\mem/bwbf/n1 ),
    .o(_al_u1007_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~(E*~(D*C*B)))"),
    .INIT(32'hbfffaaaa))
    _al_u1008 (
    .a(_al_u1007_o),
    .b(_al_u1005_o),
    .c(_al_u924_o),
    .d(_al_u922_o),
    .e(\mem/bwbf/n2 ),
    .o(bdatw[11]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u1009 (
    .a(\alu/art/n4 [3]),
    .b(\alu/art/n2_lutinv ),
    .o(\alu/art/inb [3]));
  AL_MAP_LUT4 #(
    .EQN("~((D*C)*~(A)*~(B)+(D*C)*A*~(B)+~((D*C))*A*B+(D*C)*A*B)"),
    .INIT(16'h4777))
    _al_u1010 (
    .a(_al_u938_o),
    .b(_al_u939_o),
    .c(_al_u934_o),
    .d(_al_u935_o),
    .o(_al_u1010_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(D*~B*~A))"),
    .INIT(16'he0f0))
    _al_u1011 (
    .a(_al_u1010_o),
    .b(_al_u933_o),
    .c(ctl_bcmdw),
    .d(_al_u930_o),
    .o(bdatw[2]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1012 (
    .a(_al_u933_o),
    .b(_al_u747_o),
    .c(\rgf/bank/gr06 [2]),
    .o(_al_u1012_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(~C*B))*~(D*A))"),
    .INIT(32'hfbf3aa00))
    _al_u1013 (
    .a(bbus[10]),
    .b(_al_u1012_o),
    .c(_al_u1010_o),
    .d(\mem/bwbf/n1 ),
    .e(\mem/bwbf/n2 ),
    .o(bdatw[10]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u1014 (
    .a(\alu/art/n4 [2]),
    .b(\alu/art/n2_lutinv ),
    .o(\alu/art/inb [2]));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'h4e))
    _al_u1015 (
    .a(_al_u407_o),
    .b(_al_u599_o),
    .c(\ctl/stat [1]),
    .o(_al_u1015_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1016 (
    .a(_al_u434_o),
    .b(_al_u341_o),
    .o(_al_u1016_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~C*~(~D*B)))"),
    .INIT(16'ha0a8))
    _al_u1017 (
    .a(_al_u354_o),
    .b(_al_u446_o),
    .c(_al_u458_o),
    .d(fch_ir[7]),
    .o(_al_u1017_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*A*~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'h00200222))
    _al_u1018 (
    .a(_al_u572_o),
    .b(\ctl/n365_lutinv ),
    .c(_al_u1017_o),
    .d(_al_u355_o),
    .e(_al_u519_o),
    .o(_al_u1018_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u1019 (
    .a(_al_u1018_o),
    .b(\ctl/n321_lutinv ),
    .c(\ctl/n338_lutinv ),
    .d(\alu/log/n9_lutinv ),
    .e(_al_u570_o),
    .o(_al_u1019_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u1020 (
    .a(_al_u360_o),
    .b(_al_u644_o),
    .c(_al_u719_o),
    .d(_al_u466_o),
    .e(_al_u497_o),
    .o(_al_u1020_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u1021 (
    .a(_al_u1019_o),
    .b(_al_u1020_o),
    .c(\alu/log/n11_lutinv ),
    .d(_al_u463_o),
    .o(_al_u1021_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u1022 (
    .a(_al_u691_o),
    .b(_al_u475_o),
    .c(_al_u451_o),
    .o(_al_u1022_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*~A)"),
    .INIT(32'h00001000))
    _al_u1023 (
    .a(_al_u1015_o),
    .b(_al_u1016_o),
    .c(_al_u1021_o),
    .d(_al_u1022_o),
    .e(\ctl/n901_lutinv ),
    .o(_al_u1023_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~D*C*B))"),
    .INIT(16'haa2a))
    _al_u1024 (
    .a(_al_u592_o),
    .b(_al_u350_o),
    .c(_al_u352_o),
    .d(fch_ir[0]),
    .o(_al_u1024_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u1025 (
    .a(_al_u367_o),
    .b(_al_u382_o),
    .c(rgf_sr_flag[0]),
    .o(\ctl/n246_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u1026 (
    .a(_al_u618_o),
    .b(_al_u430_o),
    .c(_al_u372_o),
    .d(\ctl/n867_lutinv ),
    .e(\ctl/n246_lutinv ),
    .o(_al_u1026_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1027 (
    .a(ctl_fetch_ext_lutinv),
    .b(\ctl/n192_lutinv ),
    .o(_al_u1027_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u1028 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(_al_u1026_o),
    .d(_al_u1027_o),
    .o(_al_u1028_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*~(~D*C))"),
    .INIT(16'h1101))
    _al_u1029 (
    .a(_al_u433_o),
    .b(_al_u530_o),
    .c(_al_u434_o),
    .d(_al_u406_o),
    .o(_al_u1029_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u1030 (
    .a(_al_u667_o),
    .b(_al_u1029_o),
    .c(_al_u497_o),
    .d(\ctl/n358_lutinv ),
    .o(_al_u1030_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1031 (
    .a(_al_u1030_o),
    .b(_al_u569_o),
    .o(_al_u1031_o));
  AL_MAP_LUT4 #(
    .EQN("(~(C*~B)*~(D*~A))"),
    .INIT(16'h8acf))
    _al_u1032 (
    .a(_al_u688_o),
    .b(_al_u1031_o),
    .c(fch_ir[2]),
    .d(fch_ir[5]),
    .o(_al_u1032_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*A))"),
    .INIT(8'hd0))
    _al_u1033 (
    .a(_al_u502_o),
    .b(_al_u519_o),
    .c(fch_ir[10]),
    .o(_al_u1033_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u1034 (
    .a(_al_u608_o),
    .b(_al_u621_o),
    .c(_al_u1033_o),
    .d(_al_u441_o),
    .o(_al_u1034_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*~A)"),
    .INIT(32'h00001000))
    _al_u1035 (
    .a(\ctl/sel2_b0/or_or_or_B110_B111_o_o_lutinv ),
    .b(_al_u547_o),
    .c(_al_u1032_o),
    .d(_al_u1034_o),
    .e(\ctl/sel0_b2/or_or_B0_or_B1_B2_o__o_lutinv ),
    .o(\ctl_sela_rn[2]_neg_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(D*A*~(E*C*B))"),
    .INIT(32'h2a00aa00))
    _al_u1036 (
    .a(_al_u1028_o),
    .b(_al_u549_o),
    .c(_al_u603_o),
    .d(\ctl_sela_rn[2]_neg_lutinv ),
    .e(_al_u614_o),
    .o(_al_u1036_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B*A))"),
    .INIT(8'h70))
    _al_u1037 (
    .a(_al_u577_o),
    .b(_al_u453_o),
    .c(fch_ir[3]),
    .o(_al_u1037_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u1038 (
    .a(_al_u608_o),
    .b(_al_u371_o),
    .c(_al_u441_o),
    .d(\ctl/sel0_b0/or_B108_B109_o_lutinv ),
    .o(_al_u1038_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*~A)"),
    .INIT(32'h00000400))
    _al_u1039 (
    .a(_al_u500_o),
    .b(_al_u502_o),
    .c(_al_u519_o),
    .d(_al_u564_o),
    .e(_al_u463_o),
    .o(_al_u1039_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1040 (
    .a(_al_u1039_o),
    .b(fch_ir[8]),
    .o(_al_u1040_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*~B*~A)"),
    .INIT(32'h00000100))
    _al_u1041 (
    .a(\ctl/sel2_b0/or_or_or_B110_B111_o_o_lutinv ),
    .b(_al_u547_o),
    .c(_al_u1037_o),
    .d(_al_u1038_o),
    .e(_al_u1040_o),
    .o(_al_u1041_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1042 (
    .a(_al_u688_o),
    .b(fch_ir[4]),
    .o(_al_u1042_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u1043 (
    .a(_al_u1042_o),
    .b(_al_u350_o),
    .c(_al_u352_o),
    .d(fch_ir[0]),
    .o(_al_u1043_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1044 (
    .a(_al_u1031_o),
    .b(fch_ir[1]),
    .o(_al_u1044_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u1045 (
    .a(_al_u403_o),
    .b(_al_u635_o),
    .c(\ctl/sel0_b0/or_B108_B109_o_lutinv ),
    .o(_al_u1045_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1046 (
    .a(_al_u1039_o),
    .b(fch_ir[9]),
    .o(_al_u1046_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*~A)"),
    .INIT(32'h00000400))
    _al_u1047 (
    .a(_al_u404_o),
    .b(_al_u1043_o),
    .c(_al_u1044_o),
    .d(_al_u1045_o),
    .e(_al_u1046_o),
    .o(\ctl_sela_rn[1]_neg_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1048 (
    .a(\ctl_sela_rn[1]_neg_lutinv ),
    .b(\rgf/bank/gr01 [9]),
    .c(\rgf/bank/gr03 [9]),
    .o(_al_u1048_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1049 (
    .a(_al_u621_o),
    .b(\ctl/sel0_b2/or_or_B0_or_B1_B2_o__o_lutinv ),
    .c(_al_u1033_o),
    .o(_al_u1049_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~(E*C*~B*~A))"),
    .INIT(32'hef00ff00))
    _al_u1050 (
    .a(_al_u1015_o),
    .b(_al_u1016_o),
    .c(_al_u1021_o),
    .d(_al_u1049_o),
    .e(_al_u1022_o),
    .o(_al_u1050_o));
  AL_MAP_LUT4 #(
    .EQN("(~(~D*C)*~(B*~A))"),
    .INIT(16'hbb0b))
    _al_u1051 (
    .a(_al_u1030_o),
    .b(fch_ir[0]),
    .c(fch_ir[3]),
    .d(_al_u679_o),
    .o(_al_u1051_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1052 (
    .a(_al_u1051_o),
    .b(_al_u633_o),
    .c(_al_u631_o),
    .o(_al_u1052_o));
  AL_MAP_LUT5 #(
    .EQN("(D*C*B*~(E*A))"),
    .INIT(32'h4000c000))
    _al_u1053 (
    .a(_al_u1041_o),
    .b(_al_u1048_o),
    .c(_al_u1050_o),
    .d(_al_u1032_o),
    .e(_al_u1052_o),
    .o(_al_u1053_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1054 (
    .a(\ctl_sela_rn[1]_neg_lutinv ),
    .b(\rgf/bank/gr00 [9]),
    .c(\rgf/bank/gr02 [9]),
    .o(_al_u1054_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*A)"),
    .INIT(32'h20000000))
    _al_u1055 (
    .a(_al_u1041_o),
    .b(_al_u1054_o),
    .c(_al_u1050_o),
    .d(_al_u1032_o),
    .e(_al_u1052_o),
    .o(_al_u1055_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~B*~A)"),
    .INIT(32'h00010000))
    _al_u1056 (
    .a(\ctl/sel2_b0/or_or_or_B110_B111_o_o_lutinv ),
    .b(\rgf/sreg/mux2_b2_sel_is_2_o ),
    .c(\ctl/n169_lutinv ),
    .d(_al_u1037_o),
    .e(_al_u1038_o),
    .o(_al_u1056_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*A*~(E*~D)))"),
    .INIT(32'h4ccc4c4c))
    _al_u1057 (
    .a(_al_u1056_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(_al_u1039_o),
    .e(fch_ir[8]),
    .o(_al_u1057_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*~(E*D*A))"),
    .INIT(32'h01030303))
    _al_u1058 (
    .a(_al_u1036_o),
    .b(_al_u1053_o),
    .c(_al_u1055_o),
    .d(_al_u1057_o),
    .e(rgf_pc[9]),
    .o(_al_u1058_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(C*A*~(E*~D)))"),
    .INIT(32'h13331313))
    _al_u1059 (
    .a(_al_u1056_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(_al_u1039_o),
    .e(fch_ir[8]),
    .o(_al_u1059_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u1060 (
    .a(_al_u1015_o),
    .b(_al_u1016_o),
    .c(_al_u1021_o),
    .d(_al_u1022_o),
    .o(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1061 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(\rgf/ivec/iv [9]),
    .o(_al_u1061_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1062 (
    .a(_al_u1059_o),
    .b(_al_u1061_o),
    .o(\rgf/abus_iv [9]));
  AL_MAP_LUT5 #(
    .EQN("(C*~B*A*~(E*~D))"),
    .INIT(32'h20002020))
    _al_u1063 (
    .a(_al_u1056_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(_al_u1039_o),
    .e(fch_ir[8]),
    .o(_al_u1063_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u1064 (
    .a(_al_u1063_o),
    .b(_al_u1028_o),
    .c(\ctl_sela_rn[2]_neg_lutinv ),
    .d(\rgf/sptr/sp [9]),
    .o(\rgf/sptr/abus1 [9]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1065 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .o(_al_u1065_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1066 (
    .a(_al_u1052_o),
    .b(_al_u1041_o),
    .o(\ctl_sela_rn[0]_neg_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(A*(B*C*D*~(E)+~(B)*~(C)*~(D)*E+~(B)*~(C)*D*E+B*C*D*E))"),
    .INIT(32'h82028000))
    _al_u1067 (
    .a(_al_u1065_o),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr04 [9]),
    .e(\rgf/bank/gr07 [9]),
    .o(_al_u1067_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1068 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(\rgf/bank/gr06 [9]),
    .o(_al_u1068_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1069 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(\rgf/bank/gr05 [9]),
    .o(_al_u1069_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*(A*C*~(D)*~(E)+A*C*D*~(E)+~(A)*~(C)*D*E+~(A)*C*D*E))"),
    .INIT(32'h11002020))
    _al_u1070 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(_al_u1068_o),
    .d(_al_u1069_o),
    .e(\ctl_sela_rn[1]_neg_lutinv ),
    .o(_al_u1070_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~C*A*~(E*B))"),
    .INIT(32'h02000a00))
    _al_u1071 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(_al_u1041_o),
    .c(\ctl_sela_rn[2]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(_al_u1052_o),
    .o(\rgf/abus_sel_cr [5]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~A*~(D*B))"),
    .INIT(16'h0105))
    _al_u1072 (
    .a(_al_u1070_o),
    .b(\rgf/abus_sel_cr [5]),
    .c(_al_u1053_o),
    .d(n0[8]),
    .o(_al_u1072_o));
  AL_MAP_LUT5 #(
    .EQN("~(E*~D*~C*~B*A)"),
    .INIT(32'hfffdffff))
    _al_u1073 (
    .a(_al_u1058_o),
    .b(\rgf/abus_iv [9]),
    .c(\rgf/sptr/abus1 [9]),
    .d(_al_u1067_o),
    .e(_al_u1072_o),
    .o(abus[9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1074 (
    .a(_al_u1050_o),
    .b(_al_u1032_o),
    .o(_al_u1074_o));
  AL_MAP_LUT5 #(
    .EQN("(C*B*(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A))"),
    .INIT(32'hc0408000))
    _al_u1075 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr00 [8]),
    .e(\rgf/bank/gr01 [8]),
    .o(\rgf/bank/abuso/n8 [8]));
  AL_MAP_LUT5 #(
    .EQN("(~D*C*~B*~(E*A))"),
    .INIT(32'h00100030))
    _al_u1076 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .e(_al_u1052_o),
    .o(\rgf/abus_sel [5]));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*A)"),
    .INIT(32'h08000000))
    _al_u1077 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr02 [8]),
    .o(\rgf/bank/abuso/gr2_bus [8]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~A*~(D*B))"),
    .INIT(16'h0105))
    _al_u1078 (
    .a(\rgf/bank/abuso/n8 [8]),
    .b(\rgf/abus_sel [5]),
    .c(\rgf/bank/abuso/gr2_bus [8]),
    .d(\rgf/bank/gr05 [8]),
    .o(_al_u1078_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*B)*~(E*C*A))"),
    .INIT(32'h135f33ff))
    _al_u1079 (
    .a(_al_u1036_o),
    .b(\rgf/abus_sel_cr [5]),
    .c(_al_u1059_o),
    .d(n0[7]),
    .e(\rgf/ivec/iv [8]),
    .o(_al_u1079_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(~(B)*C*D*~(E)+B*~(C)*~(D)*E+B*~(C)*D*E+~(B)*C*D*E))"),
    .INIT(32'h28082000))
    _al_u1080 (
    .a(_al_u1036_o),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(rgf_pc[8]),
    .e(\rgf/sptr/sp [8]),
    .o(_al_u1080_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~C*~B*~(E*A))"),
    .INIT(32'h00010003))
    _al_u1081 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .e(_al_u1052_o),
    .o(\rgf/abus_sel [7]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*B*~(D*A))"),
    .INIT(32'h040c0000))
    _al_u1082 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr03 [8]),
    .o(\rgf/bank/abuso/gr3_bus [8]));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u1083 (
    .a(\rgf/abus_sel [7]),
    .b(\rgf/bank/abuso/gr3_bus [8]),
    .c(\rgf/bank/gr07 [8]),
    .o(_al_u1083_o));
  AL_MAP_LUT5 #(
    .EQN("(B*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'h88088000))
    _al_u1084 (
    .a(_al_u1065_o),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr04 [8]),
    .e(\rgf/bank/gr06 [8]),
    .o(_al_u1084_o));
  AL_MAP_LUT5 #(
    .EQN("~(~E*D*~C*B*A)"),
    .INIT(32'hfffff7ff))
    _al_u1085 (
    .a(_al_u1078_o),
    .b(_al_u1079_o),
    .c(_al_u1080_o),
    .d(_al_u1083_o),
    .e(_al_u1084_o),
    .o(abus[8]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1086 (
    .a(_al_u1045_o),
    .b(_al_u1046_o),
    .o(_al_u1086_o));
  AL_MAP_LUT5 #(
    .EQN("(D*A*~(~E*C*B))"),
    .INIT(32'haa002a00))
    _al_u1087 (
    .a(_al_u1050_o),
    .b(_al_u1086_o),
    .c(_al_u1043_o),
    .d(_al_u1032_o),
    .e(_al_u1044_o),
    .o(_al_u1087_o));
  AL_MAP_LUT5 #(
    .EQN("(B*(E*~(D)*~((C*A))+E*D*~((C*A))+~(E)*D*(C*A)+E*D*(C*A)))"),
    .INIT(32'hcc4c8000))
    _al_u1088 (
    .a(_al_u1041_o),
    .b(_al_u1087_o),
    .c(_al_u1052_o),
    .d(\rgf/bank/gr02 [15]),
    .e(\rgf/bank/gr03 [15]),
    .o(_al_u1088_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*~(D*C*A))"),
    .INIT(16'h1333))
    _al_u1089 (
    .a(_al_u1036_o),
    .b(_al_u1088_o),
    .c(_al_u1057_o),
    .d(rgf_pc[15]),
    .o(_al_u1089_o));
  AL_MAP_LUT5 #(
    .EQN("(E*C*B*~(D*A))"),
    .INIT(32'h40c00000))
    _al_u1090 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr01 [15]),
    .o(\rgf/bank/abuso/gr1_bus [15]));
  AL_MAP_LUT5 #(
    .EQN("(~B*(D*~(E)*~((C*A))+D*E*~((C*A))+~(D)*E*(C*A)+D*E*(C*A)))"),
    .INIT(32'h33201300))
    _al_u1091 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(\rgf/ivec/iv [15]),
    .e(\rgf/sptr/sp [15]),
    .o(_al_u1091_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u1092 (
    .a(\rgf/bank/abuso/gr1_bus [15]),
    .b(_al_u1091_o),
    .c(_al_u1028_o),
    .d(\ctl_sela_rn[2]_neg_lutinv ),
    .o(_al_u1092_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u1093 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr00 [15]),
    .o(\rgf/bank/abuso/gr0_bus [15]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u1094 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .o(_al_u1094_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)))"),
    .INIT(32'h11511555))
    _al_u1095 (
    .a(\rgf/bank/abuso/gr0_bus [15]),
    .b(_al_u1094_o),
    .c(\ctl_sela_rn[0]_neg_lutinv ),
    .d(\rgf/bank/gr06 [15]),
    .e(\rgf/bank/gr07 [15]),
    .o(_al_u1095_o));
  AL_MAP_LUT5 #(
    .EQN("(C*A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))"),
    .INIT(32'ha0208000))
    _al_u1096 (
    .a(_al_u1065_o),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr04 [15]),
    .e(\rgf/bank/gr05 [15]),
    .o(_al_u1096_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*~A)"),
    .INIT(32'h04000000))
    _al_u1097 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(\ctl_sela_rn[2]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(n0[14]),
    .o(\rgf/sptr/abus2 [15]));
  AL_MAP_LUT5 #(
    .EQN("~(~E*~D*C*B*A)"),
    .INIT(32'hffffff7f))
    _al_u1098 (
    .a(_al_u1089_o),
    .b(_al_u1092_o),
    .c(_al_u1095_o),
    .d(_al_u1096_o),
    .e(\rgf/sptr/abus2 [15]),
    .o(abus[15]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    _al_u1099 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .d(\rgf/bank/gr04 [14]),
    .o(_al_u1099_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~A*~(E*~D*C)))"),
    .INIT(32'h88c88888))
    _al_u1100 (
    .a(_al_u1099_o),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(_al_u1074_o),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(\rgf/bank/gr02 [14]),
    .o(_al_u1100_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~B*~A)"),
    .INIT(32'h00010000))
    _al_u1101 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .e(\rgf/bank/gr07 [14]),
    .o(\rgf/bank/abuso/gr7_bus [14]));
  AL_MAP_LUT5 #(
    .EQN("(D*C*~B*~(E*A))"),
    .INIT(32'h10003000))
    _al_u1102 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1050_o),
    .d(_al_u1032_o),
    .e(_al_u1052_o),
    .o(\rgf/abus_sel [3]));
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*~(D*C))"),
    .INIT(16'h0111))
    _al_u1103 (
    .a(_al_u1100_o),
    .b(\rgf/bank/abuso/gr7_bus [14]),
    .c(\rgf/abus_sel [3]),
    .d(\rgf/bank/gr03 [14]),
    .o(_al_u1103_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*~A)"),
    .INIT(32'h04000000))
    _al_u1104 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(\ctl_sela_rn[2]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(n0[13]),
    .o(\rgf/sptr/abus2 [14]));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u1105 (
    .a(\rgf/sptr/abus2 [14]),
    .b(_al_u1036_o),
    .c(_al_u1057_o),
    .d(rgf_pc[14]),
    .o(_al_u1105_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*A*(D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B))"),
    .INIT(32'h0a080200))
    _al_u1106 (
    .a(_al_u1036_o),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/ivec/iv [14]),
    .e(\rgf/sptr/sp [14]),
    .o(_al_u1106_o));
  AL_MAP_LUT5 #(
    .EQN("(C*B*(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A))"),
    .INIT(32'hc0408000))
    _al_u1107 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr00 [14]),
    .e(\rgf/bank/gr01 [14]),
    .o(\rgf/bank/abuso/n8 [14]));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~B*A)"),
    .INIT(32'h00020000))
    _al_u1108 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .e(_al_u1052_o),
    .o(\rgf/abus_sel [6]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(D*C)*~(E*B))"),
    .INIT(32'h01110555))
    _al_u1109 (
    .a(\rgf/bank/abuso/n8 [14]),
    .b(\rgf/abus_sel [6]),
    .c(\rgf/abus_sel [5]),
    .d(\rgf/bank/gr05 [14]),
    .e(\rgf/bank/gr06 [14]),
    .o(_al_u1109_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*~C*B*A)"),
    .INIT(16'hf7ff))
    _al_u1110 (
    .a(_al_u1103_o),
    .b(_al_u1105_o),
    .c(_al_u1106_o),
    .d(_al_u1109_o),
    .o(abus[14]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1111 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(\rgf/bank/gr01 [11]),
    .o(_al_u1111_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1112 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(\rgf/bank/gr06 [11]),
    .o(_al_u1112_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'hbfbfddff))
    _al_u1113 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(_al_u1111_o),
    .d(_al_u1112_o),
    .e(\ctl_sela_rn[1]_neg_lutinv ),
    .o(_al_u1113_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(D*C*B))"),
    .INIT(16'h2aaa))
    _al_u1114 (
    .a(_al_u1113_o),
    .b(_al_u1036_o),
    .c(_al_u1059_o),
    .d(\rgf/ivec/iv [11]),
    .o(_al_u1114_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*A)"),
    .INIT(32'h20000000))
    _al_u1115 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1050_o),
    .d(_al_u1032_o),
    .e(_al_u1052_o),
    .o(\rgf/abus_sel [2]));
  AL_MAP_LUT5 #(
    .EQN("(~(D*C)*~(E*B*A))"),
    .INIT(32'h07770fff))
    _al_u1116 (
    .a(_al_u1036_o),
    .b(_al_u1057_o),
    .c(\rgf/abus_sel [2]),
    .d(\rgf/bank/gr02 [11]),
    .e(rgf_pc[11]),
    .o(_al_u1116_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D*C*~B*~A))"),
    .INIT(32'hefff0000))
    _al_u1117 (
    .a(_al_u1015_o),
    .b(_al_u1016_o),
    .c(_al_u1021_o),
    .d(_al_u1022_o),
    .e(\rgf/bank/gr05 [11]),
    .o(_al_u1117_o));
  AL_MAP_LUT5 #(
    .EQN("(D*C*~B*~(E*A))"),
    .INIT(32'h10003000))
    _al_u1118 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1117_o),
    .e(_al_u1052_o),
    .o(\rgf/bank/abuso/gr5_bus [11]));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*~B*A)"),
    .INIT(32'h00200000))
    _al_u1119 (
    .a(_al_u1056_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(_al_u1040_o),
    .e(\rgf/sptr/sp [11]),
    .o(_al_u1119_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u1120 (
    .a(\rgf/bank/abuso/gr5_bus [11]),
    .b(_al_u1119_o),
    .c(_al_u1028_o),
    .d(\ctl_sela_rn[2]_neg_lutinv ),
    .o(_al_u1120_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1121 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\rgf/bank/gr00 [11]),
    .c(\rgf/bank/gr04 [11]),
    .o(_al_u1121_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1122 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\rgf/bank/gr03 [11]),
    .c(\rgf/bank/gr07 [11]),
    .o(_al_u1122_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*(~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+A*~(B)*C*D+A*B*C*D))"),
    .INIT(32'h0000a00c))
    _al_u1123 (
    .a(_al_u1121_o),
    .b(_al_u1122_o),
    .c(\ctl_sela_rn[0]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .o(_al_u1123_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*~A)"),
    .INIT(32'h10000000))
    _al_u1124 (
    .a(_al_u1015_o),
    .b(_al_u1016_o),
    .c(_al_u1021_o),
    .d(_al_u1022_o),
    .e(n0[10]),
    .o(_al_u1124_o));
  AL_MAP_LUT5 #(
    .EQN("(D*C*~B*~(E*A))"),
    .INIT(32'h10003000))
    _al_u1125 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1124_o),
    .e(_al_u1052_o),
    .o(\rgf/sptr/abus2 [11]));
  AL_MAP_LUT5 #(
    .EQN("~(~E*~D*C*B*A)"),
    .INIT(32'hffffff7f))
    _al_u1126 (
    .a(_al_u1114_o),
    .b(_al_u1116_o),
    .c(_al_u1120_o),
    .d(_al_u1123_o),
    .e(\rgf/sptr/abus2 [11]),
    .o(abus[11]));
  AL_MAP_LUT5 #(
    .EQN("(E*~B*~(~D*C*A))"),
    .INIT(32'h33130000))
    _al_u1127 (
    .a(_al_u1056_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(_al_u1040_o),
    .e(\rgf/ivec/iv [10]),
    .o(_al_u1127_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~C*~(D*B)))"),
    .INIT(16'ha8a0))
    _al_u1128 (
    .a(_al_u1036_o),
    .b(_al_u1063_o),
    .c(_al_u1127_o),
    .d(\rgf/sptr/sp [10]),
    .o(_al_u1128_o));
  AL_MAP_LUT5 #(
    .EQN("(B*((E*C)*~(D)*~(A)+(E*C)*D*~(A)+~((E*C))*D*A+(E*C)*D*A))"),
    .INIT(32'hc8408800))
    _al_u1129 (
    .a(_al_u1036_o),
    .b(_al_u1057_o),
    .c(\rgf/bank/gr05 [10]),
    .d(rgf_pc[10]),
    .e(_al_u1065_o),
    .o(_al_u1129_o));
  AL_MAP_LUT5 #(
    .EQN("(E*C*B*~(D*A))"),
    .INIT(32'h40c00000))
    _al_u1130 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr01 [10]),
    .o(\rgf/bank/abuso/gr1_bus [10]));
  AL_MAP_LUT5 #(
    .EQN("(B*(E*~(D)*~((C*A))+E*D*~((C*A))+~(E)*D*(C*A)+E*D*(C*A)))"),
    .INIT(32'hcc4c8000))
    _al_u1131 (
    .a(_al_u1041_o),
    .b(_al_u1087_o),
    .c(_al_u1052_o),
    .d(\rgf/bank/gr02 [10]),
    .e(\rgf/bank/gr03 [10]),
    .o(_al_u1131_o));
  AL_MAP_LUT5 #(
    .EQN("(C*B*A*~(E*~D))"),
    .INIT(32'h80008080))
    _al_u1132 (
    .a(_al_u1056_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(_al_u1039_o),
    .e(fch_ir[8]),
    .o(_al_u1132_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(E*D*C))"),
    .INIT(32'h01111111))
    _al_u1133 (
    .a(\rgf/bank/abuso/gr1_bus [10]),
    .b(_al_u1131_o),
    .c(_al_u1132_o),
    .d(_al_u1074_o),
    .e(\rgf/bank/gr00 [10]),
    .o(_al_u1133_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D)*~((~C*B*A))+E*D*~((~C*B*A))+~(E)*D*(~C*B*A)+E*D*(~C*B*A))"),
    .INIT(32'hfff70800))
    _al_u1134 (
    .a(_al_u1056_o),
    .b(_al_u1052_o),
    .c(_al_u1040_o),
    .d(\rgf/bank/gr06 [10]),
    .e(\rgf/bank/gr07 [10]),
    .o(_al_u1134_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(B*~((E*C))*~(D)+B*(E*C)*~(D)+~(B)*(E*C)*D+B*(E*C)*D))"),
    .INIT(32'ha0880088))
    _al_u1135 (
    .a(_al_u1065_o),
    .b(_al_u1134_o),
    .c(\ctl_sela_rn[0]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(\rgf/bank/gr04 [10]),
    .o(_al_u1135_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1136 (
    .a(\rgf/abus_sel_cr [5]),
    .b(n0[9]),
    .o(\rgf/sptr/abus2 [10]));
  AL_MAP_LUT5 #(
    .EQN("~(~E*~D*C*~B*~A)"),
    .INIT(32'hffffffef))
    _al_u1137 (
    .a(_al_u1128_o),
    .b(_al_u1129_o),
    .c(_al_u1133_o),
    .d(_al_u1135_o),
    .e(\rgf/sptr/abus2 [10]),
    .o(abus[10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1138 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(n0[0]),
    .o(_al_u1138_o));
  AL_MAP_LUT5 #(
    .EQN("(D*C*~B*~(E*A))"),
    .INIT(32'h10003000))
    _al_u1139 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(_al_u1138_o),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(_al_u1052_o),
    .o(\rgf/sptr/abus2 [1]));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u1140 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .o(_al_u1140_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D)*~((~C*B*A))+E*D*~((~C*B*A))+~(E)*D*(~C*B*A)+E*D*(~C*B*A))"),
    .INIT(32'hfff70800))
    _al_u1141 (
    .a(_al_u1056_o),
    .b(_al_u1052_o),
    .c(_al_u1040_o),
    .d(\rgf/bank/gr04 [1]),
    .e(\rgf/bank/gr05 [1]),
    .o(_al_u1141_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D)*~((~C*B*A))+E*D*~((~C*B*A))+~(E)*D*(~C*B*A)+E*D*(~C*B*A))"),
    .INIT(32'hfff70800))
    _al_u1142 (
    .a(_al_u1056_o),
    .b(_al_u1052_o),
    .c(_al_u1040_o),
    .d(\rgf/bank/gr02 [1]),
    .e(\rgf/bank/gr03 [1]),
    .o(_al_u1142_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*D)*~(C*B))"),
    .INIT(32'h00151515))
    _al_u1143 (
    .a(\rgf/sptr/abus2 [1]),
    .b(_al_u1140_o),
    .c(_al_u1141_o),
    .d(_al_u1142_o),
    .e(_al_u1087_o),
    .o(_al_u1143_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1144 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(\rgf/ivec/iv [1]),
    .o(_al_u1144_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u1145 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(\rgf/bank/gr00 [1]),
    .o(_al_u1145_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hbff5))
    _al_u1146 (
    .a(_al_u1144_o),
    .b(_al_u1145_o),
    .c(\ctl_sela_rn[0]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .o(_al_u1146_o));
  AL_MAP_LUT5 #(
    .EQN("(E*C*B*~(D*A))"),
    .INIT(32'h40c00000))
    _al_u1147 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr01 [1]),
    .o(\rgf/bank/abuso/gr1_bus [1]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)))"),
    .INIT(32'h11511555))
    _al_u1148 (
    .a(\rgf/bank/abuso/gr1_bus [1]),
    .b(_al_u1094_o),
    .c(\ctl_sela_rn[0]_neg_lutinv ),
    .d(\rgf/bank/gr06 [1]),
    .e(\rgf/bank/gr07 [1]),
    .o(_al_u1148_o));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~((C*A))*~(D)*~(E)+B*~((C*A))*~(D)*~(E)+~(B)*(C*A)*~(D)*~(E)+B*(C*A)*~(D)*~(E)+~(B)*~((C*A))*D*~(E)+~(B)*(C*A)*D*~(E)+B*(C*A)*D*~(E)+~(B)*~((C*A))*~(D)*E+B*~((C*A))*~(D)*E+B*(C*A)*~(D)*E+~(B)*~((C*A))*D*E+B*(C*A)*D*E)"),
    .INIT(32'h93dfb3ff))
    _al_u1149 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(rgf_pc[1]),
    .e(\rgf/sptr/sp [1]),
    .o(_al_u1149_o));
  AL_MAP_LUT5 #(
    .EQN("~(C*B*A*~(~E*D))"),
    .INIT(32'h7f7fff7f))
    _al_u1150 (
    .a(_al_u1143_o),
    .b(_al_u1146_o),
    .c(_al_u1148_o),
    .d(_al_u1036_o),
    .e(_al_u1149_o),
    .o(abus[1]));
  AL_MAP_LUT5 #(
    .EQN("(~B*A*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))"),
    .INIT(32'h22200200))
    _al_u1151 (
    .a(_al_u1036_o),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(rgf_iv_ve),
    .e(rgf_pc[0]),
    .o(_al_u1151_o));
  AL_MAP_LUT5 #(
    .EQN("(E*A*(B*C*~(D)+~(B)*~(C)*D))"),
    .INIT(32'h02800000))
    _al_u1152 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(\ctl_sela_rn[2]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(\rgf/sptr/sp [0]),
    .o(\rgf/abus_sp [0]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1153 (
    .a(\ctl_sela_rn[1]_neg_lutinv ),
    .b(\rgf/bank/gr04 [0]),
    .c(\rgf/bank/gr06 [0]),
    .o(_al_u1153_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~B*A)"),
    .INIT(32'h00020000))
    _al_u1154 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(_al_u1153_o),
    .d(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .e(_al_u1052_o),
    .o(_al_u1154_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*B*~(D*A))"),
    .INIT(32'h040c0000))
    _al_u1155 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr03 [0]),
    .o(\rgf/bank/abuso/gr3_bus [0]));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(E*D*C))"),
    .INIT(32'h01111111))
    _al_u1156 (
    .a(_al_u1154_o),
    .b(\rgf/bank/abuso/gr3_bus [0]),
    .c(_al_u1132_o),
    .d(_al_u1074_o),
    .e(\rgf/bank/gr00 [0]),
    .o(_al_u1156_o));
  AL_MAP_LUT5 #(
    .EQN("(D*C*B*~(E*A))"),
    .INIT(32'h4000c000))
    _al_u1157 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1050_o),
    .d(_al_u1032_o),
    .e(_al_u1052_o),
    .o(\rgf/abus_sel [1]));
  AL_MAP_LUT4 #(
    .EQN("(~(C*B)*~(D*A))"),
    .INIT(16'h153f))
    _al_u1158 (
    .a(\rgf/abus_sel [5]),
    .b(\rgf/abus_sel [1]),
    .c(\rgf/bank/gr01 [0]),
    .d(\rgf/bank/gr05 [0]),
    .o(_al_u1158_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D*C*~B*~A))"),
    .INIT(32'hefff0000))
    _al_u1159 (
    .a(_al_u1015_o),
    .b(_al_u1016_o),
    .c(_al_u1021_o),
    .d(_al_u1022_o),
    .e(\rgf/bank/gr07 [0]),
    .o(_al_u1159_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*(A*B*D*~(E)+~(A)*~(B)*~(D)*E+~(A)*~(B)*D*E+A*B*D*E))"),
    .INIT(32'h09010800))
    _al_u1160 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr02 [0]),
    .e(_al_u1159_o),
    .o(_al_u1160_o));
  AL_MAP_LUT5 #(
    .EQN("~(~E*D*C*~B*~A)"),
    .INIT(32'hffffefff))
    _al_u1161 (
    .a(_al_u1151_o),
    .b(\rgf/abus_sp [0]),
    .c(_al_u1156_o),
    .d(_al_u1158_o),
    .e(_al_u1160_o),
    .o(abus[0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u1162 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(\rgf/bank/gr07 [9]),
    .o(_al_u1162_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1163 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(\rgf/sptr/sp [9]),
    .o(_al_u1163_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u1164 (
    .a(_al_u1162_o),
    .b(_al_u1163_o),
    .c(\ctl_sela_rn[0]_neg_lutinv ),
    .o(_al_u1164_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1165 (
    .a(ctl_bcmdw),
    .b(ctl_bcmdr),
    .o(_al_u1165_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(~E*~D*~B*A))"),
    .INIT(32'h0f0f0f0d))
    _al_u1166 (
    .a(_al_u1072_o),
    .b(_al_u1164_o),
    .c(_al_u1165_o),
    .d(_al_u1055_o),
    .e(_al_u1067_o),
    .o(\mem/babf/n1 [9]));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u1167 (
    .a(_al_u1056_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(_al_u1040_o),
    .o(_al_u1167_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1168 (
    .a(_al_u1167_o),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .o(\rgf/abus_sel_cr [2]));
  AL_MAP_LUT5 #(
    .EQN("(A*((D*C)*~(E)*~(B)+(D*C)*E*~(B)+~((D*C))*E*B+(D*C)*E*B))"),
    .INIT(32'ha8882000))
    _al_u1169 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr04 [8]),
    .e(\rgf/bank/abuso/gr2_bus [8]),
    .o(_al_u1169_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(D*C)*~(E*A))"),
    .INIT(32'h01110333))
    _al_u1170 (
    .a(\rgf/abus_sel_cr [2]),
    .b(_al_u1169_o),
    .c(\rgf/abus_sel_cr [5]),
    .d(n0[7]),
    .e(\rgf/sptr/sp [8]),
    .o(_al_u1170_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u1171 (
    .a(\rgf/abus_sel [5]),
    .b(\rgf/bank/abuso/gr3_bus [8]),
    .c(\rgf/bank/gr05 [8]),
    .o(_al_u1171_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u1172 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr00 [8]),
    .o(\rgf/bank/abuso/gr0_bus [8]));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(D*C)*~(E*A))"),
    .INIT(32'h01110333))
    _al_u1173 (
    .a(\rgf/abus_sel [7]),
    .b(\rgf/bank/abuso/gr0_bus [8]),
    .c(\rgf/abus_sel [1]),
    .d(\rgf/bank/gr01 [8]),
    .e(\rgf/bank/gr07 [8]),
    .o(_al_u1173_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(~E*C*~B*A))"),
    .INIT(32'h00ff00df))
    _al_u1174 (
    .a(_al_u1170_o),
    .b(_al_u1171_o),
    .c(_al_u1173_o),
    .d(_al_u1165_o),
    .e(_al_u1084_o),
    .o(\mem/babf/n1 [8]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*B*~(D*A))"),
    .INIT(32'h040c0000))
    _al_u1175 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr03 [7]),
    .o(\rgf/bank/abuso/gr3_bus [7]));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u1176 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr00 [7]),
    .o(\rgf/bank/abuso/gr0_bus [7]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*A)"),
    .INIT(16'h0200))
    _al_u1177 (
    .a(_al_u1086_o),
    .b(_al_u1042_o),
    .c(_al_u1044_o),
    .d(\rgf/bank/gr04 [7]),
    .o(_al_u1177_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*~B*A)"),
    .INIT(32'h00200000))
    _al_u1178 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(_al_u1177_o),
    .d(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .e(_al_u1052_o),
    .o(\rgf/bank/abuso/gr4_bus [7]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*~A*~(E*D))"),
    .INIT(32'h00010101))
    _al_u1179 (
    .a(\rgf/bank/abuso/gr3_bus [7]),
    .b(\rgf/bank/abuso/gr0_bus [7]),
    .c(\rgf/bank/abuso/gr4_bus [7]),
    .d(\rgf/abus_sel [2]),
    .e(\rgf/bank/gr02 [7]),
    .o(_al_u1179_o));
  AL_MAP_LUT5 #(
    .EQN("((D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B)*~(C*A))"),
    .INIT(32'h5f4c1300))
    _al_u1180 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(\rgf/ivec/iv [7]),
    .e(rgf_pc[7]),
    .o(_al_u1180_o));
  AL_MAP_LUT5 #(
    .EQN("(C*A*(D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B))"),
    .INIT(32'ha0802000))
    _al_u1181 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(\rgf/sptr/sp [7]),
    .e(rgf_sr_flag[3]),
    .o(_al_u1181_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~A*~(~C*~B))"),
    .INIT(32'h54000000))
    _al_u1182 (
    .a(_al_u615_o),
    .b(_al_u1180_o),
    .c(_al_u1181_o),
    .d(_al_u1028_o),
    .e(\ctl_sela_rn[2]_neg_lutinv ),
    .o(_al_u1182_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*~A)"),
    .INIT(32'h04000000))
    _al_u1183 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(\ctl_sela_rn[2]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(n0[6]),
    .o(\rgf/sptr/abus2 [7]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1184 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(\rgf/bank/gr06 [7]),
    .o(_al_u1184_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1185 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(\rgf/bank/gr01 [7]),
    .o(_al_u1185_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'hbbffdfdf))
    _al_u1186 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(_al_u1184_o),
    .d(_al_u1185_o),
    .e(\ctl_sela_rn[1]_neg_lutinv ),
    .o(_al_u1186_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u1187 (
    .a(_al_u1186_o),
    .b(\rgf/abus_sel [7]),
    .c(\rgf/abus_sel [5]),
    .d(\rgf/bank/gr05 [7]),
    .e(\rgf/bank/gr07 [7]),
    .o(_al_u1187_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*~C*~B*A)"),
    .INIT(16'hfdff))
    _al_u1188 (
    .a(_al_u1179_o),
    .b(_al_u1182_o),
    .c(\rgf/sptr/abus2 [7]),
    .d(_al_u1187_o),
    .o(abus[7]));
  AL_MAP_LUT5 #(
    .EQN("(E*C*B*~(D*A))"),
    .INIT(32'h40c00000))
    _al_u1189 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr01 [6]),
    .o(\rgf/bank/abuso/gr1_bus [6]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(B*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)))"),
    .INIT(32'h11511555))
    _al_u1190 (
    .a(\rgf/bank/abuso/gr1_bus [6]),
    .b(_al_u1094_o),
    .c(\ctl_sela_rn[0]_neg_lutinv ),
    .d(\rgf/bank/gr06 [6]),
    .e(\rgf/bank/gr07 [6]),
    .o(_al_u1190_o));
  AL_MAP_LUT5 #(
    .EQN("(B*(D*~(E)*~((C*A))+D*E*~((C*A))+~(D)*E*(C*A)+D*E*(C*A)))"),
    .INIT(32'hcc804c00))
    _al_u1191 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(rgf_pc[6]),
    .e(rgf_sr_flag[2]),
    .o(_al_u1191_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B*~(~D*~(E*C))))"),
    .INIT(32'h222a22aa))
    _al_u1192 (
    .a(_al_u1190_o),
    .b(_al_u1036_o),
    .c(_al_u1059_o),
    .d(_al_u1191_o),
    .e(\rgf/ivec/iv [6]),
    .o(_al_u1192_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*B*~(D*A))"),
    .INIT(32'h040c0000))
    _al_u1193 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr03 [6]),
    .o(\rgf/bank/abuso/gr3_bus [6]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(E*B)*~(D*A))"),
    .INIT(32'h0103050f))
    _al_u1194 (
    .a(\rgf/abus_sel_cr [5]),
    .b(\rgf/abus_sel [5]),
    .c(\rgf/bank/abuso/gr3_bus [6]),
    .d(n0[5]),
    .e(\rgf/bank/gr05 [6]),
    .o(_al_u1194_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    _al_u1195 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .d(\rgf/bank/gr04 [6]),
    .o(_al_u1195_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*C)*~(E*B*A))"),
    .INIT(32'h07770fff))
    _al_u1196 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(_al_u1167_o),
    .c(_al_u1195_o),
    .d(\ctl_sela_rn[0]_neg_lutinv ),
    .e(\rgf/sptr/sp [6]),
    .o(_al_u1196_o));
  AL_MAP_LUT5 #(
    .EQN("(B*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'h88088000))
    _al_u1197 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr00 [6]),
    .e(\rgf/bank/gr02 [6]),
    .o(_al_u1197_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*C*B*A)"),
    .INIT(16'hff7f))
    _al_u1198 (
    .a(_al_u1192_o),
    .b(_al_u1194_o),
    .c(_al_u1196_o),
    .d(_al_u1197_o),
    .o(abus[6]));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~B*A)"),
    .INIT(32'h00020000))
    _al_u1199 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .e(\rgf/bank/gr06 [5]),
    .o(\rgf/bank/abuso/gr6_bus [5]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~((C*A))*~(D)*~(E)+B*~((C*A))*~(D)*~(E)+~(B)*(C*A)*~(D)*~(E)+B*(C*A)*~(D)*~(E)+B*~((C*A))*D*~(E)+~(B)*(C*A)*D*~(E)+B*(C*A)*D*~(E)+~(B)*~((C*A))*~(D)*E+B*~((C*A))*~(D)*E+~(B)*(C*A)*~(D)*E+B*~((C*A))*D*E+~(B)*(C*A)*D*E)"),
    .INIT(32'h6c7fecff))
    _al_u1200 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(\rgf/ivec/iv [5]),
    .e(rgf_sr_flag[1]),
    .o(_al_u1200_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(B*~(D*~(E*C))))"),
    .INIT(32'h15115511))
    _al_u1201 (
    .a(\rgf/bank/abuso/gr6_bus [5]),
    .b(_al_u1036_o),
    .c(_al_u1057_o),
    .d(_al_u1200_o),
    .e(rgf_pc[5]),
    .o(_al_u1201_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1202 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(\rgf/bank/gr05 [5]),
    .o(_al_u1202_o));
  AL_MAP_LUT5 #(
    .EQN("(D*C*~B*~(E*A))"),
    .INIT(32'h10003000))
    _al_u1203 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(_al_u1202_o),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(_al_u1052_o),
    .o(\rgf/bank/abuso/gr5_bus [5]));
  AL_MAP_LUT4 #(
    .EQN("(~B*~(D*C*A))"),
    .INIT(16'h1333))
    _al_u1204 (
    .a(_al_u1036_o),
    .b(\rgf/bank/abuso/gr5_bus [5]),
    .c(_al_u1063_o),
    .d(\rgf/sptr/sp [5]),
    .o(_al_u1204_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*~B*A)"),
    .INIT(32'h00200000))
    _al_u1205 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .e(_al_u1052_o),
    .o(\rgf/abus_sel [4]));
  AL_MAP_LUT5 #(
    .EQN("(B*(E*~(D)*~((C*A))+E*D*~((C*A))+~(E)*D*(C*A)+E*D*(C*A)))"),
    .INIT(32'hcc4c8000))
    _al_u1206 (
    .a(_al_u1041_o),
    .b(_al_u1087_o),
    .c(_al_u1052_o),
    .d(\rgf/bank/gr02 [5]),
    .e(\rgf/bank/gr03 [5]),
    .o(_al_u1206_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(D*C)*~(E*A))"),
    .INIT(32'h01110333))
    _al_u1207 (
    .a(\rgf/abus_sel [4]),
    .b(_al_u1206_o),
    .c(\rgf/abus_sel [1]),
    .d(\rgf/bank/gr01 [5]),
    .e(\rgf/bank/gr04 [5]),
    .o(_al_u1207_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*C*B)*~(E*A))"),
    .INIT(32'h15553fff))
    _al_u1208 (
    .a(\rgf/abus_sel [7]),
    .b(_al_u1132_o),
    .c(_al_u1074_o),
    .d(\rgf/bank/gr00 [5]),
    .e(\rgf/bank/gr07 [5]),
    .o(_al_u1208_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*~A)"),
    .INIT(32'h04000000))
    _al_u1209 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(\ctl_sela_rn[2]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(n0[4]),
    .o(\rgf/sptr/abus2 [5]));
  AL_MAP_LUT5 #(
    .EQN("~(~E*D*C*B*A)"),
    .INIT(32'hffff7fff))
    _al_u1210 (
    .a(_al_u1201_o),
    .b(_al_u1204_o),
    .c(_al_u1207_o),
    .d(_al_u1208_o),
    .e(\rgf/sptr/abus2 [5]),
    .o(abus[5]));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u1211 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(\rgf/bank/gr07 [4]),
    .o(_al_u1211_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*(A*~((E*C))*~(B)+A*(E*C)*~(B)+~(A)*(E*C)*B+A*(E*C)*B))"),
    .INIT(32'h00e20022))
    _al_u1212 (
    .a(_al_u1211_o),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(_al_u1074_o),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(\rgf/bank/gr02 [4]),
    .o(_al_u1212_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~B*A)"),
    .INIT(32'h00020000))
    _al_u1213 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .e(\rgf/bank/gr06 [4]),
    .o(\rgf/bank/abuso/gr6_bus [4]));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(E*D*C))"),
    .INIT(32'h01111111))
    _al_u1214 (
    .a(_al_u1212_o),
    .b(\rgf/bank/abuso/gr6_bus [4]),
    .c(_al_u1036_o),
    .d(_al_u1132_o),
    .e(rgf_sr_flag[0]),
    .o(_al_u1214_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*~A)"),
    .INIT(32'h04000000))
    _al_u1215 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(\ctl_sela_rn[2]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(n0[3]),
    .o(\rgf/sptr/abus2 [4]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D*C*~B*~A))"),
    .INIT(32'hefff0000))
    _al_u1216 (
    .a(_al_u1015_o),
    .b(_al_u1016_o),
    .c(_al_u1021_o),
    .d(_al_u1022_o),
    .e(\rgf/bank/gr05 [4]),
    .o(_al_u1216_o));
  AL_MAP_LUT5 #(
    .EQN("(D*C*~B*~(E*A))"),
    .INIT(32'h10003000))
    _al_u1217 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1216_o),
    .e(_al_u1052_o),
    .o(\rgf/bank/abuso/gr5_bus [4]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~A*~(E*D*B))"),
    .INIT(32'h01050505))
    _al_u1218 (
    .a(\rgf/sptr/abus2 [4]),
    .b(_al_u1036_o),
    .c(\rgf/bank/abuso/gr5_bus [4]),
    .d(_al_u1063_o),
    .e(\rgf/sptr/sp [4]),
    .o(_al_u1218_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*C)*~(E*B*A))"),
    .INIT(32'h07770fff))
    _al_u1219 (
    .a(_al_u1036_o),
    .b(_al_u1057_o),
    .c(\rgf/abus_sel [3]),
    .d(\rgf/bank/gr03 [4]),
    .e(rgf_pc[4]),
    .o(_al_u1219_o));
  AL_MAP_LUT5 #(
    .EQN("(E*C*B*~(D*A))"),
    .INIT(32'h40c00000))
    _al_u1220 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr01 [4]),
    .o(\rgf/bank/abuso/gr1_bus [4]));
  AL_MAP_LUT5 #(
    .EQN("(E*~B*~(~D*C*A))"),
    .INIT(32'h33130000))
    _al_u1221 (
    .a(_al_u1056_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(_al_u1040_o),
    .e(\rgf/ivec/iv [4]),
    .o(_al_u1221_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u1222 (
    .a(\rgf/bank/abuso/gr1_bus [4]),
    .b(_al_u1221_o),
    .c(_al_u1028_o),
    .d(\ctl_sela_rn[2]_neg_lutinv ),
    .o(_al_u1222_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))"),
    .INIT(32'h0a020800))
    _al_u1223 (
    .a(_al_u1132_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .d(\rgf/bank/gr00 [4]),
    .e(\rgf/bank/gr04 [4]),
    .o(_al_u1223_o));
  AL_MAP_LUT5 #(
    .EQN("~(~E*D*C*B*A)"),
    .INIT(32'hffff7fff))
    _al_u1224 (
    .a(_al_u1214_o),
    .b(_al_u1218_o),
    .c(_al_u1219_o),
    .d(_al_u1222_o),
    .e(_al_u1223_o),
    .o(abus[4]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1225 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(\rgf/ivec/iv [3]),
    .o(_al_u1225_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*(A*~((E*C))*~(B)+A*(E*C)*~(B)+~(A)*(E*C)*B+A*(E*C)*B))"),
    .INIT(32'h00e20022))
    _al_u1226 (
    .a(_al_u1225_o),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(_al_u1074_o),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(\rgf/bank/gr02 [3]),
    .o(_al_u1226_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1227 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(n0[2]),
    .o(_al_u1227_o));
  AL_MAP_LUT5 #(
    .EQN("(D*C*~B*~(E*A))"),
    .INIT(32'h10003000))
    _al_u1228 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(_al_u1227_o),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(_al_u1052_o),
    .o(\rgf/sptr/abus2 [3]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~A*~(E*D*B))"),
    .INIT(32'h01050505))
    _al_u1229 (
    .a(_al_u1226_o),
    .b(_al_u1036_o),
    .c(\rgf/sptr/abus2 [3]),
    .d(_al_u1132_o),
    .e(rgf_sr_ie[1]),
    .o(_al_u1229_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1230 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(\rgf/bank/gr07 [3]),
    .o(_al_u1230_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1231 (
    .a(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(\rgf/bank/gr01 [3]),
    .o(_al_u1231_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*(~(B)*C*~(D)*~(E)+~(B)*C*D*~(E)+B*~(C)*D*E+B*C*D*E))"),
    .INIT(32'h44001010))
    _al_u1232 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(_al_u1230_o),
    .d(_al_u1231_o),
    .e(\ctl_sela_rn[1]_neg_lutinv ),
    .o(_al_u1232_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1233 (
    .a(\ctl_sela_rn[1]_neg_lutinv ),
    .b(\rgf/bank/gr00 [3]),
    .o(_al_u1233_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u1234 (
    .a(_al_u1041_o),
    .b(_al_u1233_o),
    .c(_al_u1050_o),
    .d(_al_u1032_o),
    .e(_al_u1052_o),
    .o(\rgf/bank/abuso/gr0_bus [3]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~A*~(E*D*B))"),
    .INIT(32'h01050505))
    _al_u1235 (
    .a(_al_u1232_o),
    .b(_al_u1036_o),
    .c(\rgf/bank/abuso/gr0_bus [3]),
    .d(_al_u1057_o),
    .e(rgf_pc[3]),
    .o(_al_u1235_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*B)*~(E*C*A))"),
    .INIT(32'h135f33ff))
    _al_u1236 (
    .a(_al_u1036_o),
    .b(\rgf/abus_sel [4]),
    .c(_al_u1063_o),
    .d(\rgf/bank/gr04 [3]),
    .e(\rgf/sptr/sp [3]),
    .o(_al_u1236_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*B*~(D*A))"),
    .INIT(32'h040c0000))
    _al_u1237 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr03 [3]),
    .o(\rgf/bank/abuso/gr3_bus [3]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*~A)"),
    .INIT(16'h0100))
    _al_u1238 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .d(\rgf/bank/gr06 [3]),
    .o(_al_u1238_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(D*C)*~(E*A))"),
    .INIT(32'h01110333))
    _al_u1239 (
    .a(\rgf/abus_sel [5]),
    .b(\rgf/bank/abuso/gr3_bus [3]),
    .c(_al_u1238_o),
    .d(\ctl_sela_rn[0]_neg_lutinv ),
    .e(\rgf/bank/gr05 [3]),
    .o(_al_u1239_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*C*B*A)"),
    .INIT(16'h7fff))
    _al_u1240 (
    .a(_al_u1229_o),
    .b(_al_u1235_o),
    .c(_al_u1236_o),
    .d(_al_u1239_o),
    .o(abus[3]));
  AL_MAP_LUT5 #(
    .EQN("(B*(A*C*D*~(E)+~(A)*~(C)*~(D)*E+~(A)*~(C)*D*E+A*C*D*E))"),
    .INIT(32'h84048000))
    _al_u1241 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr00 [2]),
    .e(\rgf/bank/gr03 [2]),
    .o(_al_u1241_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*B*A)"),
    .INIT(32'h00800000))
    _al_u1242 (
    .a(_al_u1056_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(_al_u1040_o),
    .e(rgf_sr_ie[0]),
    .o(_al_u1242_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(B*~(~D*~(E*C))))"),
    .INIT(32'h11151155))
    _al_u1243 (
    .a(_al_u1241_o),
    .b(_al_u1036_o),
    .c(_al_u1059_o),
    .d(_al_u1242_o),
    .e(\rgf/ivec/iv [2]),
    .o(_al_u1243_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*~B*~A)"),
    .INIT(32'h00100000))
    _al_u1244 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .e(\rgf/bank/gr05 [2]),
    .o(\rgf/bank/abuso/gr5_bus [2]));
  AL_MAP_LUT5 #(
    .EQN("(E*C*B*~(D*A))"),
    .INIT(32'h40c00000))
    _al_u1245 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr01 [2]),
    .o(\rgf/bank/abuso/gr1_bus [2]));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*~A)"),
    .INIT(32'h10000000))
    _al_u1246 (
    .a(_al_u1015_o),
    .b(_al_u1016_o),
    .c(_al_u1021_o),
    .d(_al_u1022_o),
    .e(n0[1]),
    .o(_al_u1246_o));
  AL_MAP_LUT5 #(
    .EQN("(D*C*~B*~(E*A))"),
    .INIT(32'h10003000))
    _al_u1247 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1246_o),
    .e(_al_u1052_o),
    .o(\rgf/sptr/abus2 [2]));
  AL_MAP_LUT5 #(
    .EQN("(~D*~C*~A*~(E*B))"),
    .INIT(32'h00010005))
    _al_u1248 (
    .a(\rgf/bank/abuso/gr5_bus [2]),
    .b(\rgf/abus_sel [7]),
    .c(\rgf/bank/abuso/gr1_bus [2]),
    .d(\rgf/sptr/abus2 [2]),
    .e(\rgf/bank/gr07 [2]),
    .o(_al_u1248_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(~(B)*C*D*~(E)+B*~(C)*~(D)*E+B*~(C)*D*E+~(B)*C*D*E))"),
    .INIT(32'h28082000))
    _al_u1249 (
    .a(_al_u1036_o),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(rgf_pc[2]),
    .e(\rgf/sptr/sp [2]),
    .o(_al_u1249_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*A)"),
    .INIT(32'h08000000))
    _al_u1250 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr02 [2]),
    .o(\rgf/bank/abuso/gr2_bus [2]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*~A)"),
    .INIT(16'h0100))
    _al_u1251 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .d(\rgf/bank/gr06 [2]),
    .o(_al_u1251_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(D*C)*~(E*A))"),
    .INIT(32'h01110333))
    _al_u1252 (
    .a(\rgf/abus_sel [4]),
    .b(\rgf/bank/abuso/gr2_bus [2]),
    .c(_al_u1251_o),
    .d(\ctl_sela_rn[0]_neg_lutinv ),
    .e(\rgf/bank/gr04 [2]),
    .o(_al_u1252_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*~C*B*A)"),
    .INIT(16'hf7ff))
    _al_u1253 (
    .a(_al_u1243_o),
    .b(_al_u1248_o),
    .c(_al_u1249_o),
    .d(_al_u1252_o),
    .o(abus[2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1254 (
    .a(_al_u1036_o),
    .b(\rgf/sptr/sp [15]),
    .o(_al_u1254_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1255 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(\rgf/bank/gr00 [15]),
    .o(_al_u1255_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h0415))
    _al_u1256 (
    .a(\rgf/bank/abuso/gr1_bus [15]),
    .b(_al_u1255_o),
    .c(\ctl_sela_rn[0]_neg_lutinv ),
    .d(_al_u1088_o),
    .o(_al_u1256_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    _al_u1257 (
    .a(_al_u1056_o),
    .b(_al_u1052_o),
    .c(\rgf/bank/gr06 [15]),
    .d(\rgf/bank/gr07 [15]),
    .o(_al_u1257_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    _al_u1258 (
    .a(_al_u1056_o),
    .b(_al_u1052_o),
    .c(\rgf/bank/gr04 [15]),
    .d(\rgf/bank/gr05 [15]),
    .o(_al_u1258_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(32'h00000c0a))
    _al_u1259 (
    .a(_al_u1257_o),
    .b(_al_u1258_o),
    .c(\ctl_sela_rn[2]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .o(_al_u1259_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(~E*~C*B*~A))"),
    .INIT(32'h00ff00fb))
    _al_u1260 (
    .a(_al_u1254_o),
    .b(_al_u1256_o),
    .c(_al_u1259_o),
    .d(_al_u1165_o),
    .e(\rgf/sptr/abus2 [15]),
    .o(\mem/babf/n1 [15]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~(~D*C*B*A))"),
    .INIT(32'h0000ff7f))
    _al_u1261 (
    .a(_al_u1103_o),
    .b(_al_u1105_o),
    .c(_al_u1109_o),
    .d(_al_u1106_o),
    .e(_al_u1165_o),
    .o(\mem/babf/n1 [14]));
  AL_MAP_LUT5 #(
    .EQN("(~C*A*(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))"),
    .INIT(32'h0a020800))
    _al_u1262 (
    .a(_al_u1059_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .d(\rgf/bank/gr03 [13]),
    .e(\rgf/bank/gr07 [13]),
    .o(_al_u1262_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*~B*A)"),
    .INIT(32'h00200000))
    _al_u1263 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .e(\rgf/bank/gr04 [13]),
    .o(\rgf/bank/abuso/gr4_bus [13]));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(E*D*C))"),
    .INIT(32'h01111111))
    _al_u1264 (
    .a(_al_u1262_o),
    .b(\rgf/bank/abuso/gr4_bus [13]),
    .c(_al_u1094_o),
    .d(\ctl_sela_rn[0]_neg_lutinv ),
    .e(\rgf/bank/gr06 [13]),
    .o(_al_u1264_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(~(B)*~(C)*D*~(E)+B*C*~(D)*E+~(B)*~(C)*D*E+B*C*D*E))"),
    .INIT(32'h82800200))
    _al_u1265 (
    .a(_al_u1036_o),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/ivec/iv [13]),
    .e(\rgf/sreg/sr [13]),
    .o(_al_u1265_o));
  AL_MAP_LUT5 #(
    .EQN("(E*B*~(~D*C*A))"),
    .INIT(32'hcc4c0000))
    _al_u1266 (
    .a(_al_u1056_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(_al_u1040_o),
    .e(rgf_pc[13]),
    .o(_al_u1266_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u1267 (
    .a(_al_u1036_o),
    .b(\rgf/abus_sel_cr [5]),
    .c(_al_u1266_o),
    .d(n0[12]),
    .o(_al_u1267_o));
  AL_MAP_LUT5 #(
    .EQN("(E*C*B*~(D*A))"),
    .INIT(32'h40c00000))
    _al_u1268 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr01 [13]),
    .o(\rgf/bank/abuso/gr1_bus [13]));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*A)"),
    .INIT(32'h20000000))
    _al_u1269 (
    .a(_al_u1041_o),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(_al_u1032_o),
    .d(_al_u1052_o),
    .e(_al_u1049_o),
    .o(_al_u1269_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1270 (
    .a(\ctl_sela_rn[1]_neg_lutinv ),
    .b(\rgf/bank/gr00 [13]),
    .c(\rgf/bank/gr02 [13]),
    .o(_al_u1270_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(D*C)*~(E*A))"),
    .INIT(32'h01110333))
    _al_u1271 (
    .a(\rgf/abus_sel [5]),
    .b(\rgf/bank/abuso/gr1_bus [13]),
    .c(_al_u1269_o),
    .d(_al_u1270_o),
    .e(\rgf/bank/gr05 [13]),
    .o(_al_u1271_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u1272 (
    .a(\rgf/abus_sel_cr [2]),
    .b(\rgf/bank/abuso/gr1_bus [13]),
    .c(\rgf/sptr/sp [13]),
    .o(_al_u1272_o));
  AL_MAP_LUT5 #(
    .EQN("~(~E*D*C*~B*A)"),
    .INIT(32'hffffdfff))
    _al_u1273 (
    .a(_al_u1264_o),
    .b(_al_u1265_o),
    .c(_al_u1267_o),
    .d(_al_u1271_o),
    .e(_al_u1272_o),
    .o(abus[13]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~((C*A))*~(D)*~(E)+B*~((C*A))*~(D)*~(E)+~(B)*(C*A)*~(D)*~(E)+B*(C*A)*~(D)*~(E)+~(B)*~((C*A))*D*~(E)+~(B)*(C*A)*D*~(E)+B*(C*A)*D*~(E)+~(B)*~((C*A))*~(D)*E+B*~((C*A))*~(D)*E+B*(C*A)*~(D)*E+~(B)*~((C*A))*D*E+B*(C*A)*D*E)"),
    .INIT(32'h93dfb3ff))
    _al_u1274 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(rgf_pc[12]),
    .e(\rgf/sptr/sp [12]),
    .o(_al_u1274_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B*~(E*D*C)))"),
    .INIT(32'ha2222222))
    _al_u1275 (
    .a(_al_u1036_o),
    .b(_al_u1274_o),
    .c(\ctl_sela_rn[0]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(\rgf/sreg/sr [12]),
    .o(_al_u1275_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1276 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(\rgf/ivec/iv [12]),
    .o(_al_u1276_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u1277 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(n0[11]),
    .o(_al_u1277_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D))"),
    .INIT(16'h040a))
    _al_u1278 (
    .a(_al_u1276_o),
    .b(_al_u1277_o),
    .c(\ctl_sela_rn[0]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .o(_al_u1278_o));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~((C*A))*~(D)*~(E)+B*~((C*A))*~(D)*~(E)+~(B)*(C*A)*~(D)*~(E)+B*(C*A)*~(D)*~(E)+~(B)*~((C*A))*D*~(E)+~(B)*(C*A)*D*~(E)+B*(C*A)*D*~(E)+~(B)*~((C*A))*~(D)*E+B*~((C*A))*~(D)*E+B*(C*A)*~(D)*E+~(B)*~((C*A))*D*E+B*(C*A)*D*E)"),
    .INIT(32'h93dfb3ff))
    _al_u1279 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1052_o),
    .d(\rgf/bank/gr05 [12]),
    .e(\rgf/bank/gr06 [12]),
    .o(_al_u1279_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B*~(E*D*C)))"),
    .INIT(32'ha2222222))
    _al_u1280 (
    .a(_al_u1065_o),
    .b(_al_u1279_o),
    .c(\ctl_sela_rn[0]_neg_lutinv ),
    .d(\ctl_sela_rn[1]_neg_lutinv ),
    .e(\rgf/bank/gr04 [12]),
    .o(_al_u1280_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~B*~A)"),
    .INIT(32'h00010000))
    _al_u1281 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/rctl/eq0/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .e(\rgf/bank/gr07 [12]),
    .o(\rgf/bank/abuso/gr7_bus [12]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1282 (
    .a(\ctl_sela_rn[1]_neg_lutinv ),
    .b(\rgf/bank/gr01 [12]),
    .c(\rgf/bank/gr03 [12]),
    .o(_al_u1282_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1283 (
    .a(\ctl_sela_rn[1]_neg_lutinv ),
    .b(\rgf/bank/gr00 [12]),
    .c(\rgf/bank/gr02 [12]),
    .o(_al_u1283_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~C*~(D)*~((E*A))+~C*D*~((E*A))+~(~C)*D*(E*A)+~C*D*(E*A)))"),
    .INIT(32'h40c8c0c0))
    _al_u1284 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(_al_u1282_o),
    .d(_al_u1283_o),
    .e(_al_u1052_o),
    .o(\rgf/bank/abuso/n10 [12]));
  AL_MAP_LUT5 #(
    .EQN("~(~E*~D*~C*~B*~A)"),
    .INIT(32'hfffffffe))
    _al_u1285 (
    .a(_al_u1275_o),
    .b(_al_u1278_o),
    .c(_al_u1280_o),
    .d(\rgf/bank/abuso/gr7_bus [12]),
    .e(\rgf/bank/abuso/n10 [12]),
    .o(abus[12]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u1286 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(_al_u1117_o),
    .o(_al_u1286_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(~E*C)*~(D*A))"),
    .INIT(32'h11330103))
    _al_u1287 (
    .a(_al_u1036_o),
    .b(\rgf/sptr/abus2 [11]),
    .c(_al_u1286_o),
    .d(_al_u1119_o),
    .e(\ctl_sela_rn[0]_neg_lutinv ),
    .o(_al_u1287_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~(~D*C*B*A))"),
    .INIT(32'h0000ff7f))
    _al_u1288 (
    .a(_al_u1114_o),
    .b(_al_u1287_o),
    .c(_al_u1116_o),
    .d(_al_u1123_o),
    .e(_al_u1165_o),
    .o(\mem/babf/n1 [11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1289 (
    .a(\rgf/abus_sel [7]),
    .b(\rgf/bank/gr07 [10]),
    .o(\rgf/bank/abuso/gr7_bus [10]));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u1290 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr00 [10]),
    .o(\rgf/bank/abuso/gr0_bus [10]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*B*~(D*A))"),
    .INIT(32'h040c0000))
    _al_u1291 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr03 [10]),
    .o(\rgf/bank/abuso/gr3_bus [10]));
  AL_MAP_LUT5 #(
    .EQN("(~D*~C*~A*~(E*B))"),
    .INIT(32'h00010005))
    _al_u1292 (
    .a(\rgf/bank/abuso/gr7_bus [10]),
    .b(\rgf/abus_sel [4]),
    .c(\rgf/bank/abuso/gr0_bus [10]),
    .d(\rgf/bank/abuso/gr3_bus [10]),
    .e(\rgf/bank/gr04 [10]),
    .o(_al_u1292_o));
  AL_MAP_LUT5 #(
    .EQN("(B*(~(A)*C*D*~(E)+A*~(C)*~(D)*E+A*~(C)*D*E+~(A)*C*D*E))"),
    .INIT(32'h48084000))
    _al_u1293 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr01 [10]),
    .e(\rgf/bank/gr02 [10]),
    .o(_al_u1293_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(D*C)*~(E*B))"),
    .INIT(32'h01110555))
    _al_u1294 (
    .a(_al_u1293_o),
    .b(\rgf/abus_sel [6]),
    .c(\rgf/abus_sel [5]),
    .d(\rgf/bank/gr05 [10]),
    .e(\rgf/bank/gr06 [10]),
    .o(_al_u1294_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1295 (
    .a(_al_u1036_o),
    .b(\rgf/sptr/sp [10]),
    .o(_al_u1295_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~(~D*~C*B*A))"),
    .INIT(32'h0000fff7))
    _al_u1296 (
    .a(_al_u1292_o),
    .b(_al_u1294_o),
    .c(_al_u1295_o),
    .d(\rgf/sptr/abus2 [10]),
    .e(_al_u1165_o),
    .o(\mem/babf/n1 [10]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    _al_u1297 (
    .a(_al_u1056_o),
    .b(_al_u1052_o),
    .c(\rgf/bank/gr06 [1]),
    .d(\rgf/bank/gr07 [1]),
    .o(_al_u1297_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(D*C)*~(~E*A))"),
    .INIT(32'h03330111))
    _al_u1298 (
    .a(_al_u1036_o),
    .b(\rgf/bank/abuso/gr1_bus [1]),
    .c(_al_u1094_o),
    .d(_al_u1297_o),
    .e(_al_u1149_o),
    .o(_al_u1298_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1299 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(\rgf/bank/gr00 [1]),
    .o(_al_u1299_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u1300 (
    .a(_al_u1299_o),
    .b(_al_u1142_o),
    .c(\ctl_sela_rn[0]_neg_lutinv ),
    .d(_al_u1087_o),
    .o(_al_u1300_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(D*B*A))"),
    .INIT(16'h070f))
    _al_u1301 (
    .a(_al_u1298_o),
    .b(_al_u1300_o),
    .c(_al_u1165_o),
    .d(_al_u1143_o),
    .o(\mem/babf/n1 [1]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1302 (
    .a(abus[1]),
    .b(_al_u510_o),
    .o(\alu/mul/ina [1]));
  AL_MAP_LUT5 #(
    .EQN("(B*(~(A)*C*D*~(E)+A*~(C)*~(D)*E+A*~(C)*D*E+~(A)*C*D*E))"),
    .INIT(32'h48084000))
    _al_u1303 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr01 [0]),
    .e(\rgf/bank/gr02 [0]),
    .o(_al_u1303_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~C*~B*~(E*A))"),
    .INIT(32'h01000300))
    _al_u1304 (
    .a(_al_u1041_o),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1159_o),
    .e(_al_u1052_o),
    .o(\rgf/bank/abuso/gr7_bus [0]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1305 (
    .a(_al_u1303_o),
    .b(\rgf/bank/abuso/gr7_bus [0]),
    .o(_al_u1305_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u1306 (
    .a(\rgf/abus_sel [5]),
    .b(\rgf/bank/abuso/gr3_bus [0]),
    .c(\rgf/bank/gr05 [0]),
    .o(_al_u1306_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1307 (
    .a(\ctl_sela_rn[2]_neg_lutinv ),
    .b(\ctl_sela_rn[1]_neg_lutinv ),
    .c(\rgf/bank/gr00 [0]),
    .o(_al_u1307_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(~A*~(~D*~C)))"),
    .INIT(16'h888c))
    _al_u1308 (
    .a(_al_u1307_o),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(\ctl_sela_rn[2]_neg_lutinv ),
    .d(_al_u1153_o),
    .o(_al_u1308_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(~E*C*~B*A))"),
    .INIT(32'h00ff00df))
    _al_u1309 (
    .a(_al_u1305_o),
    .b(\rgf/abus_sp [0]),
    .c(_al_u1306_o),
    .d(_al_u1165_o),
    .e(_al_u1308_o),
    .o(\mem/babf/n1 [0]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1310 (
    .a(abus[0]),
    .b(_al_u510_o),
    .o(\alu/mul/ina [0]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~(~D*~C*B*A))"),
    .INIT(32'h0000fff7))
    _al_u1311 (
    .a(_al_u1187_o),
    .b(_al_u1179_o),
    .c(_al_u1182_o),
    .d(\rgf/sptr/abus2 [7]),
    .e(_al_u1165_o),
    .o(\mem/babf/n1 [7]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1312 (
    .a(abus[7]),
    .b(_al_u510_o),
    .o(\alu/mul/ina [7]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1313 (
    .a(abus[7]),
    .b(_al_u507_o),
    .o(\alu/mul/ina [10]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~(~D*C*B*A))"),
    .INIT(32'h0000ff7f))
    _al_u1314 (
    .a(_al_u1192_o),
    .b(_al_u1194_o),
    .c(_al_u1196_o),
    .d(_al_u1197_o),
    .e(_al_u1165_o),
    .o(\mem/babf/n1 [6]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1315 (
    .a(abus[6]),
    .b(_al_u510_o),
    .o(\alu/mul/ina [6]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1316 (
    .a(_al_u1165_o),
    .b(abus[5]),
    .o(\mem/babf/n1 [5]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1317 (
    .a(abus[5]),
    .b(_al_u510_o),
    .o(\alu/mul/ina [5]));
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*~(D*C))"),
    .INIT(16'h0111))
    _al_u1318 (
    .a(_al_u1212_o),
    .b(\rgf/bank/abuso/gr6_bus [4]),
    .c(\rgf/abus_sel [3]),
    .d(\rgf/bank/gr03 [4]),
    .o(_al_u1318_o));
  AL_MAP_LUT5 #(
    .EQN("(C*B*(E*~(D)*~(A)+E*D*~(A)+~(E)*D*A+E*D*A))"),
    .INIT(32'hc0408000))
    _al_u1319 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr00 [4]),
    .e(\rgf/bank/gr01 [4]),
    .o(\rgf/bank/abuso/n8 [4]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~A*~(D*B))"),
    .INIT(16'h0105))
    _al_u1320 (
    .a(\rgf/bank/abuso/n8 [4]),
    .b(\rgf/abus_sel [4]),
    .c(\rgf/bank/abuso/gr5_bus [4]),
    .d(\rgf/bank/gr04 [4]),
    .o(_al_u1320_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(D*B*A))"),
    .INIT(16'h070f))
    _al_u1321 (
    .a(_al_u1318_o),
    .b(_al_u1320_o),
    .c(_al_u1165_o),
    .d(_al_u1218_o),
    .o(\mem/babf/n1 [4]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1322 (
    .a(abus[4]),
    .b(_al_u510_o),
    .o(\alu/mul/ina [4]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~(D*C*B*A))"),
    .INIT(32'h00007fff))
    _al_u1323 (
    .a(_al_u1229_o),
    .b(_al_u1235_o),
    .c(_al_u1236_o),
    .d(_al_u1239_o),
    .e(_al_u1165_o),
    .o(\mem/babf/n1 [3]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1324 (
    .a(abus[3]),
    .b(_al_u510_o),
    .o(\alu/mul/ina [3]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~(D*~C*B*A))"),
    .INIT(32'h0000f7ff))
    _al_u1325 (
    .a(_al_u1243_o),
    .b(_al_u1248_o),
    .c(_al_u1249_o),
    .d(_al_u1252_o),
    .e(_al_u1165_o),
    .o(\mem/babf/n1 [2]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1326 (
    .a(abus[2]),
    .b(_al_u510_o),
    .o(\alu/mul/ina [2]));
  AL_MAP_LUT5 #(
    .EQN("(~B*A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'h22022000))
    _al_u1327 (
    .a(_al_u1065_o),
    .b(\ctl_sela_rn[0]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr05 [13]),
    .e(\rgf/bank/gr07 [13]),
    .o(_al_u1327_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*A)"),
    .INIT(16'h0200))
    _al_u1328 (
    .a(\ctl_sela_rn[0]_neg_lutinv ),
    .b(\ctl_sela_rn[2]_neg_lutinv ),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(\rgf/bank/gr06 [13]),
    .o(_al_u1328_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*B*~(D*A))"),
    .INIT(32'h040c0000))
    _al_u1329 (
    .a(_al_u1041_o),
    .b(_al_u1074_o),
    .c(\ctl_sela_rn[1]_neg_lutinv ),
    .d(_al_u1052_o),
    .e(\rgf/bank/gr03 [13]),
    .o(\rgf/bank/abuso/gr3_bus [13]));
  AL_MAP_LUT5 #(
    .EQN("(~D*~B*~A*~(E*C))"),
    .INIT(32'h00010011))
    _al_u1330 (
    .a(_al_u1327_o),
    .b(_al_u1328_o),
    .c(\rgf/abus_sel [4]),
    .d(\rgf/bank/abuso/gr3_bus [13]),
    .e(\rgf/bank/gr04 [13]),
    .o(_al_u1330_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1331 (
    .a(\rgf/abus_sel_cr [5]),
    .b(n0[12]),
    .o(\rgf/sptr/abus2 [13]));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(E*~C*B*~A))"),
    .INIT(32'h00fb00ff))
    _al_u1332 (
    .a(_al_u1272_o),
    .b(_al_u1330_o),
    .c(\rgf/sptr/abus2 [13]),
    .d(_al_u1165_o),
    .e(_al_u1271_o),
    .o(\mem/babf/n1 [13]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1333 (
    .a(_al_u1165_o),
    .b(abus[12]),
    .o(\mem/babf/n1 [12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1334 (
    .a(abus[1]),
    .b(\alu/log/n11_lutinv ),
    .o(\alu/log/sel0_b9/B4 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1335 (
    .a(bbus[7]),
    .b(\alu/log/n12_lutinv ),
    .o(\alu/log/sel0_b10/B3 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1336 (
    .a(\alu/sft/n30_lutinv ),
    .b(\alu/sft/n36_lutinv ),
    .o(_al_u1336_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1337 (
    .a(\alu/sft/n31_lutinv ),
    .b(\alu/log/eq3/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .o(_al_u1337_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1338 (
    .a(_al_u1336_o),
    .b(_al_u1337_o),
    .o(\alu/log/n14_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1339 (
    .a(\alu/art/n4 [1]),
    .b(\alu/log/n14_lutinv ),
    .o(\alu/log/sel0_b9/B1 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1340 (
    .a(\alu/sft/n30_lutinv ),
    .b(\alu/sft/n36_lutinv ),
    .o(_al_u1340_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1341 (
    .a(_al_u1340_o),
    .b(_al_u1337_o),
    .o(\alu/log/n13_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1342 (
    .a(_al_u1336_o),
    .b(\alu/log/eq3/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .o(_al_u1342_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1343 (
    .a(\alu/log/n13_lutinv ),
    .b(_al_u1342_o),
    .c(\alu/sft/n31_lutinv ),
    .o(_al_u1343_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*~A*~(~E*D))"),
    .INIT(32'h01010001))
    _al_u1344 (
    .a(\alu/log/sel0_b9/B4 ),
    .b(\alu/log/sel0_b10/B3 ),
    .c(\alu/log/sel0_b9/B1 ),
    .d(abus[9]),
    .e(_al_u1343_o),
    .o(_al_u1344_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u1345 (
    .a(\alu/art/n13 [9]),
    .b(_al_u1344_o),
    .c(\ctl/n119_lutinv ),
    .o(_al_u1345_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u1346 (
    .a(bdatr[9]),
    .b(\mem/read_cyc [1]),
    .c(\mem/read_cyc [2]),
    .o(cbus_mem[9]));
  AL_MAP_LUT4 #(
    .EQN("~(~C*B*~(~D*A))"),
    .INIT(16'hf3fb))
    _al_u1347 (
    .a(\alu/mul/out [9]),
    .b(_al_u1345_o),
    .c(cbus_mem[9]),
    .d(_al_u510_o),
    .o(cbus[9]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*~B)*~(~C*A))"),
    .INIT(16'hc4f5))
    _al_u1348 (
    .a(abus[8]),
    .b(\alu/art/n4 [0]),
    .c(_al_u1343_o),
    .d(\alu/log/n14_lutinv ),
    .o(_al_u1348_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(D*C))"),
    .INIT(16'h0222))
    _al_u1349 (
    .a(_al_u1348_o),
    .b(\alu/log/sel0_b10/B3 ),
    .c(abus[0]),
    .d(\alu/log/n11_lutinv ),
    .o(_al_u1349_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u1350 (
    .a(\alu/art/n13 [8]),
    .b(_al_u1349_o),
    .c(\ctl/n119_lutinv ),
    .o(_al_u1350_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u1351 (
    .a(bdatr[8]),
    .b(\mem/read_cyc [1]),
    .c(\mem/read_cyc [2]),
    .o(cbus_mem[8]));
  AL_MAP_LUT4 #(
    .EQN("~(~C*B*~(~D*A))"),
    .INIT(16'hf3fb))
    _al_u1352 (
    .a(\alu/mul/out [8]),
    .b(_al_u1350_o),
    .c(cbus_mem[8]),
    .d(_al_u510_o),
    .o(cbus[8]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1353 (
    .a(\alu/log/sel0_b10/B3 ),
    .b(abus[7]),
    .c(\alu/log/n11_lutinv ),
    .o(_al_u1353_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(~D*B))"),
    .INIT(32'h0a02aa22))
    _al_u1354 (
    .a(_al_u1353_o),
    .b(abus[15]),
    .c(bbus[7]),
    .d(_al_u1343_o),
    .e(\alu/log/n14_lutinv ),
    .o(_al_u1354_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u1355 (
    .a(\alu/art/n13 [15]),
    .b(_al_u1354_o),
    .c(\ctl/n119_lutinv ),
    .o(_al_u1355_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u1356 (
    .a(bdatr[15]),
    .b(\mem/read_cyc [1]),
    .c(\mem/read_cyc [2]),
    .o(cbus_mem[15]));
  AL_MAP_LUT4 #(
    .EQN("~(~C*B*~(~D*A))"),
    .INIT(16'hf3fb))
    _al_u1357 (
    .a(\alu/mul/out [15]),
    .b(_al_u1355_o),
    .c(cbus_mem[15]),
    .d(_al_u510_o),
    .o(cbus[15]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1358 (
    .a(abus[14]),
    .b(_al_u1343_o),
    .o(_al_u1358_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1359 (
    .a(bbus[6]),
    .b(\alu/log/n14_lutinv ),
    .o(\alu/log/sel0_b14/B1 ));
  AL_MAP_LUT5 #(
    .EQN("(~D*~C*~A*~(E*B))"),
    .INIT(32'h00010005))
    _al_u1360 (
    .a(_al_u1358_o),
    .b(abus[6]),
    .c(\alu/log/sel0_b10/B3 ),
    .d(\alu/log/sel0_b14/B1 ),
    .e(\alu/log/n11_lutinv ),
    .o(_al_u1360_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u1361 (
    .a(\alu/art/n13 [14]),
    .b(_al_u1360_o),
    .c(\ctl/n119_lutinv ),
    .o(_al_u1361_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u1362 (
    .a(bdatr[14]),
    .b(\mem/read_cyc [1]),
    .c(\mem/read_cyc [2]),
    .o(cbus_mem[14]));
  AL_MAP_LUT4 #(
    .EQN("~(~C*B*~(~D*A))"),
    .INIT(16'hf3fb))
    _al_u1363 (
    .a(\alu/mul/out [14]),
    .b(_al_u1361_o),
    .c(cbus_mem[14]),
    .d(_al_u510_o),
    .o(cbus[14]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1364 (
    .a(abus[5]),
    .b(\alu/log/n11_lutinv ),
    .o(\alu/log/sel0_b13/B4 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1365 (
    .a(bbus[5]),
    .b(\alu/log/n14_lutinv ),
    .o(\alu/log/sel0_b13/B1 ));
  AL_MAP_LUT5 #(
    .EQN("(~D*~B*~A*~(~E*C))"),
    .INIT(32'h00110001))
    _al_u1366 (
    .a(\alu/log/sel0_b13/B4 ),
    .b(\alu/log/sel0_b10/B3 ),
    .c(abus[13]),
    .d(\alu/log/sel0_b13/B1 ),
    .e(_al_u1343_o),
    .o(_al_u1366_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u1367 (
    .a(\alu/art/n13 [13]),
    .b(_al_u1366_o),
    .c(\ctl/n119_lutinv ),
    .o(_al_u1367_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u1368 (
    .a(bdatr[13]),
    .b(\mem/read_cyc [1]),
    .c(\mem/read_cyc [2]),
    .o(cbus_mem[13]));
  AL_MAP_LUT4 #(
    .EQN("~(~C*B*~(~D*A))"),
    .INIT(16'hf3fb))
    _al_u1369 (
    .a(\alu/mul/out [13]),
    .b(_al_u1367_o),
    .c(cbus_mem[13]),
    .d(_al_u510_o),
    .o(cbus[13]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1370 (
    .a(\alu/log/sel0_b10/B3 ),
    .b(abus[4]),
    .c(\alu/log/n11_lutinv ),
    .o(_al_u1370_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(~D*B))"),
    .INIT(32'h0a02aa22))
    _al_u1371 (
    .a(_al_u1370_o),
    .b(abus[12]),
    .c(bbus[4]),
    .d(_al_u1343_o),
    .e(\alu/log/n14_lutinv ),
    .o(_al_u1371_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u1372 (
    .a(\alu/art/n13 [12]),
    .b(_al_u1371_o),
    .c(\ctl/n119_lutinv ),
    .o(_al_u1372_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u1373 (
    .a(bdatr[12]),
    .b(\mem/read_cyc [1]),
    .c(\mem/read_cyc [2]),
    .o(cbus_mem[12]));
  AL_MAP_LUT4 #(
    .EQN("~(~C*B*~(~D*A))"),
    .INIT(16'hf3fb))
    _al_u1374 (
    .a(\alu/mul/out [12]),
    .b(_al_u1372_o),
    .c(cbus_mem[12]),
    .d(_al_u510_o),
    .o(cbus[12]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1375 (
    .a(\alu/log/sel0_b10/B3 ),
    .b(abus[3]),
    .c(\alu/log/n11_lutinv ),
    .o(_al_u1375_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*~C)*~(~D*B))"),
    .INIT(32'ha020aa22))
    _al_u1376 (
    .a(_al_u1375_o),
    .b(abus[11]),
    .c(\alu/art/n4 [3]),
    .d(_al_u1343_o),
    .e(\alu/log/n14_lutinv ),
    .o(_al_u1376_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u1377 (
    .a(\alu/art/n13 [11]),
    .b(_al_u1376_o),
    .c(\ctl/n119_lutinv ),
    .o(_al_u1377_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u1378 (
    .a(bdatr[11]),
    .b(\mem/read_cyc [1]),
    .c(\mem/read_cyc [2]),
    .o(cbus_mem[11]));
  AL_MAP_LUT4 #(
    .EQN("~(~C*B*~(~D*A))"),
    .INIT(16'hf3fb))
    _al_u1379 (
    .a(\alu/mul/out [11]),
    .b(_al_u1377_o),
    .c(cbus_mem[11]),
    .d(_al_u510_o),
    .o(cbus[11]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1380 (
    .a(\alu/log/sel0_b10/B3 ),
    .b(abus[2]),
    .c(\alu/log/n11_lutinv ),
    .o(_al_u1380_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*~C)*~(~D*B))"),
    .INIT(32'ha020aa22))
    _al_u1381 (
    .a(_al_u1380_o),
    .b(abus[10]),
    .c(\alu/art/n4 [2]),
    .d(_al_u1343_o),
    .e(\alu/log/n14_lutinv ),
    .o(_al_u1381_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u1382 (
    .a(\alu/art/n13 [10]),
    .b(_al_u1381_o),
    .c(\ctl/n119_lutinv ),
    .o(_al_u1382_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u1383 (
    .a(bdatr[10]),
    .b(\mem/read_cyc [1]),
    .c(\mem/read_cyc [2]),
    .o(cbus_mem[10]));
  AL_MAP_LUT4 #(
    .EQN("~(~C*B*~(~D*A))"),
    .INIT(16'hf3fb))
    _al_u1384 (
    .a(\alu/mul/out [10]),
    .b(_al_u1382_o),
    .c(cbus_mem[10]),
    .d(_al_u510_o),
    .o(cbus[10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1385 (
    .a(_al_u626_o),
    .b(_al_u648_o),
    .o(\rgf/cbus_sel_cr [2]));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(C*~(~E*~D)))"),
    .INIT(32'h01010111))
    _al_u1386 (
    .a(\fch/n1 ),
    .b(\rgf/sreg/mux2_b2_sel_is_2_o ),
    .c(brdy),
    .d(_al_u441_o),
    .e(_al_u685_o),
    .o(_al_u1386_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(B*~(~C*~(E*D))))"),
    .INIT(32'h11151515))
    _al_u1387 (
    .a(\ctl/n220_lutinv ),
    .b(brdy),
    .c(_al_u403_o),
    .d(_al_u350_o),
    .e(_al_u355_o),
    .o(ctl_sp_inc_neg_lutinv));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1388 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [9]),
    .d(n0[8]),
    .e(\rgf/sptr/sp [9]),
    .o(_al_u1388_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1389 (
    .a(cbus[9]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1388_o),
    .o(\rgf/sptr/n2 [9]));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(~C*A))"),
    .INIT(8'h31))
    _al_u1390 (
    .a(\ctl/n936 ),
    .b(_al_u321_o),
    .c(ctl_fetch_ext_lutinv),
    .o(\rgf/pcnt/mux0_b10_sel_is_1_o ));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1391 (
    .a(cbus[9]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [8]),
    .e(rgf_pc[9]),
    .o(\rgf/pcnt/n2 [9]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1392 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [8]),
    .d(n0[7]),
    .e(\rgf/sptr/sp [8]),
    .o(_al_u1392_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1393 (
    .a(cbus[8]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1392_o),
    .o(\rgf/sptr/n2 [8]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1394 (
    .a(cbus[8]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [7]),
    .e(rgf_pc[8]),
    .o(\rgf/pcnt/n2 [8]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1395 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [15]),
    .d(n0[14]),
    .e(\rgf/sptr/sp [15]),
    .o(_al_u1395_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1396 (
    .a(cbus[15]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1395_o),
    .o(\rgf/sptr/n2 [15]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1397 (
    .a(cbus[15]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [14]),
    .e(rgf_pc[15]),
    .o(\rgf/pcnt/n2 [15]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1398 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [14]),
    .d(n0[13]),
    .e(\rgf/sptr/sp [14]),
    .o(_al_u1398_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1399 (
    .a(cbus[14]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1398_o),
    .o(\rgf/sptr/n2 [14]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1400 (
    .a(cbus[14]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [13]),
    .e(rgf_pc[14]),
    .o(\rgf/pcnt/n2 [14]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1401 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [13]),
    .d(n0[12]),
    .e(\rgf/sptr/sp [13]),
    .o(_al_u1401_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1402 (
    .a(cbus[13]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1401_o),
    .o(\rgf/sptr/n2 [13]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1403 (
    .a(cbus[13]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [12]),
    .e(rgf_pc[13]),
    .o(\rgf/pcnt/n2 [13]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1404 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [12]),
    .d(n0[11]),
    .e(\rgf/sptr/sp [12]),
    .o(_al_u1404_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1405 (
    .a(cbus[12]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1404_o),
    .o(\rgf/sptr/n2 [12]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1406 (
    .a(cbus[12]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [11]),
    .e(rgf_pc[12]),
    .o(\rgf/pcnt/n2 [12]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1407 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [11]),
    .d(n0[10]),
    .e(\rgf/sptr/sp [11]),
    .o(_al_u1407_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1408 (
    .a(cbus[11]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1407_o),
    .o(\rgf/sptr/n2 [11]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1409 (
    .a(cbus[11]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [10]),
    .e(rgf_pc[11]),
    .o(\rgf/pcnt/n2 [11]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1410 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [10]),
    .d(n0[9]),
    .e(\rgf/sptr/sp [10]),
    .o(_al_u1410_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1411 (
    .a(cbus[10]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1410_o),
    .o(\rgf/sptr/n2 [10]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1412 (
    .a(cbus[10]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [9]),
    .e(rgf_pc[10]),
    .o(\rgf/pcnt/n2 [10]));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1413 (
    .a(\alu/sft/n27 [0]),
    .b(\alu/art/n4 [3]),
    .c(\alu/art/n4 [0]),
    .o(\alu/sft/babs [0]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1414 (
    .a(\alu/sft/babs [0]),
    .b(abus[0]),
    .c(abus[1]),
    .o(_al_u1414_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1415 (
    .a(\alu/sft/n27 [1]),
    .b(\alu/art/n4 [3]),
    .c(\alu/art/n4 [1]),
    .o(\alu/sft/babs [1]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'h53))
    _al_u1416 (
    .a(abus[3]),
    .b(abus[2]),
    .c(\alu/art/n4 [0]),
    .o(_al_u1416_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u1417 (
    .a(_al_u1414_o),
    .b(\alu/sft/babs [1]),
    .c(_al_u1416_o),
    .o(_al_u1417_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u1418 (
    .a(\alu/sft/babs [0]),
    .b(abus[6]),
    .c(abus[5]),
    .o(_al_u1418_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1419 (
    .a(_al_u1418_o),
    .b(\alu/sft/babs [1]),
    .o(_al_u1419_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h5140))
    _al_u1420 (
    .a(\alu/sft/babs [1]),
    .b(\alu/sft/babs [0]),
    .c(abus[7]),
    .d(rgf_sr_flag[2]),
    .o(_al_u1420_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1421 (
    .a(\alu/sft/n27 [2]),
    .b(\alu/art/n4 [3]),
    .c(\alu/art/n4 [2]),
    .o(_al_u1421_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1422 (
    .a(\alu/art/n4 [3]),
    .b(_al_u513_o),
    .o(\alu/sft/n44_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(E*(~(~C*~B)*~(A)*~(D)+~(~C*~B)*A*~(D)+~(~(~C*~B))*A*D+~(~C*~B)*A*D))"),
    .INIT(32'haafc0000))
    _al_u1423 (
    .a(_al_u1417_o),
    .b(_al_u1419_o),
    .c(_al_u1420_o),
    .d(_al_u1421_o),
    .e(\alu/sft/n44_lutinv ),
    .o(_al_u1423_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1424 (
    .a(\alu/sft/n27 [3]),
    .b(\alu/art/n4 [3]),
    .o(_al_u1424_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1425 (
    .a(_al_u1424_o),
    .b(_al_u513_o),
    .o(\alu/sft/n42_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1426 (
    .a(_al_u1337_o),
    .b(\alu/sft/n30_lutinv ),
    .o(\alu/sft/n48_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1427 (
    .a(\alu/sft/n48_lutinv ),
    .b(\alu/sft/n36_lutinv ),
    .o(_al_u1427_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*~(~B*A))"),
    .INIT(32'h00d00000))
    _al_u1428 (
    .a(_al_u1421_o),
    .b(\alu/sft/n27 [3]),
    .c(abus[7]),
    .d(\alu/art/n4 [3]),
    .e(_al_u1427_o),
    .o(_al_u1428_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u1429 (
    .a(\alu/sft/n42_lutinv ),
    .b(_al_u1428_o),
    .c(abus[2]),
    .o(_al_u1429_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1430 (
    .a(\alu/sft/babs [0]),
    .b(abus[4]),
    .c(abus[3]),
    .o(_al_u1430_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1431 (
    .a(\alu/sft/n27 [0]),
    .b(abus[6]),
    .c(abus[5]),
    .o(_al_u1431_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u1432 (
    .a(_al_u1430_o),
    .b(\alu/sft/babs [1]),
    .c(_al_u1431_o),
    .o(_al_u1432_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u1433 (
    .a(\alu/sft/n27 [3]),
    .b(\alu/art/n4 [3]),
    .c(_al_u1427_o),
    .o(\alu/sft/n28_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u1434 (
    .a(_al_u1432_o),
    .b(\alu/sft/n28_lutinv ),
    .c(_al_u1421_o),
    .o(_al_u1434_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1435 (
    .a(\alu/art/n4 [3]),
    .b(\alu/art/n4 [2]),
    .c(\alu/sft/n48_lutinv ),
    .o(_al_u1435_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*~A*~(E*D))"),
    .INIT(32'h00040404))
    _al_u1436 (
    .a(_al_u1423_o),
    .b(_al_u1429_o),
    .c(_al_u1434_o),
    .d(_al_u1417_o),
    .e(_al_u1435_o),
    .o(_al_u1436_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u1437 (
    .a(\alu/sft/n27 [3]),
    .b(\alu/art/n4 [3]),
    .c(\alu/sft/n48_lutinv ),
    .o(_al_u1437_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1438 (
    .a(_al_u1437_o),
    .b(\alu/sft/n36_lutinv ),
    .o(\alu/sft/n34_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u1439 (
    .a(\alu/sft/babs [1]),
    .b(\alu/sft/babs [0]),
    .c(abus[7]),
    .o(\alu/sft/lsr2 [7]));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~C*~(B)*~(D)+~C*B*~(D)+~(~C)*B*D+~C*B*D))"),
    .INIT(16'h22a0))
    _al_u1440 (
    .a(\alu/sft/n34_lutinv ),
    .b(_al_u1432_o),
    .c(\alu/sft/lsr2 [7]),
    .d(_al_u1421_o),
    .o(_al_u1440_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u1441 (
    .a(\alu/sft/babs [0]),
    .b(abus[0]),
    .c(abus[1]),
    .o(_al_u1441_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u1442 (
    .a(\alu/sft/babs [0]),
    .b(abus[7]),
    .c(rgf_sr_flag[2]),
    .o(_al_u1442_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'h53))
    _al_u1443 (
    .a(_al_u1441_o),
    .b(_al_u1442_o),
    .c(\alu/sft/babs [1]),
    .o(_al_u1443_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u1444 (
    .a(\alu/sft/n27 [3]),
    .b(\alu/art/n4 [3]),
    .c(_al_u513_o),
    .o(\alu/sft/n41_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(D*~(~B*~(C)*~(E)+~B*C*~(E)+~(~B)*C*E+~B*C*E)))"),
    .INIT(32'h50551155))
    _al_u1445 (
    .a(_al_u1440_o),
    .b(_al_u1443_o),
    .c(_al_u1432_o),
    .d(\alu/sft/n41_lutinv ),
    .e(_al_u1421_o),
    .o(_al_u1445_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1446 (
    .a(_al_u1436_o),
    .b(_al_u1445_o),
    .o(_al_u1446_o));
  AL_MAP_LUT5 #(
    .EQN("(E*(B*~(A)*~((D*~C))+B*A*~((D*~C))+~(B)*A*(D*~C)+B*A*(D*~C)))"),
    .INIT(32'hcacc0000))
    _al_u1447 (
    .a(bdatr[11]),
    .b(bdatr[3]),
    .c(\mem/read_cyc [0]),
    .d(\mem/read_cyc [1]),
    .e(\mem/read_cyc [2]),
    .o(cbus_mem[3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u1448 (
    .a(_al_u1340_o),
    .b(_al_u515_o),
    .c(_al_u980_o),
    .o(\alu/art/drv_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~C*~((E*A)*~(B)*~(D)+(E*A)*B*~(D)+~((E*A))*B*D+(E*A)*B*D))"),
    .INIT(32'h0305030f))
    _al_u1449 (
    .a(\alu/art/out [3]),
    .b(\alu/art/n13 [3]),
    .c(cbus_mem[3]),
    .d(\ctl/n119_lutinv ),
    .e(\alu/art/drv_lutinv ),
    .o(_al_u1449_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~A*~(C*B))"),
    .INIT(16'h0015))
    _al_u1450 (
    .a(\alu/log/n13_lutinv ),
    .b(_al_u1336_o),
    .c(_al_u980_o),
    .d(\alu/log/n12_lutinv ),
    .o(_al_u1450_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1451 (
    .a(_al_u980_o),
    .b(\alu/sft/n30_lutinv ),
    .o(_al_u1451_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1452 (
    .a(_al_u1342_o),
    .b(_al_u1451_o),
    .c(\alu/sft/n36_lutinv ),
    .o(_al_u1452_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1453 (
    .a(_al_u749_o),
    .b(_al_u980_o),
    .o(\alu/log/n8_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(C*~(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A))"),
    .INIT(16'h40e0))
    _al_u1454 (
    .a(\alu/art/n4 [3]),
    .b(_al_u1450_o),
    .c(_al_u1452_o),
    .d(\alu/log/n8_lutinv ),
    .o(_al_u1454_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u1455 (
    .a(\alu/log/n13_lutinv ),
    .b(_al_u1451_o),
    .c(\alu/log/n12_lutinv ),
    .o(_al_u1455_o));
  AL_MAP_LUT5 #(
    .EQN("((~E*~(~D*~C))*~(A)*~(B)+(~E*~(~D*~C))*A*~(B)+~((~E*~(~D*~C)))*A*B+(~E*~(~D*~C))*A*B)"),
    .INIT(32'h8888bbb8))
    _al_u1456 (
    .a(_al_u1454_o),
    .b(abus[3]),
    .c(\alu/art/n4 [3]),
    .d(_al_u1455_o),
    .e(\alu/log/n9_lutinv ),
    .o(_al_u1456_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u1457 (
    .a(_al_u1456_o),
    .b(abus[11]),
    .c(\alu/log/n11_lutinv ),
    .o(_al_u1457_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*C*B*~(~E*A))"),
    .INIT(32'h3fffbfff))
    _al_u1458 (
    .a(\alu/mul/out [3]),
    .b(_al_u1446_o),
    .c(_al_u1449_o),
    .d(_al_u1457_o),
    .e(_al_u510_o),
    .o(cbus[3]));
  AL_MAP_LUT4 #(
    .EQN("(C*(~D*~(B)*~(A)+~D*B*~(A)+~(~D)*B*A+~D*B*A))"),
    .INIT(16'h80d0))
    _al_u1459 (
    .a(bbus[7]),
    .b(_al_u1450_o),
    .c(_al_u1452_o),
    .d(\alu/log/n8_lutinv ),
    .o(_al_u1459_o));
  AL_MAP_LUT5 #(
    .EQN("((~E*~(~D*C))*~(A)*~(B)+(~E*~(~D*C))*A*~(B)+~((~E*~(~D*C)))*A*B+(~E*~(~D*C))*A*B)"),
    .INIT(32'h8888bb8b))
    _al_u1460 (
    .a(_al_u1459_o),
    .b(abus[7]),
    .c(bbus[7]),
    .d(_al_u1455_o),
    .e(\alu/log/n9_lutinv ),
    .o(_al_u1460_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u1461 (
    .a(_al_u1460_o),
    .b(abus[15]),
    .c(\alu/log/n11_lutinv ),
    .o(_al_u1461_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(D*B)*~(E*A))"),
    .INIT(32'h105030f0))
    _al_u1462 (
    .a(\alu/art/alu_sr_flag_add [3]),
    .b(\alu/art/n13 [7]),
    .c(_al_u1461_o),
    .d(\ctl/n119_lutinv ),
    .e(\alu/art/drv_lutinv ),
    .o(_al_u1462_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1463 (
    .a(\alu/sft/n34_lutinv ),
    .b(\alu/sft/lsr2 [7]),
    .c(_al_u1421_o),
    .o(_al_u1463_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1464 (
    .a(\alu/sft/n28_lutinv ),
    .b(abus[7]),
    .o(\alu/sft/sel0_b7/B9 ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1465 (
    .a(_al_u1424_o),
    .b(abus[7]),
    .c(_al_u1427_o),
    .o(\alu/sft/sel0_b0/B8 ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u1466 (
    .a(_al_u1463_o),
    .b(\alu/sft/sel0_b7/B9 ),
    .c(\alu/sft/sel0_b0/B8 ),
    .o(_al_u1466_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1467 (
    .a(\alu/sft/babs [0]),
    .b(abus[4]),
    .c(abus[5]),
    .o(_al_u1467_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u1468 (
    .a(abus[6]),
    .b(abus[7]),
    .c(\alu/art/n4 [0]),
    .o(_al_u1468_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    _al_u1469 (
    .a(_al_u1467_o),
    .b(\alu/sft/babs [1]),
    .c(_al_u1468_o),
    .o(_al_u1469_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'h3a))
    _al_u1470 (
    .a(_al_u1417_o),
    .b(_al_u1469_o),
    .c(_al_u1421_o),
    .o(_al_u1470_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1471 (
    .a(\alu/art/n4 [3]),
    .b(\alu/sft/n48_lutinv ),
    .o(\alu/sft/mux18_b1_sel_is_1_o ));
  AL_MAP_LUT4 #(
    .EQN("(A*~(B*~(~D*~C)))"),
    .INIT(16'h222a))
    _al_u1472 (
    .a(_al_u1466_o),
    .b(_al_u1470_o),
    .c(\alu/sft/mux18_b1_sel_is_1_o ),
    .d(\alu/sft/n44_lutinv ),
    .o(_al_u1472_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u1473 (
    .a(\alu/sft/babs [0]),
    .b(abus[4]),
    .c(abus[5]),
    .o(_al_u1473_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1474 (
    .a(\alu/sft/babs [0]),
    .b(abus[3]),
    .c(abus[2]),
    .o(_al_u1474_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u1475 (
    .a(_al_u1473_o),
    .b(_al_u1474_o),
    .c(\alu/sft/babs [1]),
    .o(_al_u1475_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'ha3))
    _al_u1476 (
    .a(_al_u1443_o),
    .b(_al_u1475_o),
    .c(_al_u1421_o),
    .o(_al_u1476_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1477 (
    .a(_al_u1476_o),
    .b(\alu/sft/n41_lutinv ),
    .o(_al_u1477_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1478 (
    .a(\alu/sft/n42_lutinv ),
    .b(abus[6]),
    .o(\alu/sft/sel0_b7/B2 ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1479 (
    .a(_al_u1472_o),
    .b(_al_u1477_o),
    .c(\alu/sft/sel0_b7/B2 ),
    .o(_al_u1479_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1480 (
    .a(_al_u1462_o),
    .b(_al_u1479_o),
    .o(_al_u1480_o));
  AL_MAP_LUT5 #(
    .EQN("(E*(B*~(A)*~((D*~C))+B*A*~((D*~C))+~(B)*A*(D*~C)+B*A*(D*~C)))"),
    .INIT(32'hcacc0000))
    _al_u1481 (
    .a(bdatr[15]),
    .b(bdatr[7]),
    .c(\mem/read_cyc [0]),
    .d(\mem/read_cyc [1]),
    .e(\mem/read_cyc [2]),
    .o(cbus_mem[7]));
  AL_MAP_LUT4 #(
    .EQN("~(~C*B*~(~D*A))"),
    .INIT(16'hf3fb))
    _al_u1482 (
    .a(\alu/mul/out [7]),
    .b(_al_u1480_o),
    .c(cbus_mem[7]),
    .d(_al_u510_o),
    .o(cbus[7]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1483 (
    .a(\alu/sft/babs [0]),
    .b(abus[0]),
    .o(_al_u1483_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u1484 (
    .a(\alu/sft/babs [0]),
    .b(abus[2]),
    .c(abus[1]),
    .o(_al_u1484_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'ha3))
    _al_u1485 (
    .a(_al_u1483_o),
    .b(_al_u1484_o),
    .c(\alu/sft/babs [1]),
    .o(_al_u1485_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(E*C)*~(D*A))"),
    .INIT(32'h01031133))
    _al_u1487 (
    .a(_al_u1485_o),
    .b(\alu/sft/sel0_b0/B8 ),
    .c(\alu/sft/n42_lutinv ),
    .d(_al_u1435_o),
    .e(abus[1]),
    .o(_al_u1487_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*~B*~(~D*~C)))"),
    .INIT(32'h888aaaaa))
    _al_u1488 (
    .a(_al_u1487_o),
    .b(_al_u1475_o),
    .c(_al_u1437_o),
    .d(\alu/sft/n41_lutinv ),
    .e(_al_u1421_o),
    .o(_al_u1488_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u1489 (
    .a(\alu/sft/babs [0]),
    .b(abus[6]),
    .c(abus[7]),
    .o(_al_u1489_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1490 (
    .a(_al_u1489_o),
    .b(\alu/sft/babs [1]),
    .o(_al_u1490_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1491 (
    .a(\alu/sft/babs [1]),
    .b(abus[7]),
    .o(_al_u1491_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u1492 (
    .a(_al_u1490_o),
    .b(_al_u1491_o),
    .c(_al_u1437_o),
    .d(\alu/sft/n28_lutinv ),
    .o(_al_u1492_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u1493 (
    .a(_al_u1489_o),
    .b(\alu/sft/babs [1]),
    .c(\alu/sft/babs [0]),
    .d(abus[0]),
    .e(rgf_sr_flag[2]),
    .o(_al_u1493_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~(A*~(C*B)))"),
    .INIT(16'h00d5))
    _al_u1494 (
    .a(_al_u1492_o),
    .b(_al_u1493_o),
    .c(\alu/sft/n41_lutinv ),
    .d(_al_u1421_o),
    .o(_al_u1494_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u1495 (
    .a(\alu/sft/babs [0]),
    .b(abus[0]),
    .c(rgf_sr_flag[2]),
    .o(_al_u1495_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u1496 (
    .a(_al_u1484_o),
    .b(_al_u1495_o),
    .c(\alu/sft/babs [1]),
    .o(_al_u1496_o));
  AL_MAP_LUT4 #(
    .EQN("(D*(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C))"),
    .INIT(16'ha300))
    _al_u1497 (
    .a(_al_u1496_o),
    .b(_al_u1469_o),
    .c(_al_u1421_o),
    .d(\alu/sft/n44_lutinv ),
    .o(_al_u1497_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1498 (
    .a(_al_u1488_o),
    .b(_al_u1494_o),
    .c(_al_u1497_o),
    .o(_al_u1498_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(~B*~A))"),
    .INIT(8'h0e))
    _al_u1499 (
    .a(\alu/art/n4 [2]),
    .b(_al_u1455_o),
    .c(\alu/log/n9_lutinv ),
    .o(_al_u1499_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A))"),
    .INIT(16'h40e0))
    _al_u1500 (
    .a(\alu/art/n4 [2]),
    .b(_al_u1450_o),
    .c(_al_u1452_o),
    .d(\alu/log/n8_lutinv ),
    .o(_al_u1500_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*D)*(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A))"),
    .INIT(32'h00e4e4e4))
    _al_u1501 (
    .a(abus[2]),
    .b(_al_u1499_o),
    .c(_al_u1500_o),
    .d(abus[10]),
    .e(\alu/log/n11_lutinv ),
    .o(_al_u1501_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~((E*A)*~(B)*~(D)+(E*A)*B*~(D)+~((E*A))*B*D+(E*A)*B*D))"),
    .INIT(32'h305030f0))
    _al_u1502 (
    .a(\alu/art/out [2]),
    .b(\alu/art/n13 [2]),
    .c(_al_u1501_o),
    .d(\ctl/n119_lutinv ),
    .e(\alu/art/drv_lutinv ),
    .o(_al_u1502_o));
  AL_MAP_LUT5 #(
    .EQN("(E*(B*~(A)*~((D*~C))+B*A*~((D*~C))+~(B)*A*(D*~C)+B*A*(D*~C)))"),
    .INIT(32'hcacc0000))
    _al_u1503 (
    .a(bdatr[10]),
    .b(bdatr[2]),
    .c(\mem/read_cyc [0]),
    .d(\mem/read_cyc [1]),
    .e(\mem/read_cyc [2]),
    .o(cbus_mem[2]));
  AL_MAP_LUT5 #(
    .EQN("~(~D*C*B*~(~E*A))"),
    .INIT(32'hff3fffbf))
    _al_u1504 (
    .a(\alu/mul/out [2]),
    .b(_al_u1498_o),
    .c(_al_u1502_o),
    .d(cbus_mem[2]),
    .e(_al_u510_o),
    .o(cbus[2]));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~E*~(D)*~((~C*B))+~E*D*~((~C*B))+~(~E)*D*(~C*B)+~E*D*(~C*B)))"),
    .INIT(32'ha2aa0008))
    _al_u1505 (
    .a(\alu/sft/n28_lutinv ),
    .b(_al_u1421_o),
    .c(\alu/sft/babs [1]),
    .d(_al_u1431_o),
    .e(abus[7]),
    .o(_al_u1505_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*~A*~(D*B))"),
    .INIT(16'h0105))
    _al_u1506 (
    .a(\alu/sft/sel0_b0/B8 ),
    .b(\alu/sft/n42_lutinv ),
    .c(_al_u1505_o),
    .d(abus[4]),
    .o(_al_u1506_o));
  AL_MAP_LUT4 #(
    .EQN("~(~C*~((D*~B))*~(A)+~C*(D*~B)*~(A)+~(~C)*(D*~B)*A+~C*(D*~B)*A)"),
    .INIT(16'hd8fa))
    _al_u1507 (
    .a(\alu/sft/babs [1]),
    .b(\alu/sft/babs [0]),
    .c(_al_u1431_o),
    .d(abus[7]),
    .o(_al_u1507_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(D*~C*B))"),
    .INIT(16'ha2aa))
    _al_u1508 (
    .a(_al_u1506_o),
    .b(\alu/sft/n34_lutinv ),
    .c(_al_u1507_o),
    .d(_al_u1421_o),
    .o(_al_u1508_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u1509 (
    .a(_al_u1467_o),
    .b(\alu/sft/babs [1]),
    .c(_al_u1416_o),
    .o(_al_u1509_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1510 (
    .a(_al_u1414_o),
    .b(\alu/sft/babs [1]),
    .o(_al_u1510_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C))"),
    .INIT(16'h5c00))
    _al_u1511 (
    .a(_al_u1509_o),
    .b(_al_u1510_o),
    .c(_al_u1421_o),
    .d(\alu/sft/mux18_b1_sel_is_1_o ),
    .o(_al_u1511_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*~(B)+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(B)+~(~A)*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B+~A*(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*B)"),
    .INIT(32'hdd1dd111))
    _al_u1512 (
    .a(_al_u1414_o),
    .b(\alu/sft/babs [1]),
    .c(\alu/sft/babs [0]),
    .d(abus[7]),
    .e(rgf_sr_flag[2]),
    .o(_al_u1512_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C))"),
    .INIT(16'h5c00))
    _al_u1513 (
    .a(_al_u1509_o),
    .b(_al_u1512_o),
    .c(_al_u1421_o),
    .d(\alu/sft/n44_lutinv ),
    .o(_al_u1513_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u1514 (
    .a(_al_u1441_o),
    .b(_al_u1474_o),
    .c(\alu/sft/babs [1]),
    .o(_al_u1514_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u1515 (
    .a(_al_u1442_o),
    .b(\alu/sft/babs [1]),
    .c(_al_u1431_o),
    .o(_al_u1515_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u1516 (
    .a(_al_u1514_o),
    .b(_al_u1515_o),
    .c(_al_u1421_o),
    .o(_al_u1516_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*A*~(E*D))"),
    .INIT(32'h00020202))
    _al_u1517 (
    .a(_al_u1508_o),
    .b(_al_u1511_o),
    .c(_al_u1513_o),
    .d(_al_u1516_o),
    .e(\alu/sft/n41_lutinv ),
    .o(_al_u1517_o));
  AL_MAP_LUT5 #(
    .EQN("(E*(B*~(A)*~((D*~C))+B*A*~((D*~C))+~(B)*A*(D*~C)+B*A*(D*~C)))"),
    .INIT(32'hcacc0000))
    _al_u1518 (
    .a(bdatr[13]),
    .b(bdatr[5]),
    .c(\mem/read_cyc [0]),
    .d(\mem/read_cyc [1]),
    .e(\mem/read_cyc [2]),
    .o(cbus_mem[5]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~((E*A)*~(B)*~(D)+(E*A)*B*~(D)+~((E*A))*B*D+(E*A)*B*D))"),
    .INIT(32'h0305030f))
    _al_u1519 (
    .a(\alu/art/out [5]),
    .b(\alu/art/n13 [5]),
    .c(cbus_mem[5]),
    .d(\ctl/n119_lutinv ),
    .e(\alu/art/drv_lutinv ),
    .o(_al_u1519_o));
  AL_MAP_LUT4 #(
    .EQN("(C*(~D*~(B)*~(A)+~D*B*~(A)+~(~D)*B*A+~D*B*A))"),
    .INIT(16'h80d0))
    _al_u1520 (
    .a(bbus[5]),
    .b(_al_u1450_o),
    .c(_al_u1452_o),
    .d(\alu/log/n8_lutinv ),
    .o(_al_u1520_o));
  AL_MAP_LUT5 #(
    .EQN("((~E*~(~D*C))*~(B)*~(A)+(~E*~(~D*C))*B*~(A)+~((~E*~(~D*C)))*B*A+(~E*~(~D*C))*B*A)"),
    .INIT(32'h8888dd8d))
    _al_u1521 (
    .a(abus[5]),
    .b(_al_u1520_o),
    .c(bbus[5]),
    .d(_al_u1455_o),
    .e(\alu/log/n9_lutinv ),
    .o(_al_u1521_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u1522 (
    .a(_al_u1521_o),
    .b(abus[13]),
    .c(\alu/log/n11_lutinv ),
    .o(_al_u1522_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*C*B*~(~E*A))"),
    .INIT(32'h3fffbfff))
    _al_u1523 (
    .a(\alu/mul/out [5]),
    .b(_al_u1517_o),
    .c(_al_u1519_o),
    .d(_al_u1522_o),
    .e(_al_u510_o),
    .o(cbus[5]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1524 (
    .a(_al_u1483_o),
    .b(\alu/sft/babs [1]),
    .o(\alu/sft/lsl2 [0]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(D*C)*~(E*B))"),
    .INIT(32'h01110555))
    _al_u1525 (
    .a(\alu/sft/sel0_b0/B8 ),
    .b(\alu/sft/n42_lutinv ),
    .c(\alu/sft/lsl2 [0]),
    .d(_al_u1435_o),
    .e(rgf_sr_flag[2]),
    .o(_al_u1525_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u1526 (
    .a(_al_u1495_o),
    .b(\alu/sft/babs [1]),
    .c(_al_u1468_o),
    .o(_al_u1526_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u1527 (
    .a(_al_u1509_o),
    .b(_al_u1526_o),
    .c(_al_u1421_o),
    .o(_al_u1527_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~A*~(~C*~B))"),
    .INIT(16'h5400))
    _al_u1528 (
    .a(_al_u1514_o),
    .b(_al_u1437_o),
    .c(\alu/sft/n41_lutinv ),
    .d(_al_u1421_o),
    .o(_al_u1528_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u1529 (
    .a(_al_u1473_o),
    .b(_al_u1489_o),
    .c(\alu/sft/babs [1]),
    .o(_al_u1529_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~A*~(~C*~B))"),
    .INIT(16'h0054))
    _al_u1530 (
    .a(_al_u1529_o),
    .b(_al_u1437_o),
    .c(\alu/sft/n41_lutinv ),
    .d(_al_u1421_o),
    .o(_al_u1530_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~C*A*~(E*B))"),
    .INIT(32'h0002000a))
    _al_u1531 (
    .a(_al_u1525_o),
    .b(_al_u1527_o),
    .c(_al_u1528_o),
    .d(_al_u1530_o),
    .e(\alu/sft/n44_lutinv ),
    .o(_al_u1531_o));
  AL_MAP_LUT5 #(
    .EQN("(E*(B*~(A)*~((D*~C))+B*A*~((D*~C))+~(B)*A*(D*~C)+B*A*(D*~C)))"),
    .INIT(32'hcacc0000))
    _al_u1532 (
    .a(bdatr[8]),
    .b(bdatr[0]),
    .c(\mem/read_cyc [0]),
    .d(\mem/read_cyc [1]),
    .e(\mem/read_cyc [2]),
    .o(cbus_mem[0]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~((E*A)*~(B)*~(D)+(E*A)*B*~(D)+~((E*A))*B*D+(E*A)*B*D))"),
    .INIT(32'h0305030f))
    _al_u1533 (
    .a(\alu/art/out [0]),
    .b(\alu/art/n13 [0]),
    .c(cbus_mem[0]),
    .d(\ctl/n119_lutinv ),
    .e(\alu/art/drv_lutinv ),
    .o(_al_u1533_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A))"),
    .INIT(16'h40e0))
    _al_u1534 (
    .a(\alu/art/n4 [0]),
    .b(_al_u1450_o),
    .c(_al_u1452_o),
    .d(\alu/log/n8_lutinv ),
    .o(_al_u1534_o));
  AL_MAP_LUT5 #(
    .EQN("((~E*~(~D*~C))*~(A)*~(B)+(~E*~(~D*~C))*A*~(B)+~((~E*~(~D*~C)))*A*B+(~E*~(~D*~C))*A*B)"),
    .INIT(32'h8888bbb8))
    _al_u1535 (
    .a(_al_u1534_o),
    .b(abus[0]),
    .c(\alu/art/n4 [0]),
    .d(_al_u1455_o),
    .e(\alu/log/n9_lutinv ),
    .o(_al_u1535_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u1536 (
    .a(_al_u1535_o),
    .b(abus[8]),
    .c(\alu/log/n11_lutinv ),
    .o(_al_u1536_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*C*B*~(~E*A))"),
    .INIT(32'h3fffbfff))
    _al_u1537 (
    .a(\alu/mul/out [0]),
    .b(_al_u1531_o),
    .c(_al_u1533_o),
    .d(_al_u1536_o),
    .e(_al_u510_o),
    .o(cbus[0]));
  AL_MAP_LUT4 #(
    .EQN("(C*(~D*~(B)*~(A)+~D*B*~(A)+~(~D)*B*A+~D*B*A))"),
    .INIT(16'h80d0))
    _al_u1538 (
    .a(bbus[4]),
    .b(_al_u1450_o),
    .c(_al_u1452_o),
    .d(\alu/log/n8_lutinv ),
    .o(_al_u1538_o));
  AL_MAP_LUT5 #(
    .EQN("((~E*~(~D*C))*~(A)*~(B)+(~E*~(~D*C))*A*~(B)+~((~E*~(~D*C)))*A*B+(~E*~(~D*C))*A*B)"),
    .INIT(32'h8888bb8b))
    _al_u1539 (
    .a(_al_u1538_o),
    .b(abus[4]),
    .c(bbus[4]),
    .d(_al_u1455_o),
    .e(\alu/log/n9_lutinv ),
    .o(_al_u1539_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u1540 (
    .a(_al_u1539_o),
    .b(abus[12]),
    .c(\alu/log/n11_lutinv ),
    .o(_al_u1540_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~((E*A)*~(B)*~(D)+(E*A)*B*~(D)+~((E*A))*B*D+(E*A)*B*D))"),
    .INIT(32'h305030f0))
    _al_u1541 (
    .a(\alu/art/out [4]),
    .b(\alu/art/n13 [4]),
    .c(_al_u1540_o),
    .d(\ctl/n119_lutinv ),
    .e(\alu/art/drv_lutinv ),
    .o(_al_u1541_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u1542 (
    .a(\alu/sft/babs [0]),
    .b(abus[4]),
    .c(abus[3]),
    .o(_al_u1542_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u1543 (
    .a(_al_u1484_o),
    .b(_al_u1542_o),
    .c(\alu/sft/babs [1]),
    .o(_al_u1543_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u1544 (
    .a(_al_u1543_o),
    .b(_al_u1526_o),
    .c(_al_u1421_o),
    .o(_al_u1544_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*~B))"),
    .INIT(8'h8a))
    _al_u1545 (
    .a(_al_u1541_o),
    .b(_al_u1544_o),
    .c(\alu/sft/n44_lutinv ),
    .o(_al_u1545_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(C*~(~E*~(A)*~(D)+~E*A*~(D)+~(~E)*A*D+~E*A*D)))"),
    .INIT(32'h23032333))
    _al_u1546 (
    .a(_al_u1529_o),
    .b(\alu/sft/sel0_b0/B8 ),
    .c(\alu/sft/n28_lutinv ),
    .d(_al_u1421_o),
    .e(abus[7]),
    .o(_al_u1546_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1547 (
    .a(_al_u1529_o),
    .b(_al_u1421_o),
    .o(_al_u1547_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'ha3))
    _al_u1548 (
    .a(_al_u1543_o),
    .b(\alu/sft/lsl2 [0]),
    .c(_al_u1421_o),
    .o(_al_u1548_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1549 (
    .a(\alu/art/n4 [3]),
    .b(_al_u1427_o),
    .o(\alu/sft/n33_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*~C)*~(D*B))"),
    .INIT(32'h20a022aa))
    _al_u1550 (
    .a(_al_u1546_o),
    .b(_al_u1547_o),
    .c(_al_u1548_o),
    .d(\alu/sft/n34_lutinv ),
    .e(\alu/sft/n33_lutinv ),
    .o(_al_u1550_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1551 (
    .a(\alu/sft/babs [0]),
    .b(abus[2]),
    .c(abus[1]),
    .o(_al_u1551_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~(~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'h77477444))
    _al_u1552 (
    .a(_al_u1551_o),
    .b(\alu/sft/babs [1]),
    .c(\alu/sft/babs [0]),
    .d(abus[0]),
    .e(rgf_sr_flag[2]),
    .o(_al_u1552_o));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'h5c))
    _al_u1553 (
    .a(_al_u1529_o),
    .b(_al_u1552_o),
    .c(_al_u1421_o),
    .o(_al_u1553_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*~A)"),
    .INIT(32'h00001000))
    _al_u1554 (
    .a(\alu/sft/n27 [3]),
    .b(\alu/art/n4 [3]),
    .c(\alu/sft/n30_lutinv ),
    .d(\alu/sft/n36_lutinv ),
    .e(\alu/art/eq4/or_xor_i0[2]_i1[2]_o_o_lutinv ),
    .o(_al_u1554_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1555 (
    .a(\alu/art/n4 [3]),
    .b(_al_u749_o),
    .c(_al_u1337_o),
    .o(\alu/sft/n40_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~(D*~B)*~(C*A))"),
    .INIT(16'h4c5f))
    _al_u1556 (
    .a(_al_u1553_o),
    .b(_al_u1548_o),
    .c(_al_u1554_o),
    .d(\alu/sft/n40_lutinv ),
    .o(_al_u1556_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~B*~(D*C)))"),
    .INIT(16'ha888))
    _al_u1557 (
    .a(_al_u1424_o),
    .b(\ctl/n321_lutinv ),
    .c(_al_u512_o),
    .d(_al_u484_o),
    .o(_al_u1557_o));
  AL_MAP_LUT5 #(
    .EQN("(C*B*A*~(E*D))"),
    .INIT(32'h00808080))
    _al_u1558 (
    .a(_al_u1545_o),
    .b(_al_u1550_o),
    .c(_al_u1556_o),
    .d(_al_u1557_o),
    .e(abus[3]),
    .o(_al_u1558_o));
  AL_MAP_LUT5 #(
    .EQN("(E*(B*~(A)*~((D*~C))+B*A*~((D*~C))+~(B)*A*(D*~C)+B*A*(D*~C)))"),
    .INIT(32'hcacc0000))
    _al_u1559 (
    .a(bdatr[12]),
    .b(bdatr[4]),
    .c(\mem/read_cyc [0]),
    .d(\mem/read_cyc [1]),
    .e(\mem/read_cyc [2]),
    .o(cbus_mem[4]));
  AL_MAP_LUT4 #(
    .EQN("~(~C*B*~(~D*A))"),
    .INIT(16'hf3fb))
    _al_u1560 (
    .a(\alu/mul/out [4]),
    .b(_al_u1558_o),
    .c(cbus_mem[4]),
    .d(_al_u510_o),
    .o(cbus[4]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u1561 (
    .a(_al_u1418_o),
    .b(_al_u1542_o),
    .c(\alu/sft/babs [1]),
    .o(_al_u1561_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u1562 (
    .a(_al_u1485_o),
    .b(_al_u1561_o),
    .c(_al_u1421_o),
    .o(_al_u1562_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~E*~(B)*~((~D*C))+~E*B*~((~D*C))+~(~E)*B*(~D*C)+~E*B*(~D*C)))"),
    .INIT(32'haa2a0020))
    _al_u1563 (
    .a(\alu/sft/n28_lutinv ),
    .b(_al_u1489_o),
    .c(_al_u1421_o),
    .d(\alu/sft/babs [1]),
    .e(abus[7]),
    .o(_al_u1563_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*~B*~(D*~A))"),
    .INIT(16'h0203))
    _al_u1564 (
    .a(_al_u1562_o),
    .b(_al_u1563_o),
    .c(\alu/sft/sel0_b0/B8 ),
    .d(\alu/sft/n33_lutinv ),
    .o(_al_u1564_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(D*C*B))"),
    .INIT(16'h2aaa))
    _al_u1565 (
    .a(_al_u1564_o),
    .b(\alu/sft/n34_lutinv ),
    .c(_al_u1490_o),
    .d(_al_u1421_o),
    .o(_al_u1565_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(~B*A))"),
    .INIT(8'h0d))
    _al_u1566 (
    .a(bbus[6]),
    .b(_al_u1455_o),
    .c(\alu/log/n9_lutinv ),
    .o(_al_u1566_o));
  AL_MAP_LUT4 #(
    .EQN("(C*(~D*~(B)*~(A)+~D*B*~(A)+~(~D)*B*A+~D*B*A))"),
    .INIT(16'h80d0))
    _al_u1567 (
    .a(bbus[6]),
    .b(_al_u1450_o),
    .c(_al_u1452_o),
    .d(\alu/log/n8_lutinv ),
    .o(_al_u1567_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*B)*(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))"),
    .INIT(32'h3210fa50))
    _al_u1568 (
    .a(abus[6]),
    .b(abus[14]),
    .c(_al_u1566_o),
    .d(_al_u1567_o),
    .e(\alu/log/n11_lutinv ),
    .o(_al_u1568_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~((E*A)*~(B)*~(D)+(E*A)*B*~(D)+~((E*A))*B*D+(E*A)*B*D))"),
    .INIT(32'h305030f0))
    _al_u1569 (
    .a(\alu/art/out [6]),
    .b(\alu/art/n13 [6]),
    .c(_al_u1568_o),
    .d(\ctl/n119_lutinv ),
    .e(\alu/art/drv_lutinv ),
    .o(_al_u1569_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*~(~B*~(C)*~(D)+~B*C*~(D)+~(~B)*C*D+~B*C*D)))"),
    .INIT(32'ha022aaaa))
    _al_u1570 (
    .a(_al_u1569_o),
    .b(_al_u1496_o),
    .c(_al_u1561_o),
    .d(_al_u1421_o),
    .e(\alu/sft/n44_lutinv ),
    .o(_al_u1570_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*~A))"),
    .INIT(16'h23af))
    _al_u1571 (
    .a(_al_u1562_o),
    .b(_al_u1557_o),
    .c(\alu/sft/n40_lutinv ),
    .d(abus[5]),
    .o(_al_u1571_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u1572 (
    .a(_al_u1430_o),
    .b(_al_u1551_o),
    .c(\alu/sft/babs [1]),
    .o(_al_u1572_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u1573 (
    .a(_al_u1572_o),
    .b(_al_u1493_o),
    .c(_al_u1421_o),
    .o(_al_u1573_o));
  AL_MAP_LUT5 #(
    .EQN("(C*B*A*~(E*D))"),
    .INIT(32'h00808080))
    _al_u1574 (
    .a(_al_u1565_o),
    .b(_al_u1570_o),
    .c(_al_u1571_o),
    .d(_al_u1573_o),
    .e(_al_u1554_o),
    .o(_al_u1574_o));
  AL_MAP_LUT5 #(
    .EQN("(E*(B*~(A)*~((D*~C))+B*A*~((D*~C))+~(B)*A*(D*~C)+B*A*(D*~C)))"),
    .INIT(32'hcacc0000))
    _al_u1575 (
    .a(bdatr[14]),
    .b(bdatr[6]),
    .c(\mem/read_cyc [0]),
    .d(\mem/read_cyc [1]),
    .e(\mem/read_cyc [2]),
    .o(cbus_mem[6]));
  AL_MAP_LUT4 #(
    .EQN("~(~C*B*~(~D*A))"),
    .INIT(16'hf3fb))
    _al_u1576 (
    .a(\alu/mul/out [6]),
    .b(_al_u1574_o),
    .c(cbus_mem[6]),
    .d(_al_u510_o),
    .o(cbus[6]));
  AL_MAP_LUT4 #(
    .EQN("(B*~(C*~(A)*~(D)+C*A*~(D)+~(C)*A*D+C*A*D))"),
    .INIT(16'h440c))
    _al_u1577 (
    .a(_al_u1572_o),
    .b(\alu/sft/n34_lutinv ),
    .c(_al_u1507_o),
    .d(_al_u1421_o),
    .o(_al_u1577_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~((E*~B)*~(A)*~(D)+(E*~B)*A*~(D)+~((E*~B))*A*D+(E*~B)*A*D))"),
    .INIT(32'h50c050f0))
    _al_u1578 (
    .a(_al_u1572_o),
    .b(_al_u1491_o),
    .c(\alu/sft/n28_lutinv ),
    .d(_al_u1421_o),
    .e(_al_u1507_o),
    .o(_al_u1578_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1579 (
    .a(_al_u1510_o),
    .b(_al_u1421_o),
    .o(_al_u1579_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~B*~A*~(E*C))"),
    .INIT(32'h00010011))
    _al_u1580 (
    .a(_al_u1577_o),
    .b(_al_u1578_o),
    .c(_al_u1579_o),
    .d(\alu/sft/sel0_b0/B8 ),
    .e(\alu/sft/n33_lutinv ),
    .o(_al_u1580_o));
  AL_MAP_LUT4 #(
    .EQN("(D*(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(16'hc500))
    _al_u1581 (
    .a(_al_u1561_o),
    .b(_al_u1512_o),
    .c(_al_u1421_o),
    .d(\alu/sft/n44_lutinv ),
    .o(_al_u1581_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1582 (
    .a(_al_u1581_o),
    .b(_al_u1557_o),
    .c(abus[0]),
    .o(_al_u1582_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D))"),
    .INIT(16'h50c0))
    _al_u1583 (
    .a(_al_u1572_o),
    .b(_al_u1515_o),
    .c(_al_u1554_o),
    .d(_al_u1421_o),
    .o(_al_u1583_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*A*~(E*D))"),
    .INIT(32'h00080808))
    _al_u1584 (
    .a(_al_u1580_o),
    .b(_al_u1582_o),
    .c(_al_u1583_o),
    .d(_al_u1579_o),
    .e(\alu/sft/n40_lutinv ),
    .o(_al_u1584_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A))"),
    .INIT(16'h40e0))
    _al_u1585 (
    .a(\alu/art/n4 [1]),
    .b(_al_u1450_o),
    .c(_al_u1452_o),
    .d(\alu/log/n8_lutinv ),
    .o(_al_u1585_o));
  AL_MAP_LUT5 #(
    .EQN("((~E*~(~D*~C))*~(A)*~(B)+(~E*~(~D*~C))*A*~(B)+~((~E*~(~D*~C)))*A*B+(~E*~(~D*~C))*A*B)"),
    .INIT(32'h8888bbb8))
    _al_u1586 (
    .a(_al_u1585_o),
    .b(abus[1]),
    .c(\alu/art/n4 [1]),
    .d(_al_u1455_o),
    .e(\alu/log/n9_lutinv ),
    .o(_al_u1586_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u1587 (
    .a(_al_u1586_o),
    .b(abus[9]),
    .c(\alu/log/n11_lutinv ),
    .o(_al_u1587_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(D*B)*~(E*A))"),
    .INIT(32'h105030f0))
    _al_u1588 (
    .a(\alu/art/out [1]),
    .b(\alu/art/n13 [1]),
    .c(_al_u1587_o),
    .d(\ctl/n119_lutinv ),
    .e(\alu/art/drv_lutinv ),
    .o(_al_u1588_o));
  AL_MAP_LUT5 #(
    .EQN("(E*(B*~(A)*~((D*~C))+B*A*~((D*~C))+~(B)*A*(D*~C)+B*A*(D*~C)))"),
    .INIT(32'hcacc0000))
    _al_u1589 (
    .a(bdatr[9]),
    .b(bdatr[1]),
    .c(\mem/read_cyc [0]),
    .d(\mem/read_cyc [1]),
    .e(\mem/read_cyc [2]),
    .o(cbus_mem[1]));
  AL_MAP_LUT5 #(
    .EQN("~(~D*C*B*~(~E*A))"),
    .INIT(32'hff3fffbf))
    _al_u1590 (
    .a(\alu/mul/out [1]),
    .b(_al_u1584_o),
    .c(_al_u1588_o),
    .d(cbus_mem[1]),
    .e(_al_u510_o),
    .o(cbus[1]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1591 (
    .a(cbus[3]),
    .b(_al_u665_o),
    .c(\rgf/sreg/mux2_b2_sel_is_2_o ),
    .d(fch_irq_lev[1]),
    .e(rgf_sr_ie[1]),
    .o(\rgf/sreg/n7 [3]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1592 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [3]),
    .d(n0[2]),
    .e(\rgf/sptr/sp [3]),
    .o(_al_u1592_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1593 (
    .a(cbus[3]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1592_o),
    .o(\rgf/sptr/n2 [3]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1594 (
    .a(cbus[3]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [2]),
    .e(rgf_pc[3]),
    .o(\rgf/pcnt/n2 [3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u1595 (
    .a(\alu/art/alu_sr_flag_add [3]),
    .b(_al_u1461_o),
    .c(\alu/art/drv_lutinv ),
    .o(_al_u1595_o));
  AL_MAP_LUT4 #(
    .EQN("(~(B*A)*~(D)*~(C)+~(B*A)*D*~(C)+~(~(B*A))*D*C+~(B*A)*D*C)"),
    .INIT(16'hf707))
    _al_u1596 (
    .a(_al_u1479_o),
    .b(_al_u1595_o),
    .c(ctl_sr_upd_neg_lutinv),
    .d(rgf_sr_flag[3]),
    .o(_al_u1596_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1597 (
    .a(_al_u665_o),
    .b(_al_u666_o),
    .o(\rgf/sreg/mux3_b4_sel_is_0_o ));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u1598 (
    .a(cbus[7]),
    .b(_al_u1596_o),
    .c(\rgf/sreg/mux3_b4_sel_is_0_o ),
    .o(\rgf/sreg/n7 [7]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1599 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [7]),
    .d(n0[6]),
    .e(\rgf/sptr/sp [7]),
    .o(_al_u1599_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1600 (
    .a(cbus[7]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1599_o),
    .o(\rgf/sptr/n2 [7]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1601 (
    .a(cbus[7]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [6]),
    .e(rgf_pc[7]),
    .o(\rgf/pcnt/n2 [7]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1602 (
    .a(cbus[2]),
    .b(_al_u665_o),
    .c(\rgf/sreg/mux2_b2_sel_is_2_o ),
    .d(fch_irq_lev[0]),
    .e(rgf_sr_ie[0]),
    .o(\rgf/sreg/n7 [2]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1603 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [2]),
    .d(n0[1]),
    .e(\rgf/sptr/sp [2]),
    .o(_al_u1603_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1604 (
    .a(cbus[2]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1603_o),
    .o(\rgf/sptr/n2 [2]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1605 (
    .a(cbus[2]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [1]),
    .e(rgf_pc[2]),
    .o(\rgf/pcnt/n2 [2]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1606 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [5]),
    .d(n0[4]),
    .e(\rgf/sptr/sp [5]),
    .o(_al_u1606_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1607 (
    .a(cbus[5]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1606_o),
    .o(\rgf/sptr/n2 [5]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1608 (
    .a(cbus[5]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [4]),
    .e(rgf_pc[5]),
    .o(\rgf/pcnt/n2 [5]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    _al_u1609 (
    .a(cbus[0]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(\rgf/sptr/sp [0]),
    .o(\rgf/sptr/n2 [0]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1610 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [4]),
    .d(n0[3]),
    .e(\rgf/sptr/sp [4]),
    .o(_al_u1610_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1611 (
    .a(cbus[4]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1610_o),
    .o(\rgf/sptr/n2 [4]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1612 (
    .a(cbus[4]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [3]),
    .e(rgf_pc[4]),
    .o(\rgf/pcnt/n2 [4]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*~B))"),
    .INIT(8'h54))
    _al_u1613 (
    .a(_al_u1421_o),
    .b(\alu/sft/mux18_b1_sel_is_1_o ),
    .c(\alu/sft/n44_lutinv ),
    .o(_al_u1613_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1614 (
    .a(\alu/sft/n48_lutinv ),
    .b(_al_u513_o),
    .o(_al_u1614_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~E*D*C)*~(B*~A))"),
    .INIT(32'hbbbb0bbb))
    _al_u1615 (
    .a(_al_u1543_o),
    .b(_al_u1613_o),
    .c(_al_u1424_o),
    .d(abus[7]),
    .e(_al_u1614_o),
    .o(_al_u1615_o));
  AL_MAP_LUT5 #(
    .EQN("(D*C*~A*~(~E*~B))"),
    .INIT(32'h50004000))
    _al_u1616 (
    .a(\alu/sft/babs [1]),
    .b(\alu/sft/babs [0]),
    .c(\alu/sft/mux18_b1_sel_is_1_o ),
    .d(abus[7]),
    .e(\alu/sft/n36_lutinv ),
    .o(_al_u1616_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*(~(A)*~(B)*~(D)*~(E)+A*~(B)*~(D)*~(E)+~(A)*B*~(D)*~(E)+A*B*~(D)*~(E)+~(A)*~(B)*D*~(E)+~(A)*B*D*~(E)+~(A)*~(B)*~(D)*E+~(A)*~(B)*D*E))"),
    .INIT(32'h0101050f))
    _al_u1617 (
    .a(_al_u1419_o),
    .b(_al_u1420_o),
    .c(_al_u1616_o),
    .d(\alu/sft/mux18_b1_sel_is_1_o ),
    .e(\alu/sft/n44_lutinv ),
    .o(_al_u1617_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*~(B*~(D*C))))"),
    .INIT(32'h0888aaaa))
    _al_u1618 (
    .a(_al_u1615_o),
    .b(_al_u1617_o),
    .c(\alu/sft/lsr2 [7]),
    .d(\alu/sft/n28_lutinv ),
    .e(_al_u1421_o),
    .o(_al_u1618_o));
  AL_MAP_LUT4 #(
    .EQN("(C*(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))"),
    .INIT(16'hc050))
    _al_u1619 (
    .a(_al_u1432_o),
    .b(_al_u1552_o),
    .c(\alu/sft/n41_lutinv ),
    .d(_al_u1421_o),
    .o(_al_u1619_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*C)*~(A)*~(B)+~(D*C)*A*~(B)+~(~(D*C))*A*B+~(D*C)*A*B)"),
    .INIT(16'h8bbb))
    _al_u1620 (
    .a(_al_u1551_o),
    .b(\alu/sft/babs [1]),
    .c(\alu/sft/babs [0]),
    .d(abus[0]),
    .o(_al_u1620_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h3050))
    _al_u1621 (
    .a(_al_u1432_o),
    .b(_al_u1620_o),
    .c(_al_u1437_o),
    .d(_al_u1421_o),
    .o(_al_u1621_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1622 (
    .a(_al_u1618_o),
    .b(_al_u1619_o),
    .c(_al_u1621_o),
    .o(_al_u1622_o));
  AL_MAP_LUT3 #(
    .EQN("(B*(C@A))"),
    .INIT(8'h48))
    _al_u1623 (
    .a(\alu/art/alu_sr_flag_ihz [2]),
    .b(\alu/art/drv_lutinv ),
    .c(\alu/art/n2_lutinv ),
    .o(\alu/alu_sr_flag_art [2]));
  AL_MAP_LUT4 #(
    .EQN("(~(~B*A)*~(D)*~(C)+~(~B*A)*D*~(C)+~(~(~B*A))*D*C+~(~B*A)*D*C)"),
    .INIT(16'hfd0d))
    _al_u1624 (
    .a(_al_u1622_o),
    .b(\alu/alu_sr_flag_art [2]),
    .c(ctl_sr_upd_neg_lutinv),
    .d(rgf_sr_flag[2]),
    .o(_al_u1624_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u1625 (
    .a(cbus[6]),
    .b(_al_u1624_o),
    .c(\rgf/sreg/mux3_b4_sel_is_0_o ),
    .o(\rgf/sreg/n7 [6]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1626 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [6]),
    .d(n0[5]),
    .e(\rgf/sptr/sp [6]),
    .o(_al_u1626_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1627 (
    .a(cbus[6]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1626_o),
    .o(\rgf/sptr/n2 [6]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1628 (
    .a(cbus[6]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [5]),
    .e(rgf_pc[6]),
    .o(\rgf/pcnt/n2 [6]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A))*~(B)+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*~(B)+~(C)*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B+C*(D*~(E)*~(A)+D*E*~(A)+~(D)*E*A+D*E*A)*B)"),
    .INIT(32'h03478bcf))
    _al_u1629 (
    .a(_al_u1386_o),
    .b(ctl_sp_inc_neg_lutinv),
    .c(\rgf/sptr/sp_inc [1]),
    .d(n0[0]),
    .e(\rgf/sptr/sp [1]),
    .o(_al_u1629_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h8b))
    _al_u1630 (
    .a(cbus[1]),
    .b(\rgf/cbus_sel_cr [2]),
    .c(_al_u1629_o),
    .o(\rgf/sptr/n2 [1]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*~(A)*~(B)+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*~(B)+~((E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))*A*B+(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C)*A*B)"),
    .INIT(32'hbb8bb888))
    _al_u1631 (
    .a(cbus[1]),
    .b(\rgf/cbus_sel_cr [1]),
    .c(\rgf/pcnt/mux0_b10_sel_is_1_o ),
    .d(\fch/n12 [0]),
    .e(rgf_pc[1]),
    .o(\rgf/pcnt/n2 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~(D*(A*~(B)*~(C)+~(A)*B*C)))"),
    .INIT(32'h0000bdff))
    _al_u1632 (
    .a(\alu/art/alu_sr_flag_add [3]),
    .b(\alu/art/inb [7]),
    .c(abus[7]),
    .d(\alu/art/drv_lutinv ),
    .e(ctl_sr_upd_neg_lutinv),
    .o(_al_u1632_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(D*(B@A)))"),
    .INIT(16'h90f0))
    _al_u1633 (
    .a(_al_u1479_o),
    .b(_al_u1622_o),
    .c(_al_u1632_o),
    .d(\alu/sft/mux18_b1_sel_is_1_o ),
    .o(_al_u1633_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((~B*~(~E*D)))*~(C)+A*(~B*~(~E*D))*~(C)+~(A)*(~B*~(~E*D))*C+A*(~B*~(~E*D))*C)"),
    .INIT(32'h3a3a0a3a))
    _al_u1634 (
    .a(cbus[5]),
    .b(_al_u1633_o),
    .c(\rgf/sreg/mux3_b4_sel_is_0_o ),
    .d(ctl_sr_upd_neg_lutinv),
    .e(rgf_sr_flag[1]),
    .o(\rgf/sreg/n7 [5]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))"),
    .INIT(16'h3a00))
    _al_u1635 (
    .a(_al_u1485_o),
    .b(_al_u1561_o),
    .c(_al_u1421_o),
    .d(\alu/sft/mux18_b1_sel_is_1_o ),
    .o(_al_u1635_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C))"),
    .INIT(16'h5c00))
    _al_u1636 (
    .a(_al_u1543_o),
    .b(\alu/sft/lsl2 [0]),
    .c(_al_u1421_o),
    .d(\alu/sft/mux18_b1_sel_is_1_o ),
    .o(_al_u1636_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*~A*~(D*B))"),
    .INIT(16'h0105))
    _al_u1637 (
    .a(_al_u1635_o),
    .b(_al_u1547_o),
    .c(_al_u1636_o),
    .d(_al_u1437_o),
    .o(_al_u1637_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*A))"),
    .INIT(8'hd0))
    _al_u1639 (
    .a(_al_u1572_o),
    .b(_al_u1515_o),
    .c(\alu/sft/n41_lutinv ),
    .o(_al_u1639_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u1640 (
    .a(_al_u1446_o),
    .b(_al_u1637_o),
    .c(_al_u1577_o),
    .d(_al_u1639_o),
    .o(_al_u1640_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1641 (
    .a(_al_u1579_o),
    .b(\alu/sft/mux18_b1_sel_is_1_o ),
    .o(_al_u1641_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~D*~C*~B))"),
    .INIT(16'haaa8))
    _al_u1642 (
    .a(\alu/sft/n42_lutinv ),
    .b(abus[3]),
    .c(abus[0]),
    .d(abus[5]),
    .o(_al_u1642_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u1643 (
    .a(_al_u1641_o),
    .b(_al_u1578_o),
    .c(_al_u1642_o),
    .d(_al_u1614_o),
    .o(_al_u1643_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u1644 (
    .a(_al_u1553_o),
    .b(_al_u1573_o),
    .c(\alu/sft/n41_lutinv ),
    .o(_al_u1644_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u1645 (
    .a(_al_u1643_o),
    .b(_al_u1531_o),
    .c(_al_u1644_o),
    .d(_al_u1492_o),
    .o(_al_u1645_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u1646 (
    .a(_al_u1544_o),
    .b(_al_u1496_o),
    .c(_al_u1561_o),
    .d(_al_u1512_o),
    .o(_al_u1646_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B*~A))"),
    .INIT(8'hb0))
    _al_u1647 (
    .a(_al_u1646_o),
    .b(\alu/sft/n44_lutinv ),
    .c(_al_u1479_o),
    .o(_al_u1647_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u1648 (
    .a(_al_u1640_o),
    .b(_al_u1645_o),
    .c(_al_u1647_o),
    .d(_al_u1498_o),
    .e(_al_u1517_o),
    .o(_al_u1648_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u1649 (
    .a(\alu/art/out [3]),
    .b(\alu/art/out [2]),
    .c(\alu/art/out [1]),
    .d(\alu/art/out [0]),
    .o(_al_u1649_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u1650 (
    .a(_al_u1649_o),
    .b(\alu/art/alu_sr_flag_add [3]),
    .c(\alu/art/out [6]),
    .d(\alu/art/out [5]),
    .e(\alu/art/out [4]),
    .o(\alu/art/alu_sr_flag_add [0]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u1651 (
    .a(\alu/sft/n30_lutinv ),
    .b(\alu/sft/n36_lutinv ),
    .o(_al_u1651_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(B*A*~(~E*C)))"),
    .INIT(32'h007700f7))
    _al_u1652 (
    .a(\alu/art/alu_sr_flag_add [0]),
    .b(\alu/art/drv_lutinv ),
    .c(_al_u1651_o),
    .d(ctl_sr_upd_neg_lutinv),
    .e(rgf_sr_flag[0]),
    .o(_al_u1652_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u1653 (
    .a(_al_u1540_o),
    .b(_al_u1522_o),
    .c(_al_u1587_o),
    .d(_al_u1568_o),
    .o(_al_u1653_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    _al_u1654 (
    .a(_al_u1340_o),
    .b(\alu/sft/n31_lutinv ),
    .c(\alu/log/eq3/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .o(_al_u1654_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u1655 (
    .a(_al_u1461_o),
    .b(_al_u1536_o),
    .c(_al_u1654_o),
    .d(\alu/sft/n48_lutinv ),
    .o(_al_u1655_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*D*C*B))"),
    .INIT(32'h2aaaaaaa))
    _al_u1656 (
    .a(_al_u1652_o),
    .b(_al_u1653_o),
    .c(_al_u1655_o),
    .d(_al_u1457_o),
    .e(_al_u1501_o),
    .o(_al_u1656_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1657 (
    .a(_al_u1648_o),
    .b(_al_u1656_o),
    .o(_al_u1657_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~((~B*~(~E*D)))*~(C)+A*(~B*~(~E*D))*~(C)+~(A)*(~B*~(~E*D))*C+A*(~B*~(~E*D))*C)"),
    .INIT(32'h3a3a0a3a))
    _al_u1658 (
    .a(cbus[4]),
    .b(_al_u1657_o),
    .c(\rgf/sreg/mux3_b4_sel_is_0_o ),
    .d(ctl_sr_upd_neg_lutinv),
    .e(rgf_sr_flag[0]),
    .o(\rgf/sreg/n7 [4]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u1659 (
    .a(\alu/art/n4 [1]),
    .o(bbus[1]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u1660 (
    .a(\alu/art/n4 [0]),
    .o(bbus[0]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u1661 (
    .a(\alu/art/n4 [3]),
    .o(bbus[3]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u1662 (
    .a(\alu/art/n4 [2]),
    .o(bbus[2]));
  AL_MAP_LUT5 #(
    .EQN("(A*(~(B)*(D*~C)*~(E)+~(B)*~((D*~C))*E+~(B)*(D*~C)*E+B*(D*~C)*E))"),
    .INIT(32'h2a220200))
    _al_u321 (
    .a(irq),
    .b(irq_lev[1]),
    .c(irq_lev[0]),
    .d(rgf_sr_ie[0]),
    .e(rgf_sr_ie[1]),
    .o(_al_u321_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u322 (
    .a(_al_u321_o),
    .b(fdat[9]),
    .o(\fch/n4 [9]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u323 (
    .a(_al_u321_o),
    .b(fdat[8]),
    .o(\fch/n4 [8]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u324 (
    .a(_al_u321_o),
    .b(fdat[7]),
    .o(\fch/n4 [7]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u325 (
    .a(_al_u321_o),
    .b(fdat[6]),
    .o(\fch/n4 [6]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u326 (
    .a(_al_u321_o),
    .b(fdat[5]),
    .o(\fch/n4 [5]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u327 (
    .a(_al_u321_o),
    .b(fdat[4]),
    .o(\fch/n4 [4]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u328 (
    .a(_al_u321_o),
    .b(fdat[3]),
    .o(\fch/n4 [3]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u329 (
    .a(_al_u321_o),
    .b(fdat[2]),
    .o(\fch/n4 [2]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u330 (
    .a(_al_u321_o),
    .b(fdat[15]),
    .o(\fch/n4 [15]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u331 (
    .a(_al_u321_o),
    .b(fdat[14]),
    .o(\fch/n4 [14]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u332 (
    .a(_al_u321_o),
    .b(fdat[13]),
    .o(\fch/n4 [13]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u333 (
    .a(_al_u321_o),
    .b(fdat[12]),
    .o(\fch/n4 [12]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u334 (
    .a(_al_u321_o),
    .b(fdat[11]),
    .o(\fch/n4 [11]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u335 (
    .a(_al_u321_o),
    .b(fdat[10]),
    .o(\fch/n4 [10]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u336 (
    .a(_al_u321_o),
    .b(fdat[1]),
    .o(\fch/n4 [1]));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u337 (
    .a(_al_u321_o),
    .b(fdat[0]),
    .o(\fch/n4 [0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u338 (
    .a(fch_ir[12]),
    .b(fch_ir[13]),
    .o(_al_u338_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u339 (
    .a(_al_u338_o),
    .b(fch_ir[14]),
    .c(fch_ir[15]),
    .o(_al_u339_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*A)"),
    .INIT(16'h2000))
    _al_u340 (
    .a(_al_u339_o),
    .b(fch_ir[10]),
    .c(fch_ir[11]),
    .d(fch_ir[9]),
    .o(_al_u340_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    _al_u341 (
    .a(\ctl/stat [2]),
    .b(fch_ir[6]),
    .c(fch_ir[7]),
    .d(fch_ir[8]),
    .o(_al_u341_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*~A)"),
    .INIT(16'h0100))
    _al_u342 (
    .a(\ctl/stat [2]),
    .b(fch_ir[6]),
    .c(fch_ir[7]),
    .d(fch_ir[8]),
    .o(_al_u342_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u343 (
    .a(\ctl/stat [0]),
    .b(\ctl/stat [1]),
    .o(_al_u343_o));
  AL_MAP_LUT4 #(
    .EQN("(D*A*~(~C*~B))"),
    .INIT(16'ha800))
    _al_u344 (
    .a(_al_u340_o),
    .b(_al_u341_o),
    .c(_al_u342_o),
    .d(_al_u343_o),
    .o(ctl_bcmdb));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u345 (
    .a(fch_ir[10]),
    .b(fch_ir[6]),
    .c(fch_ir[7]),
    .d(fch_ir[8]),
    .e(fch_ir[9]),
    .o(_al_u345_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u346 (
    .a(fch_ir[13]),
    .b(fch_ir[14]),
    .c(fch_ir[15]),
    .o(_al_u346_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u347 (
    .a(fch_ir[11]),
    .b(fch_ir[12]),
    .o(_al_u347_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u348 (
    .a(_al_u345_o),
    .b(_al_u346_o),
    .c(_al_u347_o),
    .o(_al_u348_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u349 (
    .a(fch_ir[4]),
    .b(fch_ir[5]),
    .o(_al_u349_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u350 (
    .a(_al_u348_o),
    .b(_al_u349_o),
    .c(fch_ir[1]),
    .d(fch_ir[2]),
    .e(fch_ir[3]),
    .o(_al_u350_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u351 (
    .a(\ctl/stat [1]),
    .b(\ctl/stat [2]),
    .o(_al_u351_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u352 (
    .a(_al_u351_o),
    .b(\ctl/stat [0]),
    .o(_al_u352_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u353 (
    .a(brdy),
    .b(_al_u350_o),
    .c(_al_u352_o),
    .d(fch_ir[0]),
    .o(\ctl/n204_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u354 (
    .a(_al_u339_o),
    .b(fch_ir[10]),
    .c(fch_ir[11]),
    .d(fch_ir[8]),
    .e(fch_ir[9]),
    .o(_al_u354_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u355 (
    .a(_al_u351_o),
    .b(\ctl/stat [0]),
    .o(_al_u355_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u356 (
    .a(_al_u355_o),
    .b(fch_ir[3]),
    .o(_al_u356_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u357 (
    .a(_al_u354_o),
    .b(_al_u356_o),
    .o(_al_u357_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u358 (
    .a(_al_u349_o),
    .b(fch_ir[6]),
    .c(fch_ir[7]),
    .o(_al_u358_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u359 (
    .a(_al_u354_o),
    .b(_al_u352_o),
    .c(_al_u358_o),
    .d(fch_ir[3]),
    .o(\ctl/n602_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u360 (
    .a(_al_u357_o),
    .b(\ctl/n602_lutinv ),
    .c(_al_u358_o),
    .o(_al_u360_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u361 (
    .a(fch_ir[1]),
    .b(fch_ir[2]),
    .o(_al_u361_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u362 (
    .a(_al_u349_o),
    .b(_al_u361_o),
    .c(fch_ir[3]),
    .o(_al_u362_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u363 (
    .a(_al_u348_o),
    .b(_al_u362_o),
    .o(_al_u363_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u364 (
    .a(\ctl/stat [1]),
    .b(\ctl/stat [2]),
    .c(fch_ir[0]),
    .o(_al_u364_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u365 (
    .a(_al_u363_o),
    .b(_al_u364_o),
    .o(\ctl/sel0_b0/or_B108_B109_o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(B*~A*~(~D*C))"),
    .INIT(16'h4404))
    _al_u366 (
    .a(\ctl/n204_lutinv ),
    .b(_al_u360_o),
    .c(\ctl/sel0_b0/or_B108_B109_o_lutinv ),
    .d(\ctl/stat [0]),
    .o(_al_u366_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u367 (
    .a(_al_u355_o),
    .b(_al_u346_o),
    .o(_al_u367_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(B@(~D*C)))"),
    .INIT(16'h8828))
    _al_u368 (
    .a(_al_u367_o),
    .b(fch_ir[11]),
    .c(fch_ir[12]),
    .d(rgf_sr_flag[0]),
    .o(_al_u368_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u369 (
    .a(fch_ir[13]),
    .b(fch_ir[14]),
    .c(fch_ir[15]),
    .o(_al_u369_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u370 (
    .a(_al_u355_o),
    .b(_al_u369_o),
    .c(_al_u347_o),
    .d(rgf_sr_flag[2]),
    .o(\ctl/n248_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u371 (
    .a(_al_u368_o),
    .b(\ctl/n248_lutinv ),
    .o(_al_u371_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u372 (
    .a(_al_u350_o),
    .b(_al_u364_o),
    .c(\ctl/stat [0]),
    .o(_al_u372_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u373 (
    .a(brdy),
    .b(_al_u371_o),
    .c(_al_u372_o),
    .o(_al_u373_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u374 (
    .a(\ctl/stat [0]),
    .b(\ctl/stat [1]),
    .o(_al_u374_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u375 (
    .a(_al_u348_o),
    .b(_al_u362_o),
    .c(_al_u374_o),
    .d(\ctl/stat [2]),
    .e(fch_ir[0]),
    .o(\ctl/n192_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u376 (
    .a(\ctl/sel0_b0/or_B108_B109_o_lutinv ),
    .b(\ctl/n192_lutinv ),
    .c(\ctl/stat [0]),
    .o(_al_u376_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u377 (
    .a(_al_u363_o),
    .b(_al_u343_o),
    .c(\ctl/stat [2]),
    .d(fch_ir[0]),
    .o(ctl_fetch_ext_lutinv));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u378 (
    .a(_al_u376_o),
    .b(ctl_fetch_ext_lutinv),
    .o(_al_u378_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u379 (
    .a(fch_ir[13]),
    .b(fch_ir[14]),
    .c(fch_ir[15]),
    .o(_al_u379_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(~(B)*C*~(D)*~(E)+B*~(C)*D*~(E)+B*~(C)*D*E+~(B)*C*D*E))"),
    .INIT(32'h28000820))
    _al_u380 (
    .a(_al_u379_o),
    .b(fch_ir[11]),
    .c(fch_ir[12]),
    .d(rgf_sr_flag[1]),
    .e(rgf_sr_flag[3]),
    .o(_al_u380_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u381 (
    .a(_al_u380_o),
    .b(_al_u355_o),
    .o(_al_u381_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u382 (
    .a(fch_ir[11]),
    .b(fch_ir[12]),
    .o(_al_u382_o));
  AL_MAP_LUT5 #(
    .EQN("(C*B*A*(E@D))"),
    .INIT(32'h00808000))
    _al_u383 (
    .a(_al_u355_o),
    .b(_al_u379_o),
    .c(_al_u382_o),
    .d(rgf_sr_flag[1]),
    .e(rgf_sr_flag[3]),
    .o(\ctl/n298_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u384 (
    .a(_al_u381_o),
    .b(\ctl/n298_lutinv ),
    .o(_al_u384_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u385 (
    .a(_al_u355_o),
    .b(_al_u369_o),
    .c(_al_u382_o),
    .d(rgf_sr_flag[3]),
    .o(\ctl/n270_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(A*(~(B)*C*~(D)*~(E)+B*~(C)*D*~(E)+~(B)*C*D*~(E)+B*~(C)*D*E))"),
    .INIT(32'h08002820))
    _al_u386 (
    .a(_al_u369_o),
    .b(fch_ir[11]),
    .c(fch_ir[12]),
    .d(rgf_sr_flag[2]),
    .e(rgf_sr_flag[3]),
    .o(_al_u386_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u387 (
    .a(_al_u379_o),
    .b(_al_u347_o),
    .o(_al_u387_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(D*~(~B*~(~E*C))))"),
    .INIT(32'h11550155))
    _al_u388 (
    .a(\ctl/n270_lutinv ),
    .b(_al_u386_o),
    .c(_al_u387_o),
    .d(_al_u355_o),
    .e(rgf_sr_flag[1]),
    .o(_al_u388_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u389 (
    .a(_al_u384_o),
    .b(_al_u388_o),
    .o(_al_u389_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*D*B*A))"),
    .INIT(32'h70f0f0f0))
    _al_u390 (
    .a(_al_u366_o),
    .b(_al_u373_o),
    .c(rst_n),
    .d(_al_u378_o),
    .e(_al_u389_o),
    .o(\ctl/mux4_b2_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u391 (
    .a(brdy),
    .b(_al_u350_o),
    .c(_al_u352_o),
    .d(fch_ir[0]),
    .o(\ctl/n220_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*~(~D*C))"),
    .INIT(16'h1101))
    _al_u392 (
    .a(\ctl/n220_lutinv ),
    .b(_al_u372_o),
    .c(\ctl/sel0_b0/or_B108_B109_o_lutinv ),
    .d(\ctl/stat [0]),
    .o(_al_u392_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u393 (
    .a(_al_u392_o),
    .b(\ctl/n204_lutinv ),
    .c(_al_u360_o),
    .d(\ctl/n192_lutinv ),
    .o(_al_u393_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u394 (
    .a(_al_u348_o),
    .b(fch_ir[5]),
    .o(_al_u394_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u395 (
    .a(_al_u361_o),
    .b(fch_ir[0]),
    .c(fch_ir[3]),
    .d(fch_ir[4]),
    .o(_al_u395_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u396 (
    .a(brdy),
    .b(_al_u394_o),
    .c(_al_u352_o),
    .d(_al_u395_o),
    .o(\rgf/sreg/mux2_b2_sel_is_2_o ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u397 (
    .a(_al_u389_o),
    .b(\ctl/n248_lutinv ),
    .c(_al_u368_o),
    .o(_al_u397_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(D*~B*A))"),
    .INIT(16'hd0f0))
    _al_u398 (
    .a(_al_u393_o),
    .b(\rgf/sreg/mux2_b2_sel_is_2_o ),
    .c(rst_n),
    .d(_al_u397_o),
    .o(\ctl/mux4_b1_sel_is_3_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u400 (
    .a(_al_u354_o),
    .b(fch_ir[7]),
    .o(_al_u400_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u401 (
    .a(fch_ir[5]),
    .b(fch_ir[6]),
    .o(_al_u401_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u402 (
    .a(_al_u400_o),
    .b(_al_u401_o),
    .c(fch_ir[3]),
    .o(_al_u402_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u403 (
    .a(_al_u402_o),
    .b(_al_u355_o),
    .o(_al_u403_o));
  AL_MAP_LUT5 #(
    .EQN("(C*B*~(D*~(E*~A)))"),
    .INIT(32'h40c000c0))
    _al_u404 (
    .a(brdy),
    .b(_al_u350_o),
    .c(_al_u351_o),
    .d(\ctl/stat [0]),
    .e(fch_ir[0]),
    .o(_al_u404_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u405 (
    .a(\ctl/stat [2]),
    .b(fch_ir[6]),
    .c(fch_ir[7]),
    .d(fch_ir[8]),
    .o(_al_u405_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u406 (
    .a(_al_u342_o),
    .b(_al_u405_o),
    .o(_al_u406_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u407 (
    .a(_al_u340_o),
    .b(_al_u406_o),
    .o(_al_u407_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u408 (
    .a(_al_u407_o),
    .b(_al_u343_o),
    .o(_al_u408_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~C*~B*~A)"),
    .INIT(16'hfffe))
    _al_u409 (
    .a(\ctl/n220_lutinv ),
    .b(_al_u403_o),
    .c(_al_u404_o),
    .d(_al_u408_o),
    .o(ctl_bcmdr));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~((C*~B))*~(D)+A*~((C*~B))*~(D)+A*(C*~B)*~(D)+A*~((C*~B))*D)"),
    .INIT(16'h8aef))
    _al_u410 (
    .a(irq_lev[1]),
    .b(irq_lev[0]),
    .c(rgf_sr_ie[0]),
    .d(rgf_sr_ie[1]),
    .o(_al_u410_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u411 (
    .a(brdy),
    .b(_al_u355_o),
    .o(_al_u411_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*~A)"),
    .INIT(32'h40000000))
    _al_u412 (
    .a(_al_u410_o),
    .b(_al_u411_o),
    .c(irq),
    .d(_al_u394_o),
    .e(_al_u395_o),
    .o(\fch/n1 ));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(B)*~(C)+(D*~A)*B*~(C)+~((D*~A))*B*C+(D*~A)*B*C)"),
    .INIT(16'hc5c0))
    _al_u414 (
    .a(\fch/n1 ),
    .b(fdat[9]),
    .c(ctl_fetch_ext_lutinv),
    .d(\fch/eir [9]),
    .o(\fch/n10 [9]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(B)*~(C)+(D*~A)*B*~(C)+~((D*~A))*B*C+(D*~A)*B*C)"),
    .INIT(16'hc5c0))
    _al_u415 (
    .a(\fch/n1 ),
    .b(fdat[8]),
    .c(ctl_fetch_ext_lutinv),
    .d(\fch/eir [8]),
    .o(\fch/n10 [8]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(B)*~(C)+(D*~A)*B*~(C)+~((D*~A))*B*C+(D*~A)*B*C)"),
    .INIT(16'hc5c0))
    _al_u416 (
    .a(\fch/n1 ),
    .b(fdat[7]),
    .c(ctl_fetch_ext_lutinv),
    .d(\fch/eir [7]),
    .o(\fch/n10 [7]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*~(B)*~(D)+(E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*B*~(D)+~((E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A))*B*D+(E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*B*D)"),
    .INIT(32'hccf5cca0))
    _al_u417 (
    .a(\fch/n1 ),
    .b(fdat[6]),
    .c(irq_vec[5]),
    .d(ctl_fetch_ext_lutinv),
    .e(\fch/eir [6]),
    .o(\fch/n10 [6]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*~(B)*~(D)+(E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*B*~(D)+~((E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A))*B*D+(E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*B*D)"),
    .INIT(32'hccf5cca0))
    _al_u418 (
    .a(\fch/n1 ),
    .b(fdat[5]),
    .c(irq_vec[4]),
    .d(ctl_fetch_ext_lutinv),
    .e(\fch/eir [5]),
    .o(\fch/n10 [5]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*~(B)*~(D)+(E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*B*~(D)+~((E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A))*B*D+(E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*B*D)"),
    .INIT(32'hccf5cca0))
    _al_u419 (
    .a(\fch/n1 ),
    .b(fdat[4]),
    .c(irq_vec[3]),
    .d(ctl_fetch_ext_lutinv),
    .e(\fch/eir [4]),
    .o(\fch/n10 [4]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*~(B)*~(D)+(E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*B*~(D)+~((E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A))*B*D+(E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*B*D)"),
    .INIT(32'hccf5cca0))
    _al_u420 (
    .a(\fch/n1 ),
    .b(fdat[3]),
    .c(irq_vec[2]),
    .d(ctl_fetch_ext_lutinv),
    .e(\fch/eir [3]),
    .o(\fch/n10 [3]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*~(B)*~(D)+(E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*B*~(D)+~((E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A))*B*D+(E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*B*D)"),
    .INIT(32'hccf5cca0))
    _al_u421 (
    .a(\fch/n1 ),
    .b(fdat[2]),
    .c(irq_vec[1]),
    .d(ctl_fetch_ext_lutinv),
    .e(\fch/eir [2]),
    .o(\fch/n10 [2]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(B)*~(C)+(D*~A)*B*~(C)+~((D*~A))*B*C+(D*~A)*B*C)"),
    .INIT(16'hc5c0))
    _al_u422 (
    .a(\fch/n1 ),
    .b(fdat[15]),
    .c(ctl_fetch_ext_lutinv),
    .d(\fch/eir [15]),
    .o(\fch/n10 [15]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(B)*~(C)+(D*~A)*B*~(C)+~((D*~A))*B*C+(D*~A)*B*C)"),
    .INIT(16'hc5c0))
    _al_u423 (
    .a(\fch/n1 ),
    .b(fdat[14]),
    .c(ctl_fetch_ext_lutinv),
    .d(\fch/eir [14]),
    .o(\fch/n10 [14]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(B)*~(C)+(D*~A)*B*~(C)+~((D*~A))*B*C+(D*~A)*B*C)"),
    .INIT(16'hc5c0))
    _al_u424 (
    .a(\fch/n1 ),
    .b(fdat[13]),
    .c(ctl_fetch_ext_lutinv),
    .d(\fch/eir [13]),
    .o(\fch/n10 [13]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(B)*~(C)+(D*~A)*B*~(C)+~((D*~A))*B*C+(D*~A)*B*C)"),
    .INIT(16'hc5c0))
    _al_u425 (
    .a(\fch/n1 ),
    .b(fdat[12]),
    .c(ctl_fetch_ext_lutinv),
    .d(\fch/eir [12]),
    .o(\fch/n10 [12]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(B)*~(C)+(D*~A)*B*~(C)+~((D*~A))*B*C+(D*~A)*B*C)"),
    .INIT(16'hc5c0))
    _al_u426 (
    .a(\fch/n1 ),
    .b(fdat[11]),
    .c(ctl_fetch_ext_lutinv),
    .d(\fch/eir [11]),
    .o(\fch/n10 [11]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(B)*~(C)+(D*~A)*B*~(C)+~((D*~A))*B*C+(D*~A)*B*C)"),
    .INIT(16'hc5c0))
    _al_u427 (
    .a(\fch/n1 ),
    .b(fdat[10]),
    .c(ctl_fetch_ext_lutinv),
    .d(\fch/eir [10]),
    .o(\fch/n10 [10]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*~(B)*~(D)+(E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*B*~(D)+~((E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A))*B*D+(E*~(C)*~(A)+E*C*~(A)+~(E)*C*A+E*C*A)*B*D)"),
    .INIT(32'hccf5cca0))
    _al_u428 (
    .a(\fch/n1 ),
    .b(fdat[1]),
    .c(irq_vec[0]),
    .d(ctl_fetch_ext_lutinv),
    .e(\fch/eir [1]),
    .o(\fch/n10 [1]));
  AL_MAP_LUT4 #(
    .EQN("((D*~A)*~(B)*~(C)+(D*~A)*B*~(C)+~((D*~A))*B*C+(D*~A)*B*C)"),
    .INIT(16'hc5c0))
    _al_u429 (
    .a(\fch/n1 ),
    .b(fdat[0]),
    .c(ctl_fetch_ext_lutinv),
    .d(\fch/eir [0]),
    .o(\fch/n10 [0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u430 (
    .a(_al_u402_o),
    .b(_al_u352_o),
    .o(_al_u430_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~A*~(C*~B))"),
    .INIT(16'h0045))
    _al_u431 (
    .a(\fch/n1 ),
    .b(brdy),
    .c(_al_u430_o),
    .d(ctl_fetch_ext_lutinv),
    .o(_al_u431_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u432 (
    .a(brdy),
    .b(_al_u352_o),
    .o(_al_u432_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u433 (
    .a(_al_u407_o),
    .b(_al_u374_o),
    .o(_al_u433_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u434 (
    .a(_al_u340_o),
    .b(_al_u343_o),
    .o(_al_u434_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~((C*~(~E*~D)))*~(A)+B*(C*~(~E*~D))*~(A)+~(B)*(C*~(~E*~D))*A+B*(C*~(~E*~D))*A)"),
    .INIT(32'he4e4e444))
    _al_u435 (
    .a(brdy),
    .b(_al_u433_o),
    .c(_al_u434_o),
    .d(_al_u342_o),
    .e(_al_u405_o),
    .o(_al_u435_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*~(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))"),
    .INIT(16'h0213))
    _al_u436 (
    .a(_al_u432_o),
    .b(_al_u435_o),
    .c(_al_u350_o),
    .d(\ctl/n192_lutinv ),
    .o(_al_u436_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u437 (
    .a(_al_u411_o),
    .b(_al_u350_o),
    .o(\ctl/n754_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*A*~(E*D))"),
    .INIT(32'h00080808))
    _al_u438 (
    .a(_al_u431_o),
    .b(_al_u436_o),
    .c(\ctl/n754_lutinv ),
    .d(\rgf/sreg/mux2_b2_sel_is_2_o ),
    .e(rgf_iv_ve),
    .o(_al_u438_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u439 (
    .a(brdy),
    .b(_al_u363_o),
    .c(_al_u352_o),
    .d(fch_ir[0]),
    .o(\ctl/n169_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u440 (
    .a(_al_u343_o),
    .b(\ctl/stat [2]),
    .c(fch_ir[6]),
    .o(_al_u440_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u441 (
    .a(_al_u400_o),
    .b(_al_u440_o),
    .c(_al_u349_o),
    .d(fch_ir[3]),
    .o(_al_u441_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~A*~(D*B))"),
    .INIT(16'h1050))
    _al_u442 (
    .a(\ctl/n169_lutinv ),
    .b(brdy),
    .c(_al_u397_o),
    .d(_al_u441_o),
    .o(_al_u442_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u443 (
    .a(_al_u366_o),
    .b(_al_u442_o),
    .o(_al_u443_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u444 (
    .a(_al_u411_o),
    .b(_al_u402_o),
    .o(\ctl/n755_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(D*~(E*~C*B*A))"),
    .INIT(32'hf700ff00))
    _al_u445 (
    .a(_al_u438_o),
    .b(_al_u443_o),
    .c(\ctl/n755_lutinv ),
    .d(rst_n),
    .e(_al_u373_o),
    .o(\ctl/mux4_b0_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u446 (
    .a(_al_u401_o),
    .b(fch_ir[3]),
    .c(fch_ir[4]),
    .o(_al_u446_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u447 (
    .a(_al_u400_o),
    .b(_al_u355_o),
    .c(_al_u446_o),
    .o(_al_u447_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u448 (
    .a(_al_u447_o),
    .b(_al_u363_o),
    .c(_al_u352_o),
    .d(fch_ir[0]),
    .o(_al_u448_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u449 (
    .a(_al_u343_o),
    .b(\ctl/stat [2]),
    .c(fch_ir[6]),
    .o(_al_u449_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u450 (
    .a(_al_u449_o),
    .b(fch_ir[7]),
    .c(fch_ir[8]),
    .o(_al_u450_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u451 (
    .a(_al_u340_o),
    .b(_al_u450_o),
    .o(_al_u451_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u452 (
    .a(_al_u340_o),
    .b(_al_u341_o),
    .c(_al_u343_o),
    .o(\mem/bwbf/n2 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u453 (
    .a(_al_u451_o),
    .b(\mem/bwbf/n2 ),
    .o(_al_u453_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u454 (
    .a(_al_u400_o),
    .b(_al_u355_o),
    .c(_al_u401_o),
    .d(fch_ir[3]),
    .e(fch_ir[4]),
    .o(_al_u454_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u455 (
    .a(_al_u453_o),
    .b(_al_u441_o),
    .c(_al_u454_o),
    .o(_al_u455_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*~A)"),
    .INIT(32'h40000000))
    _al_u456 (
    .a(_al_u410_o),
    .b(irq),
    .c(_al_u394_o),
    .d(_al_u355_o),
    .e(_al_u395_o),
    .o(\ctl/sel2_b0/or_or_or_B110_B111_o_o_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("~(~C*B*A)"),
    .INIT(8'hf7))
    _al_u457 (
    .a(_al_u448_o),
    .b(_al_u455_o),
    .c(\ctl/sel2_b0/or_or_or_B110_B111_o_o_lutinv ),
    .o(ctl_bcmdw));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u458 (
    .a(_al_u349_o),
    .b(fch_ir[6]),
    .c(fch_ir[7]),
    .o(_al_u458_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u459 (
    .a(_al_u357_o),
    .b(_al_u458_o),
    .o(\ctl/n541_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u460 (
    .a(fch_ir[14]),
    .b(fch_ir[15]),
    .o(_al_u460_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u461 (
    .a(_al_u355_o),
    .b(_al_u460_o),
    .o(_al_u461_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u462 (
    .a(_al_u461_o),
    .b(_al_u338_o),
    .c(fch_ir[11]),
    .o(\ctl/n867_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u463 (
    .a(_al_u355_o),
    .b(_al_u460_o),
    .c(fch_ir[13]),
    .o(_al_u463_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(B*(D@C)))"),
    .INIT(16'h5115))
    _al_u464 (
    .a(\ctl/n867_lutinv ),
    .b(_al_u463_o),
    .c(fch_ir[11]),
    .d(fch_ir[12]),
    .o(_al_u464_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u465 (
    .a(_al_u339_o),
    .b(fch_ir[10]),
    .c(fch_ir[11]),
    .d(fch_ir[9]),
    .o(_al_u465_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*A*~(~C*~B))"),
    .INIT(32'h000000a8))
    _al_u466 (
    .a(_al_u465_o),
    .b(_al_u449_o),
    .c(_al_u440_o),
    .d(fch_ir[7]),
    .e(fch_ir[8]),
    .o(_al_u466_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u467 (
    .a(_al_u466_o),
    .b(_al_u461_o),
    .c(_al_u338_o),
    .o(_al_u467_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u468 (
    .a(_al_u340_o),
    .b(_al_u449_o),
    .c(fch_ir[8]),
    .o(_al_u468_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u469 (
    .a(_al_u343_o),
    .b(\ctl/stat [2]),
    .c(fch_ir[3]),
    .o(_al_u469_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u470 (
    .a(_al_u354_o),
    .b(_al_u469_o),
    .c(_al_u458_o),
    .o(\ctl/n550_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*~A)"),
    .INIT(32'h00000040))
    _al_u471 (
    .a(\ctl/n541_lutinv ),
    .b(_al_u464_o),
    .c(_al_u467_o),
    .d(_al_u468_o),
    .e(\ctl/n550_lutinv ),
    .o(_al_u471_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u472 (
    .a(_al_u339_o),
    .b(fch_ir[10]),
    .c(fch_ir[11]),
    .d(fch_ir[9]),
    .o(_al_u472_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u473 (
    .a(_al_u472_o),
    .b(_al_u440_o),
    .c(fch_ir[7]),
    .d(fch_ir[8]),
    .o(\ctl/n511_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u474 (
    .a(_al_u472_o),
    .b(_al_u449_o),
    .c(fch_ir[7]),
    .d(fch_ir[8]),
    .o(\ctl/n518_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u475 (
    .a(\ctl/n511_lutinv ),
    .b(\ctl/n518_lutinv ),
    .o(_al_u475_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u476 (
    .a(_al_u465_o),
    .b(_al_u440_o),
    .c(fch_ir[7]),
    .d(fch_ir[8]),
    .o(\ctl/n338_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(D*C))"),
    .INIT(16'h0222))
    _al_u477 (
    .a(_al_u475_o),
    .b(\ctl/n338_lutinv ),
    .c(_al_u463_o),
    .d(_al_u347_o),
    .o(_al_u477_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    _al_u478 (
    .a(fch_ir[4]),
    .b(fch_ir[5]),
    .c(fch_ir[6]),
    .d(fch_ir[7]),
    .o(_al_u478_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u479 (
    .a(_al_u357_o),
    .b(_al_u478_o),
    .o(\ctl/n633_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u480 (
    .a(_al_u354_o),
    .b(_al_u469_o),
    .c(_al_u478_o),
    .o(\ctl/n644_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u481 (
    .a(\ctl/n633_lutinv ),
    .b(\ctl/n644_lutinv ),
    .o(_al_u481_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u482 (
    .a(_al_u354_o),
    .b(_al_u355_o),
    .o(_al_u482_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*B*A)"),
    .INIT(32'h00080000))
    _al_u483 (
    .a(_al_u482_o),
    .b(fch_ir[4]),
    .c(fch_ir[5]),
    .d(fch_ir[6]),
    .e(fch_ir[7]),
    .o(\ctl/n120_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u484 (
    .a(fch_ir[14]),
    .b(fch_ir[15]),
    .o(_al_u484_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u485 (
    .a(_al_u355_o),
    .b(_al_u484_o),
    .c(fch_ir[13]),
    .o(\ctl/n743_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(B*A*(C*D*~(E)+~(C)*~(D)*E))"),
    .INIT(32'h00088000))
    _al_u486 (
    .a(_al_u355_o),
    .b(_al_u484_o),
    .c(fch_ir[11]),
    .d(fch_ir[12]),
    .e(fch_ir[13]),
    .o(_al_u486_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u487 (
    .a(\ctl/n120_lutinv ),
    .b(\ctl/n192_lutinv ),
    .c(\ctl/n743_lutinv ),
    .d(_al_u486_o),
    .o(_al_u487_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u488 (
    .a(_al_u471_o),
    .b(_al_u477_o),
    .c(_al_u481_o),
    .d(_al_u487_o),
    .o(\alu/sft/n31_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*A)"),
    .INIT(16'h2000))
    _al_u489 (
    .a(fch_ir[4]),
    .b(fch_ir[5]),
    .c(fch_ir[6]),
    .d(fch_ir[7]),
    .o(_al_u489_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u490 (
    .a(_al_u357_o),
    .b(_al_u489_o),
    .o(\alu/log/n11_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u491 (
    .a(_al_u354_o),
    .b(_al_u469_o),
    .c(_al_u489_o),
    .o(\alu/log/n12_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~D*~B*A*~(~E*C))"),
    .INIT(32'h00220002))
    _al_u492 (
    .a(_al_u360_o),
    .b(\alu/log/n11_lutinv ),
    .c(\ctl/sel0_b0/or_B108_B109_o_lutinv ),
    .d(\alu/log/n12_lutinv ),
    .e(\ctl/stat [0]),
    .o(_al_u492_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u493 (
    .a(_al_u465_o),
    .b(_al_u341_o),
    .c(_al_u343_o),
    .o(\ctl/n358_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u494 (
    .a(\ctl/n511_lutinv ),
    .b(\ctl/n358_lutinv ),
    .o(_al_u494_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u495 (
    .a(_al_u354_o),
    .b(_al_u469_o),
    .c(_al_u349_o),
    .d(fch_ir[6]),
    .e(fch_ir[7]),
    .o(\alu/log/n9_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u496 (
    .a(\ctl/n518_lutinv ),
    .b(\alu/log/n9_lutinv ),
    .c(_al_u486_o),
    .o(_al_u496_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(B*~(C)*D*~(E)+B*C*D*~(E)+~(B)*C*~(D)*E+B*C*~(D)*E))"),
    .INIT(32'h00a08800))
    _al_u497 (
    .a(_al_u465_o),
    .b(_al_u449_o),
    .c(_al_u440_o),
    .d(fch_ir[7]),
    .e(fch_ir[8]),
    .o(_al_u497_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u498 (
    .a(_al_u494_o),
    .b(_al_u496_o),
    .c(\ctl/n867_lutinv ),
    .d(_al_u497_o),
    .o(_al_u498_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u499 (
    .a(_al_u355_o),
    .b(_al_u484_o),
    .c(fch_ir[12]),
    .d(fch_ir[13]),
    .o(_al_u499_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u500 (
    .a(\ctl/n743_lutinv ),
    .b(_al_u499_o),
    .c(fch_ir[11]),
    .o(_al_u500_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u501 (
    .a(_al_u355_o),
    .b(_al_u347_o),
    .c(_al_u484_o),
    .d(fch_ir[13]),
    .o(\ctl/n875_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~B*~(D*C*A))"),
    .INIT(16'h1333))
    _al_u502 (
    .a(_al_u461_o),
    .b(\ctl/n875_lutinv ),
    .c(_al_u382_o),
    .d(fch_ir[13]),
    .o(_al_u502_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u503 (
    .a(_al_u492_o),
    .b(_al_u498_o),
    .c(_al_u500_o),
    .d(_al_u502_o),
    .o(\alu/log/eq3/or_xor_i0[3]_i1[3]_o_o_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u504 (
    .a(_al_u472_o),
    .b(_al_u341_o),
    .c(_al_u343_o),
    .o(\ctl/n533_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u505 (
    .a(_al_u339_o),
    .b(fch_ir[10]),
    .c(fch_ir[11]),
    .d(fch_ir[9]),
    .o(_al_u505_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u506 (
    .a(_al_u505_o),
    .b(_al_u449_o),
    .c(fch_ir[7]),
    .d(fch_ir[8]),
    .o(\ctl/n313_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u507 (
    .a(\ctl/n533_lutinv ),
    .b(\ctl/n313_lutinv ),
    .o(_al_u507_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u508 (
    .a(_al_u472_o),
    .b(_al_u342_o),
    .c(_al_u343_o),
    .o(\ctl/n525_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u509 (
    .a(_al_u505_o),
    .b(_al_u440_o),
    .c(fch_ir[7]),
    .d(fch_ir[8]),
    .o(\ctl/n307_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u510 (
    .a(_al_u507_o),
    .b(\ctl/n525_lutinv ),
    .c(\ctl/n307_lutinv ),
    .o(_al_u510_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u511 (
    .a(_al_u450_o),
    .b(_al_u505_o),
    .o(\ctl/n321_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u512 (
    .a(fch_ir[11]),
    .b(fch_ir[12]),
    .c(fch_ir[13]),
    .o(_al_u512_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u513 (
    .a(\ctl/n321_lutinv ),
    .b(_al_u355_o),
    .c(_al_u512_o),
    .d(_al_u484_o),
    .o(_al_u513_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u514 (
    .a(_al_u510_o),
    .b(_al_u389_o),
    .c(_al_u513_o),
    .d(_al_u371_o),
    .o(\alu/art/eq4/or_xor_i0[2]_i1[2]_o_o_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u515 (
    .a(\alu/sft/n31_lutinv ),
    .b(\alu/log/eq3/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .c(\alu/art/eq4/or_xor_i0[2]_i1[2]_o_o_lutinv ),
    .o(_al_u515_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u516 (
    .a(_al_u357_o),
    .b(_al_u401_o),
    .c(fch_ir[4]),
    .d(fch_ir[7]),
    .o(\ctl/n561_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u517 (
    .a(_al_u354_o),
    .b(_al_u356_o),
    .c(_al_u349_o),
    .d(fch_ir[6]),
    .e(fch_ir[7]),
    .o(\ctl/n654_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u518 (
    .a(_al_u477_o),
    .b(\alu/log/n11_lutinv ),
    .c(\ctl/n561_lutinv ),
    .d(\ctl/n654_lutinv ),
    .e(\alu/log/n12_lutinv ),
    .o(_al_u518_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u519 (
    .a(_al_u461_o),
    .b(fch_ir[12]),
    .c(fch_ir[13]),
    .o(_al_u519_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u520 (
    .a(\ctl/n120_lutinv ),
    .b(_al_u519_o),
    .o(_al_u520_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u521 (
    .a(_al_u388_o),
    .b(\ctl/n248_lutinv ),
    .o(_al_u521_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u522 (
    .a(_al_u340_o),
    .b(_al_u440_o),
    .c(fch_ir[7]),
    .d(fch_ir[8]),
    .o(\ctl/n379_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u523 (
    .a(\ctl/n379_lutinv ),
    .b(_al_u450_o),
    .c(_al_u465_o),
    .o(_al_u523_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u524 (
    .a(_al_u520_o),
    .b(_al_u507_o),
    .c(_al_u521_o),
    .d(_al_u523_o),
    .o(_al_u524_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u525 (
    .a(_al_u465_o),
    .b(_al_u440_o),
    .c(fch_ir[8]),
    .o(_al_u525_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*~(~D*C))"),
    .INIT(16'h1101))
    _al_u526 (
    .a(_al_u368_o),
    .b(_al_u525_o),
    .c(_al_u463_o),
    .d(fch_ir[11]),
    .o(_al_u526_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u527 (
    .a(_al_u340_o),
    .b(_al_u440_o),
    .c(fch_ir[8]),
    .o(_al_u527_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u528 (
    .a(_al_u526_o),
    .b(_al_u384_o),
    .c(_al_u527_o),
    .d(\ctl/n192_lutinv ),
    .e(_al_u486_o),
    .o(_al_u528_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u529 (
    .a(_al_u518_o),
    .b(_al_u524_o),
    .c(_al_u528_o),
    .o(\alu/sft/n30_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(C*B*A*~(E@D))"),
    .INIT(32'h80000080))
    _al_u530 (
    .a(_al_u354_o),
    .b(_al_u358_o),
    .c(_al_u351_o),
    .d(\ctl/stat [0]),
    .e(fch_ir[3]),
    .o(_al_u530_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(B*~(C)*~(D)*~(E)+B*C*~(D)*~(E)+B*~(C)*D*~(E)+~(B)*C*D*~(E)+B*C*D*~(E)+~(B)*C*~(D)*E+B*C*~(D)*E))"),
    .INIT(32'h00a0a888))
    _al_u531 (
    .a(_al_u465_o),
    .b(_al_u449_o),
    .c(_al_u440_o),
    .d(fch_ir[7]),
    .e(fch_ir[8]),
    .o(_al_u531_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u532 (
    .a(\ctl/n633_lutinv ),
    .b(_al_u530_o),
    .c(_al_u368_o),
    .d(_al_u531_o),
    .e(_al_u381_o),
    .o(_al_u532_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(B*(D@C)))"),
    .INIT(16'h5115))
    _al_u533 (
    .a(\alu/log/n12_lutinv ),
    .b(_al_u463_o),
    .c(fch_ir[11]),
    .d(fch_ir[12]),
    .o(_al_u533_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u534 (
    .a(_al_u354_o),
    .b(_al_u355_o),
    .c(_al_u446_o),
    .d(fch_ir[7]),
    .o(_al_u534_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u535 (
    .a(_al_u494_o),
    .b(_al_u533_o),
    .c(\ctl/n525_lutinv ),
    .d(\ctl/n307_lutinv ),
    .e(_al_u534_o),
    .o(_al_u535_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u536 (
    .a(_al_u465_o),
    .b(_al_u405_o),
    .c(_al_u343_o),
    .o(\ctl/n365_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u537 (
    .a(_al_u355_o),
    .b(_al_u382_o),
    .c(_al_u460_o),
    .d(fch_ir[13]),
    .o(\ctl/n856_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~B*~A*~(D*C))"),
    .INIT(32'h00000111))
    _al_u538 (
    .a(\ctl/n644_lutinv ),
    .b(\ctl/n365_lutinv ),
    .c(_al_u450_o),
    .d(_al_u465_o),
    .e(\ctl/n856_lutinv ),
    .o(_al_u538_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u539 (
    .a(_al_u388_o),
    .b(\ctl/n248_lutinv ),
    .c(\ctl/n298_lutinv ),
    .d(_al_u499_o),
    .e(\ctl/n875_lutinv ),
    .o(_al_u539_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u540 (
    .a(_al_u532_o),
    .b(_al_u535_o),
    .c(_al_u538_o),
    .d(_al_u539_o),
    .e(\ctl/sel0_b0/or_B108_B109_o_lutinv ),
    .o(\alu/sft/n36_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+A*~(B)*~(C)*D+A*~(B)*C*D)"),
    .INIT(16'h22f5))
    _al_u541 (
    .a(_al_u515_o),
    .b(\alu/sft/n30_lutinv ),
    .c(\alu/sft/n36_lutinv ),
    .d(rgf_sr_flag[2]),
    .o(\alu/art/cin ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u542 (
    .a(_al_u432_o),
    .b(_al_u400_o),
    .c(_al_u401_o),
    .d(fch_ir[3]),
    .o(_al_u542_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u543 (
    .a(_al_u401_o),
    .b(fch_ir[3]),
    .c(fch_ir[4]),
    .o(_al_u543_o));
  AL_MAP_LUT5 #(
    .EQN("(D*C*B*~(E*A))"),
    .INIT(32'h4000c000))
    _al_u544 (
    .a(brdy),
    .b(_al_u400_o),
    .c(_al_u543_o),
    .d(_al_u351_o),
    .e(\ctl/stat [0]),
    .o(_al_u544_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u545 (
    .a(_al_u542_o),
    .b(_al_u544_o),
    .o(_al_u545_o));
  AL_MAP_LUT5 #(
    .EQN("(E*A*~(~C*~(~D*~B)))"),
    .INIT(32'ha0a20000))
    _al_u546 (
    .a(_al_u545_o),
    .b(\ctl/sel2_b0/or_or_or_B110_B111_o_o_lutinv ),
    .c(brdy),
    .d(_al_u433_o),
    .e(_al_u384_o),
    .o(_al_u546_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u547 (
    .a(_al_u363_o),
    .b(_al_u352_o),
    .c(fch_ir[0]),
    .o(_al_u547_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u548 (
    .a(_al_u372_o),
    .b(_al_u350_o),
    .c(_al_u352_o),
    .o(_al_u548_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*~B*~A)"),
    .INIT(32'h01000000))
    _al_u549 (
    .a(\fch/n1 ),
    .b(_al_u547_o),
    .c(_al_u404_o),
    .d(_al_u548_o),
    .e(_al_u378_o),
    .o(_al_u549_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u550 (
    .a(\ctl/sel0_b0/or_B108_B109_o_lutinv ),
    .b(\ctl/n602_lutinv ),
    .c(_al_u368_o),
    .d(_al_u408_o),
    .o(_al_u550_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u551 (
    .a(_al_u355_o),
    .b(_al_u395_o),
    .o(_al_u551_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(D*C*~B))"),
    .INIT(16'h8aaa))
    _al_u552 (
    .a(_al_u550_o),
    .b(irq),
    .c(_al_u394_o),
    .d(_al_u551_o),
    .o(_al_u552_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u553 (
    .a(_al_u400_o),
    .b(_al_u355_o),
    .c(_al_u401_o),
    .d(fch_ir[3]),
    .e(fch_ir[4]),
    .o(_al_u553_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B*~A))"),
    .INIT(8'h0b))
    _al_u554 (
    .a(brdy),
    .b(_al_u447_o),
    .c(_al_u553_o),
    .o(_al_u554_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u555 (
    .a(_al_u441_o),
    .b(_al_u357_o),
    .c(_al_u358_o),
    .o(_al_u555_o));
  AL_MAP_LUT5 #(
    .EQN("(C*A*~(~B*~(~E*D)))"),
    .INIT(32'h8080a080))
    _al_u556 (
    .a(_al_u554_o),
    .b(brdy),
    .c(_al_u555_o),
    .d(_al_u453_o),
    .e(_al_u454_o),
    .o(_al_u556_o));
  AL_MAP_LUT5 #(
    .EQN("~(E*D*C*B*A)"),
    .INIT(32'h7fffffff))
    _al_u557 (
    .a(_al_u546_o),
    .b(_al_u549_o),
    .c(_al_u552_o),
    .d(_al_u556_o),
    .e(_al_u521_o),
    .o(\ctl/n936 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u558 (
    .a(\ctl/n936 ),
    .b(rst_n),
    .o(\fch/n8 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u559 (
    .a(brdy),
    .b(_al_u374_o),
    .o(_al_u559_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u560 (
    .a(_al_u559_o),
    .b(_al_u340_o),
    .c(_al_u342_o),
    .o(\ctl/n433_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u561 (
    .a(_al_u354_o),
    .b(_al_u356_o),
    .c(_al_u458_o),
    .o(_al_u561_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*~A)"),
    .INIT(16'h0004))
    _al_u562 (
    .a(_al_u561_o),
    .b(_al_u502_o),
    .c(_al_u534_o),
    .d(_al_u463_o),
    .o(_al_u562_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u563 (
    .a(_al_u357_o),
    .b(_al_u349_o),
    .c(fch_ir[6]),
    .d(fch_ir[7]),
    .o(_al_u563_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u564 (
    .a(_al_u486_o),
    .b(_al_u355_o),
    .c(_al_u512_o),
    .d(_al_u484_o),
    .o(_al_u564_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    _al_u565 (
    .a(\ctl/n433_lutinv ),
    .b(_al_u562_o),
    .c(_al_u563_o),
    .d(_al_u564_o),
    .o(_al_u565_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u566 (
    .a(brdy),
    .b(_al_u402_o),
    .c(_al_u352_o),
    .o(_al_u566_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(~C*A))"),
    .INIT(8'h31))
    _al_u567 (
    .a(_al_u566_o),
    .b(\alu/log/n12_lutinv ),
    .c(fch_ir[4]),
    .o(_al_u567_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*~(D*C*A))"),
    .INIT(16'h1333))
    _al_u568 (
    .a(_al_u559_o),
    .b(\ctl/n867_lutinv ),
    .c(_al_u340_o),
    .d(_al_u405_o),
    .o(_al_u568_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u569 (
    .a(\alu/log/n11_lutinv ),
    .b(\alu/log/n9_lutinv ),
    .o(_al_u569_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~(B)*C*~(D)+B*C*~(D)+~(B)*~(C)*D))"),
    .INIT(16'h02a0))
    _al_u570 (
    .a(_al_u461_o),
    .b(fch_ir[11]),
    .c(fch_ir[12]),
    .d(fch_ir[13]),
    .o(_al_u570_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u571 (
    .a(_al_u565_o),
    .b(_al_u567_o),
    .c(_al_u568_o),
    .d(_al_u569_o),
    .e(_al_u570_o),
    .o(_al_u571_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~E*~D*C*B))"),
    .INIT(32'haaaaaa2a))
    _al_u572 (
    .a(_al_u523_o),
    .b(_al_u340_o),
    .c(_al_u449_o),
    .d(fch_ir[7]),
    .e(fch_ir[8]),
    .o(_al_u572_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u573 (
    .a(_al_u465_o),
    .b(_al_u449_o),
    .o(_al_u573_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u574 (
    .a(_al_u572_o),
    .b(\ctl/n338_lutinv ),
    .c(\ctl/n365_lutinv ),
    .d(_al_u573_o),
    .o(_al_u574_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u575 (
    .a(\ctl/n321_lutinv ),
    .b(\ctl/n313_lutinv ),
    .c(_al_u466_o),
    .o(_al_u575_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u576 (
    .a(_al_u575_o),
    .b(\ctl/n307_lutinv ),
    .o(_al_u576_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u577 (
    .a(_al_u475_o),
    .b(\ctl/n525_lutinv ),
    .o(_al_u577_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u578 (
    .a(_al_u571_o),
    .b(_al_u574_o),
    .c(_al_u576_o),
    .d(_al_u577_o),
    .e(\ctl/n533_lutinv ),
    .o(\rgf/rctl/eq16/or_xor_i0[3]_i1[3]_o_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u579 (
    .a(_al_u542_o),
    .b(_al_u544_o),
    .c(_al_u454_o),
    .d(_al_u553_o),
    .e(_al_u441_o),
    .o(_al_u579_o));
  AL_MAP_LUT5 #(
    .EQN("(A*((~E*~D)*~(B)*~(C)+(~E*~D)*B*~(C)+~((~E*~D))*B*C+(~E*~D)*B*C))"),
    .INIT(32'h8080808a))
    _al_u580 (
    .a(_al_u579_o),
    .b(brdy),
    .c(_al_u372_o),
    .d(ctl_fetch_ext_lutinv),
    .e(_al_u460_o),
    .o(_al_u580_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*A)"),
    .INIT(16'h2000))
    _al_u581 (
    .a(_al_u367_o),
    .b(fch_ir[11]),
    .c(fch_ir[12]),
    .d(rgf_sr_flag[0]),
    .o(\ctl/n239_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u582 (
    .a(_al_u355_o),
    .b(_al_u369_o),
    .c(fch_ir[11]),
    .d(fch_ir[12]),
    .e(rgf_sr_flag[2]),
    .o(\ctl/n258_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~E*D*C*B))"),
    .INIT(32'h55551555))
    _al_u583 (
    .a(\ctl/n258_lutinv ),
    .b(_al_u355_o),
    .c(_al_u369_o),
    .d(_al_u382_o),
    .e(rgf_sr_flag[3]),
    .o(_al_u583_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u584 (
    .a(_al_u349_o),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .d(fch_ir[3]),
    .o(_al_u584_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u585 (
    .a(_al_u348_o),
    .b(_al_u355_o),
    .c(_al_u584_o),
    .d(fch_ir[0]),
    .o(\ctl/n232_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u586 (
    .a(_al_u355_o),
    .b(_al_u369_o),
    .c(_al_u347_o),
    .d(rgf_sr_flag[2]),
    .o(\ctl/n251_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(C*B*A*~(E@D))"),
    .INIT(32'h80000080))
    _al_u587 (
    .a(_al_u355_o),
    .b(_al_u379_o),
    .c(_al_u382_o),
    .d(rgf_sr_flag[1]),
    .e(rgf_sr_flag[3]),
    .o(\ctl/n302_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*~A)"),
    .INIT(32'h00000004))
    _al_u588 (
    .a(\ctl/n239_lutinv ),
    .b(_al_u583_o),
    .c(\ctl/n232_lutinv ),
    .d(\ctl/n251_lutinv ),
    .e(\ctl/n302_lutinv ),
    .o(_al_u588_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u589 (
    .a(_al_u369_o),
    .b(fch_ir[11]),
    .c(fch_ir[12]),
    .o(_al_u589_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(B*~(C)*~(D)*~(E)+~(B)*C*D*~(E)+B*~(C)*~(D)*E+~(B)*C*~(D)*E))"),
    .INIT(32'h00282008))
    _al_u590 (
    .a(_al_u379_o),
    .b(fch_ir[11]),
    .c(fch_ir[12]),
    .d(rgf_sr_flag[1]),
    .e(rgf_sr_flag[3]),
    .o(_al_u590_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(D*B)*~(E*A))"),
    .INIT(32'h0105030f))
    _al_u591 (
    .a(_al_u589_o),
    .b(_al_u387_o),
    .c(_al_u590_o),
    .d(rgf_sr_flag[1]),
    .e(rgf_sr_flag[3]),
    .o(_al_u591_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*~B))"),
    .INIT(8'h8a))
    _al_u592 (
    .a(_al_u588_o),
    .b(_al_u591_o),
    .c(_al_u355_o),
    .o(_al_u592_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*B*C*D)"),
    .INIT(16'h4a4e))
    _al_u593 (
    .a(_al_u432_o),
    .b(_al_u592_o),
    .c(_al_u350_o),
    .d(_al_u340_o),
    .o(_al_u593_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u594 (
    .a(_al_u394_o),
    .b(_al_u355_o),
    .o(_al_u594_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u595 (
    .a(_al_u593_o),
    .b(_al_u448_o),
    .c(_al_u594_o),
    .o(_al_u595_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u596 (
    .a(_al_u580_o),
    .b(_al_u595_o),
    .c(_al_u435_o),
    .o(_al_u596_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u597 (
    .a(irq_lev[0]),
    .b(rgf_sr_ie[0]),
    .o(\fch/lt0/o_0_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(D*B*(A*~(C)*~(E)+~(A)*~(C)*E+A*~(C)*E+A*C*E))"),
    .INIT(32'h8c000800))
    _al_u598 (
    .a(\fch/lt0/o_0_lutinv ),
    .b(irq),
    .c(irq_lev[1]),
    .d(_al_u395_o),
    .e(rgf_sr_ie[1]),
    .o(_al_u598_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*A*~(~C*~B))"),
    .INIT(32'h0000a800))
    _al_u599 (
    .a(_al_u340_o),
    .b(_al_u449_o),
    .c(_al_u440_o),
    .d(fch_ir[7]),
    .e(fch_ir[8]),
    .o(_al_u599_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*~(E*D*A))"),
    .INIT(32'h01030303))
    _al_u600 (
    .a(_al_u400_o),
    .b(_al_u599_o),
    .c(\ctl/n232_lutinv ),
    .d(_al_u355_o),
    .e(_al_u543_o),
    .o(_al_u600_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B*~(~D*~(~E*C))))"),
    .INIT(32'h22aa222a))
    _al_u601 (
    .a(_al_u600_o),
    .b(_al_u355_o),
    .c(_al_u369_o),
    .d(_al_u379_o),
    .e(_al_u347_o),
    .o(_al_u601_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u602 (
    .a(_al_u601_o),
    .b(_al_u520_o),
    .c(\alu/log/n11_lutinv ),
    .d(\ctl/n654_lutinv ),
    .o(_al_u602_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(~D*C*A))"),
    .INIT(16'hcc4c))
    _al_u603 (
    .a(_al_u598_o),
    .b(_al_u602_o),
    .c(_al_u394_o),
    .d(\ctl/stat [1]),
    .o(_al_u603_o));
  AL_MAP_LUT5 #(
    .EQN("(B*A*~(E*D*C))"),
    .INIT(32'h08888888))
    _al_u604 (
    .a(_al_u574_o),
    .b(_al_u575_o),
    .c(_al_u465_o),
    .d(_al_u342_o),
    .e(_al_u343_o),
    .o(_al_u604_o));
  AL_MAP_LUT5 #(
    .EQN("(B*A*(~(C)*~(D)*~(E)+C*D*E))"),
    .INIT(32'h80000008))
    _al_u605 (
    .a(_al_u355_o),
    .b(_al_u460_o),
    .c(fch_ir[11]),
    .d(fch_ir[12]),
    .e(fch_ir[13]),
    .o(_al_u605_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u606 (
    .a(\ctl/n867_lutinv ),
    .b(\ctl/n644_lutinv ),
    .c(_al_u605_o),
    .o(_al_u606_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u607 (
    .a(_al_u606_o),
    .b(_al_u433_o),
    .c(_al_u451_o),
    .d(\ctl/n533_lutinv ),
    .e(\ctl/n307_lutinv ),
    .o(_al_u607_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u608 (
    .a(_al_u454_o),
    .b(_al_u447_o),
    .o(_al_u608_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~B*~A*~(E*C))"),
    .INIT(32'h00010011))
    _al_u609 (
    .a(\mem/bwbf/n2 ),
    .b(\ctl/n602_lutinv ),
    .c(_al_u434_o),
    .d(\ctl/n248_lutinv ),
    .e(_al_u342_o),
    .o(_al_u609_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u610 (
    .a(_al_u607_o),
    .b(_al_u608_o),
    .c(_al_u609_o),
    .d(_al_u553_o),
    .o(_al_u610_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u611 (
    .a(_al_u577_o),
    .b(_al_u430_o),
    .c(_al_u555_o),
    .d(\ctl/sel0_b0/or_B108_B109_o_lutinv ),
    .o(_al_u611_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u612 (
    .a(\ctl/stat [0]),
    .b(\ctl/stat [1]),
    .c(\ctl/stat [2]),
    .o(\ctl/n901_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~B*~A*~(D*C))"),
    .INIT(32'h00000111))
    _al_u613 (
    .a(\ctl/n633_lutinv ),
    .b(_al_u368_o),
    .c(_al_u434_o),
    .d(_al_u405_o),
    .e(\ctl/n901_lutinv ),
    .o(_al_u613_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*B*A)"),
    .INIT(32'h00008000))
    _al_u614 (
    .a(_al_u604_o),
    .b(_al_u610_o),
    .c(_al_u611_o),
    .d(_al_u613_o),
    .e(\ctl/n743_lutinv ),
    .o(_al_u614_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u615 (
    .a(_al_u603_o),
    .b(_al_u614_o),
    .c(_al_u549_o),
    .o(_al_u615_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u616 (
    .a(\rgf/rctl/eq16/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(_al_u596_o),
    .c(_al_u615_o),
    .d(\ctl/n901_lutinv ),
    .o(_al_u616_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u617 (
    .a(_al_u604_o),
    .b(_al_u577_o),
    .c(_al_u407_o),
    .d(\ctl/n307_lutinv ),
    .o(_al_u617_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u618 (
    .a(_al_u563_o),
    .b(\alu/log/n12_lutinv ),
    .o(_al_u618_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*~A)"),
    .INIT(16'h0040))
    _al_u619 (
    .a(_al_u566_o),
    .b(_al_u569_o),
    .c(_al_u618_o),
    .d(_al_u534_o),
    .o(_al_u619_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u620 (
    .a(_al_u463_o),
    .b(fch_ir[10]),
    .o(_al_u620_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(E*B)*~(D*A))"),
    .INIT(32'h0103050f))
    _al_u621 (
    .a(_al_u561_o),
    .b(\ctl/n533_lutinv ),
    .c(_al_u620_o),
    .d(fch_ir[2]),
    .e(fch_ir[5]),
    .o(_al_u621_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B*~A))"),
    .INIT(8'hb0))
    _al_u622 (
    .a(_al_u500_o),
    .b(_al_u564_o),
    .c(fch_ir[10]),
    .o(\ctl/sel0_b2/or_or_B0_or_B1_B2_o__o_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("~(~B*~((~D*C))*~(A)+~B*(~D*C)*~(A)+~(~B)*(~D*C)*A+~B*(~D*C)*A)"),
    .INIT(16'hee4e))
    _al_u623 (
    .a(_al_u461_o),
    .b(\ctl/n875_lutinv ),
    .c(fch_ir[11]),
    .d(fch_ir[12]),
    .o(_al_u623_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(D*C))"),
    .INIT(16'h0222))
    _al_u624 (
    .a(_al_u621_o),
    .b(\ctl/sel0_b2/or_or_B0_or_B1_B2_o__o_lutinv ),
    .c(_al_u623_o),
    .d(fch_ir[10]),
    .o(_al_u624_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(D*~B)*~(E*~A))"),
    .INIT(32'h80a0c0f0))
    _al_u625 (
    .a(_al_u617_o),
    .b(_al_u619_o),
    .c(_al_u624_o),
    .d(fch_ir[2]),
    .e(fch_ir[5]),
    .o(_al_u625_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u626 (
    .a(_al_u616_o),
    .b(_al_u625_o),
    .o(_al_u626_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*~A)"),
    .INIT(32'h00000004))
    _al_u627 (
    .a(\ctl/n204_lutinv ),
    .b(_al_u373_o),
    .c(\ctl/sel0_b0/or_B108_B109_o_lutinv ),
    .d(_al_u530_o),
    .e(\ctl/n192_lutinv ),
    .o(_al_u627_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~C*B*A))"),
    .INIT(16'hf700))
    _al_u628 (
    .a(_al_u604_o),
    .b(_al_u577_o),
    .c(_al_u407_o),
    .d(fch_ir[3]),
    .o(_al_u628_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*~A)"),
    .INIT(16'h0010))
    _al_u629 (
    .a(_al_u500_o),
    .b(_al_u623_o),
    .c(_al_u564_o),
    .d(_al_u463_o),
    .o(_al_u629_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(D*~C))"),
    .INIT(16'h2022))
    _al_u630 (
    .a(_al_u627_o),
    .b(_al_u628_o),
    .c(_al_u629_o),
    .d(fch_ir[8]),
    .o(_al_u630_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u631 (
    .a(_al_u389_o),
    .b(\ctl/n307_lutinv ),
    .c(fch_ir[3]),
    .o(_al_u631_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~(~D*B*~A)))"),
    .INIT(32'h0040f0f0))
    _al_u632 (
    .a(_al_u566_o),
    .b(_al_u618_o),
    .c(_al_u631_o),
    .d(_al_u534_o),
    .e(fch_ir[0]),
    .o(_al_u632_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*C)*~(D*~(~B*A)))"),
    .INIT(32'h020f22ff))
    _al_u633 (
    .a(_al_u569_o),
    .b(_al_u561_o),
    .c(\ctl/n533_lutinv ),
    .d(fch_ir[0]),
    .e(fch_ir[3]),
    .o(_al_u633_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u634 (
    .a(_al_u630_o),
    .b(_al_u632_o),
    .c(_al_u633_o),
    .o(_al_u634_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u635 (
    .a(_al_u561_o),
    .b(\ctl/n533_lutinv ),
    .c(fch_ir[1]),
    .d(fch_ir[4]),
    .o(_al_u635_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(E*~B)*~(D*~A))"),
    .INIT(32'h80c0a0f0))
    _al_u636 (
    .a(_al_u619_o),
    .b(_al_u629_o),
    .c(_al_u635_o),
    .d(fch_ir[1]),
    .e(fch_ir[9]),
    .o(_al_u636_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*~B))"),
    .INIT(8'h8a))
    _al_u637 (
    .a(_al_u636_o),
    .b(_al_u617_o),
    .c(fch_ir[4]),
    .o(_al_u637_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u638 (
    .a(_al_u634_o),
    .b(_al_u637_o),
    .o(_al_u638_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u639 (
    .a(_al_u626_o),
    .b(_al_u638_o),
    .o(\rgf/cbus_sel_cr [3]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u640 (
    .a(_al_u634_o),
    .b(_al_u637_o),
    .o(_al_u640_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u641 (
    .a(_al_u626_o),
    .b(_al_u640_o),
    .o(\rgf/cbus_sel_cr [1]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u642 (
    .a(\rgf/rctl/eq16/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(_al_u625_o),
    .o(_al_u642_o));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u643 (
    .a(_al_u642_o),
    .b(_al_u638_o),
    .o(\rgf/bank/grn07/mux0_b0_sel_is_0_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u644 (
    .a(\ctl/n313_lutinv ),
    .b(\ctl/n307_lutinv ),
    .o(_al_u644_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u645 (
    .a(_al_u568_o),
    .b(_al_u644_o),
    .c(\alu/log/n11_lutinv ),
    .d(_al_u502_o),
    .e(\ctl/n358_lutinv ),
    .o(_al_u645_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u646 (
    .a(_al_u645_o),
    .b(_al_u567_o),
    .o(_al_u646_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u647 (
    .a(\rgf/bank/grn07/mux0_b0_sel_is_0_o ),
    .b(_al_u646_o),
    .o(\rgf/bank/grn07/n1 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u648 (
    .a(_al_u634_o),
    .b(_al_u637_o),
    .o(_al_u648_o));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u649 (
    .a(_al_u642_o),
    .b(_al_u648_o),
    .o(\rgf/bank/grn06/mux0_b0_sel_is_0_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u650 (
    .a(\rgf/bank/grn06/mux0_b0_sel_is_0_o ),
    .b(_al_u646_o),
    .o(\rgf/bank/grn06/n1 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u651 (
    .a(_al_u642_o),
    .b(_al_u640_o),
    .o(\rgf/bank/grn05/mux0_b0_sel_is_0_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u652 (
    .a(\rgf/bank/grn05/mux0_b0_sel_is_0_o ),
    .b(_al_u646_o),
    .o(\rgf/bank/grn05/n1 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u653 (
    .a(_al_u634_o),
    .b(_al_u637_o),
    .o(_al_u653_o));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u654 (
    .a(_al_u642_o),
    .b(_al_u653_o),
    .o(\rgf/bank/grn04/mux0_b0_sel_is_0_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u655 (
    .a(\rgf/bank/grn04/mux0_b0_sel_is_0_o ),
    .b(_al_u646_o),
    .o(\rgf/bank/grn04/n1 ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u656 (
    .a(\rgf/rctl/eq16/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .b(_al_u625_o),
    .o(_al_u656_o));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u657 (
    .a(_al_u656_o),
    .b(_al_u638_o),
    .o(\rgf/bank/grn03/mux0_b0_sel_is_0_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u658 (
    .a(\rgf/bank/grn03/mux0_b0_sel_is_0_o ),
    .b(_al_u646_o),
    .o(\rgf/bank/grn03/n1 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u659 (
    .a(_al_u656_o),
    .b(_al_u648_o),
    .o(\rgf/bank/grn02/mux0_b0_sel_is_0_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u660 (
    .a(\rgf/bank/grn02/mux0_b0_sel_is_0_o ),
    .b(_al_u646_o),
    .o(\rgf/bank/grn02/n1 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u661 (
    .a(_al_u656_o),
    .b(_al_u640_o),
    .o(\rgf/bank/grn01/mux0_b0_sel_is_0_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u662 (
    .a(\rgf/bank/grn01/mux0_b0_sel_is_0_o ),
    .b(_al_u646_o),
    .o(\rgf/bank/grn01/n1 ));
  AL_MAP_LUT2 #(
    .EQN("~(B*A)"),
    .INIT(4'h7))
    _al_u663 (
    .a(_al_u656_o),
    .b(_al_u653_o),
    .o(\rgf/bank/grn00/mux0_b0_sel_is_0_o ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u664 (
    .a(\rgf/bank/grn00/mux0_b0_sel_is_0_o ),
    .b(_al_u646_o),
    .o(\rgf/bank/grn00/n1 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u665 (
    .a(_al_u626_o),
    .b(_al_u653_o),
    .o(_al_u665_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u666 (
    .a(_al_u616_o),
    .b(_al_u648_o),
    .c(_al_u625_o),
    .o(_al_u666_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u667 (
    .a(\ctl/n561_lutinv ),
    .b(\ctl/n550_lutinv ),
    .o(_al_u667_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u668 (
    .a(_al_u667_o),
    .b(\ctl/n541_lutinv ),
    .o(_al_u668_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u669 (
    .a(_al_u572_o),
    .b(_al_u599_o),
    .o(_al_u669_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*~(~D*C))"),
    .INIT(16'h1101))
    _al_u670 (
    .a(\alu/log/n12_lutinv ),
    .b(_al_u531_o),
    .c(_al_u461_o),
    .d(_al_u338_o),
    .o(_al_u670_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u671 (
    .a(_al_u475_o),
    .b(_al_u670_o),
    .c(\ctl/n654_lutinv ),
    .d(\alu/log/n9_lutinv ),
    .o(_al_u671_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u672 (
    .a(_al_u513_o),
    .b(_al_u525_o),
    .c(\ctl/n358_lutinv ),
    .d(\ctl/n365_lutinv ),
    .e(_al_u486_o),
    .o(_al_u672_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u673 (
    .a(_al_u668_o),
    .b(_al_u669_o),
    .c(_al_u671_o),
    .d(_al_u672_o),
    .o(ctl_sr_upd_neg_lutinv));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*~B*~A)"),
    .INIT(32'h01000000))
    _al_u674 (
    .a(_al_u665_o),
    .b(_al_u666_o),
    .c(\rgf/sreg/mux2_b2_sel_is_2_o ),
    .d(rst_n),
    .e(ctl_sr_upd_neg_lutinv),
    .o(_al_u674_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*D*~B)*~(C*~A))"),
    .INIT(32'h73505050))
    _al_u675 (
    .a(_al_u674_o),
    .b(_al_u665_o),
    .c(cpuid[1]),
    .d(rst_n),
    .e(\rgf/sreg/sr [13]),
    .o(\rgf/sreg/n8 [13]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*D*~B)*~(C*~A))"),
    .INIT(32'h73505050))
    _al_u676 (
    .a(_al_u674_o),
    .b(_al_u665_o),
    .c(cpuid[0]),
    .d(rst_n),
    .e(\rgf/sreg/sr [12]),
    .o(\rgf/sreg/n8 [12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u677 (
    .a(irq),
    .b(_al_u395_o),
    .o(_al_u677_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u678 (
    .a(_al_u575_o),
    .b(\ctl/n307_lutinv ),
    .c(\ctl/n365_lutinv ),
    .o(_al_u678_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u679 (
    .a(_al_u678_o),
    .b(_al_u572_o),
    .c(\ctl/n338_lutinv ),
    .d(_al_u599_o),
    .o(_al_u679_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u680 (
    .a(_al_u577_o),
    .b(_al_u608_o),
    .c(_al_u453_o),
    .d(\ctl/n533_lutinv ),
    .e(\alu/log/n12_lutinv ),
    .o(_al_u680_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u681 (
    .a(_al_u679_o),
    .b(fch_ir[0]),
    .c(_al_u680_o),
    .o(_al_u681_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u682 (
    .a(_al_u563_o),
    .b(fch_ir[0]),
    .o(\ctl/sel0_b0/B31 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u683 (
    .a(\ctl/sel0_b0/B31 ),
    .b(_al_u441_o),
    .o(_al_u683_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~C*~(E*B*~A))"),
    .INIT(32'h0b000f00))
    _al_u684 (
    .a(_al_u410_o),
    .b(_al_u677_o),
    .c(_al_u681_o),
    .d(_al_u683_o),
    .e(_al_u594_o),
    .o(\ctl_selb_rn[0]_neg_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u685 (
    .a(_al_u357_o),
    .b(_al_u401_o),
    .c(fch_ir[7]),
    .o(_al_u685_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u686 (
    .a(_al_u669_o),
    .b(_al_u576_o),
    .c(_al_u618_o),
    .d(_al_u685_o),
    .o(_al_u686_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*~B))"),
    .INIT(8'h8a))
    _al_u687 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u547_o),
    .c(_al_u686_o),
    .o(_al_u687_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u688 (
    .a(_al_u679_o),
    .b(_al_u577_o),
    .c(_al_u453_o),
    .o(_al_u688_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u689 (
    .a(_al_u688_o),
    .b(_al_u618_o),
    .c(_al_u685_o),
    .d(\ctl/n533_lutinv ),
    .o(_al_u689_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u690 (
    .a(_al_u689_o),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .o(_al_u690_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u691 (
    .a(\ctl/n533_lutinv ),
    .b(\ctl/n525_lutinv ),
    .o(_al_u691_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u692 (
    .a(_al_u691_o),
    .b(_al_u521_o),
    .c(_al_u451_o),
    .d(\mem/bwbf/n2 ),
    .e(\ctl/n518_lutinv ),
    .o(_al_u692_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u693 (
    .a(_al_u618_o),
    .b(_al_u692_o),
    .c(_al_u454_o),
    .d(_al_u368_o),
    .e(\ctl/n511_lutinv ),
    .o(_al_u693_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u694 (
    .a(_al_u482_o),
    .b(_al_u478_o),
    .o(\ctl/n121_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*B*A)"),
    .INIT(32'h00800000))
    _al_u695 (
    .a(_al_u679_o),
    .b(_al_u693_o),
    .c(_al_u376_o),
    .d(\ctl/n121_lutinv ),
    .e(_al_u384_o),
    .o(\ctl_selb[0]_neg_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u696 (
    .a(_al_u690_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .o(_al_u696_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u697 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u696_o),
    .c(\rgf/bank/gr03 [9]),
    .o(\rgf/bank/bbuso/gr3_bus [9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u698 (
    .a(_al_u690_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .o(_al_u698_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*~(D*C*A))"),
    .INIT(16'h1333))
    _al_u699 (
    .a(_al_u687_o),
    .b(\rgf/bank/bbuso/gr3_bus [9]),
    .c(_al_u698_o),
    .d(\rgf/sptr/sp [9]),
    .o(_al_u699_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*~C*B*A)"),
    .INIT(32'h00000800))
    _al_u700 (
    .a(_al_u481_o),
    .b(_al_u691_o),
    .c(_al_u441_o),
    .d(_al_u688_o),
    .e(\ctl/n120_lutinv ),
    .o(_al_u700_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*~B*~A)"),
    .INIT(32'h01000000))
    _al_u701 (
    .a(\ctl/sel2_b0/or_or_or_B110_B111_o_o_lutinv ),
    .b(\rgf/sreg/mux2_b2_sel_is_2_o ),
    .c(\ctl/n169_lutinv ),
    .d(_al_u686_o),
    .e(_al_u700_o),
    .o(\ctl_selb[1]_neg_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u702 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u698_o),
    .c(\rgf/ivec/iv [9]),
    .o(\rgf/bbus_iv [9]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u703 (
    .a(_al_u689_o),
    .b(_al_u361_o),
    .o(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u704 (
    .a(\ctl/sel2_b0/or_or_or_B110_B111_o_o_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u681_o),
    .d(\ctl/sel0_b0/B31 ),
    .e(_al_u441_o),
    .o(_al_u704_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u705 (
    .a(_al_u521_o),
    .b(\ctl/n120_lutinv ),
    .c(_al_u368_o),
    .d(\ctl/n867_lutinv ),
    .o(_al_u705_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u706 (
    .a(_al_u705_o),
    .b(\ctl/n121_lutinv ),
    .c(_al_u384_o),
    .o(_al_u706_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u707 (
    .a(\ctl_selb[0]_neg_lutinv ),
    .b(_al_u706_o),
    .o(_al_u707_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(E*D*C*~A))"),
    .INIT(32'h23333333))
    _al_u708 (
    .a(\ctl_selb[1]_neg_lutinv ),
    .b(\rgf/bbus_iv [9]),
    .c(_al_u704_o),
    .d(_al_u707_o),
    .e(\rgf/bank/gr00 [9]),
    .o(_al_u708_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u709 (
    .a(_al_u689_o),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .o(_al_u709_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u710 (
    .a(_al_u709_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .o(_al_u710_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u711 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u710_o),
    .c(\rgf/bank/gr06 [9]),
    .o(\rgf/bank/bbuso/gr6_bus [9]));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u712 (
    .a(_al_u689_o),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .o(_al_u712_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*~B))"),
    .INIT(8'ha8))
    _al_u713 (
    .a(_al_u712_o),
    .b(_al_u681_o),
    .c(\ctl/sel0_b0/B31 ),
    .o(_al_u713_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u714 (
    .a(_al_u713_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .c(\rgf/bank/gr05 [9]),
    .o(\rgf/bank/bbuso/gr5_bus [9]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u715 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u707_o),
    .d(\rgf/bank/gr01 [9]),
    .o(\rgf/bank/bbuso/gr1_bus [9]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u716 (
    .a(_al_u699_o),
    .b(_al_u708_o),
    .c(\rgf/bank/bbuso/gr6_bus [9]),
    .d(\rgf/bank/bbuso/gr5_bus [9]),
    .e(\rgf/bank/bbuso/gr1_bus [9]),
    .o(_al_u716_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u717 (
    .a(_al_u700_o),
    .b(fch_ir[8]),
    .o(_al_u717_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u718 (
    .a(_al_u376_o),
    .b(\fch/eir [9]),
    .o(bbus_fch[9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u719 (
    .a(_al_u502_o),
    .b(_al_u564_o),
    .o(_al_u719_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u720 (
    .a(_al_u719_o),
    .b(_al_u500_o),
    .c(_al_u461_o),
    .o(_al_u720_o));
  AL_MAP_LUT5 #(
    .EQN("~(B*~(A)*~((E*D*C))+B*A*~((E*D*C))+~(B)*A*(E*D*C)+B*A*(E*D*C))"),
    .INIT(32'h53333333))
    _al_u721 (
    .a(\ctl/n120_lutinv ),
    .b(\ctl/n121_lutinv ),
    .c(_al_u361_o),
    .d(fch_ir[0]),
    .e(fch_ir[3]),
    .o(_al_u721_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(D*~(E*~(~B*A))))"),
    .INIT(32'h0d0f000f))
    _al_u722 (
    .a(_al_u717_o),
    .b(_al_u706_o),
    .c(bbus_fch[9]),
    .d(_al_u720_o),
    .e(_al_u721_o),
    .o(_al_u722_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u723 (
    .a(_al_u679_o),
    .b(_al_u453_o),
    .c(_al_u691_o),
    .d(_al_u475_o),
    .e(_al_u686_o),
    .o(_al_u723_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u724 (
    .a(_al_u723_o),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .o(_al_u724_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u725 (
    .a(_al_u724_o),
    .b(fch_ir[0]),
    .o(_al_u725_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u726 (
    .a(\ctl_selb[0]_neg_lutinv ),
    .b(_al_u706_o),
    .o(_al_u726_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(D*C*B))"),
    .INIT(16'h2aaa))
    _al_u727 (
    .a(_al_u722_o),
    .b(_al_u725_o),
    .c(_al_u726_o),
    .d(n0[8]),
    .o(_al_u727_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u728 (
    .a(fch_ir[0]),
    .b(_al_u690_o),
    .o(_al_u728_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u729 (
    .a(_al_u712_o),
    .b(_al_u681_o),
    .c(\ctl/sel0_b0/B31 ),
    .o(_al_u729_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*A))"),
    .INIT(16'h135f))
    _al_u730 (
    .a(_al_u728_o),
    .b(_al_u729_o),
    .c(\rgf/bank/gr02 [9]),
    .d(\rgf/bank/gr04 [9]),
    .o(_al_u730_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u731 (
    .a(\ctl_selb[0]_neg_lutinv ),
    .b(_al_u723_o),
    .c(fch_ir[1]),
    .d(fch_ir[2]),
    .o(_al_u731_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u732 (
    .a(_al_u731_o),
    .b(fch_ir[0]),
    .o(\rgf/bbus_sel [7]));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+~(A)*B*C*~(D)+~(A)*B*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hdc54))
    _al_u733 (
    .a(_al_u730_o),
    .b(\rgf/bbus_sel [7]),
    .c(_al_u707_o),
    .d(\rgf/bank/gr07 [9]),
    .o(_al_u733_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(~E*~D*~C*~A))"),
    .INIT(32'h33333332))
    _al_u734 (
    .a(\ctl/sel2_b0/or_or_or_B110_B111_o_o_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u681_o),
    .d(\ctl/sel0_b0/B31 ),
    .e(_al_u441_o),
    .o(_al_u734_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u735 (
    .a(_al_u734_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .o(\rgf/bbus_sel_cr [1]));
  AL_MAP_LUT5 #(
    .EQN("~(~C*B*A*~(E*D))"),
    .INIT(32'hfff7f7f7))
    _al_u736 (
    .a(_al_u716_o),
    .b(_al_u727_o),
    .c(_al_u733_o),
    .d(rgf_pc[9]),
    .e(\rgf/bbus_sel_cr [1]),
    .o(bbus[9]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u737 (
    .a(_al_u707_o),
    .b(_al_u686_o),
    .c(_al_u700_o),
    .o(_al_u737_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u738 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u696_o),
    .c(\rgf/bank/gr03 [8]),
    .o(\rgf/bank/bbuso/gr3_bus [8]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u739 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u707_o),
    .d(\rgf/bank/gr01 [8]),
    .o(\rgf/bank/bbuso/gr1_bus [8]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u740 (
    .a(_al_u690_o),
    .b(_al_u681_o),
    .c(\ctl/sel0_b0/B31 ),
    .o(_al_u740_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*~(E*D*A))"),
    .INIT(32'h01030303))
    _al_u741 (
    .a(_al_u737_o),
    .b(\rgf/bank/bbuso/gr3_bus [8]),
    .c(\rgf/bank/bbuso/gr1_bus [8]),
    .d(_al_u740_o),
    .e(\rgf/bank/gr02 [8]),
    .o(_al_u741_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u742 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u709_o),
    .o(_al_u742_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*~B))"),
    .INIT(8'ha8))
    _al_u743 (
    .a(_al_u690_o),
    .b(_al_u681_o),
    .c(\ctl/sel0_b0/B31 ),
    .o(_al_u743_o));
  AL_MAP_LUT5 #(
    .EQN("~((E*D)*~((C*B))*~(A)+(E*D)*(C*B)*~(A)+~((E*D))*(C*B)*A+(E*D)*(C*B)*A)"),
    .INIT(32'h2a7f7f7f))
    _al_u744 (
    .a(_al_u737_o),
    .b(_al_u742_o),
    .c(\rgf/bank/gr07 [8]),
    .d(\rgf/ivec/iv [8]),
    .e(_al_u743_o),
    .o(_al_u744_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u745 (
    .a(_al_u737_o),
    .b(_al_u713_o),
    .c(\rgf/bank/gr05 [8]),
    .o(\rgf/bank/bbuso/gr5_bus [8]));
  AL_MAP_LUT4 #(
    .EQN("(~C*A*~(D*B))"),
    .INIT(16'h020a))
    _al_u746 (
    .a(_al_u744_o),
    .b(\rgf/bbus_sel_cr [1]),
    .c(\rgf/bank/bbuso/gr5_bus [8]),
    .d(rgf_pc[8]),
    .o(_al_u746_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u747 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u709_o),
    .o(_al_u747_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~(D*C)*~(E*B)))"),
    .INIT(32'ha888a000))
    _al_u748 (
    .a(_al_u737_o),
    .b(_al_u747_o),
    .c(_al_u704_o),
    .d(\rgf/bank/gr00 [8]),
    .e(\rgf/bank/gr06 [8]),
    .o(_al_u748_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u749 (
    .a(\alu/sft/n30_lutinv ),
    .b(\alu/sft/n36_lutinv ),
    .o(_al_u749_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u750 (
    .a(_al_u749_o),
    .b(\alu/art/eq4/or_xor_i0[2]_i1[2]_o_o_lutinv ),
    .o(\ctl/n119_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("~(B*~(A)*~((E*~D*C))+B*A*~((E*~D*C))+~(B)*A*(E*~D*C)+B*A*(E*~D*C))"),
    .INIT(32'h33533333))
    _al_u751 (
    .a(\ctl/n120_lutinv ),
    .b(\ctl/n121_lutinv ),
    .c(_al_u361_o),
    .d(fch_ir[0]),
    .e(fch_ir[3]),
    .o(_al_u751_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(E*~C)*~(D*A))"),
    .INIT(32'h40c044cc))
    _al_u752 (
    .a(\ctl/n119_lutinv ),
    .b(_al_u751_o),
    .c(_al_u376_o),
    .d(fch_ir[7]),
    .e(\fch/eir [8]),
    .o(_al_u752_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(D*C*A))"),
    .INIT(16'h4ccc))
    _al_u753 (
    .a(_al_u740_o),
    .b(_al_u752_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(\rgf/sptr/sp [8]),
    .o(_al_u753_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u754 (
    .a(_al_u713_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .c(n0[7]),
    .o(\rgf/sptr/bbus2 [8]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u755 (
    .a(_al_u712_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .o(_al_u755_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u756 (
    .a(fch_ir[0]),
    .b(_al_u755_o),
    .o(\rgf/bbus_sel [4]));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*~A*~(E*D))"),
    .INIT(32'h00040404))
    _al_u757 (
    .a(_al_u748_o),
    .b(_al_u753_o),
    .c(\rgf/sptr/bbus2 [8]),
    .d(\rgf/bbus_sel [4]),
    .e(\rgf/bank/gr04 [8]),
    .o(_al_u757_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*B*A)"),
    .INIT(8'h7f))
    _al_u758 (
    .a(_al_u741_o),
    .b(_al_u746_o),
    .c(_al_u757_o),
    .o(bbus[8]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u759 (
    .a(_al_u713_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .c(n0[14]),
    .o(\rgf/sptr/bbus2 [15]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u760 (
    .a(\ctl/n119_lutinv ),
    .b(fch_ir[10]),
    .o(_al_u760_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u761 (
    .a(fch_ir[0]),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .d(fch_ir[3]),
    .o(_al_u761_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~B*~(C)*~(D)+~B*C*~(D)+~(~B)*C*D+~B*C*D))"),
    .INIT(16'h0544))
    _al_u762 (
    .a(_al_u760_o),
    .b(_al_u481_o),
    .c(\ctl/n120_lutinv ),
    .d(_al_u761_o),
    .o(_al_u762_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*D*C*B))"),
    .INIT(32'h15555555))
    _al_u763 (
    .a(\ctl/n192_lutinv ),
    .b(_al_u348_o),
    .c(_al_u362_o),
    .d(_al_u364_o),
    .e(\ctl/stat [0]),
    .o(_al_u763_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u764 (
    .a(_al_u763_o),
    .b(\fch/eir [15]),
    .o(_al_u764_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*B*~(E*C*~A))"),
    .INIT(32'h008c00cc))
    _al_u765 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u762_o),
    .c(_al_u698_o),
    .d(_al_u764_o),
    .e(\rgf/ivec/iv [15]),
    .o(_al_u765_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~A*~(E*C*B))"),
    .INIT(32'h15005500))
    _al_u766 (
    .a(\rgf/sptr/bbus2 [15]),
    .b(_al_u737_o),
    .c(_al_u747_o),
    .d(_al_u765_o),
    .e(\rgf/bank/gr06 [15]),
    .o(_al_u766_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~(D*~C)*~(E*B)))"),
    .INIT(32'h8a880a00))
    _al_u767 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .d(\rgf/bank/gr00 [15]),
    .e(\rgf/bank/gr04 [15]),
    .o(_al_u767_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~(D*C)*~(E*B)))"),
    .INIT(32'h54445000))
    _al_u768 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(_al_u690_o),
    .d(\rgf/bank/gr03 [15]),
    .e(\rgf/bank/gr05 [15]),
    .o(_al_u768_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~C*~B*~(E*D)))"),
    .INIT(32'haaa8a8a8))
    _al_u769 (
    .a(_al_u737_o),
    .b(_al_u767_o),
    .c(_al_u768_o),
    .d(_al_u734_o),
    .e(\rgf/bank/gr01 [15]),
    .o(_al_u769_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u770 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u710_o),
    .c(\rgf/bank/gr07 [15]),
    .o(\rgf/bank/bbuso/gr7_bus [15]));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u771 (
    .a(\rgf/bank/bbuso/gr7_bus [15]),
    .b(_al_u734_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(rgf_pc[15]),
    .o(_al_u771_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u772 (
    .a(_al_u740_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .c(\rgf/sptr/sp [15]),
    .o(\rgf/sptr/bbus1 [15]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u773 (
    .a(_al_u737_o),
    .b(_al_u740_o),
    .c(\rgf/bank/gr02 [15]),
    .o(\rgf/bank/bbuso/gr2_bus [15]));
  AL_MAP_LUT5 #(
    .EQN("~(~E*~D*C*~B*A)"),
    .INIT(32'hffffffdf))
    _al_u774 (
    .a(_al_u766_o),
    .b(_al_u769_o),
    .c(_al_u771_o),
    .d(\rgf/sptr/bbus1 [15]),
    .e(\rgf/bank/bbuso/gr2_bus [15]),
    .o(bbus[15]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u775 (
    .a(_al_u737_o),
    .b(_al_u704_o),
    .c(\rgf/bank/gr00 [14]),
    .o(\rgf/bank/bbuso/gr0_bus [14]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u776 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(_al_u707_o),
    .d(\rgf/bank/gr05 [14]),
    .o(\rgf/bank/bbuso/gr5_bus [14]));
  AL_MAP_LUT5 #(
    .EQN("(~C*~A*~(E*D*B))"),
    .INIT(32'h01050505))
    _al_u777 (
    .a(\rgf/bank/bbuso/gr0_bus [14]),
    .b(_al_u737_o),
    .c(\rgf/bank/bbuso/gr5_bus [14]),
    .d(_al_u740_o),
    .e(\rgf/bank/gr02 [14]),
    .o(_al_u777_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~(D*C)*~(E*~B)))"),
    .INIT(32'h51115000))
    _al_u778 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u690_o),
    .d(\rgf/ivec/iv [14]),
    .e(rgf_pc[14]),
    .o(_al_u778_o));
  AL_MAP_LUT5 #(
    .EQN("~((D*B)*~((E*C))*~(A)+(D*B)*(E*C)*~(A)+~((D*B))*(E*C)*A+(D*B)*(E*C)*A)"),
    .INIT(32'h1b5fbbff))
    _al_u779 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(_al_u690_o),
    .d(n0[13]),
    .e(\rgf/sptr/sp [14]),
    .o(_al_u779_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B*~A))"),
    .INIT(8'hb0))
    _al_u780 (
    .a(_al_u778_o),
    .b(_al_u779_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .o(_al_u780_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u781 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u707_o),
    .d(\rgf/bank/gr01 [14]),
    .o(\rgf/bank/bbuso/gr1_bus [14]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(D*B*A))"),
    .INIT(16'h070f))
    _al_u782 (
    .a(_al_u737_o),
    .b(_al_u747_o),
    .c(\rgf/bank/bbuso/gr1_bus [14]),
    .d(\rgf/bank/gr06 [14]),
    .o(_al_u782_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u783 (
    .a(fch_ir[0]),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .d(fch_ir[3]),
    .o(_al_u783_o));
  AL_MAP_LUT5 #(
    .EQN("(~(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E*~A))"),
    .INIT(32'h220a330f))
    _al_u784 (
    .a(_al_u376_o),
    .b(\ctl/n120_lutinv ),
    .c(\ctl/n121_lutinv ),
    .d(_al_u783_o),
    .e(\fch/eir [14]),
    .o(_al_u784_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~B*~(D*A))"),
    .INIT(16'h1030))
    _al_u785 (
    .a(\rgf/bbus_sel [4]),
    .b(_al_u760_o),
    .c(_al_u784_o),
    .d(\rgf/bank/gr04 [14]),
    .o(_al_u785_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~(E*C)*~(D*B)))"),
    .INIT(32'h54504400))
    _al_u786 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u696_o),
    .c(_al_u710_o),
    .d(\rgf/bank/gr03 [14]),
    .e(\rgf/bank/gr07 [14]),
    .o(_al_u786_o));
  AL_MAP_LUT5 #(
    .EQN("~(~E*D*C*~B*A)"),
    .INIT(32'hffffdfff))
    _al_u787 (
    .a(_al_u777_o),
    .b(_al_u780_o),
    .c(_al_u782_o),
    .d(_al_u785_o),
    .e(_al_u786_o),
    .o(bbus[14]));
  AL_MAP_LUT4 #(
    .EQN("(A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha280))
    _al_u788 (
    .a(_al_u734_o),
    .b(_al_u707_o),
    .c(\rgf/bank/gr01 [11]),
    .d(rgf_pc[11]),
    .o(_al_u788_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u789 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u710_o),
    .c(\rgf/bank/gr07 [11]),
    .o(\rgf/bank/bbuso/gr7_bus [11]));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u790 (
    .a(\rgf/bank/bbuso/gr7_bus [11]),
    .b(_al_u713_o),
    .c(_al_u707_o),
    .d(\rgf/bank/gr05 [11]),
    .o(_al_u790_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u791 (
    .a(\ctl_selb[1]_neg_lutinv ),
    .b(_al_u704_o),
    .c(_al_u707_o),
    .d(\rgf/bank/gr00 [11]),
    .o(\rgf/bank/bbuso/gr0_bus [11]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u792 (
    .a(_al_u713_o),
    .b(_al_u726_o),
    .c(n0[10]),
    .o(\rgf/sptr/bbus2 [11]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u793 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u696_o),
    .c(\rgf/bank/gr03 [11]),
    .o(\rgf/bank/bbuso/gr3_bus [11]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*~A)"),
    .INIT(32'h00000004))
    _al_u794 (
    .a(_al_u788_o),
    .b(_al_u790_o),
    .c(\rgf/bank/bbuso/gr0_bus [11]),
    .d(\rgf/sptr/bbus2 [11]),
    .e(\rgf/bank/bbuso/gr3_bus [11]),
    .o(_al_u794_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u795 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u690_o),
    .c(_al_u726_o),
    .d(\rgf/ivec/iv [11]),
    .o(\rgf/bbus_iv [11]));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u796 (
    .a(\rgf/bbus_iv [11]),
    .b(_al_u729_o),
    .c(_al_u707_o),
    .d(\rgf/bank/gr04 [11]),
    .o(_al_u796_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)))"),
    .INIT(32'h222aa2aa))
    _al_u797 (
    .a(_al_u796_o),
    .b(_al_u740_o),
    .c(_al_u726_o),
    .d(\rgf/bank/gr02 [11]),
    .e(\rgf/sptr/sp [11]),
    .o(_al_u797_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u798 (
    .a(_al_u737_o),
    .b(\ctl_selb_rn[0]_neg_lutinv ),
    .c(_al_u709_o),
    .d(\rgf/bank/gr06 [11]),
    .o(\rgf/bank/bbuso/gr6_bus [11]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*~B))"),
    .INIT(8'h45))
    _al_u799 (
    .a(\rgf/bank/bbuso/gr6_bus [11]),
    .b(_al_u763_o),
    .c(\fch/eir [11]),
    .o(_al_u799_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    _al_u800 (
    .a(fch_ir[0]),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .d(fch_ir[3]),
    .o(_al_u800_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~B*~(C)*~(D)+~B*C*~(D)+~(~B)*C*D+~B*C*D))"),
    .INIT(16'h0544))
    _al_u801 (
    .a(_al_u760_o),
    .b(_al_u481_o),
    .c(\ctl/n120_lutinv ),
    .d(_al_u800_o),
    .o(_al_u801_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*C*B*A)"),
    .INIT(16'h7fff))
    _al_u802 (
    .a(_al_u794_o),
    .b(_al_u797_o),
    .c(_al_u799_o),
    .d(_al_u801_o),
    .o(bbus[11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u803 (
    .a(\rgf/bbus_sel [4]),
    .b(\rgf/bank/gr04 [10]),
    .o(\rgf/bank/bbuso/gr4_bus [10]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    _al_u804 (
    .a(fch_ir[0]),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .d(fch_ir[3]),
    .o(_al_u804_o));
  AL_MAP_LUT5 #(
    .EQN("(~(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E*~A))"),
    .INIT(32'h220a330f))
    _al_u805 (
    .a(_al_u376_o),
    .b(\ctl/n120_lutinv ),
    .c(\ctl/n121_lutinv ),
    .d(_al_u804_o),
    .e(\fch/eir [10]),
    .o(_al_u805_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u806 (
    .a(\ctl/n119_lutinv ),
    .b(_al_u805_o),
    .c(fch_ir[9]),
    .o(_al_u806_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~A*~(E*C*B))"),
    .INIT(32'h15005500))
    _al_u807 (
    .a(\rgf/bank/bbuso/gr4_bus [10]),
    .b(_al_u737_o),
    .c(_al_u747_o),
    .d(_al_u806_o),
    .e(\rgf/bank/gr06 [10]),
    .o(_al_u807_o));
  AL_MAP_LUT5 #(
    .EQN("~((D*~B)*~((E*C))*~(A)+(D*~B)*(E*C)*~(A)+~((D*~B))*(E*C)*A+(D*~B)*(E*C)*A)"),
    .INIT(32'h4e5feeff))
    _al_u808 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u690_o),
    .d(\rgf/bank/gr01 [10]),
    .e(\rgf/bank/gr02 [10]),
    .o(_al_u808_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u809 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u690_o),
    .c(\rgf/bank/gr03 [10]),
    .o(_al_u809_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~C*B*~(E*D)))"),
    .INIT(32'haaa2a2a2))
    _al_u810 (
    .a(_al_u737_o),
    .b(_al_u808_o),
    .c(_al_u809_o),
    .d(_al_u713_o),
    .e(\rgf/bank/gr05 [10]),
    .o(_al_u810_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u811 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u710_o),
    .o(_al_u811_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*B)*~(D*C*A))"),
    .INIT(32'h13335fff))
    _al_u812 (
    .a(_al_u737_o),
    .b(_al_u811_o),
    .c(_al_u704_o),
    .d(\rgf/bank/gr00 [10]),
    .e(\rgf/bank/gr07 [10]),
    .o(_al_u812_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~(E*C)*~(D*B)))"),
    .INIT(32'h54504400))
    _al_u813 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(_al_u690_o),
    .d(n0[9]),
    .e(\rgf/ivec/iv [10]),
    .o(_al_u813_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(D*C)*~(E*B))"),
    .INIT(32'h01110555))
    _al_u814 (
    .a(_al_u813_o),
    .b(_al_u740_o),
    .c(_al_u734_o),
    .d(rgf_pc[10]),
    .e(\rgf/sptr/sp [10]),
    .o(_al_u814_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D*C*~B*~A))"),
    .INIT(32'hefff0000))
    _al_u815 (
    .a(\ctl/sel2_b0/or_or_or_B110_B111_o_o_lutinv ),
    .b(_al_u547_o),
    .c(_al_u686_o),
    .d(_al_u700_o),
    .e(_al_u706_o),
    .o(_al_u815_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u816 (
    .a(_al_u815_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .o(_al_u816_o));
  AL_MAP_LUT5 #(
    .EQN("~(C*~B*A*~(E*~D))"),
    .INIT(32'hdfffdfdf))
    _al_u817 (
    .a(_al_u807_o),
    .b(_al_u810_o),
    .c(_al_u812_o),
    .d(_al_u814_o),
    .e(_al_u816_o),
    .o(bbus[10]));
  AL_MAP_LUT5 #(
    .EQN("(B*~(A)*~((~E*D*C))+B*A*~((~E*D*C))+~(B)*A*(~E*D*C)+B*A*(~E*D*C))"),
    .INIT(32'hccccaccc))
    _al_u818 (
    .a(\ctl/n120_lutinv ),
    .b(\ctl/n121_lutinv ),
    .c(_al_u361_o),
    .d(fch_ir[0]),
    .e(fch_ir[3]),
    .o(_al_u818_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(E*~C)*~(D*~A))"),
    .INIT(32'h20302233))
    _al_u819 (
    .a(_al_u720_o),
    .b(_al_u818_o),
    .c(_al_u376_o),
    .d(fch_ir[1]),
    .e(\fch/eir [1]),
    .o(_al_u819_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u820 (
    .a(\ctl/n119_lutinv ),
    .b(_al_u819_o),
    .c(fch_ir[0]),
    .o(_al_u820_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(D*C*A))"),
    .INIT(16'h4ccc))
    _al_u821 (
    .a(_al_u734_o),
    .b(_al_u820_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(rgf_pc[1]),
    .o(_al_u821_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u822 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u710_o),
    .c(\rgf/bank/gr07 [1]),
    .o(\rgf/bank/bbuso/gr7_bus [1]));
  AL_MAP_LUT5 #(
    .EQN("(~C*A*~(E*D*B))"),
    .INIT(32'h020a0a0a))
    _al_u823 (
    .a(_al_u821_o),
    .b(_al_u737_o),
    .c(\rgf/bank/bbuso/gr7_bus [1]),
    .d(_al_u704_o),
    .e(\rgf/bank/gr00 [1]),
    .o(_al_u823_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~(E*C)*~(D*~B)))"),
    .INIT(32'h51501100))
    _al_u824 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u690_o),
    .d(\rgf/bank/gr01 [1]),
    .e(\rgf/bank/gr03 [1]),
    .o(_al_u824_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))"),
    .INIT(16'hc480))
    _al_u825 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(\rgf/bank/gr04 [1]),
    .d(\rgf/bank/gr05 [1]),
    .o(_al_u825_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~C*~B*~(E*D)))"),
    .INIT(32'haaa8a8a8))
    _al_u826 (
    .a(_al_u737_o),
    .b(_al_u824_o),
    .c(_al_u825_o),
    .d(_al_u740_o),
    .e(\rgf/bank/gr02 [1]),
    .o(_al_u826_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u827 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u731_o),
    .c(\rgf/bank/gr06 [1]),
    .o(\rgf/bank/bbuso/gr6_bus [1]));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u828 (
    .a(\rgf/bank/bbuso/gr6_bus [1]),
    .b(_al_u743_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(\rgf/ivec/iv [1]),
    .o(_al_u828_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u829 (
    .a(_al_u740_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .c(\rgf/sptr/sp [1]),
    .o(\rgf/sptr/bbus1 [1]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u830 (
    .a(_al_u713_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .c(n0[0]),
    .o(\rgf/sptr/bbus2 [1]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u831 (
    .a(_al_u823_o),
    .b(_al_u826_o),
    .c(_al_u828_o),
    .d(\rgf/sptr/bbus1 [1]),
    .e(\rgf/sptr/bbus2 [1]),
    .o(\alu/art/n4 [1]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~(~B*~A))"),
    .INIT(16'he000))
    _al_u832 (
    .a(_al_u713_o),
    .b(_al_u740_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(\rgf/sptr/sp [0]),
    .o(\rgf/bbus_sp [0]));
  AL_MAP_LUT4 #(
    .EQN("(B*(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))"),
    .INIT(16'hc480))
    _al_u833 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u696_o),
    .c(\rgf/bank/gr02 [0]),
    .d(\rgf/bank/gr03 [0]),
    .o(_al_u833_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~A*~(E*D*C))"),
    .INIT(32'h01111111))
    _al_u834 (
    .a(\rgf/bbus_sp [0]),
    .b(_al_u833_o),
    .c(_al_u737_o),
    .d(_al_u704_o),
    .e(\rgf/bank/gr00 [0]),
    .o(_al_u834_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*C*B)*~(E*A))"),
    .INIT(32'h15553fff))
    _al_u835 (
    .a(\rgf/bbus_sel_cr [1]),
    .b(_al_u737_o),
    .c(_al_u729_o),
    .d(\rgf/bank/gr04 [0]),
    .e(rgf_pc[0]),
    .o(_al_u835_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u836 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u690_o),
    .c(rgf_iv_ve),
    .o(_al_u836_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(C)*~((D*B))+A*~(C)*~((D*B))+~(A)*C*~((D*B))+A*~(C)*(D*B)+~(A)*C*(D*B))"),
    .INIT(16'h5b5f))
    _al_u837 (
    .a(_al_u836_o),
    .b(_al_u713_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(\rgf/bank/gr05 [0]),
    .o(_al_u837_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u838 (
    .a(_al_u707_o),
    .b(\rgf/bank/gr01 [0]),
    .o(_al_u838_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~(~D*C)*~(E*B)))"),
    .INIT(32'h44540050))
    _al_u839 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u710_o),
    .c(_al_u838_o),
    .d(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .e(\rgf/bank/gr07 [0]),
    .o(_al_u839_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u840 (
    .a(_al_u710_o),
    .b(\rgf/bank/gr06 [0]),
    .o(_al_u840_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(A)*~((~E*~D*C))+B*A*~((~E*~D*C))+~(B)*A*(~E*~D*C)+B*A*(~E*~D*C))"),
    .INIT(32'hccccccac))
    _al_u841 (
    .a(\ctl/n120_lutinv ),
    .b(\ctl/n121_lutinv ),
    .c(_al_u361_o),
    .d(fch_ir[0]),
    .e(fch_ir[3]),
    .o(_al_u841_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(E*~C)*~(D*~A))"),
    .INIT(32'h20302233))
    _al_u842 (
    .a(_al_u720_o),
    .b(_al_u841_o),
    .c(_al_u376_o),
    .d(fch_ir[0]),
    .e(\fch/eir [0]),
    .o(_al_u842_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~A*~(C*B))"),
    .INIT(16'h1500))
    _al_u843 (
    .a(_al_u839_o),
    .b(\ctl_selb_rn[0]_neg_lutinv ),
    .c(_al_u840_o),
    .d(_al_u842_o),
    .o(_al_u843_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u844 (
    .a(_al_u834_o),
    .b(_al_u835_o),
    .c(_al_u837_o),
    .d(_al_u843_o),
    .o(\alu/art/n4 [0]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u845 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(\rgf/bank/gr05 [7]),
    .o(_al_u845_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(~A*~(D*B)))"),
    .INIT(16'he0a0))
    _al_u846 (
    .a(_al_u845_o),
    .b(_al_u743_o),
    .c(_al_u707_o),
    .d(\rgf/bank/gr03 [7]),
    .o(_al_u846_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*B*~A)"),
    .INIT(32'h00040000))
    _al_u847 (
    .a(\ctl_selb[1]_neg_lutinv ),
    .b(\ctl_selb_rn[0]_neg_lutinv ),
    .c(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .d(\ctl_selb[0]_neg_lutinv ),
    .e(_al_u706_o),
    .o(\rgf/bbus_sel [0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u848 (
    .a(_al_u734_o),
    .b(_al_u707_o),
    .o(\rgf/bbus_sel [1]));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*B))"),
    .INIT(32'h01051155))
    _al_u849 (
    .a(_al_u846_o),
    .b(\rgf/bbus_sel [0]),
    .c(\rgf/bbus_sel [1]),
    .d(\rgf/bank/gr00 [7]),
    .e(\rgf/bank/gr01 [7]),
    .o(_al_u849_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u850 (
    .a(_al_u734_o),
    .b(_al_u726_o),
    .c(rgf_pc[7]),
    .o(\rgf/bbus_pc [7]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u851 (
    .a(\ctl_selb[0]_neg_lutinv ),
    .b(\rgf/bank/gr02 [7]),
    .o(_al_u851_o));
  AL_MAP_LUT5 #(
    .EQN("~((E*B)*~((D*C))*~(A)+(E*B)*(D*C)*~(A)+~((E*B))*(D*C)*A+(E*B)*(D*C)*A)"),
    .INIT(32'h1bbb5fff))
    _al_u852 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u710_o),
    .c(_al_u690_o),
    .d(_al_u851_o),
    .e(\rgf/bank/gr07 [7]),
    .o(_al_u852_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~A*~(E*D*B))"),
    .INIT(32'h10505050))
    _al_u853 (
    .a(\rgf/bbus_pc [7]),
    .b(_al_u687_o),
    .c(_al_u852_o),
    .d(_al_u698_o),
    .e(\rgf/sptr/sp [7]),
    .o(_al_u853_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~(D*C)*~(E*B)))"),
    .INIT(32'ha888a000))
    _al_u854 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u710_o),
    .c(_al_u755_o),
    .d(\rgf/bank/gr04 [7]),
    .e(\rgf/bank/gr06 [7]),
    .o(_al_u854_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u855 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u698_o),
    .c(\rgf/ivec/iv [7]),
    .o(\rgf/bbus_iv [7]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u856 (
    .a(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .b(\ctl_selb[0]_neg_lutinv ),
    .o(_al_u856_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~B*~(E*D*A))"),
    .INIT(32'h01030303))
    _al_u857 (
    .a(_al_u687_o),
    .b(_al_u854_o),
    .c(\rgf/bbus_iv [7]),
    .d(_al_u856_o),
    .e(rgf_sr_flag[3]),
    .o(_al_u857_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u858 (
    .a(fch_ir[0]),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .d(fch_ir[3]),
    .o(_al_u858_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~B*~(C)*~(D)+~B*C*~(D)+~(~B)*C*D+~B*C*D)*~(E*A))"),
    .INIT(32'h05440fcc))
    _al_u859 (
    .a(\ctl/n119_lutinv ),
    .b(_al_u481_o),
    .c(\ctl/n120_lutinv ),
    .d(_al_u858_o),
    .e(fch_ir[6]),
    .o(_al_u859_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*~B)*~(C*~A))"),
    .INIT(16'h8caf))
    _al_u860 (
    .a(_al_u720_o),
    .b(_al_u376_o),
    .c(fch_ir[7]),
    .d(\fch/eir [7]),
    .o(_al_u860_o));
  AL_MAP_LUT5 #(
    .EQN("(D*B*~(E*C*A))"),
    .INIT(32'h4c00cc00))
    _al_u861 (
    .a(_al_u713_o),
    .b(_al_u859_o),
    .c(_al_u726_o),
    .d(_al_u860_o),
    .e(n0[6]),
    .o(_al_u861_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*C*B*A)"),
    .INIT(16'h7fff))
    _al_u862 (
    .a(_al_u849_o),
    .b(_al_u853_o),
    .c(_al_u857_o),
    .d(_al_u861_o),
    .o(bbus[7]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u863 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(\rgf/bank/gr05 [6]),
    .o(_al_u863_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))"),
    .INIT(16'hc480))
    _al_u864 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u690_o),
    .c(\rgf/bank/gr02 [6]),
    .d(\rgf/bank/gr03 [6]),
    .o(_al_u864_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~(E*C)*~(D*~B)))"),
    .INIT(32'ha2a02200))
    _al_u865 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u709_o),
    .d(\rgf/bank/gr00 [6]),
    .e(\rgf/bank/gr06 [6]),
    .o(_al_u865_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~(E*C)*~(D*~B)))"),
    .INIT(32'h51501100))
    _al_u866 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u709_o),
    .d(\rgf/bank/gr01 [6]),
    .e(\rgf/bank/gr07 [6]),
    .o(_al_u866_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~E*~D*~C*~B))"),
    .INIT(32'haaaaaaa8))
    _al_u867 (
    .a(_al_u737_o),
    .b(_al_u863_o),
    .c(_al_u864_o),
    .d(_al_u865_o),
    .e(_al_u866_o),
    .o(_al_u867_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*~A)"),
    .INIT(16'h0040))
    _al_u868 (
    .a(fch_ir[0]),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .d(fch_ir[3]),
    .o(_al_u868_o));
  AL_MAP_LUT5 #(
    .EQN("(~(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E*~A))"),
    .INIT(32'h220a330f))
    _al_u869 (
    .a(_al_u720_o),
    .b(\ctl/n120_lutinv ),
    .c(\ctl/n121_lutinv ),
    .d(_al_u868_o),
    .e(fch_ir[6]),
    .o(_al_u869_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(E*~C)*~(D*A))"),
    .INIT(32'h40c044cc))
    _al_u870 (
    .a(\ctl/n119_lutinv ),
    .b(_al_u869_o),
    .c(_al_u376_o),
    .d(fch_ir[5]),
    .e(\fch/eir [6]),
    .o(_al_u870_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(D*C*A))"),
    .INIT(16'h4ccc))
    _al_u871 (
    .a(_al_u713_o),
    .b(_al_u870_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(n0[5]),
    .o(_al_u871_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u872 (
    .a(_al_u871_o),
    .b(\rgf/bbus_sel [4]),
    .c(\rgf/bank/gr04 [6]),
    .o(_al_u872_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~(D*C)*~(E*~B)))"),
    .INIT(32'ha222a000))
    _al_u873 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u690_o),
    .d(\rgf/sptr/sp [6]),
    .e(rgf_sr_flag[2]),
    .o(_al_u873_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(~(D*C)*~(E*~B)))"),
    .INIT(32'h51115000))
    _al_u874 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u690_o),
    .d(\rgf/ivec/iv [6]),
    .e(rgf_pc[6]),
    .o(_al_u874_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u875 (
    .a(_al_u873_o),
    .b(_al_u874_o),
    .o(_al_u875_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~B*A*~(D*~C)))"),
    .INIT(32'hdfdd0000))
    _al_u876 (
    .a(_al_u872_o),
    .b(_al_u867_o),
    .c(_al_u875_o),
    .d(_al_u816_o),
    .e(ctl_bcmdw),
    .o(bdatw[6]));
  AL_MAP_LUT5 #(
    .EQN("~(B*~A*~(E*~(D)*~(C)+E*D*~(C)+~(E)*D*C+E*D*C))"),
    .INIT(32'hffbffbbb))
    _al_u877 (
    .a(_al_u867_o),
    .b(_al_u871_o),
    .c(\rgf/bbus_sel [4]),
    .d(\rgf/bank/gr04 [6]),
    .e(bdatw[6]),
    .o(bbus[6]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u878 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u710_o),
    .c(\rgf/bank/gr07 [5]),
    .o(\rgf/bank/bbuso/gr7_bus [5]));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*A)"),
    .INIT(16'h0020))
    _al_u879 (
    .a(fch_ir[0]),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .d(fch_ir[3]),
    .o(_al_u879_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~B*~(C)*~(D)+~B*C*~(D)+~(~B)*C*D+~B*C*D)*~(E*A))"),
    .INIT(32'h05440fcc))
    _al_u880 (
    .a(\ctl/n119_lutinv ),
    .b(_al_u481_o),
    .c(\ctl/n120_lutinv ),
    .d(_al_u879_o),
    .e(fch_ir[4]),
    .o(_al_u880_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*~C)*~(D*~B))"),
    .INIT(32'h80a088aa))
    _al_u881 (
    .a(_al_u880_o),
    .b(_al_u720_o),
    .c(_al_u376_o),
    .d(fch_ir[5]),
    .e(\fch/eir [5]),
    .o(_al_u881_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~C*~(E*B*A))"),
    .INIT(32'h07000f00))
    _al_u882 (
    .a(_al_u737_o),
    .b(_al_u747_o),
    .c(\rgf/bank/bbuso/gr7_bus [5]),
    .d(_al_u881_o),
    .e(\rgf/bank/gr06 [5]),
    .o(_al_u882_o));
  AL_MAP_LUT5 #(
    .EQN("~((D*B)*~((E*C))*~(A)+(D*B)*(E*C)*~(A)+~((D*B))*(E*C)*A+(D*B)*(E*C)*A)"),
    .INIT(32'h1b5fbbff))
    _al_u883 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(_al_u690_o),
    .d(n0[4]),
    .e(\rgf/sptr/sp [5]),
    .o(_al_u883_o));
  AL_MAP_LUT5 #(
    .EQN("~((D*C)*~((E*~B))*~(A)+(D*C)*(E*~B)*~(A)+~((D*C))*(E*~B)*A+(D*C)*(E*~B)*A)"),
    .INIT(32'h8dddafff))
    _al_u884 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u690_o),
    .d(\rgf/ivec/iv [5]),
    .e(rgf_sr_flag[1]),
    .o(_al_u884_o));
  AL_MAP_LUT5 #(
    .EQN("(D*B*A*~(E*C))"),
    .INIT(32'h08008800))
    _al_u885 (
    .a(_al_u883_o),
    .b(_al_u884_o),
    .c(_al_u734_o),
    .d(\ctl_selb[0]_neg_lutinv ),
    .e(rgf_pc[5]),
    .o(_al_u885_o));
  AL_MAP_LUT5 #(
    .EQN("~((E*C)*~((D*~B))*~(A)+(E*C)*(D*~B)*~(A)+~((E*C))*(D*~B)*A+(E*C)*(D*~B)*A)"),
    .INIT(32'h8dafddff))
    _al_u886 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u690_o),
    .d(\rgf/bank/gr00 [5]),
    .e(\rgf/bank/gr03 [5]),
    .o(_al_u886_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~D*B*~(E*C)))"),
    .INIT(32'haaa2aa22))
    _al_u887 (
    .a(_al_u815_o),
    .b(_al_u886_o),
    .c(_al_u740_o),
    .d(\ctl_selb[0]_neg_lutinv ),
    .e(\rgf/bank/gr02 [5]),
    .o(_al_u887_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u888 (
    .a(_al_u737_o),
    .b(_al_u729_o),
    .c(\rgf/bank/gr04 [5]),
    .o(\rgf/bank/bbuso/gr4_bus [5]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~(D*B)*~(E*A)))"),
    .INIT(32'he0a0c000))
    _al_u889 (
    .a(_al_u725_o),
    .b(_al_u734_o),
    .c(_al_u707_o),
    .d(\rgf/bank/gr01 [5]),
    .e(\rgf/bank/gr05 [5]),
    .o(_al_u889_o));
  AL_MAP_LUT5 #(
    .EQN("~(~E*~D*A*~(C*~B))"),
    .INIT(32'hffffff75))
    _al_u890 (
    .a(_al_u882_o),
    .b(_al_u885_o),
    .c(_al_u887_o),
    .d(\rgf/bank/bbuso/gr4_bus [5]),
    .e(_al_u889_o),
    .o(bbus[5]));
  AL_MAP_LUT5 #(
    .EQN("(C*((E*B)*~(D)*~(A)+(E*B)*D*~(A)+~((E*B))*D*A+(E*B)*D*A))"),
    .INIT(32'he040a000))
    _al_u891 (
    .a(_al_u740_o),
    .b(_al_u729_o),
    .c(_al_u707_o),
    .d(\rgf/bank/gr02 [4]),
    .e(\rgf/bank/gr04 [4]),
    .o(_al_u891_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*~B)*~(C*~A))"),
    .INIT(16'h8caf))
    _al_u892 (
    .a(_al_u720_o),
    .b(_al_u376_o),
    .c(fch_ir[4]),
    .d(\fch/eir [4]),
    .o(_al_u892_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(D*~B*A))"),
    .INIT(16'hd0f0))
    _al_u893 (
    .a(_al_u743_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .c(_al_u892_o),
    .d(\rgf/bank/gr03 [4]),
    .o(_al_u893_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(C*~(D)*~(A)+C*D*~(A)+~(C)*D*A+C*D*A))"),
    .INIT(16'hc840))
    _al_u894 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u690_o),
    .c(\rgf/ivec/iv [4]),
    .d(\rgf/sptr/sp [4]),
    .o(_al_u894_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u895 (
    .a(fch_ir[0]),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .o(\ctl/n1916_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'hbbbbf033))
    _al_u896 (
    .a(\ctl/n119_lutinv ),
    .b(_al_u481_o),
    .c(\ctl/n120_lutinv ),
    .d(\ctl/n1916_lutinv ),
    .e(fch_ir[3]),
    .o(_al_u896_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*B*~A*~(E*C))"),
    .INIT(32'h00040044))
    _al_u897 (
    .a(_al_u891_o),
    .b(_al_u893_o),
    .c(_al_u894_o),
    .d(_al_u896_o),
    .e(_al_u447_o),
    .o(_al_u897_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B*~A))"),
    .INIT(8'hb0))
    _al_u898 (
    .a(_al_u547_o),
    .b(_al_u686_o),
    .c(rgf_sr_flag[0]),
    .o(_al_u898_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B*A))"),
    .INIT(8'h70))
    _al_u899 (
    .a(_al_u686_o),
    .b(_al_u700_o),
    .c(\rgf/bank/gr00 [4]),
    .o(_al_u899_o));
  AL_MAP_LUT4 #(
    .EQN("(C*(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'hc0a0))
    _al_u900 (
    .a(_al_u898_o),
    .b(_al_u899_o),
    .c(_al_u704_o),
    .d(_al_u707_o),
    .o(_al_u900_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u901 (
    .a(_al_u734_o),
    .b(_al_u707_o),
    .c(\rgf/bank/gr01 [4]),
    .o(\rgf/bank/bbuso/gr1_bus [4]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u902 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(\rgf/bank/gr05 [4]),
    .o(_al_u902_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*~(D*C))"),
    .INIT(16'h0111))
    _al_u903 (
    .a(_al_u900_o),
    .b(\rgf/bank/bbuso/gr1_bus [4]),
    .c(_al_u737_o),
    .d(_al_u902_o),
    .o(_al_u903_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u904 (
    .a(_al_u713_o),
    .b(_al_u726_o),
    .c(n0[3]),
    .o(\rgf/sptr/bbus2 [4]));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u905 (
    .a(\rgf/sptr/bbus2 [4]),
    .b(_al_u742_o),
    .c(_al_u707_o),
    .d(\rgf/bank/gr07 [4]),
    .o(_al_u905_o));
  AL_MAP_LUT5 #(
    .EQN("~((E*C)*~((D*B))*~(A)+(E*C)*(D*B)*~(A)+~((E*C))*(D*B)*A+(E*C)*(D*B)*A)"),
    .INIT(32'h27af77ff))
    _al_u906 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u710_o),
    .c(_al_u856_o),
    .d(\rgf/bank/gr06 [4]),
    .e(rgf_pc[4]),
    .o(_al_u906_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*C*B*A)"),
    .INIT(16'h7fff))
    _al_u907 (
    .a(_al_u897_o),
    .b(_al_u903_o),
    .c(_al_u905_o),
    .d(_al_u906_o),
    .o(bbus[4]));
  AL_MAP_LUT5 #(
    .EQN("(~(E*B)*~(D*C*A))"),
    .INIT(32'h13335fff))
    _al_u908 (
    .a(_al_u737_o),
    .b(\rgf/bbus_sel [7]),
    .c(_al_u740_o),
    .d(\rgf/bank/gr02 [3]),
    .e(\rgf/bank/gr07 [3]),
    .o(_al_u908_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u909 (
    .a(\ctl_selb[1]_neg_lutinv ),
    .b(_al_u704_o),
    .c(_al_u726_o),
    .d(rgf_sr_ie[1]),
    .o(\rgf/bbus_sr [3]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u910 (
    .a(\ctl_selb[1]_neg_lutinv ),
    .b(_al_u704_o),
    .c(_al_u707_o),
    .d(\rgf/bank/gr00 [3]),
    .o(\rgf/bank/bbuso/gr0_bus [3]));
  AL_MAP_LUT4 #(
    .EQN("(~(D*~B)*~(C*~A))"),
    .INIT(16'h8caf))
    _al_u911 (
    .a(_al_u720_o),
    .b(_al_u376_o),
    .c(fch_ir[3]),
    .d(\fch/eir [3]),
    .o(_al_u911_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~(E*~C*B*~A))"),
    .INIT(32'hfb00ff00))
    _al_u912 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u690_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(_al_u911_o),
    .e(\rgf/bank/gr03 [3]),
    .o(_al_u912_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*A)"),
    .INIT(16'h0200))
    _al_u913 (
    .a(_al_u908_o),
    .b(\rgf/bbus_sr [3]),
    .c(\rgf/bank/bbuso/gr0_bus [3]),
    .d(_al_u912_o),
    .o(_al_u913_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*~A)"),
    .INIT(16'h4000))
    _al_u914 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(_al_u726_o),
    .d(n0[2]),
    .o(\rgf/sptr/bbus2 [3]));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*~B))"),
    .INIT(16'h4555))
    _al_u915 (
    .a(\rgf/sptr/bbus2 [3]),
    .b(\ctl_selb_rn[0]_neg_lutinv ),
    .c(_al_u698_o),
    .d(\rgf/ivec/iv [3]),
    .o(_al_u915_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    _al_u916 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u707_o),
    .d(\rgf/bank/gr01 [3]),
    .o(\rgf/bank/bbuso/gr1_bus [3]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u917 (
    .a(fch_ir[0]),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .d(fch_ir[3]),
    .o(_al_u917_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~B*~(C)*~(D)+~B*C*~(D)+~(~B)*C*D+~B*C*D)*~(E*A))"),
    .INIT(32'h05440fcc))
    _al_u918 (
    .a(\ctl/n119_lutinv ),
    .b(_al_u481_o),
    .c(\ctl/n120_lutinv ),
    .d(_al_u917_o),
    .e(fch_ir[2]),
    .o(_al_u918_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u919 (
    .a(_al_u740_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .o(\rgf/bbus_sel_cr [2]));
  AL_MAP_LUT5 #(
    .EQN("(C*~B*A*~(E*D))"),
    .INIT(32'h00202020))
    _al_u920 (
    .a(_al_u915_o),
    .b(\rgf/bank/bbuso/gr1_bus [3]),
    .c(_al_u918_o),
    .d(\rgf/sptr/sp [3]),
    .e(\rgf/bbus_sel_cr [2]),
    .o(_al_u920_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~(E*C)*~(D*B)))"),
    .INIT(32'ha8a08800))
    _al_u921 (
    .a(_al_u737_o),
    .b(_al_u740_o),
    .c(_al_u729_o),
    .d(\rgf/bank/gr02 [3]),
    .e(\rgf/bank/gr04 [3]),
    .o(_al_u921_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(D*C*B))"),
    .INIT(16'h1555))
    _al_u922 (
    .a(_al_u921_o),
    .b(_al_u737_o),
    .c(_al_u713_o),
    .d(\rgf/bank/gr05 [3]),
    .o(_al_u922_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(D*B*A))"),
    .INIT(16'h070f))
    _al_u923 (
    .a(_al_u737_o),
    .b(_al_u747_o),
    .c(\rgf/bank/bbuso/gr1_bus [3]),
    .d(\rgf/bank/gr06 [3]),
    .o(_al_u923_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(D*C)*~(E*B))"),
    .INIT(32'h02220aaa))
    _al_u924 (
    .a(_al_u923_o),
    .b(\rgf/bbus_sel_cr [2]),
    .c(\rgf/bbus_sel_cr [1]),
    .d(rgf_pc[3]),
    .e(\rgf/sptr/sp [3]),
    .o(_al_u924_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u925 (
    .a(_al_u913_o),
    .b(_al_u920_o),
    .c(_al_u922_o),
    .d(_al_u924_o),
    .o(\alu/art/n4 [3]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*~A)"),
    .INIT(16'h0004))
    _al_u926 (
    .a(fch_ir[0]),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .d(fch_ir[3]),
    .o(_al_u926_o));
  AL_MAP_LUT5 #(
    .EQN("(~(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E*~A))"),
    .INIT(32'h220a330f))
    _al_u927 (
    .a(_al_u720_o),
    .b(\ctl/n120_lutinv ),
    .c(\ctl/n121_lutinv ),
    .d(_al_u926_o),
    .e(fch_ir[2]),
    .o(_al_u927_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(E*~C)*~(D*A))"),
    .INIT(32'h40c044cc))
    _al_u928 (
    .a(\ctl/n119_lutinv ),
    .b(_al_u927_o),
    .c(_al_u376_o),
    .d(fch_ir[1]),
    .e(\fch/eir [2]),
    .o(_al_u928_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(D*C*A))"),
    .INIT(16'h4ccc))
    _al_u929 (
    .a(_al_u743_o),
    .b(_al_u928_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(\rgf/ivec/iv [2]),
    .o(_al_u929_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(D*C*B))"),
    .INIT(16'h2aaa))
    _al_u930 (
    .a(_al_u929_o),
    .b(_al_u737_o),
    .c(_al_u747_o),
    .d(\rgf/bank/gr06 [2]),
    .o(_al_u930_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u931 (
    .a(_al_u734_o),
    .b(\rgf/bank/gr01 [2]),
    .o(_al_u931_o));
  AL_MAP_LUT5 #(
    .EQN("~((D*C)*~((E*B))*~(A)+(D*C)*(E*B)*~(A)+~((D*C))*(E*B)*A+(D*C)*(E*B)*A)"),
    .INIT(32'h2777afff))
    _al_u932 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(_al_u690_o),
    .d(\rgf/bank/gr03 [2]),
    .e(\rgf/bank/gr04 [2]),
    .o(_al_u932_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(D*~A*~(E*C)))"),
    .INIT(32'hc8cc88cc))
    _al_u933 (
    .a(_al_u931_o),
    .b(_al_u737_o),
    .c(_al_u742_o),
    .d(_al_u932_o),
    .e(\rgf/bank/gr07 [2]),
    .o(_al_u933_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(D*~B*A))"),
    .INIT(16'h0d0f))
    _al_u934 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(\rgf/bank/gr00 [2]),
    .o(_al_u934_o));
  AL_MAP_LUT5 #(
    .EQN("~((E*B)*~((D*C))*~(A)+(E*B)*(D*C)*~(A)+~((E*B))*(D*C)*A+(E*B)*(D*C)*A)"),
    .INIT(32'h1bbb5fff))
    _al_u935 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(_al_u690_o),
    .d(\rgf/bank/gr02 [2]),
    .e(\rgf/bank/gr05 [2]),
    .o(_al_u935_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u936 (
    .a(_al_u815_o),
    .b(_al_u934_o),
    .c(_al_u935_o),
    .o(_al_u936_o));
  AL_MAP_LUT5 #(
    .EQN("~((D*B)*~((E*~C))*~(A)+(D*B)*(E*~C)*~(A)+~((D*B))*(E*~C)*A+(D*B)*(E*~C)*A)"),
    .INIT(32'hb1f5bbff))
    _al_u937 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .d(n0[1]),
    .e(rgf_sr_ie[0]),
    .o(_al_u937_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u938 (
    .a(_al_u937_o),
    .b(_al_u734_o),
    .c(rgf_pc[2]),
    .o(_al_u938_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u939 (
    .a(_al_u740_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .c(\rgf/sptr/sp [2]),
    .o(_al_u939_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*A*~(C*~(E*D)))"),
    .INIT(32'h22020202))
    _al_u940 (
    .a(_al_u930_o),
    .b(_al_u933_o),
    .c(_al_u936_o),
    .d(_al_u938_o),
    .e(_al_u939_o),
    .o(\alu/art/n4 [2]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*A)"),
    .INIT(16'h2000))
    _al_u941 (
    .a(fch_ir[0]),
    .b(fch_ir[1]),
    .c(fch_ir[2]),
    .d(fch_ir[3]),
    .o(_al_u941_o));
  AL_MAP_LUT5 #(
    .EQN("(~(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E*~A))"),
    .INIT(32'h220a330f))
    _al_u942 (
    .a(_al_u376_o),
    .b(\ctl/n120_lutinv ),
    .c(\ctl/n121_lutinv ),
    .d(_al_u941_o),
    .e(\fch/eir [13]),
    .o(_al_u942_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u943 (
    .a(_al_u760_o),
    .b(_al_u942_o),
    .o(_al_u943_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(D*B)*~(E*A))"),
    .INIT(32'h105030f0))
    _al_u944 (
    .a(\rgf/bbus_sel_cr [2]),
    .b(_al_u811_o),
    .c(_al_u943_o),
    .d(\rgf/bank/gr07 [13]),
    .e(\rgf/sptr/sp [13]),
    .o(_al_u944_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u945 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u690_o),
    .c(\rgf/bank/gr02 [13]),
    .o(_al_u945_o));
  AL_MAP_LUT5 #(
    .EQN("~((D*C)*~((E*B))*~(A)+(D*C)*(E*B)*~(A)+~((D*C))*(E*B)*A+(D*C)*(E*B)*A)"),
    .INIT(32'h2777afff))
    _al_u946 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(_al_u690_o),
    .d(\rgf/bank/gr03 [13]),
    .e(\rgf/bank/gr04 [13]),
    .o(_al_u946_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*(D*~(C)*~(A)+D*C*~(A)+~(D)*C*A+D*C*A))"),
    .INIT(16'h3120))
    _al_u947 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(\rgf/bank/gr00 [13]),
    .d(\rgf/bank/gr01 [13]),
    .o(_al_u947_o));
  AL_MAP_LUT5 #(
    .EQN("~((D*B)*~((E*C))*~(A)+(D*B)*(E*C)*~(A)+~((D*B))*(E*C)*A+(D*B)*(E*C)*A)"),
    .INIT(32'h1b5fbbff))
    _al_u948 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(_al_u709_o),
    .d(\rgf/bank/gr05 [13]),
    .e(\rgf/bank/gr06 [13]),
    .o(_al_u948_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*~D*C*~B))"),
    .INIT(32'haa8aaaaa))
    _al_u949 (
    .a(_al_u737_o),
    .b(_al_u945_o),
    .c(_al_u946_o),
    .d(_al_u947_o),
    .e(_al_u948_o),
    .o(\rgf/bank/bbuso/n13 [13]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u950 (
    .a(_al_u734_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .c(rgf_pc[13]),
    .o(\rgf/bbus_pc [13]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u951 (
    .a(_al_u713_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .c(n0[12]),
    .o(\rgf/sptr/bbus2 [13]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u952 (
    .a(_al_u743_o),
    .b(\ctl_selb[0]_neg_lutinv ),
    .c(\rgf/ivec/iv [13]),
    .o(\rgf/bbus_iv [13]));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u953 (
    .a(_al_u815_o),
    .b(_al_u704_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(\rgf/sreg/sr [13]),
    .o(\rgf/bbus_sr [13]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u954 (
    .a(\rgf/bbus_pc [13]),
    .b(\rgf/sptr/bbus2 [13]),
    .c(\rgf/bbus_iv [13]),
    .d(\rgf/bbus_sr [13]),
    .o(_al_u954_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~B*A)"),
    .INIT(8'hdf))
    _al_u955 (
    .a(_al_u944_o),
    .b(\rgf/bank/bbuso/n13 [13]),
    .c(_al_u954_o),
    .o(bbus[13]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u956 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(\rgf/bank/gr05 [12]),
    .o(_al_u956_o));
  AL_MAP_LUT5 #(
    .EQN("~((D*~C)*~((E*B))*~(A)+(D*~C)*(E*B)*~(A)+~((D*~C))*(E*B)*A+(D*~C)*(E*B)*A)"),
    .INIT(32'h7277faff))
    _al_u957 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .d(\rgf/bank/gr01 [12]),
    .e(\rgf/bank/gr04 [12]),
    .o(_al_u957_o));
  AL_MAP_LUT5 #(
    .EQN("~((D*B)*~((E*C))*~(A)+(D*B)*(E*C)*~(A)+~((D*B))*(E*C)*A+(D*B)*(E*C)*A)"),
    .INIT(32'h1b5fbbff))
    _al_u958 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u690_o),
    .c(_al_u709_o),
    .d(\rgf/bank/gr03 [12]),
    .e(\rgf/bank/gr06 [12]),
    .o(_al_u958_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~(E*C)*~(D*~B)))"),
    .INIT(32'ha2a02200))
    _al_u959 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u690_o),
    .d(\rgf/bank/gr00 [12]),
    .e(\rgf/bank/gr02 [12]),
    .o(_al_u959_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~E*D*C*~B))"),
    .INIT(32'haaaa8aaa))
    _al_u960 (
    .a(_al_u737_o),
    .b(_al_u956_o),
    .c(_al_u957_o),
    .d(_al_u958_o),
    .e(_al_u959_o),
    .o(\rgf/bank/bbuso/n13 [12]));
  AL_MAP_LUT5 #(
    .EQN("~((D*B)*~((E*~C))*~(A)+(D*B)*(E*~C)*~(A)+~((D*B))*(E*~C)*A+(D*B)*(E*~C)*A)"),
    .INIT(32'hb1f5bbff))
    _al_u961 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u712_o),
    .c(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .d(n0[11]),
    .e(\rgf/sreg/sr [12]),
    .o(_al_u961_o));
  AL_MAP_LUT5 #(
    .EQN("~((D*~B)*~((E*C))*~(A)+(D*~B)*(E*C)*~(A)+~((D*~B))*(E*C)*A+(D*~B)*(E*C)*A)"),
    .INIT(32'h4e5feeff))
    _al_u962 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(\rgf/rctl/eq31/or_xor_i0[1]_i1[1]_o_o_lutinv ),
    .c(_al_u690_o),
    .d(rgf_pc[12]),
    .e(\rgf/sptr/sp [12]),
    .o(_al_u962_o));
  AL_MAP_LUT4 #(
    .EQN("(B*A*~(D*C))"),
    .INIT(16'h0888))
    _al_u963 (
    .a(_al_u961_o),
    .b(_al_u962_o),
    .c(_al_u743_o),
    .d(\rgf/ivec/iv [12]),
    .o(_al_u963_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u964 (
    .a(\ctl/n1916_lutinv ),
    .b(fch_ir[3]),
    .o(_al_u964_o));
  AL_MAP_LUT5 #(
    .EQN("(~(C*~(B)*~(D)+C*B*~(D)+~(C)*B*D+C*B*D)*~(E*~A))"),
    .INIT(32'h220a330f))
    _al_u965 (
    .a(_al_u376_o),
    .b(\ctl/n120_lutinv ),
    .c(\ctl/n121_lutinv ),
    .d(_al_u964_o),
    .e(\fch/eir [12]),
    .o(_al_u965_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~B*~(D*A))"),
    .INIT(16'h1030))
    _al_u966 (
    .a(_al_u811_o),
    .b(_al_u760_o),
    .c(_al_u965_o),
    .d(\rgf/bank/gr07 [12]),
    .o(_al_u966_o));
  AL_MAP_LUT4 #(
    .EQN("~(D*~A*~(C*~B))"),
    .INIT(16'hbaff))
    _al_u967 (
    .a(\rgf/bank/bbuso/n13 [12]),
    .b(_al_u963_o),
    .c(_al_u816_o),
    .d(_al_u966_o),
    .o(bbus[12]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u968 (
    .a(\alu/art/n4 [1]),
    .b(_al_u510_o),
    .o(\alu/mul/inb [1]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u969 (
    .a(\alu/art/n4 [0]),
    .b(_al_u510_o),
    .o(\alu/mul/inb [0]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u970 (
    .a(bbus[7]),
    .b(_al_u510_o),
    .o(\alu/mul/inb [7]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u971 (
    .a(bbus[7]),
    .b(_al_u507_o),
    .o(\alu/mul/inb [10]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u972 (
    .a(bbus[6]),
    .b(_al_u510_o),
    .o(\alu/mul/inb [6]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u973 (
    .a(bbus[5]),
    .b(_al_u510_o),
    .o(\alu/mul/inb [5]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u974 (
    .a(bbus[4]),
    .b(_al_u510_o),
    .o(\alu/mul/inb [4]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u975 (
    .a(\alu/art/n4 [3]),
    .b(_al_u510_o),
    .o(\alu/mul/inb [3]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u976 (
    .a(\alu/art/n4 [2]),
    .b(_al_u510_o),
    .o(\alu/mul/inb [2]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u977 (
    .a(ctl_bcmdw),
    .b(ctl_bcmdb),
    .o(\mem/bwbf/n1 ));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~B)*~(C*A))"),
    .INIT(16'hb3a0))
    _al_u978 (
    .a(bbus[9]),
    .b(\alu/art/n4 [1]),
    .c(\mem/bwbf/n1 ),
    .d(\mem/bwbf/n2 ),
    .o(bdatw[9]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u979 (
    .a(ctl_bcmdw),
    .b(\alu/art/n4 [1]),
    .o(bdatw[1]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u980 (
    .a(\alu/sft/n31_lutinv ),
    .b(\alu/log/eq3/or_xor_i0[3]_i1[3]_o_o_lutinv ),
    .o(_al_u980_o));
  AL_MAP_LUT4 #(
    .EQN("(D*(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C))"),
    .INIT(16'hca00))
    _al_u981 (
    .a(_al_u515_o),
    .b(_al_u980_o),
    .c(\alu/sft/n30_lutinv ),
    .d(\alu/sft/n36_lutinv ),
    .o(\alu/art/n2_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u982 (
    .a(\alu/art/n4 [1]),
    .b(\alu/art/n2_lutinv ),
    .o(\alu/art/inb [1]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D*C*B*A))"),
    .INIT(32'h7fff0000))
    _al_u983 (
    .a(_al_u834_o),
    .b(_al_u835_o),
    .c(_al_u837_o),
    .d(_al_u843_o),
    .e(ctl_bcmdw),
    .o(bdatw[0]));
  AL_MAP_LUT5 #(
    .EQN("~(~E*~((C*B*A))*~(D)+~E*(C*B*A)*~(D)+~(~E)*(C*B*A)*D+~E*(C*B*A)*D)"),
    .INIT(32'h7fff7f00))
    _al_u984 (
    .a(_al_u746_o),
    .b(_al_u757_o),
    .c(_al_u741_o),
    .d(\mem/bwbf/n1 ),
    .e(bdatw[0]),
    .o(bdatw[8]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u985 (
    .a(\alu/art/n4 [0]),
    .b(\alu/art/n2_lutinv ),
    .o(\alu/art/inb [0]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D*C*B*A))"),
    .INIT(32'h7fff0000))
    _al_u986 (
    .a(_al_u849_o),
    .b(_al_u853_o),
    .c(_al_u857_o),
    .d(_al_u861_o),
    .e(ctl_bcmdw),
    .o(bdatw[7]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u987 (
    .a(bbus[7]),
    .b(bbus[15]),
    .c(\mem/bwbf/n1 ),
    .d(\mem/bwbf/n2 ),
    .o(bdatw[15]));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u988 (
    .a(bbus[7]),
    .b(\alu/art/n2_lutinv ),
    .o(\alu/art/inb [7]));
  AL_MAP_LUT4 #(
    .EQN("(B*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))"),
    .INIT(16'h8c80))
    _al_u989 (
    .a(bbus[6]),
    .b(ctl_bcmdw),
    .c(ctl_bcmdb),
    .d(bbus[14]),
    .o(bdatw[14]));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u990 (
    .a(bbus[6]),
    .b(\alu/art/n2_lutinv ),
    .o(\alu/art/inb [6]));
  AL_MAP_LUT4 #(
    .EQN("(~C*A*~(D*B))"),
    .INIT(16'h020a))
    _al_u991 (
    .a(_al_u886_o),
    .b(_al_u740_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(\rgf/bank/gr02 [5]),
    .o(_al_u991_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u992 (
    .a(_al_u991_o),
    .b(_al_u885_o),
    .o(_al_u992_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~D*~C*B*~A))"),
    .INIT(32'hfffb0000))
    _al_u993 (
    .a(_al_u992_o),
    .b(_al_u882_o),
    .c(\rgf/bank/bbuso/gr4_bus [5]),
    .d(_al_u889_o),
    .e(ctl_bcmdw),
    .o(bdatw[5]));
  AL_MAP_LUT5 #(
    .EQN("~(~E*~((~C*B*A))*~(D)+~E*(~C*B*A)*~(D)+~(~E)*(~C*B*A)*D+~E*(~C*B*A)*D)"),
    .INIT(32'hf7fff700))
    _al_u994 (
    .a(_al_u954_o),
    .b(_al_u944_o),
    .c(\rgf/bank/bbuso/n13 [13]),
    .d(\mem/bwbf/n1 ),
    .e(bdatw[5]),
    .o(bdatw[13]));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u995 (
    .a(bbus[5]),
    .b(\alu/art/n2_lutinv ),
    .o(\alu/art/inb [5]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D*C*B*A))"),
    .INIT(32'h7fff0000))
    _al_u996 (
    .a(_al_u897_o),
    .b(_al_u903_o),
    .c(_al_u905_o),
    .d(_al_u906_o),
    .e(ctl_bcmdw),
    .o(bdatw[4]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u997 (
    .a(bbus[4]),
    .b(bbus[12]),
    .c(\mem/bwbf/n1 ),
    .d(\mem/bwbf/n2 ),
    .o(bdatw[12]));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u998 (
    .a(bbus[4]),
    .b(\alu/art/n2_lutinv ),
    .o(\alu/art/inb [4]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    _al_u999 (
    .a(\ctl_selb_rn[0]_neg_lutinv ),
    .b(_al_u690_o),
    .c(\ctl_selb[0]_neg_lutinv ),
    .d(\rgf/bank/gr03 [3]),
    .o(\rgf/bank/bbuso/gr3_bus [3]));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add/add0_2/u0  (
    .a(abus[0]),
    .b(\alu/art/inb [0]),
    .c(\alu/art/add/add0_2/c0 ),
    .o({\alu/art/add/add0_2/c1 ,\alu/art/out [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add/add0_2/u1  (
    .a(abus[1]),
    .b(\alu/art/inb [1]),
    .c(\alu/art/add/add0_2/c1 ),
    .o({\alu/art/add/add0_2/c2 ,\alu/art/out [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add/add0_2/u2  (
    .a(abus[2]),
    .b(\alu/art/inb [2]),
    .c(\alu/art/add/add0_2/c2 ),
    .o({\alu/art/add/add0_2/c3 ,\alu/art/out [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add/add0_2/u3  (
    .a(abus[3]),
    .b(\alu/art/inb [3]),
    .c(\alu/art/add/add0_2/c3 ),
    .o({\alu/art/add/add0_2/c4 ,\alu/art/out [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add/add0_2/u4  (
    .a(abus[4]),
    .b(\alu/art/inb [4]),
    .c(\alu/art/add/add0_2/c4 ),
    .o({\alu/art/add/add0_2/c5 ,\alu/art/out [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add/add0_2/u5  (
    .a(abus[5]),
    .b(\alu/art/inb [5]),
    .c(\alu/art/add/add0_2/c5 ),
    .o({\alu/art/add/add0_2/c6 ,\alu/art/out [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add/add0_2/u6  (
    .a(abus[6]),
    .b(\alu/art/inb [6]),
    .c(\alu/art/add/add0_2/c6 ),
    .o({\alu/art/add/add0_2/c7 ,\alu/art/out [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add/add0_2/u7  (
    .a(abus[7]),
    .b(\alu/art/inb [7]),
    .c(\alu/art/add/add0_2/c7 ),
    .o({\alu/art/add/add0_2/c8 ,\alu/art/alu_sr_flag_add [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add/add0_2/u8  (
    .a(abus[7]),
    .b(\alu/art/inb [7]),
    .c(\alu/art/add/add0_2/c8 ),
    .o({\alu/art/add/add0_2/c9 ,open_n0}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \alu/art/add/add0_2/ucin  (
    .a(\alu/art/cin ),
    .o({\alu/art/add/add0_2/c0 ,open_n3}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add/add0_2/ucout  (
    .c(\alu/art/add/add0_2/c9 ),
    .o({open_n6,\alu/art/alu_sr_flag_ihz [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u0  (
    .a(abus[0]),
    .b(bbus[0]),
    .c(\alu/art/add0/c0 ),
    .o({\alu/art/add0/c1 ,\alu/art/n13 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u1  (
    .a(abus[1]),
    .b(bbus[1]),
    .c(\alu/art/add0/c1 ),
    .o({\alu/art/add0/c2 ,\alu/art/n13 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u10  (
    .a(abus[10]),
    .b(bbus[10]),
    .c(\alu/art/add0/c10 ),
    .o({\alu/art/add0/c11 ,\alu/art/n13 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u11  (
    .a(abus[11]),
    .b(bbus[11]),
    .c(\alu/art/add0/c11 ),
    .o({\alu/art/add0/c12 ,\alu/art/n13 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u12  (
    .a(abus[12]),
    .b(bbus[12]),
    .c(\alu/art/add0/c12 ),
    .o({\alu/art/add0/c13 ,\alu/art/n13 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u13  (
    .a(abus[13]),
    .b(bbus[13]),
    .c(\alu/art/add0/c13 ),
    .o({\alu/art/add0/c14 ,\alu/art/n13 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u14  (
    .a(abus[14]),
    .b(bbus[14]),
    .c(\alu/art/add0/c14 ),
    .o({\alu/art/add0/c15 ,\alu/art/n13 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u15  (
    .a(abus[15]),
    .b(bbus[15]),
    .c(\alu/art/add0/c15 ),
    .o({open_n7,\alu/art/n13 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u2  (
    .a(abus[2]),
    .b(bbus[2]),
    .c(\alu/art/add0/c2 ),
    .o({\alu/art/add0/c3 ,\alu/art/n13 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u3  (
    .a(abus[3]),
    .b(bbus[3]),
    .c(\alu/art/add0/c3 ),
    .o({\alu/art/add0/c4 ,\alu/art/n13 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u4  (
    .a(abus[4]),
    .b(bbus[4]),
    .c(\alu/art/add0/c4 ),
    .o({\alu/art/add0/c5 ,\alu/art/n13 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u5  (
    .a(abus[5]),
    .b(bbus[5]),
    .c(\alu/art/add0/c5 ),
    .o({\alu/art/add0/c6 ,\alu/art/n13 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u6  (
    .a(abus[6]),
    .b(bbus[6]),
    .c(\alu/art/add0/c6 ),
    .o({\alu/art/add0/c7 ,\alu/art/n13 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u7  (
    .a(abus[7]),
    .b(bbus[7]),
    .c(\alu/art/add0/c7 ),
    .o({\alu/art/add0/c8 ,\alu/art/n13 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u8  (
    .a(abus[8]),
    .b(bbus[8]),
    .c(\alu/art/add0/c8 ),
    .o({\alu/art/add0/c9 ,\alu/art/n13 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/art/add0/u9  (
    .a(abus[9]),
    .b(bbus[9]),
    .c(\alu/art/add0/c9 ),
    .o({\alu/art/add0/c10 ,\alu/art/n13 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \alu/art/add0/ucin  (
    .a(1'b0),
    .o({\alu/art/add0/c0 ,open_n10}));
  EG_PHY_MULT18 #(
    .INPUTREGA("DISABLE"),
    .INPUTREGB("DISABLE"),
    .MODE("MULT18X18C"),
    .OUTPUTREG("DISABLE"),
    .SIGNEDAMUX("0"),
    .SIGNEDBMUX("0"))
    \alu/mul/mult0_  (
    .a({2'b00,\alu/mul/ina [10],\alu/mul/ina [10],\alu/mul/ina [10],\alu/mul/ina [10],\alu/mul/ina [10],\alu/mul/ina [10],\alu/mul/ina [10],\alu/mul/ina [10],\alu/mul/ina [7:0]}),
    .b({2'b00,\alu/mul/inb [10],\alu/mul/inb [10],\alu/mul/inb [10],\alu/mul/inb [10],\alu/mul/inb [10],\alu/mul/inb [10],\alu/mul/inb [10],\alu/mul/inb [10],\alu/mul/inb [7:0]}),
    .p({open_n94,open_n95,open_n96,open_n97,open_n98,open_n99,open_n100,open_n101,open_n102,open_n103,open_n104,open_n105,open_n106,open_n107,open_n108,open_n109,open_n110,open_n111,open_n112,open_n113,\alu/mul/out [15:0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/sft/add0/u0  (
    .a(\alu/art/n4 [0]),
    .b(1'b1),
    .c(\alu/sft/add0/c0 ),
    .o({\alu/sft/add0/c1 ,\alu/sft/n27 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/sft/add0/u1  (
    .a(\alu/art/n4 [1]),
    .b(1'b0),
    .c(\alu/sft/add0/c1 ),
    .o({\alu/sft/add0/c2 ,\alu/sft/n27 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/sft/add0/u2  (
    .a(\alu/art/n4 [2]),
    .b(1'b0),
    .c(\alu/sft/add0/c2 ),
    .o({\alu/sft/add0/c3 ,\alu/sft/n27 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \alu/sft/add0/u3  (
    .a(\alu/art/n4 [3]),
    .b(1'b0),
    .c(\alu/sft/add0/c3 ),
    .o({open_n114,\alu/sft/n27 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \alu/sft/add0/ucin  (
    .a(1'b0),
    .o({\alu/sft/add0/c0 ,open_n117}));
  reg_sr_as_w1 \ctl/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\ctl/mux4_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\ctl/stat [0]));  // rtl/tnsn_fsm.v(315)
  reg_sr_as_w1 \ctl/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\ctl/mux4_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\ctl/stat [1]));  // rtl/tnsn_fsm.v(315)
  reg_sr_as_w1 \ctl/reg0_b2  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\ctl/mux4_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\ctl/stat [2]));  // rtl/tnsn_fsm.v(315)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u0  (
    .a(rgf_pc[1]),
    .b(1'b1),
    .c(\fch/add0/c0 ),
    .o({\fch/add0/c1 ,\fch/n12 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u1  (
    .a(rgf_pc[2]),
    .b(1'b0),
    .c(\fch/add0/c1 ),
    .o({\fch/add0/c2 ,\fch/n12 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u10  (
    .a(rgf_pc[11]),
    .b(1'b0),
    .c(\fch/add0/c10 ),
    .o({\fch/add0/c11 ,\fch/n12 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u11  (
    .a(rgf_pc[12]),
    .b(1'b0),
    .c(\fch/add0/c11 ),
    .o({\fch/add0/c12 ,\fch/n12 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u12  (
    .a(rgf_pc[13]),
    .b(1'b0),
    .c(\fch/add0/c12 ),
    .o({\fch/add0/c13 ,\fch/n12 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u13  (
    .a(rgf_pc[14]),
    .b(1'b0),
    .c(\fch/add0/c13 ),
    .o({\fch/add0/c14 ,\fch/n12 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u14  (
    .a(rgf_pc[15]),
    .b(1'b0),
    .c(\fch/add0/c14 ),
    .o({open_n118,\fch/n12 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u2  (
    .a(rgf_pc[3]),
    .b(1'b0),
    .c(\fch/add0/c2 ),
    .o({\fch/add0/c3 ,\fch/n12 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u3  (
    .a(rgf_pc[4]),
    .b(1'b0),
    .c(\fch/add0/c3 ),
    .o({\fch/add0/c4 ,\fch/n12 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u4  (
    .a(rgf_pc[5]),
    .b(1'b0),
    .c(\fch/add0/c4 ),
    .o({\fch/add0/c5 ,\fch/n12 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u5  (
    .a(rgf_pc[6]),
    .b(1'b0),
    .c(\fch/add0/c5 ),
    .o({\fch/add0/c6 ,\fch/n12 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u6  (
    .a(rgf_pc[7]),
    .b(1'b0),
    .c(\fch/add0/c6 ),
    .o({\fch/add0/c7 ,\fch/n12 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u7  (
    .a(rgf_pc[8]),
    .b(1'b0),
    .c(\fch/add0/c7 ),
    .o({\fch/add0/c8 ,\fch/n12 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u8  (
    .a(rgf_pc[9]),
    .b(1'b0),
    .c(\fch/add0/c8 ),
    .o({\fch/add0/c9 ,\fch/n12 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fch/add0/u9  (
    .a(rgf_pc[10]),
    .b(1'b0),
    .c(\fch/add0/c9 ),
    .o({\fch/add0/c10 ,\fch/n12 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \fch/add0/ucin  (
    .a(1'b0),
    .o({\fch/add0/c0 ,open_n121}));
  reg_sr_as_w1 \fch/reg0_b0  (
    .clk(clk),
    .d(\fch/n4 [0]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[0]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b1  (
    .clk(clk),
    .d(\fch/n4 [1]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[1]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b10  (
    .clk(clk),
    .d(\fch/n4 [10]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[10]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b11  (
    .clk(clk),
    .d(\fch/n4 [11]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[11]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b12  (
    .clk(clk),
    .d(\fch/n4 [12]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[12]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b13  (
    .clk(clk),
    .d(\fch/n4 [13]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[13]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b14  (
    .clk(clk),
    .d(\fch/n4 [14]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[14]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b15  (
    .clk(clk),
    .d(\fch/n4 [15]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[15]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b2  (
    .clk(clk),
    .d(\fch/n4 [2]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[2]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b3  (
    .clk(clk),
    .d(\fch/n4 [3]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[3]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b4  (
    .clk(clk),
    .d(\fch/n4 [4]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[4]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b5  (
    .clk(clk),
    .d(\fch/n4 [5]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[5]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b6  (
    .clk(clk),
    .d(\fch/n4 [6]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[6]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b7  (
    .clk(clk),
    .d(\fch/n4 [7]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[7]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b8  (
    .clk(clk),
    .d(\fch/n4 [8]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[8]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg0_b9  (
    .clk(clk),
    .d(\fch/n4 [9]),
    .en(~\ctl/n936 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_ir[9]));  // rtl/tnsn_fch.v(65)
  reg_sr_as_w1 \fch/reg1_b0  (
    .clk(clk),
    .d(\fch/n10 [0]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [0]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b1  (
    .clk(clk),
    .d(\fch/n10 [1]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [1]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b10  (
    .clk(clk),
    .d(\fch/n10 [10]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [10]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b11  (
    .clk(clk),
    .d(\fch/n10 [11]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [11]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b12  (
    .clk(clk),
    .d(\fch/n10 [12]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [12]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b13  (
    .clk(clk),
    .d(\fch/n10 [13]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [13]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b14  (
    .clk(clk),
    .d(\fch/n10 [14]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [14]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b15  (
    .clk(clk),
    .d(\fch/n10 [15]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [15]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b2  (
    .clk(clk),
    .d(\fch/n10 [2]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [2]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b3  (
    .clk(clk),
    .d(\fch/n10 [3]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [3]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b4  (
    .clk(clk),
    .d(\fch/n10 [4]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [4]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b5  (
    .clk(clk),
    .d(\fch/n10 [5]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [5]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b6  (
    .clk(clk),
    .d(\fch/n10 [6]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [6]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b7  (
    .clk(clk),
    .d(\fch/n10 [7]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [7]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b8  (
    .clk(clk),
    .d(\fch/n10 [8]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [8]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg1_b9  (
    .clk(clk),
    .d(\fch/n10 [9]),
    .en(1'b1),
    .reset(\fch/n8 ),
    .set(1'b0),
    .q(\fch/eir [9]));  // rtl/tnsn_fch.v(78)
  reg_sr_as_w1 \fch/reg2_b0  (
    .clk(clk),
    .d(irq_lev[0]),
    .en(\fch/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_irq_lev[0]));  // rtl/tnsn_fch.v(55)
  reg_sr_as_w1 \fch/reg2_b1  (
    .clk(clk),
    .d(irq_lev[1]),
    .en(\fch/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(fch_irq_lev[1]));  // rtl/tnsn_fch.v(55)
  reg_sr_as_w1 \mem/bctl/reg0_b0  (
    .clk(clk),
    .d(\mem/babf/n1 [0]),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\mem/read_cyc [0]));  // rtl/tnsn_mem.v(123)
  reg_sr_as_w1 \mem/bctl/reg0_b1  (
    .clk(clk),
    .d(ctl_bcmdb),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\mem/read_cyc [1]));  // rtl/tnsn_mem.v(123)
  reg_sr_as_w1 \mem/bctl/reg0_b2  (
    .clk(clk),
    .d(ctl_bcmdr),
    .en(brdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\mem/read_cyc [2]));  // rtl/tnsn_mem.v(123)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b0  (
    .clk(clk),
    .d(cbus[0]),
    .en(~\rgf/bank/grn00/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [0]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b1  (
    .clk(clk),
    .d(cbus[1]),
    .en(~\rgf/bank/grn00/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [1]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b10  (
    .clk(clk),
    .d(cbus[10]),
    .en(\rgf/bank/grn00/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [10]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b11  (
    .clk(clk),
    .d(cbus[11]),
    .en(\rgf/bank/grn00/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [11]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b12  (
    .clk(clk),
    .d(cbus[12]),
    .en(\rgf/bank/grn00/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [12]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b13  (
    .clk(clk),
    .d(cbus[13]),
    .en(\rgf/bank/grn00/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [13]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b14  (
    .clk(clk),
    .d(cbus[14]),
    .en(\rgf/bank/grn00/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [14]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b15  (
    .clk(clk),
    .d(cbus[15]),
    .en(\rgf/bank/grn00/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [15]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b2  (
    .clk(clk),
    .d(cbus[2]),
    .en(~\rgf/bank/grn00/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [2]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b3  (
    .clk(clk),
    .d(cbus[3]),
    .en(~\rgf/bank/grn00/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [3]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b4  (
    .clk(clk),
    .d(cbus[4]),
    .en(~\rgf/bank/grn00/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [4]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b5  (
    .clk(clk),
    .d(cbus[5]),
    .en(~\rgf/bank/grn00/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [5]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b6  (
    .clk(clk),
    .d(cbus[6]),
    .en(~\rgf/bank/grn00/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [6]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b7  (
    .clk(clk),
    .d(cbus[7]),
    .en(~\rgf/bank/grn00/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [7]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b8  (
    .clk(clk),
    .d(cbus[8]),
    .en(\rgf/bank/grn00/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [8]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn00/reg0_b9  (
    .clk(clk),
    .d(cbus[9]),
    .en(\rgf/bank/grn00/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr00 [9]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b0  (
    .clk(clk),
    .d(cbus[0]),
    .en(~\rgf/bank/grn01/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [0]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b1  (
    .clk(clk),
    .d(cbus[1]),
    .en(~\rgf/bank/grn01/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [1]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b10  (
    .clk(clk),
    .d(cbus[10]),
    .en(\rgf/bank/grn01/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [10]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b11  (
    .clk(clk),
    .d(cbus[11]),
    .en(\rgf/bank/grn01/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [11]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b12  (
    .clk(clk),
    .d(cbus[12]),
    .en(\rgf/bank/grn01/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [12]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b13  (
    .clk(clk),
    .d(cbus[13]),
    .en(\rgf/bank/grn01/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [13]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b14  (
    .clk(clk),
    .d(cbus[14]),
    .en(\rgf/bank/grn01/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [14]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b15  (
    .clk(clk),
    .d(cbus[15]),
    .en(\rgf/bank/grn01/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [15]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b2  (
    .clk(clk),
    .d(cbus[2]),
    .en(~\rgf/bank/grn01/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [2]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b3  (
    .clk(clk),
    .d(cbus[3]),
    .en(~\rgf/bank/grn01/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [3]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b4  (
    .clk(clk),
    .d(cbus[4]),
    .en(~\rgf/bank/grn01/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [4]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b5  (
    .clk(clk),
    .d(cbus[5]),
    .en(~\rgf/bank/grn01/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [5]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b6  (
    .clk(clk),
    .d(cbus[6]),
    .en(~\rgf/bank/grn01/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [6]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b7  (
    .clk(clk),
    .d(cbus[7]),
    .en(~\rgf/bank/grn01/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [7]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b8  (
    .clk(clk),
    .d(cbus[8]),
    .en(\rgf/bank/grn01/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [8]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn01/reg0_b9  (
    .clk(clk),
    .d(cbus[9]),
    .en(\rgf/bank/grn01/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr01 [9]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b0  (
    .clk(clk),
    .d(cbus[0]),
    .en(~\rgf/bank/grn02/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [0]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b1  (
    .clk(clk),
    .d(cbus[1]),
    .en(~\rgf/bank/grn02/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [1]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b10  (
    .clk(clk),
    .d(cbus[10]),
    .en(\rgf/bank/grn02/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [10]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b11  (
    .clk(clk),
    .d(cbus[11]),
    .en(\rgf/bank/grn02/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [11]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b12  (
    .clk(clk),
    .d(cbus[12]),
    .en(\rgf/bank/grn02/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [12]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b13  (
    .clk(clk),
    .d(cbus[13]),
    .en(\rgf/bank/grn02/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [13]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b14  (
    .clk(clk),
    .d(cbus[14]),
    .en(\rgf/bank/grn02/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [14]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b15  (
    .clk(clk),
    .d(cbus[15]),
    .en(\rgf/bank/grn02/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [15]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b2  (
    .clk(clk),
    .d(cbus[2]),
    .en(~\rgf/bank/grn02/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [2]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b3  (
    .clk(clk),
    .d(cbus[3]),
    .en(~\rgf/bank/grn02/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [3]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b4  (
    .clk(clk),
    .d(cbus[4]),
    .en(~\rgf/bank/grn02/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [4]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b5  (
    .clk(clk),
    .d(cbus[5]),
    .en(~\rgf/bank/grn02/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [5]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b6  (
    .clk(clk),
    .d(cbus[6]),
    .en(~\rgf/bank/grn02/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [6]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b7  (
    .clk(clk),
    .d(cbus[7]),
    .en(~\rgf/bank/grn02/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [7]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b8  (
    .clk(clk),
    .d(cbus[8]),
    .en(\rgf/bank/grn02/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [8]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn02/reg0_b9  (
    .clk(clk),
    .d(cbus[9]),
    .en(\rgf/bank/grn02/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr02 [9]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b0  (
    .clk(clk),
    .d(cbus[0]),
    .en(~\rgf/bank/grn03/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [0]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b1  (
    .clk(clk),
    .d(cbus[1]),
    .en(~\rgf/bank/grn03/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [1]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b10  (
    .clk(clk),
    .d(cbus[10]),
    .en(\rgf/bank/grn03/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [10]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b11  (
    .clk(clk),
    .d(cbus[11]),
    .en(\rgf/bank/grn03/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [11]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b12  (
    .clk(clk),
    .d(cbus[12]),
    .en(\rgf/bank/grn03/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [12]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b13  (
    .clk(clk),
    .d(cbus[13]),
    .en(\rgf/bank/grn03/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [13]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b14  (
    .clk(clk),
    .d(cbus[14]),
    .en(\rgf/bank/grn03/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [14]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b15  (
    .clk(clk),
    .d(cbus[15]),
    .en(\rgf/bank/grn03/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [15]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b2  (
    .clk(clk),
    .d(cbus[2]),
    .en(~\rgf/bank/grn03/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [2]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b3  (
    .clk(clk),
    .d(cbus[3]),
    .en(~\rgf/bank/grn03/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [3]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b4  (
    .clk(clk),
    .d(cbus[4]),
    .en(~\rgf/bank/grn03/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [4]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b5  (
    .clk(clk),
    .d(cbus[5]),
    .en(~\rgf/bank/grn03/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [5]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b6  (
    .clk(clk),
    .d(cbus[6]),
    .en(~\rgf/bank/grn03/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [6]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b7  (
    .clk(clk),
    .d(cbus[7]),
    .en(~\rgf/bank/grn03/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [7]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b8  (
    .clk(clk),
    .d(cbus[8]),
    .en(\rgf/bank/grn03/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [8]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn03/reg0_b9  (
    .clk(clk),
    .d(cbus[9]),
    .en(\rgf/bank/grn03/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr03 [9]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b0  (
    .clk(clk),
    .d(cbus[0]),
    .en(~\rgf/bank/grn04/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [0]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b1  (
    .clk(clk),
    .d(cbus[1]),
    .en(~\rgf/bank/grn04/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [1]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b10  (
    .clk(clk),
    .d(cbus[10]),
    .en(\rgf/bank/grn04/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [10]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b11  (
    .clk(clk),
    .d(cbus[11]),
    .en(\rgf/bank/grn04/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [11]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b12  (
    .clk(clk),
    .d(cbus[12]),
    .en(\rgf/bank/grn04/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [12]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b13  (
    .clk(clk),
    .d(cbus[13]),
    .en(\rgf/bank/grn04/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [13]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b14  (
    .clk(clk),
    .d(cbus[14]),
    .en(\rgf/bank/grn04/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [14]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b15  (
    .clk(clk),
    .d(cbus[15]),
    .en(\rgf/bank/grn04/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [15]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b2  (
    .clk(clk),
    .d(cbus[2]),
    .en(~\rgf/bank/grn04/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [2]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b3  (
    .clk(clk),
    .d(cbus[3]),
    .en(~\rgf/bank/grn04/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [3]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b4  (
    .clk(clk),
    .d(cbus[4]),
    .en(~\rgf/bank/grn04/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [4]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b5  (
    .clk(clk),
    .d(cbus[5]),
    .en(~\rgf/bank/grn04/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [5]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b6  (
    .clk(clk),
    .d(cbus[6]),
    .en(~\rgf/bank/grn04/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [6]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b7  (
    .clk(clk),
    .d(cbus[7]),
    .en(~\rgf/bank/grn04/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [7]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b8  (
    .clk(clk),
    .d(cbus[8]),
    .en(\rgf/bank/grn04/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [8]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn04/reg0_b9  (
    .clk(clk),
    .d(cbus[9]),
    .en(\rgf/bank/grn04/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr04 [9]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b0  (
    .clk(clk),
    .d(cbus[0]),
    .en(~\rgf/bank/grn05/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [0]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b1  (
    .clk(clk),
    .d(cbus[1]),
    .en(~\rgf/bank/grn05/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [1]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b10  (
    .clk(clk),
    .d(cbus[10]),
    .en(\rgf/bank/grn05/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [10]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b11  (
    .clk(clk),
    .d(cbus[11]),
    .en(\rgf/bank/grn05/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [11]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b12  (
    .clk(clk),
    .d(cbus[12]),
    .en(\rgf/bank/grn05/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [12]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b13  (
    .clk(clk),
    .d(cbus[13]),
    .en(\rgf/bank/grn05/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [13]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b14  (
    .clk(clk),
    .d(cbus[14]),
    .en(\rgf/bank/grn05/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [14]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b15  (
    .clk(clk),
    .d(cbus[15]),
    .en(\rgf/bank/grn05/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [15]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b2  (
    .clk(clk),
    .d(cbus[2]),
    .en(~\rgf/bank/grn05/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [2]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b3  (
    .clk(clk),
    .d(cbus[3]),
    .en(~\rgf/bank/grn05/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [3]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b4  (
    .clk(clk),
    .d(cbus[4]),
    .en(~\rgf/bank/grn05/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [4]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b5  (
    .clk(clk),
    .d(cbus[5]),
    .en(~\rgf/bank/grn05/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [5]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b6  (
    .clk(clk),
    .d(cbus[6]),
    .en(~\rgf/bank/grn05/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [6]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b7  (
    .clk(clk),
    .d(cbus[7]),
    .en(~\rgf/bank/grn05/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [7]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b8  (
    .clk(clk),
    .d(cbus[8]),
    .en(\rgf/bank/grn05/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [8]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn05/reg0_b9  (
    .clk(clk),
    .d(cbus[9]),
    .en(\rgf/bank/grn05/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr05 [9]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b0  (
    .clk(clk),
    .d(cbus[0]),
    .en(~\rgf/bank/grn06/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [0]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b1  (
    .clk(clk),
    .d(cbus[1]),
    .en(~\rgf/bank/grn06/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [1]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b10  (
    .clk(clk),
    .d(cbus[10]),
    .en(\rgf/bank/grn06/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [10]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b11  (
    .clk(clk),
    .d(cbus[11]),
    .en(\rgf/bank/grn06/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [11]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b12  (
    .clk(clk),
    .d(cbus[12]),
    .en(\rgf/bank/grn06/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [12]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b13  (
    .clk(clk),
    .d(cbus[13]),
    .en(\rgf/bank/grn06/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [13]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b14  (
    .clk(clk),
    .d(cbus[14]),
    .en(\rgf/bank/grn06/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [14]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b15  (
    .clk(clk),
    .d(cbus[15]),
    .en(\rgf/bank/grn06/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [15]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b2  (
    .clk(clk),
    .d(cbus[2]),
    .en(~\rgf/bank/grn06/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [2]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b3  (
    .clk(clk),
    .d(cbus[3]),
    .en(~\rgf/bank/grn06/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [3]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b4  (
    .clk(clk),
    .d(cbus[4]),
    .en(~\rgf/bank/grn06/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [4]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b5  (
    .clk(clk),
    .d(cbus[5]),
    .en(~\rgf/bank/grn06/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [5]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b6  (
    .clk(clk),
    .d(cbus[6]),
    .en(~\rgf/bank/grn06/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [6]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b7  (
    .clk(clk),
    .d(cbus[7]),
    .en(~\rgf/bank/grn06/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [7]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b8  (
    .clk(clk),
    .d(cbus[8]),
    .en(\rgf/bank/grn06/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [8]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn06/reg0_b9  (
    .clk(clk),
    .d(cbus[9]),
    .en(\rgf/bank/grn06/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr06 [9]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b0  (
    .clk(clk),
    .d(cbus[0]),
    .en(~\rgf/bank/grn07/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [0]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b1  (
    .clk(clk),
    .d(cbus[1]),
    .en(~\rgf/bank/grn07/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [1]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b10  (
    .clk(clk),
    .d(cbus[10]),
    .en(\rgf/bank/grn07/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [10]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b11  (
    .clk(clk),
    .d(cbus[11]),
    .en(\rgf/bank/grn07/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [11]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b12  (
    .clk(clk),
    .d(cbus[12]),
    .en(\rgf/bank/grn07/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [12]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b13  (
    .clk(clk),
    .d(cbus[13]),
    .en(\rgf/bank/grn07/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [13]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b14  (
    .clk(clk),
    .d(cbus[14]),
    .en(\rgf/bank/grn07/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [14]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b15  (
    .clk(clk),
    .d(cbus[15]),
    .en(\rgf/bank/grn07/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [15]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b2  (
    .clk(clk),
    .d(cbus[2]),
    .en(~\rgf/bank/grn07/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [2]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b3  (
    .clk(clk),
    .d(cbus[3]),
    .en(~\rgf/bank/grn07/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [3]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b4  (
    .clk(clk),
    .d(cbus[4]),
    .en(~\rgf/bank/grn07/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [4]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b5  (
    .clk(clk),
    .d(cbus[5]),
    .en(~\rgf/bank/grn07/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [5]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b6  (
    .clk(clk),
    .d(cbus[6]),
    .en(~\rgf/bank/grn07/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [6]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b7  (
    .clk(clk),
    .d(cbus[7]),
    .en(~\rgf/bank/grn07/mux0_b0_sel_is_0_o ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [7]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b8  (
    .clk(clk),
    .d(cbus[8]),
    .en(\rgf/bank/grn07/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [8]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/bank/grn07/reg0_b9  (
    .clk(clk),
    .d(cbus[9]),
    .en(\rgf/bank/grn07/n1 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/bank/gr07 [9]));  // rtl/tnsn_rgf.v(435)
  reg_sr_as_w1 \rgf/ivec/reg0_b0  (
    .clk(clk),
    .d(cbus[0]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_iv_ve));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b1  (
    .clk(clk),
    .d(cbus[1]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [1]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b10  (
    .clk(clk),
    .d(cbus[10]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [10]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b11  (
    .clk(clk),
    .d(cbus[11]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [11]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b12  (
    .clk(clk),
    .d(cbus[12]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [12]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b13  (
    .clk(clk),
    .d(cbus[13]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [13]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b14  (
    .clk(clk),
    .d(cbus[14]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [14]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b15  (
    .clk(clk),
    .d(cbus[15]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [15]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b2  (
    .clk(clk),
    .d(cbus[2]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [2]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b3  (
    .clk(clk),
    .d(cbus[3]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [3]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b4  (
    .clk(clk),
    .d(cbus[4]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [4]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b5  (
    .clk(clk),
    .d(cbus[5]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [5]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b6  (
    .clk(clk),
    .d(cbus[6]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [6]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b7  (
    .clk(clk),
    .d(cbus[7]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [7]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b8  (
    .clk(clk),
    .d(cbus[8]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [8]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/ivec/reg0_b9  (
    .clk(clk),
    .d(cbus[9]),
    .en(\rgf/cbus_sel_cr [3]),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/ivec/iv [9]));  // rtl/tnsn_rgf.v(865)
  reg_sr_as_w1 \rgf/pcnt/reg0_b0  (
    .clk(clk),
    .d(cbus[0]),
    .en(\rgf/cbus_sel_cr [1]),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[0]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b1  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[1]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b10  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[10]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b11  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[11]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b12  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[12]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b13  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [13]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[13]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b14  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [14]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[14]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b15  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [15]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[15]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b2  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[2]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b3  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[3]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b4  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[4]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b5  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[5]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b6  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[6]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b7  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[7]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b8  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[8]));  // rtl/tnsn_rgf.v(758)
  reg_sr_as_w1 \rgf/pcnt/reg0_b9  (
    .clk(clk),
    .d(\rgf/pcnt/n2 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_pc[9]));  // rtl/tnsn_rgf.v(758)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u0  (
    .a(\rgf/sptr/sp [1]),
    .b(1'b1),
    .c(\rgf/sptr/add0/c0 ),
    .o({\rgf/sptr/add0/c1 ,\rgf/sptr/sp_inc [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u1  (
    .a(\rgf/sptr/sp [2]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c1 ),
    .o({\rgf/sptr/add0/c2 ,\rgf/sptr/sp_inc [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u10  (
    .a(\rgf/sptr/sp [11]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c10 ),
    .o({\rgf/sptr/add0/c11 ,\rgf/sptr/sp_inc [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u11  (
    .a(\rgf/sptr/sp [12]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c11 ),
    .o({\rgf/sptr/add0/c12 ,\rgf/sptr/sp_inc [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u12  (
    .a(\rgf/sptr/sp [13]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c12 ),
    .o({\rgf/sptr/add0/c13 ,\rgf/sptr/sp_inc [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u13  (
    .a(\rgf/sptr/sp [14]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c13 ),
    .o({\rgf/sptr/add0/c14 ,\rgf/sptr/sp_inc [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u14  (
    .a(\rgf/sptr/sp [15]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c14 ),
    .o({open_n122,\rgf/sptr/sp_inc [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u2  (
    .a(\rgf/sptr/sp [3]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c2 ),
    .o({\rgf/sptr/add0/c3 ,\rgf/sptr/sp_inc [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u3  (
    .a(\rgf/sptr/sp [4]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c3 ),
    .o({\rgf/sptr/add0/c4 ,\rgf/sptr/sp_inc [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u4  (
    .a(\rgf/sptr/sp [5]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c4 ),
    .o({\rgf/sptr/add0/c5 ,\rgf/sptr/sp_inc [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u5  (
    .a(\rgf/sptr/sp [6]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c5 ),
    .o({\rgf/sptr/add0/c6 ,\rgf/sptr/sp_inc [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u6  (
    .a(\rgf/sptr/sp [7]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c6 ),
    .o({\rgf/sptr/add0/c7 ,\rgf/sptr/sp_inc [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u7  (
    .a(\rgf/sptr/sp [8]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c7 ),
    .o({\rgf/sptr/add0/c8 ,\rgf/sptr/sp_inc [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u8  (
    .a(\rgf/sptr/sp [9]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c8 ),
    .o({\rgf/sptr/add0/c9 ,\rgf/sptr/sp_inc [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \rgf/sptr/add0/u9  (
    .a(\rgf/sptr/sp [10]),
    .b(1'b0),
    .c(\rgf/sptr/add0/c9 ),
    .o({\rgf/sptr/add0/c10 ,\rgf/sptr/sp_inc [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \rgf/sptr/add0/ucin  (
    .a(1'b0),
    .o({\rgf/sptr/add0/c0 ,open_n125}));
  reg_sr_as_w1 \rgf/sptr/reg0_b0  (
    .clk(clk),
    .d(\rgf/sptr/n2 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [0]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b1  (
    .clk(clk),
    .d(\rgf/sptr/n2 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [1]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b10  (
    .clk(clk),
    .d(\rgf/sptr/n2 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [10]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b11  (
    .clk(clk),
    .d(\rgf/sptr/n2 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [11]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b12  (
    .clk(clk),
    .d(\rgf/sptr/n2 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [12]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b13  (
    .clk(clk),
    .d(\rgf/sptr/n2 [13]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [13]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b14  (
    .clk(clk),
    .d(\rgf/sptr/n2 [14]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [14]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b15  (
    .clk(clk),
    .d(\rgf/sptr/n2 [15]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [15]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b2  (
    .clk(clk),
    .d(\rgf/sptr/n2 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [2]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b3  (
    .clk(clk),
    .d(\rgf/sptr/n2 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [3]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b4  (
    .clk(clk),
    .d(\rgf/sptr/n2 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [4]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b5  (
    .clk(clk),
    .d(\rgf/sptr/n2 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [5]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b6  (
    .clk(clk),
    .d(\rgf/sptr/n2 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [6]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b7  (
    .clk(clk),
    .d(\rgf/sptr/n2 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [7]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b8  (
    .clk(clk),
    .d(\rgf/sptr/n2 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [8]));  // rtl/tnsn_rgf.v(815)
  reg_sr_as_w1 \rgf/sptr/reg0_b9  (
    .clk(clk),
    .d(\rgf/sptr/n2 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\rgf/sptr/sp [9]));  // rtl/tnsn_rgf.v(815)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u0  (
    .a(\rgf/sptr/sp [1]),
    .b(1'b1),
    .c(\rgf/sptr/sub0/c0 ),
    .o({\rgf/sptr/sub0/c1 ,n0[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u1  (
    .a(\rgf/sptr/sp [2]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c1 ),
    .o({\rgf/sptr/sub0/c2 ,n0[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u10  (
    .a(\rgf/sptr/sp [11]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c10 ),
    .o({\rgf/sptr/sub0/c11 ,n0[10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u11  (
    .a(\rgf/sptr/sp [12]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c11 ),
    .o({\rgf/sptr/sub0/c12 ,n0[11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u12  (
    .a(\rgf/sptr/sp [13]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c12 ),
    .o({\rgf/sptr/sub0/c13 ,n0[12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u13  (
    .a(\rgf/sptr/sp [14]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c13 ),
    .o({\rgf/sptr/sub0/c14 ,n0[13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u14  (
    .a(\rgf/sptr/sp [15]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c14 ),
    .o({open_n126,n0[14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u2  (
    .a(\rgf/sptr/sp [3]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c2 ),
    .o({\rgf/sptr/sub0/c3 ,n0[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u3  (
    .a(\rgf/sptr/sp [4]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c3 ),
    .o({\rgf/sptr/sub0/c4 ,n0[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u4  (
    .a(\rgf/sptr/sp [5]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c4 ),
    .o({\rgf/sptr/sub0/c5 ,n0[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u5  (
    .a(\rgf/sptr/sp [6]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c5 ),
    .o({\rgf/sptr/sub0/c6 ,n0[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u6  (
    .a(\rgf/sptr/sp [7]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c6 ),
    .o({\rgf/sptr/sub0/c7 ,n0[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u7  (
    .a(\rgf/sptr/sp [8]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c7 ),
    .o({\rgf/sptr/sub0/c8 ,n0[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u8  (
    .a(\rgf/sptr/sp [9]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c8 ),
    .o({\rgf/sptr/sub0/c9 ,n0[8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \rgf/sptr/sub0/u9  (
    .a(\rgf/sptr/sp [10]),
    .b(1'b0),
    .c(\rgf/sptr/sub0/c9 ),
    .o({\rgf/sptr/sub0/c10 ,n0[9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \rgf/sptr/sub0/ucin  (
    .a(1'b0),
    .o({\rgf/sptr/sub0/c0 ,open_n129}));
  reg_ar_as_w1 \rgf/sreg/reg0_b12  (
    .clk(clk),
    .d(\rgf/sreg/n8 [12]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\rgf/sreg/sr [12]));  // rtl/tnsn_rgf.v(702)
  reg_ar_as_w1 \rgf/sreg/reg0_b13  (
    .clk(clk),
    .d(\rgf/sreg/n8 [13]),
    .en(1'b1),
    .reset(1'b0),
    .set(1'b0),
    .q(\rgf/sreg/sr [13]));  // rtl/tnsn_rgf.v(702)
  reg_sr_as_w1 \rgf/sreg/reg0_b2  (
    .clk(clk),
    .d(\rgf/sreg/n7 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_sr_ie[0]));  // rtl/tnsn_rgf.v(702)
  reg_sr_as_w1 \rgf/sreg/reg0_b3  (
    .clk(clk),
    .d(\rgf/sreg/n7 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_sr_ie[1]));  // rtl/tnsn_rgf.v(702)
  reg_sr_as_w1 \rgf/sreg/reg0_b4  (
    .clk(clk),
    .d(\rgf/sreg/n7 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_sr_flag[0]));  // rtl/tnsn_rgf.v(702)
  reg_sr_as_w1 \rgf/sreg/reg0_b5  (
    .clk(clk),
    .d(\rgf/sreg/n7 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_sr_flag[1]));  // rtl/tnsn_rgf.v(702)
  reg_sr_as_w1 \rgf/sreg/reg0_b6  (
    .clk(clk),
    .d(\rgf/sreg/n7 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_sr_flag[2]));  // rtl/tnsn_rgf.v(702)
  reg_sr_as_w1 \rgf/sreg/reg0_b7  (
    .clk(clk),
    .d(\rgf/sreg/n7 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(rgf_sr_flag[3]));  // rtl/tnsn_rgf.v(702)

endmodule 

