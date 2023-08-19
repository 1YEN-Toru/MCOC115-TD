
`timescale 1ns / 1ps
module sglfpu  // rtl/sglfpu.v(1)
  (
  abus,
  bbus,
  ccmd,
  clk,
  rst_n,
  sfpu_dsp_c,
  cbus,
  crdy,
  sfpu_dsp_a,
  sfpu_dsp_b
  );
//
//	Single precision FPU (Single precision floating point unit)
//		(c) 2021,2023	1YEN Toru
//
//
//	2023/02/11	ver.1.00
//		float: <1b sign> <8b exponent> <23b fraction>
//		float=pow (-1,<1b sign>)*0x1.<23b fraction>*pow (2,<8b exponent>-127)
//		non normalized number was not supported. it is treated as zero.
//		INF and NaN are available
//
//	================================
//	2021/07/10	ver.1.02
//		ccmd=HCMP: half compare command
//
//	2021/06/12	ver.1.00
//		half: <1b sign> <5b exponent> <10b fraction>
//		half=pow (-1,<1b sign>)*0x1.<10b fraction>*pow (2,<5b exponent>-15)
//		non normalized number was not supported. it is treated as zero.
//		INF and NaN are available
//

  input [31:0] abus;  // rtl/sglfpu.v(18)
  input [31:0] bbus;  // rtl/sglfpu.v(19)
  input [4:0] ccmd;  // rtl/sglfpu.v(17)
  input clk;  // rtl/sglfpu.v(14)
  input rst_n;  // rtl/sglfpu.v(15)
  input [47:0] sfpu_dsp_c;  // rtl/sglfpu.v(16)
  output [31:0] cbus;  // rtl/sglfpu.v(23)
  output crdy;  // rtl/sglfpu.v(20)
  output [23:0] sfpu_dsp_a;  // rtl/sglfpu.v(21)
  output [23:0] sfpu_dsp_b;  // rtl/sglfpu.v(22)

  wire [31:0] \fadd/n2 ;
  wire [31:0] \fadd/n3 ;
  wire [31:0] \fadd/n4 ;
  wire [31:0] \fadd/sgla_f ;  // rtl/sglfpu.v(274)
  wire [31:0] \fadd/sglb_f ;  // rtl/sglfpu.v(282)
  wire [31:0] \fadd/sglc_f_t ;  // rtl/sglfpu.v(313)
  wire [3:0] \fctl/stat ;  // rtl/sfpu_fsm.v(109)
  wire [49:0] \fdiv/den ;  // rtl/sglfpu.v(421)
  wire [49:0] \fdiv/den_r ;  // rtl/sglfpu.v(408)
  wire [24:0] \fdiv/dso_r ;  // rtl/sglfpu.v(424)
  wire [25:0] \fdiv/fdiv/n1 ;
  wire [25:0] \fdiv/fdiv/n3 ;
  wire [25:0] \fdiv/fdiv/n5 ;
  wire [25:0] \fdiv/fdiv/n7 ;
  wire [25:0] \fdiv/fdiv/n9 ;
  wire [26:0] \fdiv/fdiv/rem1 ;  // rtl/sglfpu.v(515)
  wire [26:0] \fdiv/fdiv/rem2 ;  // rtl/sglfpu.v(514)
  wire [26:0] \fdiv/fdiv/rem3 ;  // rtl/sglfpu.v(513)
  wire [26:0] \fdiv/fdiv/rem4 ;  // rtl/sglfpu.v(512)
  wire [24:0] \fdiv/fquo ;  // rtl/sglfpu.v(435)
  wire [8:0] \fdiv/n18 ;
  wire [18:0] \fdiv/n9 ;
  wire [4:0] \fdiv/quo ;  // rtl/sglfpu.v(368)
  wire [25:0] \fdiv/rem ;  // rtl/sglfpu.v(369)
  wire [4:0] n0;
  wire [7:0] n1;
  wire [6:0] n10;
  wire [7:0] n11;
  wire [6:0] n2;
  wire [7:0] n3;
  wire [5:0] n4;
  wire [7:0] n5;
  wire [6:0] n6;
  wire [7:0] n7;
  wire [4:0] n8;
  wire [5:0] n9;
  wire [44:0] \norm/n0 ;
  wire [44:0] \norm/n2 ;
  wire [8:0] \norm/n24 ;
  wire [8:0] \norm/n27 ;
  wire [31:0] \norm/n28 ;
  wire [8:0] \norm/n29 ;
  wire [31:0] \norm/n30 ;
  wire [8:0] \norm/n33 ;
  wire [31:0] \norm/n34 ;
  wire [8:0] \norm/n37 ;
  wire [31:0] \norm/n38 ;
  wire [8:0] \norm/n4 ;
  wire [8:0] \norm/n41 ;
  wire [31:0] \norm/n42 ;
  wire [31:0] \norm/n44 ;
  wire [8:0] \norm/n45 ;
  wire [31:0] \norm/n46 ;
  wire [31:0] \norm/n48 ;
  wire [8:0] \norm/n49 ;
  wire [7:0] \norm/n5 ;
  wire [31:0] \norm/n50 ;
  wire [8:0] \norm/n52 ;
  wire [31:0] \norm/n53 ;
  wire [8:0] \norm/n6 ;
  wire [7:0] \norm/n60 ;
  wire [7:0] \norm/n61 ;
  wire [8:0] \norm/sglc_e ;  // rtl/sglfpu.v(1744)
  wire [31:0] \norm/sglc_f ;  // rtl/sglfpu.v(1745)
  wire [44:41] \norm/sglc_i ;  // rtl/sglfpu.v(1743)
  wire [44:0] \norm/sglc_r ;  // rtl/sglfpu.v(1736)
  wire [4:0] \sgla/ccmd_f ;  // rtl/sglfpu.v(575)
  wire [8:0] \sgla/n11 ;
  wire [4:0] \sgla/n15 ;
  wire [8:0] \sgla/n190 ;
  wire [8:0] \sgla/n2 ;
  wire [5:0] \sgla/n20 ;
  wire [6:0] \sgla/n28 ;
  wire [7:0] \sgla/n33 ;
  wire [8:0] \sgla/n39 ;
  wire [8:0] \sgla/n48 ;
  wire [8:0] \sgla/n58 ;
  wire [8:0] \sgla/n61 ;
  wire [31:0] \sgla/n62 ;
  wire [8:0] \sgla/n63 ;
  wire [8:0] \sgla/n67 ;
  wire [31:0] \sgla/n68 ;
  wire [31:0] \sgla/n70 ;
  wire [8:0] \sgla/n71 ;
  wire [31:0] \sgla/n72 ;
  wire [31:0] \sgla/n74 ;
  wire [8:0] \sgla/n75 ;
  wire [31:0] \sgla/n76 ;
  wire [31:0] \sgla/n78 ;
  wire [8:0] \sgla/n79 ;
  wire [31:0] \sgla/n80 ;
  wire [8:0] \sgla/n84 ;
  wire [31:0] \sgla/n85 ;
  wire [8:0] \sgla/sgla_e_dif ;  // rtl/sglfpu.v(572)
  wire [8:0] \sgla/sgla_e_difl ;  // rtl/sglfpu.v(573)
  wire [31:0] \sgla/sgla_i ;  // rtl/sglfpu.v(578)
  wire [8:0] \sgla/sglb_et ;  // rtl/sglfpu.v(571)
  wire [8:0] sgla_e;  // rtl/sglfpu.v(129)
  wire [44:0] sgla_r;  // rtl/sglfpu.v(132)
  wire [8:0] \sglb/n1 ;
  wire [8:0] \sglb/n102 ;
  wire [31:0] \sglb/n103 ;
  wire [8:0] \sglb/n11 ;
  wire [4:0] \sglb/n20 ;
  wire [5:0] \sglb/n45 ;
  wire [6:0] \sglb/n62 ;
  wire [7:0] \sglb/n75 ;
  wire [8:0] \sglb/n86 ;
  wire [8:0] \sglb/n89 ;
  wire [8:0] \sglb/n91 ;
  wire [31:0] \sglb/n92 ;
  wire [8:0] \sglb/n93 ;
  wire [31:0] \sglb/n94 ;
  wire [31:0] \sglb/n96 ;
  wire [8:0] \sglb/n97 ;
  wire [31:0] \sglb/n98 ;
  wire [31:0] \sglb/sglb_i ;  // rtl/sglfpu.v(1272)
  wire [8:0] sglb_e;  // rtl/sglfpu.v(130)
  wire [44:0] sglb_r;  // rtl/sglfpu.v(133)
  wire [44:0] sglc_r_fadd;  // rtl/sglfpu.v(134)
  wire [44:0] sglc_r_fdiv;  // rtl/sglfpu.v(136)
  wire [44:0] sglc_r_fmul;  // rtl/sglfpu.v(135)
  wire _al_u1000_o;
  wire _al_u1001_o;
  wire _al_u1002_o;
  wire _al_u1003_o;
  wire _al_u1004_o;
  wire _al_u1005_o;
  wire _al_u1006_o;
  wire _al_u1007_o;
  wire _al_u1008_o;
  wire _al_u1009_o;
  wire _al_u1015_o;
  wire _al_u1020_o;
  wire _al_u1023_o;
  wire _al_u1024_o;
  wire _al_u1027_o;
  wire _al_u1030_o;
  wire _al_u1031_o;
  wire _al_u1032_o;
  wire _al_u1033_o;
  wire _al_u1035_o;
  wire _al_u1037_o;
  wire _al_u1038_o;
  wire _al_u1039_o;
  wire _al_u1040_o;
  wire _al_u1041_o;
  wire _al_u1042_o;
  wire _al_u1044_o;
  wire _al_u1045_o;
  wire _al_u1046_o;
  wire _al_u1048_o;
  wire _al_u1049_o;
  wire _al_u1051_o;
  wire _al_u1052_o;
  wire _al_u1054_o;
  wire _al_u1055_o;
  wire _al_u1057_o;
  wire _al_u1058_o;
  wire _al_u1059_o;
  wire _al_u1060_o;
  wire _al_u1061_o;
  wire _al_u1062_o;
  wire _al_u1063_o;
  wire _al_u1064_o;
  wire _al_u1066_o;
  wire _al_u1067_o;
  wire _al_u1069_o;
  wire _al_u1070_o;
  wire _al_u1072_o;
  wire _al_u1073_o;
  wire _al_u1075_o;
  wire _al_u1076_o;
  wire _al_u1078_o;
  wire _al_u1079_o;
  wire _al_u1080_o;
  wire _al_u1081_o;
  wire _al_u1084_o;
  wire _al_u1085_o;
  wire _al_u1086_o;
  wire _al_u1087_o;
  wire _al_u1088_o;
  wire _al_u1090_o;
  wire _al_u1091_o;
  wire _al_u1093_o;
  wire _al_u1094_o;
  wire _al_u1096_o;
  wire _al_u1097_o;
  wire _al_u1099_o;
  wire _al_u1100_o;
  wire _al_u1102_o;
  wire _al_u1103_o;
  wire _al_u1104_o;
  wire _al_u1105_o;
  wire _al_u1106_o;
  wire _al_u1119_o;
  wire _al_u1120_o;
  wire _al_u1121_o;
  wire _al_u1122_o;
  wire _al_u1124_o;
  wire _al_u1152_o;
  wire _al_u1161_o;
  wire _al_u1163_o;
  wire _al_u1164_o;
  wire _al_u1166_o;
  wire _al_u1167_o;
  wire _al_u1169_o;
  wire _al_u1170_o;
  wire _al_u1173_o;
  wire _al_u1174_o;
  wire _al_u1175_o;
  wire _al_u1176_o;
  wire _al_u1177_o;
  wire _al_u1178_o;
  wire _al_u1179_o;
  wire _al_u1180_o;
  wire _al_u1181_o;
  wire _al_u1182_o;
  wire _al_u1185_o;
  wire _al_u1186_o;
  wire _al_u1187_o;
  wire _al_u1188_o;
  wire _al_u1189_o;
  wire _al_u1190_o;
  wire _al_u1192_o;
  wire _al_u1193_o;
  wire _al_u1196_o;
  wire _al_u1199_o;
  wire _al_u1201_o;
  wire _al_u1202_o;
  wire _al_u1203_o;
  wire _al_u1204_o;
  wire _al_u1205_o;
  wire _al_u1206_o;
  wire _al_u1208_o;
  wire _al_u1209_o;
  wire _al_u1213_o;
  wire _al_u1215_o;
  wire _al_u1216_o;
  wire _al_u1218_o;
  wire _al_u1220_o;
  wire _al_u1221_o;
  wire _al_u1224_o;
  wire _al_u1225_o;
  wire _al_u1228_o;
  wire _al_u1229_o;
  wire _al_u1232_o;
  wire _al_u1233_o;
  wire _al_u1236_o;
  wire _al_u1237_o;
  wire _al_u1240_o;
  wire _al_u1241_o;
  wire _al_u1244_o;
  wire _al_u1245_o;
  wire _al_u1248_o;
  wire _al_u1249_o;
  wire _al_u1252_o;
  wire _al_u1253_o;
  wire _al_u1260_o;
  wire _al_u1261_o;
  wire _al_u1262_o;
  wire _al_u1268_o;
  wire _al_u1269_o;
  wire _al_u1270_o;
  wire _al_u1280_o;
  wire _al_u1283_o;
  wire _al_u1284_o;
  wire _al_u1285_o;
  wire _al_u1286_o;
  wire _al_u1287_o;
  wire _al_u1323_o;
  wire _al_u1324_o;
  wire _al_u1325_o;
  wire _al_u1326_o;
  wire _al_u1327_o;
  wire _al_u1328_o;
  wire _al_u1329_o;
  wire _al_u1330_o;
  wire _al_u1331_o;
  wire _al_u1332_o;
  wire _al_u1333_o;
  wire _al_u1334_o;
  wire _al_u1335_o;
  wire _al_u1336_o;
  wire _al_u1337_o;
  wire _al_u1338_o;
  wire _al_u1340_o;
  wire _al_u1341_o;
  wire _al_u1342_o;
  wire _al_u1343_o;
  wire _al_u1345_o;
  wire _al_u1346_o;
  wire _al_u1347_o;
  wire _al_u1348_o;
  wire _al_u1349_o;
  wire _al_u1350_o;
  wire _al_u1351_o;
  wire _al_u1352_o;
  wire _al_u1353_o;
  wire _al_u1354_o;
  wire _al_u1355_o;
  wire _al_u1356_o;
  wire _al_u1357_o;
  wire _al_u1358_o;
  wire _al_u1359_o;
  wire _al_u1360_o;
  wire _al_u1361_o;
  wire _al_u1362_o;
  wire _al_u1363_o;
  wire _al_u1365_o;
  wire _al_u1366_o;
  wire _al_u1368_o;
  wire _al_u1369_o;
  wire _al_u1370_o;
  wire _al_u1371_o;
  wire _al_u1372_o;
  wire _al_u1373_o;
  wire _al_u1374_o;
  wire _al_u1375_o;
  wire _al_u1377_o;
  wire _al_u1378_o;
  wire _al_u1380_o;
  wire _al_u1384_o;
  wire _al_u1388_o;
  wire _al_u1389_o;
  wire _al_u1390_o;
  wire _al_u1494_o;
  wire _al_u1495_o;
  wire _al_u1497_o;
  wire _al_u1500_o;
  wire _al_u1501_o;
  wire _al_u1503_o;
  wire _al_u1506_o;
  wire _al_u1507_o;
  wire _al_u1509_o;
  wire _al_u1512_o;
  wire _al_u1513_o;
  wire _al_u1515_o;
  wire _al_u1518_o;
  wire _al_u1519_o;
  wire _al_u1520_o;
  wire _al_u1523_o;
  wire _al_u1524_o;
  wire _al_u1525_o;
  wire _al_u1526_o;
  wire _al_u1528_o;
  wire _al_u1529_o;
  wire _al_u1530_o;
  wire _al_u1531_o;
  wire _al_u1532_o;
  wire _al_u1534_o;
  wire _al_u1535_o;
  wire _al_u1536_o;
  wire _al_u1537_o;
  wire _al_u1538_o;
  wire _al_u1540_o;
  wire _al_u1541_o;
  wire _al_u1542_o;
  wire _al_u1543_o;
  wire _al_u1544_o;
  wire _al_u1546_o;
  wire _al_u1548_o;
  wire _al_u1552_o;
  wire _al_u1553_o;
  wire _al_u1555_o;
  wire _al_u1556_o;
  wire _al_u1558_o;
  wire _al_u1559_o;
  wire _al_u1560_o;
  wire _al_u1588_o;
  wire _al_u1589_o;
  wire _al_u1590_o;
  wire _al_u1591_o;
  wire _al_u1592_o;
  wire _al_u1593_o;
  wire _al_u1595_o;
  wire _al_u1596_o;
  wire _al_u1597_o;
  wire _al_u1598_o;
  wire _al_u1599_o;
  wire _al_u1600_o;
  wire _al_u1602_o;
  wire _al_u1603_o;
  wire _al_u1604_o;
  wire _al_u1605_o;
  wire _al_u1606_o;
  wire _al_u1608_o;
  wire _al_u1610_o;
  wire _al_u1611_o;
  wire _al_u1612_o;
  wire _al_u1613_o;
  wire _al_u1616_o;
  wire _al_u1617_o;
  wire _al_u1618_o;
  wire _al_u1619_o;
  wire _al_u1622_o;
  wire _al_u1623_o;
  wire _al_u1624_o;
  wire _al_u1625_o;
  wire _al_u1628_o;
  wire _al_u1629_o;
  wire _al_u1630_o;
  wire _al_u1631_o;
  wire _al_u1634_o;
  wire _al_u1635_o;
  wire _al_u1636_o;
  wire _al_u1637_o;
  wire _al_u1640_o;
  wire _al_u1641_o;
  wire _al_u1642_o;
  wire _al_u1643_o;
  wire _al_u1646_o;
  wire _al_u1647_o;
  wire _al_u1648_o;
  wire _al_u1649_o;
  wire _al_u1652_o;
  wire _al_u1653_o;
  wire _al_u1654_o;
  wire _al_u1655_o;
  wire _al_u1656_o;
  wire _al_u1657_o;
  wire _al_u1659_o;
  wire _al_u1660_o;
  wire _al_u1661_o;
  wire _al_u1662_o;
  wire _al_u1663_o;
  wire _al_u1664_o;
  wire _al_u1666_o;
  wire _al_u1667_o;
  wire _al_u1668_o;
  wire _al_u1669_o;
  wire _al_u1670_o;
  wire _al_u1671_o;
  wire _al_u1673_o;
  wire _al_u1674_o;
  wire _al_u1675_o;
  wire _al_u1676_o;
  wire _al_u1677_o;
  wire _al_u1678_o;
  wire _al_u1680_o;
  wire _al_u1681_o;
  wire _al_u1682_o;
  wire _al_u1683_o;
  wire _al_u1684_o;
  wire _al_u1685_o;
  wire _al_u1687_o;
  wire _al_u1688_o;
  wire _al_u1689_o;
  wire _al_u1690_o;
  wire _al_u1691_o;
  wire _al_u1692_o;
  wire _al_u1699_o;
  wire _al_u1701_o;
  wire _al_u1702_o;
  wire _al_u1703_o;
  wire _al_u1705_o;
  wire _al_u1708_o;
  wire _al_u1709_o;
  wire _al_u1710_o;
  wire _al_u1712_o;
  wire _al_u1713_o;
  wire _al_u1715_o;
  wire _al_u1717_o;
  wire _al_u1720_o;
  wire _al_u1721_o;
  wire _al_u1723_o;
  wire _al_u1724_o;
  wire _al_u1726_o;
  wire _al_u1729_o;
  wire _al_u1731_o;
  wire _al_u1735_o;
  wire _al_u1736_o;
  wire _al_u1737_o;
  wire _al_u1738_o;
  wire _al_u1739_o;
  wire _al_u1740_o;
  wire _al_u1741_o;
  wire _al_u1742_o;
  wire _al_u1743_o;
  wire _al_u1745_o;
  wire _al_u1747_o;
  wire _al_u1748_o;
  wire _al_u1749_o;
  wire _al_u1750_o;
  wire _al_u1751_o;
  wire _al_u1752_o;
  wire _al_u1753_o;
  wire _al_u1754_o;
  wire _al_u1755_o;
  wire _al_u1756_o;
  wire _al_u1760_o;
  wire _al_u1761_o;
  wire _al_u1762_o;
  wire _al_u1765_o;
  wire _al_u1767_o;
  wire _al_u1770_o;
  wire _al_u1772_o;
  wire _al_u1773_o;
  wire _al_u1774_o;
  wire _al_u1775_o;
  wire _al_u1777_o;
  wire _al_u1780_o;
  wire _al_u1781_o;
  wire _al_u1783_o;
  wire _al_u1785_o;
  wire _al_u1786_o;
  wire _al_u1788_o;
  wire _al_u1793_o;
  wire _al_u1796_o;
  wire _al_u1797_o;
  wire _al_u1801_o;
  wire _al_u1802_o;
  wire _al_u1803_o;
  wire _al_u1804_o;
  wire _al_u1806_o;
  wire _al_u1807_o;
  wire _al_u1808_o;
  wire _al_u1809_o;
  wire _al_u1810_o;
  wire _al_u1811_o;
  wire _al_u1812_o;
  wire _al_u1816_o;
  wire _al_u1817_o;
  wire _al_u1818_o;
  wire _al_u1819_o;
  wire _al_u1820_o;
  wire _al_u1821_o;
  wire _al_u1823_o;
  wire _al_u1824_o;
  wire _al_u1825_o;
  wire _al_u1826_o;
  wire _al_u1827_o;
  wire _al_u1828_o;
  wire _al_u1830_o;
  wire _al_u1831_o;
  wire _al_u1832_o;
  wire _al_u1833_o;
  wire _al_u1834_o;
  wire _al_u1836_o;
  wire _al_u1844_o;
  wire _al_u1845_o;
  wire _al_u1846_o;
  wire _al_u1847_o;
  wire _al_u1848_o;
  wire _al_u1849_o;
  wire _al_u1850_o;
  wire _al_u1851_o;
  wire _al_u1852_o;
  wire _al_u1859_o;
  wire _al_u1860_o;
  wire _al_u1861_o;
  wire _al_u1862_o;
  wire _al_u1865_o;
  wire _al_u1872_o;
  wire _al_u1873_o;
  wire _al_u1874_o;
  wire _al_u1875_o;
  wire _al_u1876_o;
  wire _al_u1877_o;
  wire _al_u1879_o;
  wire _al_u1886_o;
  wire _al_u1887_o;
  wire _al_u1888_o;
  wire _al_u1889_o;
  wire _al_u1890_o;
  wire _al_u1891_o;
  wire _al_u1892_o;
  wire _al_u1893_o;
  wire _al_u1894_o;
  wire _al_u1896_o;
  wire _al_u1897_o;
  wire _al_u1898_o;
  wire _al_u1902_o;
  wire _al_u1903_o;
  wire _al_u1904_o;
  wire _al_u1906_o;
  wire _al_u1908_o;
  wire _al_u1910_o;
  wire _al_u1917_o;
  wire _al_u1918_o;
  wire _al_u1919_o;
  wire _al_u1920_o;
  wire _al_u1921_o;
  wire _al_u1923_o;
  wire _al_u1924_o;
  wire _al_u1925_o;
  wire _al_u1926_o;
  wire _al_u1927_o;
  wire _al_u1932_o;
  wire _al_u1935_o;
  wire _al_u1936_o;
  wire _al_u1937_o;
  wire _al_u1938_o;
  wire _al_u1939_o;
  wire _al_u1940_o;
  wire _al_u1941_o;
  wire _al_u1942_o;
  wire _al_u1944_o;
  wire _al_u1945_o;
  wire _al_u1946_o;
  wire _al_u1947_o;
  wire _al_u1948_o;
  wire _al_u1950_o;
  wire _al_u1951_o;
  wire _al_u1952_o;
  wire _al_u1953_o;
  wire _al_u1954_o;
  wire _al_u1956_o;
  wire _al_u1957_o;
  wire _al_u1958_o;
  wire _al_u1959_o;
  wire _al_u1960_o;
  wire _al_u1962_o;
  wire _al_u1963_o;
  wire _al_u1964_o;
  wire _al_u1965_o;
  wire _al_u1966_o;
  wire _al_u1967_o;
  wire _al_u1968_o;
  wire _al_u1969_o;
  wire _al_u1973_o;
  wire _al_u1974_o;
  wire _al_u1976_o;
  wire _al_u1977_o;
  wire _al_u1978_o;
  wire _al_u1979_o;
  wire _al_u1980_o;
  wire _al_u1981_o;
  wire _al_u1982_o;
  wire _al_u1983_o;
  wire _al_u1987_o;
  wire _al_u1988_o;
  wire _al_u1990_o;
  wire _al_u1991_o;
  wire _al_u1992_o;
  wire _al_u1993_o;
  wire _al_u1994_o;
  wire _al_u1995_o;
  wire _al_u1996_o;
  wire _al_u1997_o;
  wire _al_u1998_o;
  wire _al_u1999_o;
  wire _al_u2000_o;
  wire _al_u2003_o;
  wire _al_u2004_o;
  wire _al_u2005_o;
  wire _al_u2006_o;
  wire _al_u2007_o;
  wire _al_u2008_o;
  wire _al_u2009_o;
  wire _al_u2010_o;
  wire _al_u2011_o;
  wire _al_u2017_o;
  wire _al_u2018_o;
  wire _al_u2019_o;
  wire _al_u2020_o;
  wire _al_u2021_o;
  wire _al_u2022_o;
  wire _al_u2023_o;
  wire _al_u2024_o;
  wire _al_u2027_o;
  wire _al_u2030_o;
  wire _al_u2031_o;
  wire _al_u2032_o;
  wire _al_u2033_o;
  wire _al_u2035_o;
  wire _al_u2036_o;
  wire _al_u2037_o;
  wire _al_u2039_o;
  wire _al_u2042_o;
  wire _al_u2043_o;
  wire _al_u2044_o;
  wire _al_u2045_o;
  wire _al_u2048_o;
  wire _al_u2049_o;
  wire _al_u2050_o;
  wire _al_u2051_o;
  wire _al_u2054_o;
  wire _al_u2055_o;
  wire _al_u2056_o;
  wire _al_u2057_o;
  wire _al_u2058_o;
  wire _al_u2059_o;
  wire _al_u2064_o;
  wire _al_u2069_o;
  wire _al_u2070_o;
  wire _al_u2071_o;
  wire _al_u2075_o;
  wire _al_u2079_o;
  wire _al_u2081_o;
  wire _al_u2082_o;
  wire _al_u2083_o;
  wire _al_u2084_o;
  wire _al_u2089_o;
  wire _al_u2090_o;
  wire _al_u2091_o;
  wire _al_u2092_o;
  wire _al_u2097_o;
  wire _al_u2098_o;
  wire _al_u2099_o;
  wire _al_u2100_o;
  wire _al_u2105_o;
  wire _al_u2106_o;
  wire _al_u2107_o;
  wire _al_u2108_o;
  wire _al_u2113_o;
  wire _al_u2114_o;
  wire _al_u2115_o;
  wire _al_u2116_o;
  wire _al_u2121_o;
  wire _al_u2122_o;
  wire _al_u2123_o;
  wire _al_u2124_o;
  wire _al_u2131_o;
  wire _al_u2132_o;
  wire _al_u2137_o;
  wire _al_u2146_o;
  wire _al_u2147_o;
  wire _al_u2150_o;
  wire _al_u2152_o;
  wire _al_u2153_o;
  wire _al_u2154_o;
  wire _al_u2155_o;
  wire _al_u2160_o;
  wire _al_u2161_o;
  wire _al_u2162_o;
  wire _al_u2163_o;
  wire _al_u2166_o;
  wire _al_u2168_o;
  wire _al_u2169_o;
  wire _al_u2170_o;
  wire _al_u2171_o;
  wire _al_u2174_o;
  wire _al_u2176_o;
  wire _al_u2177_o;
  wire _al_u2178_o;
  wire _al_u2179_o;
  wire _al_u2182_o;
  wire _al_u2184_o;
  wire _al_u2185_o;
  wire _al_u2186_o;
  wire _al_u2187_o;
  wire _al_u2190_o;
  wire _al_u2192_o;
  wire _al_u2193_o;
  wire _al_u2194_o;
  wire _al_u2195_o;
  wire _al_u2197_o;
  wire _al_u2198_o;
  wire _al_u2199_o;
  wire _al_u2200_o;
  wire _al_u2201_o;
  wire _al_u2203_o;
  wire _al_u2204_o;
  wire _al_u2205_o;
  wire _al_u2206_o;
  wire _al_u2207_o;
  wire _al_u2208_o;
  wire _al_u2209_o;
  wire _al_u2210_o;
  wire _al_u2211_o;
  wire _al_u2212_o;
  wire _al_u2214_o;
  wire _al_u2215_o;
  wire _al_u2216_o;
  wire _al_u2217_o;
  wire _al_u2219_o;
  wire _al_u2220_o;
  wire _al_u2221_o;
  wire _al_u2222_o;
  wire _al_u2224_o;
  wire _al_u2225_o;
  wire _al_u2226_o;
  wire _al_u2227_o;
  wire _al_u2229_o;
  wire _al_u2230_o;
  wire _al_u2231_o;
  wire _al_u2232_o;
  wire _al_u2234_o;
  wire _al_u2235_o;
  wire _al_u2236_o;
  wire _al_u2237_o;
  wire _al_u2239_o;
  wire _al_u2240_o;
  wire _al_u2241_o;
  wire _al_u2242_o;
  wire _al_u2244_o;
  wire _al_u2245_o;
  wire _al_u2246_o;
  wire _al_u2247_o;
  wire _al_u2249_o;
  wire _al_u2250_o;
  wire _al_u2251_o;
  wire _al_u2252_o;
  wire _al_u2254_o;
  wire _al_u2255_o;
  wire _al_u2256_o;
  wire _al_u2257_o;
  wire _al_u2259_o;
  wire _al_u2260_o;
  wire _al_u2261_o;
  wire _al_u2262_o;
  wire _al_u2264_o;
  wire _al_u2265_o;
  wire _al_u2266_o;
  wire _al_u2267_o;
  wire _al_u2268_o;
  wire _al_u2269_o;
  wire _al_u2270_o;
  wire _al_u2272_o;
  wire _al_u2273_o;
  wire _al_u2274_o;
  wire _al_u2275_o;
  wire _al_u2276_o;
  wire _al_u2277_o;
  wire _al_u2279_o;
  wire _al_u2280_o;
  wire _al_u2281_o;
  wire _al_u2282_o;
  wire _al_u2284_o;
  wire _al_u2285_o;
  wire _al_u2286_o;
  wire _al_u2287_o;
  wire _al_u2289_o;
  wire _al_u2290_o;
  wire _al_u2291_o;
  wire _al_u2292_o;
  wire _al_u2294_o;
  wire _al_u2295_o;
  wire _al_u2296_o;
  wire _al_u2297_o;
  wire _al_u2299_o;
  wire _al_u2300_o;
  wire _al_u2301_o;
  wire _al_u2302_o;
  wire _al_u2304_o;
  wire _al_u2305_o;
  wire _al_u2306_o;
  wire _al_u2307_o;
  wire _al_u2309_o;
  wire _al_u2310_o;
  wire _al_u2311_o;
  wire _al_u2312_o;
  wire _al_u2314_o;
  wire _al_u2315_o;
  wire _al_u2316_o;
  wire _al_u2317_o;
  wire _al_u2319_o;
  wire _al_u2320_o;
  wire _al_u2321_o;
  wire _al_u2322_o;
  wire _al_u2324_o;
  wire _al_u2325_o;
  wire _al_u2326_o;
  wire _al_u2327_o;
  wire _al_u2329_o;
  wire _al_u2330_o;
  wire _al_u2331_o;
  wire _al_u2332_o;
  wire _al_u2334_o;
  wire _al_u2335_o;
  wire _al_u2336_o;
  wire _al_u2337_o;
  wire _al_u2339_o;
  wire _al_u2340_o;
  wire _al_u2341_o;
  wire _al_u2342_o;
  wire _al_u2344_o;
  wire _al_u2345_o;
  wire _al_u2346_o;
  wire _al_u2347_o;
  wire _al_u2349_o;
  wire _al_u2350_o;
  wire _al_u2351_o;
  wire _al_u2352_o;
  wire _al_u2354_o;
  wire _al_u2355_o;
  wire _al_u2356_o;
  wire _al_u2357_o;
  wire _al_u2359_o;
  wire _al_u2360_o;
  wire _al_u2361_o;
  wire _al_u2362_o;
  wire _al_u2364_o;
  wire _al_u2365_o;
  wire _al_u2366_o;
  wire _al_u2367_o;
  wire _al_u924_o;
  wire _al_u957_o;
  wire _al_u970_o;
  wire _al_u975_o;
  wire _al_u976_o;
  wire _al_u977_o;
  wire _al_u978_o;
  wire _al_u979_o;
  wire _al_u980_o;
  wire _al_u982_o;
  wire _al_u985_o;
  wire _al_u986_o;
  wire _al_u987_o;
  wire _al_u988_o;
  wire _al_u989_o;
  wire _al_u990_o;
  wire _al_u992_o;
  wire _al_u995_o;
  wire _al_u996_o;
  wire \fadd/add0/c0 ;
  wire \fadd/add0/c1 ;
  wire \fadd/add0/c10 ;
  wire \fadd/add0/c11 ;
  wire \fadd/add0/c12 ;
  wire \fadd/add0/c13 ;
  wire \fadd/add0/c14 ;
  wire \fadd/add0/c15 ;
  wire \fadd/add0/c16 ;
  wire \fadd/add0/c17 ;
  wire \fadd/add0/c18 ;
  wire \fadd/add0/c19 ;
  wire \fadd/add0/c2 ;
  wire \fadd/add0/c20 ;
  wire \fadd/add0/c21 ;
  wire \fadd/add0/c22 ;
  wire \fadd/add0/c23 ;
  wire \fadd/add0/c24 ;
  wire \fadd/add0/c25 ;
  wire \fadd/add0/c26 ;
  wire \fadd/add0/c27 ;
  wire \fadd/add0/c28 ;
  wire \fadd/add0/c29 ;
  wire \fadd/add0/c3 ;
  wire \fadd/add0/c30 ;
  wire \fadd/add0/c31 ;
  wire \fadd/add0/c4 ;
  wire \fadd/add0/c5 ;
  wire \fadd/add0/c6 ;
  wire \fadd/add0/c7 ;
  wire \fadd/add0/c8 ;
  wire \fadd/add0/c9 ;
  wire \fadd/eq0/or_or_xor_i0[16]_i1[_o_lutinv ;
  wire \fadd/eq0/or_or_xor_i0[20]_i1[_o_lutinv ;
  wire \fadd/eq0/or_or_xor_i0[8]_i1[8_o_lutinv ;
  wire \fadd/eq0/or_xor_i0[12]_i1[12]_o_lutinv ;
  wire \fadd/eq0/or_xor_i0[14]_i1[14]_o_lutinv ;
  wire \fadd/eq0/or_xor_i0[26]_i1[26]_o_lutinv ;
  wire \fadd/inf_nan ;  // rtl/sglfpu.v(286)
  wire \fadd/inf_s ;  // rtl/sglfpu.v(287)
  wire \fadd/neg0/c0 ;
  wire \fadd/neg0/c1 ;
  wire \fadd/neg0/c10 ;
  wire \fadd/neg0/c11 ;
  wire \fadd/neg0/c12 ;
  wire \fadd/neg0/c13 ;
  wire \fadd/neg0/c14 ;
  wire \fadd/neg0/c15 ;
  wire \fadd/neg0/c16 ;
  wire \fadd/neg0/c17 ;
  wire \fadd/neg0/c18 ;
  wire \fadd/neg0/c19 ;
  wire \fadd/neg0/c2 ;
  wire \fadd/neg0/c20 ;
  wire \fadd/neg0/c21 ;
  wire \fadd/neg0/c22 ;
  wire \fadd/neg0/c23 ;
  wire \fadd/neg0/c24 ;
  wire \fadd/neg0/c25 ;
  wire \fadd/neg0/c26 ;
  wire \fadd/neg0/c27 ;
  wire \fadd/neg0/c28 ;
  wire \fadd/neg0/c29 ;
  wire \fadd/neg0/c3 ;
  wire \fadd/neg0/c30 ;
  wire \fadd/neg0/c31 ;
  wire \fadd/neg0/c4 ;
  wire \fadd/neg0/c5 ;
  wire \fadd/neg0/c6 ;
  wire \fadd/neg0/c7 ;
  wire \fadd/neg0/c8 ;
  wire \fadd/neg0/c9 ;
  wire \fadd/neg1/c0 ;
  wire \fadd/neg1/c1 ;
  wire \fadd/neg1/c10 ;
  wire \fadd/neg1/c11 ;
  wire \fadd/neg1/c12 ;
  wire \fadd/neg1/c13 ;
  wire \fadd/neg1/c14 ;
  wire \fadd/neg1/c15 ;
  wire \fadd/neg1/c16 ;
  wire \fadd/neg1/c17 ;
  wire \fadd/neg1/c18 ;
  wire \fadd/neg1/c19 ;
  wire \fadd/neg1/c2 ;
  wire \fadd/neg1/c20 ;
  wire \fadd/neg1/c21 ;
  wire \fadd/neg1/c22 ;
  wire \fadd/neg1/c23 ;
  wire \fadd/neg1/c24 ;
  wire \fadd/neg1/c25 ;
  wire \fadd/neg1/c26 ;
  wire \fadd/neg1/c27 ;
  wire \fadd/neg1/c28 ;
  wire \fadd/neg1/c29 ;
  wire \fadd/neg1/c3 ;
  wire \fadd/neg1/c30 ;
  wire \fadd/neg1/c31 ;
  wire \fadd/neg1/c4 ;
  wire \fadd/neg1/c5 ;
  wire \fadd/neg1/c6 ;
  wire \fadd/neg1/c7 ;
  wire \fadd/neg1/c8 ;
  wire \fadd/neg1/c9 ;
  wire \fctl/crdy_f ;  // rtl/sfpu_fsm.v(99)
  wire \fctl/crdy_t ;  // rtl/sfpu_fsm.v(100)
  wire \fctl/mux0_b0_sel_is_3_o ;
  wire \fctl/mux0_b1_sel_is_3_o ;
  wire \fctl/mux0_b2_sel_is_3_o ;
  wire \fctl/mux0_b3_sel_is_3_o ;
  wire \fctl/n10 ;
  wire \fctl/n114_lutinv ;
  wire \fctl/n123_lutinv ;
  wire \fctl/n129_lutinv ;
  wire \fctl/n13 ;
  wire \fctl/n15 ;
  wire \fctl/n153_lutinv ;
  wire \fctl/n154_lutinv ;
  wire \fctl/n16 ;
  wire \fctl/n164 ;
  wire \fctl/n17 ;
  wire \fctl/n29 ;
  wire \fctl/n33 ;
  wire \fctl/n9 ;
  wire fctl_cbus_out_lutinv;  // rtl/sglfpu.v(165)
  wire fctl_ccmd_add;  // rtl/sglfpu.v(149)
  wire fctl_ccmd_cmp;  // rtl/sglfpu.v(151)
  wire fctl_ccmd_div;  // rtl/sglfpu.v(153)
  wire fctl_ccmd_hlf;  // rtl/sglfpu.v(155)
  wire fctl_ccmd_int;  // rtl/sglfpu.v(156)
  wire fctl_ccmd_mul;  // rtl/sglfpu.v(152)
  wire fctl_ccmd_reg;  // rtl/sglfpu.v(154)
  wire fctl_ccmd_sub;  // rtl/sglfpu.v(150)
  wire fctl_dsft_enb;  // rtl/sglfpu.v(161)
  wire fctl_load_a;  // rtl/sglfpu.v(157)
  wire fctl_load_c;  // rtl/sglfpu.v(159)
  wire fctl_norm_enb_lutinv;  // rtl/sglfpu.v(164)
  wire fctl_rsft_enb_lutinv;  // rtl/sglfpu.v(162)
  wire \fdiv/fdiv/add0_2/c0 ;
  wire \fdiv/fdiv/add0_2/c1 ;
  wire \fdiv/fdiv/add0_2/c10 ;
  wire \fdiv/fdiv/add0_2/c11 ;
  wire \fdiv/fdiv/add0_2/c12 ;
  wire \fdiv/fdiv/add0_2/c13 ;
  wire \fdiv/fdiv/add0_2/c14 ;
  wire \fdiv/fdiv/add0_2/c15 ;
  wire \fdiv/fdiv/add0_2/c16 ;
  wire \fdiv/fdiv/add0_2/c17 ;
  wire \fdiv/fdiv/add0_2/c18 ;
  wire \fdiv/fdiv/add0_2/c19 ;
  wire \fdiv/fdiv/add0_2/c2 ;
  wire \fdiv/fdiv/add0_2/c20 ;
  wire \fdiv/fdiv/add0_2/c21 ;
  wire \fdiv/fdiv/add0_2/c22 ;
  wire \fdiv/fdiv/add0_2/c23 ;
  wire \fdiv/fdiv/add0_2/c24 ;
  wire \fdiv/fdiv/add0_2/c25 ;
  wire \fdiv/fdiv/add0_2/c3 ;
  wire \fdiv/fdiv/add0_2/c4 ;
  wire \fdiv/fdiv/add0_2/c5 ;
  wire \fdiv/fdiv/add0_2/c6 ;
  wire \fdiv/fdiv/add0_2/c7 ;
  wire \fdiv/fdiv/add0_2/c8 ;
  wire \fdiv/fdiv/add0_2/c9 ;
  wire \fdiv/fdiv/add1_2/c0 ;
  wire \fdiv/fdiv/add1_2/c1 ;
  wire \fdiv/fdiv/add1_2/c10 ;
  wire \fdiv/fdiv/add1_2/c11 ;
  wire \fdiv/fdiv/add1_2/c12 ;
  wire \fdiv/fdiv/add1_2/c13 ;
  wire \fdiv/fdiv/add1_2/c14 ;
  wire \fdiv/fdiv/add1_2/c15 ;
  wire \fdiv/fdiv/add1_2/c16 ;
  wire \fdiv/fdiv/add1_2/c17 ;
  wire \fdiv/fdiv/add1_2/c18 ;
  wire \fdiv/fdiv/add1_2/c19 ;
  wire \fdiv/fdiv/add1_2/c2 ;
  wire \fdiv/fdiv/add1_2/c20 ;
  wire \fdiv/fdiv/add1_2/c21 ;
  wire \fdiv/fdiv/add1_2/c22 ;
  wire \fdiv/fdiv/add1_2/c23 ;
  wire \fdiv/fdiv/add1_2/c24 ;
  wire \fdiv/fdiv/add1_2/c25 ;
  wire \fdiv/fdiv/add1_2/c3 ;
  wire \fdiv/fdiv/add1_2/c4 ;
  wire \fdiv/fdiv/add1_2/c5 ;
  wire \fdiv/fdiv/add1_2/c6 ;
  wire \fdiv/fdiv/add1_2/c7 ;
  wire \fdiv/fdiv/add1_2/c8 ;
  wire \fdiv/fdiv/add1_2/c9 ;
  wire \fdiv/fdiv/add2_2/c0 ;
  wire \fdiv/fdiv/add2_2/c1 ;
  wire \fdiv/fdiv/add2_2/c10 ;
  wire \fdiv/fdiv/add2_2/c11 ;
  wire \fdiv/fdiv/add2_2/c12 ;
  wire \fdiv/fdiv/add2_2/c13 ;
  wire \fdiv/fdiv/add2_2/c14 ;
  wire \fdiv/fdiv/add2_2/c15 ;
  wire \fdiv/fdiv/add2_2/c16 ;
  wire \fdiv/fdiv/add2_2/c17 ;
  wire \fdiv/fdiv/add2_2/c18 ;
  wire \fdiv/fdiv/add2_2/c19 ;
  wire \fdiv/fdiv/add2_2/c2 ;
  wire \fdiv/fdiv/add2_2/c20 ;
  wire \fdiv/fdiv/add2_2/c21 ;
  wire \fdiv/fdiv/add2_2/c22 ;
  wire \fdiv/fdiv/add2_2/c23 ;
  wire \fdiv/fdiv/add2_2/c24 ;
  wire \fdiv/fdiv/add2_2/c25 ;
  wire \fdiv/fdiv/add2_2/c3 ;
  wire \fdiv/fdiv/add2_2/c4 ;
  wire \fdiv/fdiv/add2_2/c5 ;
  wire \fdiv/fdiv/add2_2/c6 ;
  wire \fdiv/fdiv/add2_2/c7 ;
  wire \fdiv/fdiv/add2_2/c8 ;
  wire \fdiv/fdiv/add2_2/c9 ;
  wire \fdiv/fdiv/add3_2/c0 ;
  wire \fdiv/fdiv/add3_2/c1 ;
  wire \fdiv/fdiv/add3_2/c10 ;
  wire \fdiv/fdiv/add3_2/c11 ;
  wire \fdiv/fdiv/add3_2/c12 ;
  wire \fdiv/fdiv/add3_2/c13 ;
  wire \fdiv/fdiv/add3_2/c14 ;
  wire \fdiv/fdiv/add3_2/c15 ;
  wire \fdiv/fdiv/add3_2/c16 ;
  wire \fdiv/fdiv/add3_2/c17 ;
  wire \fdiv/fdiv/add3_2/c18 ;
  wire \fdiv/fdiv/add3_2/c19 ;
  wire \fdiv/fdiv/add3_2/c2 ;
  wire \fdiv/fdiv/add3_2/c20 ;
  wire \fdiv/fdiv/add3_2/c21 ;
  wire \fdiv/fdiv/add3_2/c22 ;
  wire \fdiv/fdiv/add3_2/c23 ;
  wire \fdiv/fdiv/add3_2/c24 ;
  wire \fdiv/fdiv/add3_2/c25 ;
  wire \fdiv/fdiv/add3_2/c3 ;
  wire \fdiv/fdiv/add3_2/c4 ;
  wire \fdiv/fdiv/add3_2/c5 ;
  wire \fdiv/fdiv/add3_2/c6 ;
  wire \fdiv/fdiv/add3_2/c7 ;
  wire \fdiv/fdiv/add3_2/c8 ;
  wire \fdiv/fdiv/add3_2/c9 ;
  wire \fdiv/fdiv/add4_2/c0 ;
  wire \fdiv/fdiv/add4_2/c1 ;
  wire \fdiv/fdiv/add4_2/c10 ;
  wire \fdiv/fdiv/add4_2/c11 ;
  wire \fdiv/fdiv/add4_2/c12 ;
  wire \fdiv/fdiv/add4_2/c13 ;
  wire \fdiv/fdiv/add4_2/c14 ;
  wire \fdiv/fdiv/add4_2/c15 ;
  wire \fdiv/fdiv/add4_2/c16 ;
  wire \fdiv/fdiv/add4_2/c17 ;
  wire \fdiv/fdiv/add4_2/c18 ;
  wire \fdiv/fdiv/add4_2/c19 ;
  wire \fdiv/fdiv/add4_2/c2 ;
  wire \fdiv/fdiv/add4_2/c20 ;
  wire \fdiv/fdiv/add4_2/c21 ;
  wire \fdiv/fdiv/add4_2/c22 ;
  wire \fdiv/fdiv/add4_2/c23 ;
  wire \fdiv/fdiv/add4_2/c24 ;
  wire \fdiv/fdiv/add4_2/c25 ;
  wire \fdiv/fdiv/add4_2/c3 ;
  wire \fdiv/fdiv/add4_2/c4 ;
  wire \fdiv/fdiv/add4_2/c5 ;
  wire \fdiv/fdiv/add4_2/c6 ;
  wire \fdiv/fdiv/add4_2/c7 ;
  wire \fdiv/fdiv/add4_2/c8 ;
  wire \fdiv/fdiv/add4_2/c9 ;
  wire \fdiv/fdiv/n0 ;
  wire \fdiv/inf_zer_lutinv ;  // rtl/sglfpu.v(390)
  wire \fdiv/n19 ;
  wire \fdiv/n6_lutinv ;
  wire \fdiv/sub0/c0 ;
  wire \fdiv/sub0/c1 ;
  wire \fdiv/sub0/c2 ;
  wire \fdiv/sub0/c3 ;
  wire \fdiv/sub0/c4 ;
  wire \fdiv/sub0/c5 ;
  wire \fdiv/sub0/c6 ;
  wire \fdiv/sub0/c7 ;
  wire \fdiv/sub0/c8 ;
  wire \fdiv/sub1/c0 ;
  wire \fdiv/sub1/c1 ;
  wire \fdiv/sub1/c2 ;
  wire \fdiv/sub1/c3 ;
  wire \fdiv/sub1/c4 ;
  wire \fdiv/sub1/c5 ;
  wire \fdiv/sub1/c6 ;
  wire \fdiv/sub1/c7 ;
  wire \fdiv/sub1/c8 ;
  wire \fmul/add0_fmul/add1/c0 ;
  wire \fmul/add0_fmul/add1/c1 ;
  wire \fmul/add0_fmul/add1/c2 ;
  wire \fmul/add0_fmul/add1/c3 ;
  wire \fmul/add0_fmul/add1/c4 ;
  wire \fmul/add0_fmul/add1/c5 ;
  wire \fmul/add0_fmul/add1/c6 ;
  wire \fmul/add0_fmul/add1/c7 ;
  wire \fmul/add0_fmul/add1/c8 ;
  wire \norm/add0/c0 ;
  wire \norm/add0/c1 ;
  wire \norm/add0/c2 ;
  wire \norm/add0/c3 ;
  wire \norm/add0/c4 ;
  wire \norm/add0/c5 ;
  wire \norm/add0/c6 ;
  wire \norm/add0/c7 ;
  wire \norm/add0/c8 ;
  wire \norm/add1/c0 ;
  wire \norm/add1/c1 ;
  wire \norm/add1/c2 ;
  wire \norm/add1/c3 ;
  wire \norm/add1/c4 ;
  wire \norm/add1/c5 ;
  wire \norm/add1/c6 ;
  wire \norm/add1/c7 ;
  wire \norm/add2/c0 ;
  wire \norm/add2/c1 ;
  wire \norm/add2/c2 ;
  wire \norm/add2/c3 ;
  wire \norm/add2/c4 ;
  wire \norm/add2/c5 ;
  wire \norm/add2/c6 ;
  wire \norm/add2/c7 ;
  wire \norm/add2/c8 ;
  wire \norm/add3/c0 ;
  wire \norm/add3/c1 ;
  wire \norm/add3/c2 ;
  wire \norm/add3/c3 ;
  wire \norm/add3/c4 ;
  wire \norm/add3/c5 ;
  wire \norm/add3/c6 ;
  wire \norm/add3/c7 ;
  wire \norm/add4/c0 ;
  wire \norm/add4/c1 ;
  wire \norm/add4/c2 ;
  wire \norm/add4/c3 ;
  wire \norm/add4/c4 ;
  wire \norm/add4/c5 ;
  wire \norm/add4/c6 ;
  wire \norm/add4/c7 ;
  wire \norm/lt0_c0 ;
  wire \norm/lt0_c1 ;
  wire \norm/lt0_c2 ;
  wire \norm/lt0_c3 ;
  wire \norm/lt0_c4 ;
  wire \norm/lt0_c5 ;
  wire \norm/lt0_c6 ;
  wire \norm/lt0_c7 ;
  wire \norm/lt0_c8 ;
  wire \norm/lt0_c9 ;
  wire \norm/lt1_c0 ;
  wire \norm/lt1_c1 ;
  wire \norm/lt1_c2 ;
  wire \norm/lt1_c3 ;
  wire \norm/lt1_c4 ;
  wire \norm/lt1_c5 ;
  wire \norm/lt1_c6 ;
  wire \norm/lt1_c7 ;
  wire \norm/lt1_c8 ;
  wire \norm/lt1_c9 ;
  wire \norm/mux1_b0_sel_is_2_o ;
  wire \norm/mux27_b30_sel_is_0_o ;
  wire \norm/mux2_b0_sel_is_2_o ;
  wire \norm/n58_lutinv ;
  wire \norm/ovfl ;  // rtl/sglfpu.v(2023)
  wire \norm/sub0/c0 ;
  wire \norm/sub0/c1 ;
  wire \norm/sub0/c2 ;
  wire \norm/sub0/c3 ;
  wire \norm/sub0/c4 ;
  wire \norm/sub1/c0 ;
  wire \norm/sub1/c1 ;
  wire \norm/sub1/c2 ;
  wire \norm/sub1/c3 ;
  wire \norm/sub1/c4 ;
  wire \norm/sub1/c5 ;
  wire \norm/sub1/c6 ;
  wire \norm/sub1/c7 ;
  wire \norm/sub2/c0 ;
  wire \norm/sub2/c1 ;
  wire \norm/sub2/c2 ;
  wire \norm/sub2/c3 ;
  wire \norm/sub2/c4 ;
  wire \norm/sub2/c5 ;
  wire \norm/sub2/c6 ;
  wire \norm/sub3/c0 ;
  wire \norm/sub3/c1 ;
  wire \norm/sub3/c2 ;
  wire \norm/sub3/c3 ;
  wire \norm/sub3/c4 ;
  wire \norm/sub3/c5 ;
  wire \norm/sub3/c6 ;
  wire \norm/sub3/c7 ;
  wire \norm/sub4/c0 ;
  wire \norm/sub4/c1 ;
  wire \norm/sub4/c2 ;
  wire \norm/sub4/c3 ;
  wire \norm/sub4/c4 ;
  wire \norm/sub4/c5 ;
  wire \norm/sub5/c0 ;
  wire \norm/sub5/c1 ;
  wire \norm/sub5/c2 ;
  wire \norm/sub5/c3 ;
  wire \norm/sub5/c4 ;
  wire \norm/sub5/c5 ;
  wire \norm/sub5/c6 ;
  wire \norm/sub5/c7 ;
  wire \norm/sub6/c0 ;
  wire \norm/sub6/c1 ;
  wire \norm/sub6/c2 ;
  wire \norm/sub6/c3 ;
  wire \norm/sub6/c4 ;
  wire \norm/sub6/c5 ;
  wire \norm/sub6/c6 ;
  wire \norm/sub7/c0 ;
  wire \norm/sub7/c1 ;
  wire \norm/sub7/c2 ;
  wire \norm/sub7/c3 ;
  wire \norm/sub7/c4 ;
  wire \norm/sub7/c5 ;
  wire \norm/sub7/c6 ;
  wire \norm/sub7/c7 ;
  wire \norm/sub8/c0 ;
  wire \norm/sub8/c1 ;
  wire \norm/sub8/c2 ;
  wire \norm/sub8/c3 ;
  wire \norm/sub8/c4 ;
  wire \norm/sub8/c5 ;
  wire \norm/sub8/c6 ;
  wire \norm/sub8/c7 ;
  wire \norm/sub8/c8 ;
  wire \norm/udfl ;  // rtl/sglfpu.v(2024)
  wire \sgla/add0/c0 ;
  wire \sgla/add0/c1 ;
  wire \sgla/add0/c2 ;
  wire \sgla/add0/c3 ;
  wire \sgla/add0/c4 ;
  wire \sgla/add0/c5 ;
  wire \sgla/add0/c6 ;
  wire \sgla/add0/c7 ;
  wire \sgla/add0/c8 ;
  wire \sgla/add1/c0 ;
  wire \sgla/add1/c1 ;
  wire \sgla/add1/c2 ;
  wire \sgla/add1/c3 ;
  wire \sgla/add1/c4 ;
  wire \sgla/add2/c0 ;
  wire \sgla/add2/c1 ;
  wire \sgla/add2/c2 ;
  wire \sgla/add2/c3 ;
  wire \sgla/add2/c4 ;
  wire \sgla/add2/c5 ;
  wire \sgla/add3/c0 ;
  wire \sgla/add3/c1 ;
  wire \sgla/add3/c2 ;
  wire \sgla/add3/c3 ;
  wire \sgla/add3/c4 ;
  wire \sgla/add3/c5 ;
  wire \sgla/add3/c6 ;
  wire \sgla/add4/c0 ;
  wire \sgla/add4/c1 ;
  wire \sgla/add4/c2 ;
  wire \sgla/add4/c3 ;
  wire \sgla/add4/c4 ;
  wire \sgla/add4/c5 ;
  wire \sgla/add4/c6 ;
  wire \sgla/add4/c7 ;
  wire \sgla/add5/c0 ;
  wire \sgla/add5/c1 ;
  wire \sgla/add5/c2 ;
  wire \sgla/add5/c3 ;
  wire \sgla/add5/c4 ;
  wire \sgla/add5/c5 ;
  wire \sgla/add5/c6 ;
  wire \sgla/add5/c7 ;
  wire \sgla/add5/c8 ;
  wire \sgla/lt0_c0 ;
  wire \sgla/lt0_c1 ;
  wire \sgla/lt0_c2 ;
  wire \sgla/lt0_c3 ;
  wire \sgla/lt0_c4 ;
  wire \sgla/lt0_c5 ;
  wire \sgla/lt0_c6 ;
  wire \sgla/lt0_c7 ;
  wire \sgla/lt0_c8 ;
  wire \sgla/lt0_c9 ;
  wire \sgla/lt1_c0 ;
  wire \sgla/lt1_c1 ;
  wire \sgla/lt1_c2 ;
  wire \sgla/lt1_c3 ;
  wire \sgla/lt1_c4 ;
  wire \sgla/lt1_c5 ;
  wire \sgla/lt1_c6 ;
  wire \sgla/lt1_c7 ;
  wire \sgla/lt1_c8 ;
  wire \sgla/lt1_c9 ;
  wire \sgla/lt2_c0 ;
  wire \sgla/lt2_c1 ;
  wire \sgla/lt2_c2 ;
  wire \sgla/lt2_c3 ;
  wire \sgla/lt2_c4 ;
  wire \sgla/lt2_c5 ;
  wire \sgla/lt2_c6 ;
  wire \sgla/lt2_c7 ;
  wire \sgla/lt2_c8 ;
  wire \sgla/lt2_c9 ;
  wire \sgla/lt3_c0 ;
  wire \sgla/lt3_c1 ;
  wire \sgla/lt3_c2 ;
  wire \sgla/lt3_c3 ;
  wire \sgla/lt3_c4 ;
  wire \sgla/lt3_c5 ;
  wire \sgla/lt3_c6 ;
  wire \sgla/lt3_c7 ;
  wire \sgla/lt3_c8 ;
  wire \sgla/lt3_c9 ;
  wire \sgla/lt4_2_c0 ;
  wire \sgla/lt4_2_c1 ;
  wire \sgla/lt4_2_c2 ;
  wire \sgla/lt4_2_c3 ;
  wire \sgla/lt4_2_c4 ;
  wire \sgla/lt4_2_c5 ;
  wire \sgla/lt4_2_c6 ;
  wire \sgla/lt4_2_c7 ;
  wire \sgla/lt4_2_c8 ;
  wire \sgla/lt4_2_c9 ;
  wire \sgla/lt5_c0 ;
  wire \sgla/lt5_c1 ;
  wire \sgla/lt5_c2 ;
  wire \sgla/lt5_c3 ;
  wire \sgla/lt5_c4 ;
  wire \sgla/lt5_c5 ;
  wire \sgla/lt5_c6 ;
  wire \sgla/lt5_c7 ;
  wire \sgla/lt5_c8 ;
  wire \sgla/lt5_c9 ;
  wire \sgla/mux10_b2_sel_is_2_o ;
  wire \sgla/mux14_b31_sel_is_0_o ;
  wire \sgla/mux21_b2_sel_is_0_o ;
  wire \sgla/mux27_b0_sel_is_0_o ;
  wire \sgla/mux30_b0_sel_is_2_o ;
  wire \sgla/mux30_b29_sel_is_2_o ;
  wire \sgla/mux30_b30_sel_is_2_o ;
  wire \sgla/mux30_b31_sel_is_2_o ;
  wire \sgla/mux41_b32_sel_is_2_o ;
  wire \sgla/mux44_b0_sel_is_0_o ;
  wire \sgla/n131_lutinv ;
  wire \sgla/n152_neg_lutinv ;
  wire \sgla/n182_lutinv ;
  wire \sgla/n184 ;
  wire \sgla/n185_neg_lutinv ;
  wire \sgla/n186 ;
  wire \sgla/n187 ;
  wire \sgla/n188 ;
  wire \sgla/n197_lutinv ;
  wire \sgla/n199_lutinv ;
  wire \sgla/n200_lutinv ;
  wire \sgla/n202_lutinv ;
  wire \sgla/n8 ;
  wire \sgla/sgla_lsft_fin ;  // rtl/sglfpu.v(570)
  wire \sgla/sgla_rsft_fin ;  // rtl/sglfpu.v(569)
  wire \sgla/sub0/c0 ;
  wire \sgla/sub0/c1 ;
  wire \sgla/sub0/c2 ;
  wire \sgla/sub0/c3 ;
  wire \sgla/sub0/c4 ;
  wire \sgla/sub0/c5 ;
  wire \sgla/sub0/c6 ;
  wire \sgla/sub0/c7 ;
  wire \sgla/sub0/c8 ;
  wire \sgla/sub1/c0 ;
  wire \sgla/sub1/c1 ;
  wire \sgla/sub1/c2 ;
  wire \sgla/sub1/c3 ;
  wire \sgla/sub1/c4 ;
  wire \sgla/sub1/c5 ;
  wire \sgla/sub1/c6 ;
  wire \sgla/sub1/c7 ;
  wire \sgla/sub1/c8 ;
  wire \sgla/sub2/c0 ;
  wire \sgla/sub2/c1 ;
  wire \sgla/sub2/c2 ;
  wire \sgla/sub2/c3 ;
  wire \sgla/sub2/c4 ;
  wire \sgla/sub3/c0 ;
  wire \sgla/sub3/c1 ;
  wire \sgla/sub3/c2 ;
  wire \sgla/sub3/c3 ;
  wire \sgla/sub3/c4 ;
  wire \sgla/sub3/c5 ;
  wire \sgla/sub4/c0 ;
  wire \sgla/sub4/c1 ;
  wire \sgla/sub4/c2 ;
  wire \sgla/sub4/c3 ;
  wire \sgla/sub4/c4 ;
  wire \sgla/sub4/c5 ;
  wire \sgla/sub4/c6 ;
  wire \sgla/sub5/c0 ;
  wire \sgla/sub5/c1 ;
  wire \sgla/sub5/c2 ;
  wire \sgla/sub5/c3 ;
  wire \sgla/sub5/c4 ;
  wire \sgla/sub5/c5 ;
  wire \sgla/sub5/c6 ;
  wire \sgla/sub5/c7 ;
  wire \sgla/sub6/c0 ;
  wire \sgla/sub6/c1 ;
  wire \sgla/sub6/c2 ;
  wire \sgla/sub6/c3 ;
  wire \sgla/sub6/c4 ;
  wire \sgla/sub6/c5 ;
  wire \sgla/sub6/c6 ;
  wire \sgla/sub6/c7 ;
  wire \sgla/sub6/c8 ;
  wire \sgla/sub7/c0 ;
  wire \sgla/sub7/c1 ;
  wire \sgla/sub7/c2 ;
  wire \sgla/sub7/c3 ;
  wire \sgla/sub7/c4 ;
  wire \sgla/sub7/c5 ;
  wire \sgla/sub7/c6 ;
  wire \sgla/sub7/c7 ;
  wire \sgla/sub7/c8 ;
  wire \sgla/sub8/c0 ;
  wire \sgla/sub8/c1 ;
  wire \sgla/sub8/c2 ;
  wire \sgla/sub8/c3 ;
  wire \sgla/sub8/c4 ;
  wire \sgla/sub8/c5 ;
  wire \sgla/sub8/c6 ;
  wire \sgla/sub8/c7 ;
  wire \sgla/sub8/c8 ;
  wire \sgla/sub9/c0 ;
  wire \sgla/sub9/c1 ;
  wire \sgla/sub9/c2 ;
  wire \sgla/sub9/c3 ;
  wire \sgla/sub9/c4 ;
  wire \sgla/sub9/c5 ;
  wire \sgla/sub9/c6 ;
  wire \sgla/sub9/c7 ;
  wire \sgla/sub9/c8 ;
  wire \sgla/u152_sel_is_0_o ;
  wire \sglb/add0/c0 ;
  wire \sglb/add0/c1 ;
  wire \sglb/add0/c2 ;
  wire \sglb/add0/c3 ;
  wire \sglb/add0/c4 ;
  wire \sglb/add0/c5 ;
  wire \sglb/add0/c6 ;
  wire \sglb/add0/c7 ;
  wire \sglb/add0/c8 ;
  wire \sglb/add1/c0 ;
  wire \sglb/add1/c1 ;
  wire \sglb/add1/c2 ;
  wire \sglb/add1/c3 ;
  wire \sglb/add1/c4 ;
  wire \sglb/add2/c0 ;
  wire \sglb/add2/c1 ;
  wire \sglb/add2/c2 ;
  wire \sglb/add2/c3 ;
  wire \sglb/add2/c4 ;
  wire \sglb/add2/c5 ;
  wire \sglb/add3/c0 ;
  wire \sglb/add3/c1 ;
  wire \sglb/add3/c2 ;
  wire \sglb/add3/c3 ;
  wire \sglb/add3/c4 ;
  wire \sglb/add3/c5 ;
  wire \sglb/add3/c6 ;
  wire \sglb/add4/c0 ;
  wire \sglb/add4/c1 ;
  wire \sglb/add4/c2 ;
  wire \sglb/add4/c3 ;
  wire \sglb/add4/c4 ;
  wire \sglb/add4/c5 ;
  wire \sglb/add4/c6 ;
  wire \sglb/add4/c7 ;
  wire \sglb/add5/c0 ;
  wire \sglb/add5/c1 ;
  wire \sglb/add5/c2 ;
  wire \sglb/add5/c3 ;
  wire \sglb/add5/c4 ;
  wire \sglb/add5/c5 ;
  wire \sglb/add5/c6 ;
  wire \sglb/add5/c7 ;
  wire \sglb/add5/c8 ;
  wire \sglb/lt0_c0 ;
  wire \sglb/lt0_c1 ;
  wire \sglb/lt0_c2 ;
  wire \sglb/lt0_c3 ;
  wire \sglb/lt0_c4 ;
  wire \sglb/lt0_c5 ;
  wire \sglb/lt0_c6 ;
  wire \sglb/lt0_c7 ;
  wire \sglb/lt0_c8 ;
  wire \sglb/lt0_c9 ;
  wire \sglb/mux10_b28_sel_is_2_o ;
  wire \sglb/mux15_b0_sel_is_0_o ;
  wire \sglb/mux18_b0_sel_is_2_o ;
  wire \sglb/mux18_b29_sel_is_2_o ;
  wire \sglb/n107_lutinv ;
  wire \sglb/n110_lutinv ;
  wire \sglb/n111 ;
  wire \sglb/n7 ;
  wire \sglb/sub0/c0 ;
  wire \sglb/sub0/c1 ;
  wire \sglb/sub0/c2 ;
  wire \sglb/sub0/c3 ;
  wire \sglb/sub0/c4 ;
  wire \sglb/sub0/c5 ;
  wire \sglb/sub0/c6 ;
  wire \sglb/sub0/c7 ;
  wire \sglb/sub0/c8 ;

  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1000 (
    .a(\norm/mux27_b30_sel_is_0_o ),
    .b(\norm/sglc_f [28]),
    .c(\norm/sglc_f [29]),
    .o(_al_u1000_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u1001 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [25]),
    .c(\norm/sglc_f [26]),
    .d(\norm/sglc_f [27]),
    .o(_al_u1001_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1002 (
    .a(_al_u1001_o),
    .b(\norm/sglc_f [23]),
    .c(\norm/sglc_f [24]),
    .o(_al_u1002_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1003 (
    .a(_al_u1002_o),
    .b(\norm/sglc_f [21]),
    .c(\norm/sglc_f [22]),
    .o(_al_u1003_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1004 (
    .a(_al_u1003_o),
    .b(\norm/sglc_f [19]),
    .c(\norm/sglc_f [20]),
    .o(_al_u1004_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1005 (
    .a(_al_u1004_o),
    .b(\norm/sglc_f [17]),
    .c(\norm/sglc_f [18]),
    .o(_al_u1005_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u1006 (
    .a(\norm/sglc_f [2]),
    .b(\norm/sglc_f [3]),
    .c(\norm/sglc_f [4]),
    .d(\norm/sglc_f [5]),
    .o(_al_u1006_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u1007 (
    .a(_al_u1006_o),
    .b(\norm/sglc_f [6]),
    .c(\norm/sglc_f [7]),
    .d(\norm/sglc_f [8]),
    .e(\norm/sglc_f [9]),
    .o(_al_u1007_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u1008 (
    .a(\norm/sglc_f [10]),
    .b(\norm/sglc_f [11]),
    .c(\norm/sglc_f [12]),
    .d(\norm/sglc_f [15]),
    .o(_al_u1008_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u1009 (
    .a(_al_u1008_o),
    .b(\norm/sglc_f [0]),
    .c(\norm/sglc_f [1]),
    .d(\norm/sglc_f [13]),
    .e(\norm/sglc_f [14]),
    .o(_al_u1009_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    _al_u1010 (
    .a(_al_u1005_o),
    .b(_al_u1007_o),
    .c(_al_u1009_o),
    .d(\norm/sglc_f [16]),
    .o(\norm/n58_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~D*C*B))"),
    .INIT(16'h5515))
    _al_u1011 (
    .a(\norm/n58_lutinv ),
    .b(\norm/mux27_b30_sel_is_0_o ),
    .c(\norm/sglc_f [28]),
    .d(\norm/sglc_f [29]),
    .o(\fctl/n154_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(E*(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*B*C*D))"),
    .INIT(32'h40c30000))
    _al_u1012 (
    .a(\fctl/n154_lutinv ),
    .b(\fctl/stat [0]),
    .c(\fctl/stat [1]),
    .d(\fctl/stat [2]),
    .e(\fctl/stat [3]),
    .o(fctl_cbus_out_lutinv));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u1013 (
    .a(fctl_cbus_out_lutinv),
    .b(\fctl/crdy_f ),
    .o(crdy));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~B*~A)"),
    .INIT(32'h00010000))
    _al_u1014 (
    .a(ccmd[3]),
    .b(ccmd[2]),
    .c(ccmd[1]),
    .d(ccmd[0]),
    .e(_al_u995_o),
    .o(\fctl/n129_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(B*A*~(~D*~C))"),
    .INIT(16'h8880))
    _al_u1015 (
    .a(\sgla/sgla_rsft_fin ),
    .b(\sgla/sgla_lsft_fin ),
    .c(\sglb/n111 ),
    .d(fctl_ccmd_int),
    .o(_al_u1015_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    _al_u1016 (
    .a(\fctl/stat [0]),
    .b(\fctl/stat [1]),
    .c(\fctl/stat [2]),
    .d(\fctl/stat [3]),
    .o(\fctl/n123_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("~(~B*~A*~(D*C))"),
    .INIT(16'hfeee))
    _al_u1017 (
    .a(\fctl/n129_lutinv ),
    .b(fctl_cbus_out_lutinv),
    .c(_al_u1015_o),
    .d(\fctl/n123_lutinv ),
    .o(\fctl/crdy_t ));
  AL_MAP_LUT4 #(
    .EQN("(~C*(A*~(B)*~(D)+~(A)*B*D))"),
    .INIT(16'h0402))
    _al_u1018 (
    .a(\fctl/stat [0]),
    .b(\fctl/stat [1]),
    .c(\fctl/stat [2]),
    .d(\fctl/stat [3]),
    .o(fctl_rsft_enb_lutinv));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*~A)"),
    .INIT(16'h0010))
    _al_u1019 (
    .a(\sglb/n111 ),
    .b(\fdiv/n18 [8]),
    .c(fctl_rsft_enb_lutinv),
    .d(fctl_ccmd_int),
    .o(\sglb/n7 ));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~D*~C*~B))"),
    .INIT(16'haaa8))
    _al_u1020 (
    .a(\sglb/n7 ),
    .b(\fdiv/n18 [7]),
    .c(\fdiv/n18 [6]),
    .d(\fdiv/n18 [5]),
    .o(_al_u1020_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1021 (
    .a(fctl_load_a),
    .b(_al_u1020_o),
    .o(\sglb/mux15_b0_sel_is_0_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1022 (
    .a(\sglb/mux15_b0_sel_is_0_o ),
    .b(rst_n),
    .o(\sglb/mux18_b0_sel_is_2_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1023 (
    .a(\sglb/n7 ),
    .b(\fdiv/n18 [1]),
    .o(_al_u1023_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1024 (
    .a(\sglb/n7 ),
    .b(\fdiv/n18 [0]),
    .o(_al_u1024_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u1025 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[29]),
    .o(\sglb/n92 [29]));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u1026 (
    .a(\sgla/sgla_rsft_fin ),
    .b(\sgla/sgla_e_dif [8]),
    .c(fctl_rsft_enb_lutinv),
    .o(\sgla/n8 ));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~D*~C*~B))"),
    .INIT(16'haaa8))
    _al_u1027 (
    .a(\sgla/n8 ),
    .b(\sgla/sgla_e_dif [7]),
    .c(\sgla/sgla_e_dif [6]),
    .d(\sgla/sgla_e_dif [5]),
    .o(_al_u1027_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1028 (
    .a(fctl_load_a),
    .b(_al_u1027_o),
    .o(\sgla/mux27_b0_sel_is_0_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1029 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(rst_n),
    .o(\sgla/mux30_b0_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*~A)"),
    .INIT(32'h04000000))
    _al_u1030 (
    .a(\sgla/ccmd_f [0]),
    .b(\sgla/ccmd_f [1]),
    .c(\sgla/ccmd_f [2]),
    .d(\sgla/ccmd_f [3]),
    .e(\sgla/ccmd_f [4]),
    .o(_al_u1030_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1031 (
    .a(sgla_r[43]),
    .b(_al_u1030_o),
    .o(_al_u1031_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*~B*A)"),
    .INIT(32'h00200000))
    _al_u1032 (
    .a(\sgla/ccmd_f [0]),
    .b(\sgla/ccmd_f [1]),
    .c(\sgla/ccmd_f [2]),
    .d(\sgla/ccmd_f [3]),
    .e(\sgla/ccmd_f [4]),
    .o(_al_u1032_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*~B*A)"),
    .INIT(32'h02000000))
    _al_u1033 (
    .a(\sgla/ccmd_f [0]),
    .b(\sgla/ccmd_f [1]),
    .c(\sgla/ccmd_f [2]),
    .d(\sgla/ccmd_f [3]),
    .e(\sgla/ccmd_f [4]),
    .o(_al_u1033_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1034 (
    .a(_al_u1032_o),
    .b(_al_u1033_o),
    .o(\sgla/mux44_b0_sel_is_0_o ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*~A)"),
    .INIT(32'h10000000))
    _al_u1035 (
    .a(\sgla/ccmd_f [0]),
    .b(\sgla/ccmd_f [1]),
    .c(\sgla/ccmd_f [2]),
    .d(\sgla/ccmd_f [3]),
    .e(\sgla/ccmd_f [4]),
    .o(_al_u1035_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1036 (
    .a(_al_u957_o),
    .b(_al_u1035_o),
    .o(\sgla/mux41_b32_sel_is_2_o ));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u1037 (
    .a(\sgla/mux44_b0_sel_is_0_o ),
    .b(\sgla/mux41_b32_sel_is_2_o ),
    .c(_al_u1030_o),
    .o(_al_u1037_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u1038 (
    .a(\sgla/sgla_i [25]),
    .b(\sgla/sgla_i [26]),
    .c(\sgla/sgla_i [28]),
    .d(\sgla/sgla_i [29]),
    .o(_al_u1038_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1039 (
    .a(_al_u1038_o),
    .b(\sgla/sgla_i [23]),
    .c(\sgla/sgla_i [24]),
    .o(_al_u1039_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1040 (
    .a(_al_u1039_o),
    .b(\sgla/sgla_i [27]),
    .c(\sgla/sgla_i [30]),
    .o(_al_u1040_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1041 (
    .a(_al_u1037_o),
    .b(_al_u1040_o),
    .c(_al_u1030_o),
    .o(_al_u1041_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*C*B*~A)"),
    .INIT(32'h00400000))
    _al_u1042 (
    .a(\sgla/ccmd_f [0]),
    .b(\sgla/ccmd_f [1]),
    .c(\sgla/ccmd_f [2]),
    .d(\sgla/ccmd_f [3]),
    .e(\sgla/ccmd_f [4]),
    .o(_al_u1042_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1043 (
    .a(fctl_ccmd_div),
    .b(fctl_ccmd_reg),
    .o(\norm/mux1_b0_sel_is_2_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1044 (
    .a(_al_u1042_o),
    .b(\norm/mux1_b0_sel_is_2_o ),
    .o(_al_u1044_o));
  AL_MAP_LUT4 #(
    .EQN("(C*B*~(~D*~A))"),
    .INIT(16'hc080))
    _al_u1045 (
    .a(_al_u1031_o),
    .b(_al_u1041_o),
    .c(_al_u1044_o),
    .d(sgla_e[6]),
    .o(_al_u1045_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1046 (
    .a(_al_u1045_o),
    .b(sglc_r_fdiv[38]),
    .c(fctl_ccmd_div),
    .o(_al_u1046_o));
  AL_MAP_LUT5 #(
    .EQN("((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*~(E)*~(C)+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*~(C)+~((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D))*E*C+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*C)"),
    .INIT(32'hfaf30a03))
    _al_u1047 (
    .a(sglc_r_fmul[38]),
    .b(_al_u1046_o),
    .c(fctl_ccmd_add),
    .d(fctl_ccmd_mul),
    .e(sgla_e[6]),
    .o(\norm/sglc_r [38]));
  AL_MAP_LUT4 #(
    .EQN("(C*B*~(~D*~A))"),
    .INIT(16'hc080))
    _al_u1048 (
    .a(_al_u1031_o),
    .b(_al_u1041_o),
    .c(_al_u1044_o),
    .d(sgla_e[5]),
    .o(_al_u1048_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1049 (
    .a(_al_u1048_o),
    .b(sglc_r_fdiv[37]),
    .c(fctl_ccmd_div),
    .o(_al_u1049_o));
  AL_MAP_LUT5 #(
    .EQN("((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*~(E)*~(C)+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*~(C)+~((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D))*E*C+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*C)"),
    .INIT(32'hfaf30a03))
    _al_u1050 (
    .a(sglc_r_fmul[37]),
    .b(_al_u1049_o),
    .c(fctl_ccmd_add),
    .d(fctl_ccmd_mul),
    .e(sgla_e[5]),
    .o(\norm/sglc_r [37]));
  AL_MAP_LUT4 #(
    .EQN("(C*B*~(~D*~A))"),
    .INIT(16'hc080))
    _al_u1051 (
    .a(_al_u1031_o),
    .b(_al_u1041_o),
    .c(_al_u1044_o),
    .d(sgla_e[1]),
    .o(_al_u1051_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1052 (
    .a(_al_u1051_o),
    .b(sglc_r_fdiv[33]),
    .c(fctl_ccmd_div),
    .o(_al_u1052_o));
  AL_MAP_LUT5 #(
    .EQN("((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*~(E)*~(C)+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*~(C)+~((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D))*E*C+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*C)"),
    .INIT(32'hfaf30a03))
    _al_u1053 (
    .a(sglc_r_fmul[33]),
    .b(_al_u1052_o),
    .c(fctl_ccmd_add),
    .d(fctl_ccmd_mul),
    .e(sgla_e[1]),
    .o(\norm/sglc_r [33]));
  AL_MAP_LUT4 #(
    .EQN("(C*B*~(~D*~A))"),
    .INIT(16'hc080))
    _al_u1054 (
    .a(_al_u1031_o),
    .b(_al_u1041_o),
    .c(_al_u1044_o),
    .d(sgla_e[0]),
    .o(_al_u1054_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1055 (
    .a(_al_u1054_o),
    .b(sglc_r_fdiv[32]),
    .c(fctl_ccmd_div),
    .o(_al_u1055_o));
  AL_MAP_LUT5 #(
    .EQN("((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*~(E)*~(C)+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*~(C)+~((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D))*E*C+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*C)"),
    .INIT(32'hfaf30a03))
    _al_u1056 (
    .a(sglc_r_fmul[32]),
    .b(_al_u1055_o),
    .c(fctl_ccmd_add),
    .d(fctl_ccmd_mul),
    .e(sgla_e[0]),
    .o(\norm/sglc_r [32]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1057 (
    .a(\sgla/sgla_e_difl [8]),
    .b(\fctl/n123_lutinv ),
    .o(_al_u1057_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u1058 (
    .a(\sgla/sgla_lsft_fin ),
    .b(_al_u1057_o),
    .c(\sgla/sgla_e_difl [1]),
    .o(_al_u1058_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u1059 (
    .a(\sgla/sgla_lsft_fin ),
    .b(_al_u1057_o),
    .c(\sgla/sgla_e_difl [0]),
    .o(_al_u1059_o));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1060 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[29]),
    .d(sgla_r[30]),
    .e(sgla_r[31]),
    .o(_al_u1060_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u1061 (
    .a(\sgla/sgla_lsft_fin ),
    .b(_al_u1057_o),
    .c(\sgla/sgla_e_difl [2]),
    .o(_al_u1061_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u1062 (
    .a(\sgla/sgla_lsft_fin ),
    .b(_al_u1057_o),
    .c(\sgla/sgla_e_difl [3]),
    .o(_al_u1062_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1063 (
    .a(_al_u1060_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[23]),
    .e(sgla_r[27]),
    .o(_al_u1063_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    _al_u1064 (
    .a(\sgla/sgla_lsft_fin ),
    .b(_al_u1057_o),
    .c(\sgla/sgla_e_difl [4]),
    .o(_al_u1064_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1065 (
    .a(_al_u1063_o),
    .b(_al_u1064_o),
    .c(sgla_r[15]),
    .o(\sgla/n68 [31]));
  AL_MAP_LUT5 #(
    .EQN("(D*~(~C*~(B*~(~E*~A))))"),
    .INIT(32'hfc00f800))
    _al_u1066 (
    .a(_al_u1031_o),
    .b(_al_u1041_o),
    .c(_al_u1042_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(sgla_e[4]),
    .o(_al_u1066_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1067 (
    .a(_al_u1066_o),
    .b(sglc_r_fdiv[36]),
    .c(fctl_ccmd_div),
    .o(_al_u1067_o));
  AL_MAP_LUT5 #(
    .EQN("((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*~(E)*~(C)+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*~(C)+~((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D))*E*C+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*C)"),
    .INIT(32'hfaf30a03))
    _al_u1068 (
    .a(sglc_r_fmul[36]),
    .b(_al_u1067_o),
    .c(fctl_ccmd_add),
    .d(fctl_ccmd_mul),
    .e(sgla_e[4]),
    .o(\norm/sglc_r [36]));
  AL_MAP_LUT5 #(
    .EQN("(D*~(~C*~(B*~(~E*~A))))"),
    .INIT(32'hfc00f800))
    _al_u1069 (
    .a(_al_u1031_o),
    .b(_al_u1041_o),
    .c(_al_u1042_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(sgla_e[3]),
    .o(_al_u1069_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1070 (
    .a(_al_u1069_o),
    .b(sglc_r_fdiv[35]),
    .c(fctl_ccmd_div),
    .o(_al_u1070_o));
  AL_MAP_LUT5 #(
    .EQN("((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*~(E)*~(C)+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*~(C)+~((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D))*E*C+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*C)"),
    .INIT(32'hfaf30a03))
    _al_u1071 (
    .a(sglc_r_fmul[35]),
    .b(_al_u1070_o),
    .c(fctl_ccmd_add),
    .d(fctl_ccmd_mul),
    .e(sgla_e[3]),
    .o(\norm/sglc_r [35]));
  AL_MAP_LUT5 #(
    .EQN("(D*~(~C*~(B*~(~E*~A))))"),
    .INIT(32'hfc00f800))
    _al_u1072 (
    .a(_al_u1031_o),
    .b(_al_u1041_o),
    .c(_al_u1042_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(sgla_e[2]),
    .o(_al_u1072_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1073 (
    .a(_al_u1072_o),
    .b(sglc_r_fdiv[34]),
    .c(fctl_ccmd_div),
    .o(_al_u1073_o));
  AL_MAP_LUT5 #(
    .EQN("((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*~(E)*~(C)+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*~(C)+~((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D))*E*C+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*C)"),
    .INIT(32'hfaf30a03))
    _al_u1074 (
    .a(sglc_r_fmul[34]),
    .b(_al_u1073_o),
    .c(fctl_ccmd_add),
    .d(fctl_ccmd_mul),
    .e(sgla_e[2]),
    .o(\norm/sglc_r [34]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1075 (
    .a(_al_u1031_o),
    .b(_al_u1041_o),
    .o(_al_u1075_o));
  AL_MAP_LUT5 #(
    .EQN("(~(D*B)*~(E*C*A))"),
    .INIT(32'h135f33ff))
    _al_u1076 (
    .a(_al_u1075_o),
    .b(sglc_r_fdiv[39]),
    .c(_al_u1044_o),
    .d(fctl_ccmd_div),
    .e(sgla_e[7]),
    .o(_al_u1076_o));
  AL_MAP_LUT5 #(
    .EQN("((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*~(E)*~(C)+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*~(C)+~((~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D))*E*C+(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D)*E*C)"),
    .INIT(32'hfaf30a03))
    _al_u1077 (
    .a(sglc_r_fmul[39]),
    .b(_al_u1076_o),
    .c(fctl_ccmd_add),
    .d(fctl_ccmd_mul),
    .e(sgla_e[7]),
    .o(\norm/sglc_r [39]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u1078 (
    .a(\sglb/sglb_i [27]),
    .b(\sglb/sglb_i [28]),
    .c(\sglb/sglb_i [29]),
    .d(\sglb/sglb_i [30]),
    .o(_al_u1078_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u1079 (
    .a(_al_u1078_o),
    .b(\sglb/sglb_i [23]),
    .c(\sglb/sglb_i [24]),
    .d(\sglb/sglb_i [25]),
    .e(\sglb/sglb_i [26]),
    .o(_al_u1079_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*~A*~(~D*~B))"),
    .INIT(32'h05040000))
    _al_u1080 (
    .a(sglb_r[43]),
    .b(sgla_r[43]),
    .c(_al_u1040_o),
    .d(_al_u1079_o),
    .e(fctl_ccmd_div),
    .o(_al_u1080_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*B*~(D*C)))"),
    .INIT(32'h51115555))
    _al_u1081 (
    .a(_al_u1080_o),
    .b(sgla_r[43]),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(\sgla/mux41_b32_sel_is_2_o ),
    .e(_al_u1044_o),
    .o(_al_u1081_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~(~B*~A))"),
    .INIT(16'h000e))
    _al_u1082 (
    .a(sglb_r[43]),
    .b(sgla_r[43]),
    .c(_al_u1040_o),
    .d(_al_u1079_o),
    .o(sglc_r_fmul[43]));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(C)*~(E)+~A*C*~(E)+~(~A)*C*E+~A*C*E)*~(B)*~(D)+(~A*~(C)*~(E)+~A*C*~(E)+~(~A)*C*E+~A*C*E)*B*~(D)+~((~A*~(C)*~(E)+~A*C*~(E)+~(~A)*C*E+~A*C*E))*B*D+(~A*~(C)*~(E)+~A*C*~(E)+~(~A)*C*E+~A*C*E)*B*D)"),
    .INIT(32'hccf0cc55))
    _al_u1083 (
    .a(_al_u1081_o),
    .b(sglc_r_fadd[43]),
    .c(sglc_r_fmul[43]),
    .d(fctl_ccmd_add),
    .e(fctl_ccmd_mul),
    .o(\norm/sglc_r [43]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u1084 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[4]),
    .d(sglb_r[5]),
    .e(sglb_r[6]),
    .o(_al_u1084_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1085 (
    .a(\sglb/n7 ),
    .b(\fdiv/n18 [2]),
    .o(_al_u1085_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1086 (
    .a(_al_u1084_o),
    .b(_al_u1085_o),
    .c(sglb_r[8]),
    .o(_al_u1086_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1087 (
    .a(\sglb/n7 ),
    .b(\fdiv/n18 [4]),
    .o(_al_u1087_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1088 (
    .a(\sglb/n7 ),
    .b(\fdiv/n18 [3]),
    .o(_al_u1088_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u1089 (
    .a(_al_u1086_o),
    .b(_al_u1087_o),
    .c(_al_u1088_o),
    .d(sglb_r[12]),
    .e(sglb_r[20]),
    .o(\sglb/n98 [4]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u1090 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[3]),
    .d(sglb_r[4]),
    .e(sglb_r[5]),
    .o(_al_u1090_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1091 (
    .a(_al_u1090_o),
    .b(_al_u1085_o),
    .c(sglb_r[7]),
    .o(_al_u1091_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u1092 (
    .a(_al_u1091_o),
    .b(_al_u1087_o),
    .c(_al_u1088_o),
    .d(sglb_r[11]),
    .e(sglb_r[19]),
    .o(\sglb/n98 [3]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u1093 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[2]),
    .d(sglb_r[3]),
    .e(sglb_r[4]),
    .o(_al_u1093_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1094 (
    .a(_al_u1093_o),
    .b(_al_u1085_o),
    .c(sglb_r[6]),
    .o(_al_u1094_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u1095 (
    .a(_al_u1094_o),
    .b(_al_u1087_o),
    .c(_al_u1088_o),
    .d(sglb_r[10]),
    .e(sglb_r[18]),
    .o(\sglb/n98 [2]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u1096 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[1]),
    .d(sglb_r[2]),
    .e(sglb_r[3]),
    .o(_al_u1096_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1097 (
    .a(_al_u1096_o),
    .b(_al_u1085_o),
    .c(sglb_r[5]),
    .o(_al_u1097_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u1098 (
    .a(_al_u1097_o),
    .b(_al_u1087_o),
    .c(_al_u1088_o),
    .d(sglb_r[17]),
    .e(sglb_r[9]),
    .o(\sglb/n98 [1]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u1099 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[0]),
    .d(sglb_r[1]),
    .e(sglb_r[2]),
    .o(_al_u1099_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1100 (
    .a(_al_u1099_o),
    .b(_al_u1085_o),
    .c(sglb_r[4]),
    .o(_al_u1100_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'hfd31cd01))
    _al_u1101 (
    .a(_al_u1100_o),
    .b(_al_u1087_o),
    .c(_al_u1088_o),
    .d(sglb_r[16]),
    .e(sglb_r[8]),
    .o(\sglb/n98 [0]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1102 (
    .a(\sglb/mux15_b0_sel_is_0_o ),
    .b(_al_u1087_o),
    .o(_al_u1102_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1103 (
    .a(_al_u1102_o),
    .b(_al_u1088_o),
    .o(_al_u1103_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u1104 (
    .a(bbus[30]),
    .b(bbus[29]),
    .c(bbus[28]),
    .d(bbus[27]),
    .o(_al_u1104_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u1105 (
    .a(_al_u1104_o),
    .b(bbus[26]),
    .c(bbus[25]),
    .d(bbus[24]),
    .e(bbus[23]),
    .o(_al_u1105_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1106 (
    .a(_al_u1105_o),
    .b(fctl_load_a),
    .o(_al_u1106_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1107 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[23]),
    .d(sglb_r[24]),
    .e(sglb_r[25]),
    .o(\sglb/n92 [23]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u1108 (
    .a(\sglb/n92 [23]),
    .b(_al_u1085_o),
    .c(sglb_r[27]),
    .o(\sglb/n94 [23]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1109 (
    .a(_al_u1103_o),
    .b(_al_u1106_o),
    .c(bbus[18]),
    .d(\sglb/n94 [23]),
    .o(\sglb/n103 [23]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1110 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[22]),
    .d(sglb_r[23]),
    .e(sglb_r[24]),
    .o(\sglb/n92 [22]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u1111 (
    .a(\sglb/n92 [22]),
    .b(_al_u1085_o),
    .c(sglb_r[26]),
    .o(\sglb/n94 [22]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1112 (
    .a(_al_u1103_o),
    .b(_al_u1106_o),
    .c(bbus[17]),
    .d(\sglb/n94 [22]),
    .o(\sglb/n103 [22]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1113 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[25]),
    .d(sglb_r[26]),
    .e(sglb_r[27]),
    .o(\sglb/n92 [25]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u1114 (
    .a(\sglb/n92 [25]),
    .b(_al_u1085_o),
    .c(sglb_r[29]),
    .o(\sglb/n94 [25]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1115 (
    .a(_al_u1103_o),
    .b(_al_u1106_o),
    .c(bbus[20]),
    .d(\sglb/n94 [25]),
    .o(\sglb/n103 [25]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1116 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[24]),
    .d(sglb_r[25]),
    .e(sglb_r[26]),
    .o(\sglb/n92 [24]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u1117 (
    .a(\sglb/n92 [24]),
    .b(_al_u1085_o),
    .c(sglb_r[28]),
    .o(\sglb/n94 [24]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1118 (
    .a(_al_u1103_o),
    .b(_al_u1106_o),
    .c(bbus[19]),
    .d(\sglb/n94 [24]),
    .o(\sglb/n103 [24]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1119 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[28]),
    .d(sgla_r[29]),
    .e(sgla_r[30]),
    .o(_al_u1119_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1120 (
    .a(_al_u1119_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[22]),
    .e(sgla_r[26]),
    .o(_al_u1120_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1121 (
    .a(\sgla/n8 ),
    .b(\sgla/sgla_e_dif [0]),
    .o(_al_u1121_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~A*~(~E*~D*~C))"),
    .INIT(32'h44444440))
    _al_u1122 (
    .a(\sgla/sgla_lsft_fin ),
    .b(_al_u1057_o),
    .c(\sgla/sgla_e_difl [7]),
    .d(\sgla/sgla_e_difl [6]),
    .e(\sgla/sgla_e_difl [5]),
    .o(_al_u1122_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1123 (
    .a(_al_u1121_o),
    .b(_al_u1122_o),
    .o(\sgla/mux14_b31_sel_is_0_o ));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u1124 (
    .a(_al_u1120_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(sgla_r[14]),
    .o(_al_u1124_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u1125 (
    .a(_al_u1124_o),
    .b(_al_u1121_o),
    .c(sgla_r[31]),
    .o(\sgla/n72 [30]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1126 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[21]),
    .d(sglb_r[22]),
    .e(sglb_r[23]),
    .o(\sglb/n92 [21]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1127 (
    .a(\sglb/n92 [21]),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[25]),
    .e(sglb_r[29]),
    .o(\sglb/n96 [21]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1128 (
    .a(_al_u1102_o),
    .b(_al_u1106_o),
    .c(bbus[16]),
    .d(\sglb/n96 [21]),
    .o(\sglb/n103 [21]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1129 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[20]),
    .d(sglb_r[21]),
    .e(sglb_r[22]),
    .o(\sglb/n92 [20]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1130 (
    .a(\sglb/n92 [20]),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[24]),
    .e(sglb_r[28]),
    .o(\sglb/n96 [20]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1131 (
    .a(_al_u1102_o),
    .b(_al_u1106_o),
    .c(bbus[15]),
    .d(\sglb/n96 [20]),
    .o(\sglb/n103 [20]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1132 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[19]),
    .d(sglb_r[20]),
    .e(sglb_r[21]),
    .o(\sglb/n92 [19]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1133 (
    .a(\sglb/n92 [19]),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[23]),
    .e(sglb_r[27]),
    .o(\sglb/n96 [19]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1134 (
    .a(_al_u1102_o),
    .b(_al_u1106_o),
    .c(bbus[14]),
    .d(\sglb/n96 [19]),
    .o(\sglb/n103 [19]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1135 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[18]),
    .d(sglb_r[19]),
    .e(sglb_r[20]),
    .o(\sglb/n92 [18]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1136 (
    .a(\sglb/n92 [18]),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[22]),
    .e(sglb_r[26]),
    .o(\sglb/n96 [18]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1137 (
    .a(_al_u1102_o),
    .b(_al_u1106_o),
    .c(bbus[13]),
    .d(\sglb/n96 [18]),
    .o(\sglb/n103 [18]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1138 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[17]),
    .d(sglb_r[18]),
    .e(sglb_r[19]),
    .o(\sglb/n92 [17]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1139 (
    .a(\sglb/n92 [17]),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[21]),
    .e(sglb_r[25]),
    .o(\sglb/n96 [17]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1140 (
    .a(_al_u1102_o),
    .b(_al_u1106_o),
    .c(bbus[12]),
    .d(\sglb/n96 [17]),
    .o(\sglb/n103 [17]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1141 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[16]),
    .d(sglb_r[17]),
    .e(sglb_r[18]),
    .o(\sglb/n92 [16]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1142 (
    .a(\sglb/n92 [16]),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[20]),
    .e(sglb_r[24]),
    .o(\sglb/n96 [16]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1143 (
    .a(_al_u1102_o),
    .b(_al_u1106_o),
    .c(bbus[11]),
    .d(\sglb/n96 [16]),
    .o(\sglb/n103 [16]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1144 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[15]),
    .d(sglb_r[16]),
    .e(sglb_r[17]),
    .o(\sglb/n92 [15]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1145 (
    .a(\sglb/n92 [15]),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[19]),
    .e(sglb_r[23]),
    .o(\sglb/n96 [15]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1146 (
    .a(_al_u1102_o),
    .b(_al_u1106_o),
    .c(bbus[10]),
    .d(\sglb/n96 [15]),
    .o(\sglb/n103 [15]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1147 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[14]),
    .d(sglb_r[15]),
    .e(sglb_r[16]),
    .o(\sglb/n92 [14]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1148 (
    .a(\sglb/n92 [14]),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[18]),
    .e(sglb_r[22]),
    .o(\sglb/n96 [14]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1149 (
    .a(_al_u1102_o),
    .b(_al_u1106_o),
    .c(bbus[9]),
    .d(\sglb/n96 [14]),
    .o(\sglb/n103 [14]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u1150 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(\sglb/n75 [1]),
    .d(\sglb/n86 [2]),
    .e(sglb_e[2]),
    .o(\sglb/n91 [2]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u1151 (
    .a(\sglb/n91 [2]),
    .b(_al_u1085_o),
    .c(\sglb/n62 [0]),
    .o(\sglb/n93 [2]));
  AL_MAP_LUT4 #(
    .EQN("~(D*~(A)*~((~C*~B))+D*A*~((~C*~B))+~(D)*A*(~C*~B)+D*A*(~C*~B))"),
    .INIT(16'h01fd))
    _al_u1152 (
    .a(\sglb/n93 [2]),
    .b(_al_u1087_o),
    .c(_al_u1088_o),
    .d(sglb_e[2]),
    .o(_al_u1152_o));
  AL_MAP_LUT5 #(
    .EQN("((~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D)*~(B)*~(A)+(~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D)*B*~(A)+~((~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D))*B*A+(~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D)*B*A)"),
    .INIT(32'hdd8d888d))
    _al_u1153 (
    .a(fctl_load_a),
    .b(\sglb/n1 [2]),
    .c(_al_u1152_o),
    .d(_al_u1020_o),
    .e(\sglb/n11 [2]),
    .o(\sglb/n102 [2]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u1154 (
    .a(_al_u1087_o),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .o(\sglb/mux10_b28_sel_is_2_o ));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1155 (
    .a(_al_u1024_o),
    .b(\sglb/n86 [1]),
    .c(sglb_e[1]),
    .o(\sglb/n89 [1]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))*~(A)+E*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*~(A)+~(E)*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*A+E*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*A)"),
    .INIT(32'hfd5da808))
    _al_u1156 (
    .a(\sglb/mux10_b28_sel_is_2_o ),
    .b(\sglb/n89 [1]),
    .c(_al_u1023_o),
    .d(\sglb/n75 [0]),
    .e(sglb_e[1]),
    .o(\sglb/n97 [1]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*~(B)*~(A)+(C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*B*~(A)+~((C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D))*B*A+(C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*B*A)"),
    .INIT(32'hddd888d8))
    _al_u1157 (
    .a(fctl_load_a),
    .b(\sglb/n1 [1]),
    .c(\sglb/n97 [1]),
    .d(_al_u1020_o),
    .e(\sglb/n11 [1]),
    .o(\sglb/n102 [1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1158 (
    .a(\sglb/mux18_b0_sel_is_2_o ),
    .b(\sglb/mux10_b28_sel_is_2_o ),
    .o(\sglb/mux18_b29_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1159 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[27]),
    .d(sglb_r[28]),
    .e(sglb_r[29]),
    .o(\sglb/n92 [27]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*D*B)*~(C*A))"),
    .INIT(32'heca0a0a0))
    _al_u1160 (
    .a(_al_u1106_o),
    .b(\sglb/mux15_b0_sel_is_0_o ),
    .c(bbus[22]),
    .d(\sglb/mux10_b28_sel_is_2_o ),
    .e(\sglb/n92 [27]),
    .o(\sglb/n103 [27]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u1161 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[26]),
    .d(sglb_r[27]),
    .e(sglb_r[28]),
    .o(_al_u1161_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~E*D*B)*~(C*A))"),
    .INIT(32'ha0a0eca0))
    _al_u1162 (
    .a(_al_u1106_o),
    .b(\sglb/mux15_b0_sel_is_0_o ),
    .c(bbus[21]),
    .d(\sglb/mux10_b28_sel_is_2_o ),
    .e(_al_u1161_o),
    .o(\sglb/n103 [26]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1163 (
    .a(\sgla/n8 ),
    .b(\sgla/sgla_e_dif [3]),
    .o(_al_u1163_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1164 (
    .a(\sgla/n8 ),
    .b(\sgla/sgla_e_dif [4]),
    .o(_al_u1164_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1165 (
    .a(_al_u1163_o),
    .b(_al_u1164_o),
    .o(\sgla/mux21_b2_sel_is_0_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1166 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(\sgla/mux21_b2_sel_is_0_o ),
    .o(_al_u1166_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1167 (
    .a(\sgla/n8 ),
    .b(\sgla/sgla_e_dif [2]),
    .o(_al_u1167_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u1168 (
    .a(_al_u1166_o),
    .b(rst_n),
    .c(_al_u1167_o),
    .o(\sgla/mux30_b29_sel_is_2_o ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1169 (
    .a(\fadd/n4 [10]),
    .b(\fadd/sglc_f_t [31]),
    .o(_al_u1169_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u1170 (
    .a(\fadd/sglc_f_t [31]),
    .b(\fadd/sglc_f_t [11]),
    .c(\fadd/sglc_f_t [10]),
    .d(\fadd/sglc_f_t [9]),
    .e(\fadd/sglc_f_t [8]),
    .o(_al_u1170_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(~E*~D*~C*A))"),
    .INIT(32'h33333331))
    _al_u1171 (
    .a(_al_u1169_o),
    .b(_al_u1170_o),
    .c(\fadd/n4 [11]),
    .d(\fadd/n4 [9]),
    .e(\fadd/n4 [8]),
    .o(\fadd/eq0/or_or_xor_i0[8]_i1[8_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("~((~E*~D)*~((~B*~A))*~(C)+(~E*~D)*(~B*~A)*~(C)+~((~E*~D))*(~B*~A)*C+(~E*~D)*(~B*~A)*C)"),
    .INIT(32'hefefefe0))
    _al_u1172 (
    .a(\fadd/n4 [27]),
    .b(\fadd/n4 [26]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [27]),
    .e(\fadd/sglc_f_t [26]),
    .o(\fadd/eq0/or_xor_i0[26]_i1[26]_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1173 (
    .a(\fadd/sglc_f_t [25]),
    .b(\fadd/sglc_f_t [24]),
    .o(_al_u1173_o));
  AL_MAP_LUT5 #(
    .EQN("~((~E*C)*~((~B*~A))*~(D)+(~E*C)*(~B*~A)*~(D)+~((~E*C))*(~B*~A)*D+(~E*C)*(~B*~A)*D)"),
    .INIT(32'heeffee0f))
    _al_u1174 (
    .a(\fadd/n4 [25]),
    .b(\fadd/n4 [24]),
    .c(_al_u1173_o),
    .d(\fadd/sglc_f_t [31]),
    .e(\fadd/sglc_f_t [30]),
    .o(_al_u1174_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1175 (
    .a(\fadd/sglc_f_t [31]),
    .b(\fadd/n4 [1]),
    .c(\fadd/sglc_f_t [1]),
    .o(_al_u1175_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1176 (
    .a(\fadd/sglc_f_t [7]),
    .b(\fadd/sglc_f_t [6]),
    .o(_al_u1176_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(D*~((~C*~B))*~(E)+D*(~C*~B)*~(E)+~(D)*(~C*~B)*E+D*(~C*~B)*E))"),
    .INIT(32'h0202aa00))
    _al_u1177 (
    .a(_al_u1175_o),
    .b(\fadd/n4 [7]),
    .c(\fadd/n4 [6]),
    .d(_al_u1176_o),
    .e(\fadd/sglc_f_t [31]),
    .o(_al_u1177_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1178 (
    .a(\fadd/sglc_f_t [31]),
    .b(\fadd/n4 [0]),
    .c(\fadd/sglc_f_t [0]),
    .o(_al_u1178_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*~B*~A)"),
    .INIT(32'h01000000))
    _al_u1179 (
    .a(\fadd/eq0/or_or_xor_i0[8]_i1[8_o_lutinv ),
    .b(\fadd/eq0/or_xor_i0[26]_i1[26]_o_lutinv ),
    .c(_al_u1174_o),
    .d(_al_u1177_o),
    .e(_al_u1178_o),
    .o(_al_u1179_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1180 (
    .a(\fadd/n4 [3]),
    .b(\fadd/n4 [2]),
    .o(_al_u1180_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u1181 (
    .a(\fadd/sglc_f_t [31]),
    .b(\fadd/sglc_f_t [5]),
    .c(\fadd/sglc_f_t [4]),
    .d(\fadd/sglc_f_t [3]),
    .e(\fadd/sglc_f_t [2]),
    .o(_al_u1181_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(E*~D*~C*A))"),
    .INIT(32'h33313333))
    _al_u1182 (
    .a(_al_u1180_o),
    .b(_al_u1181_o),
    .c(\fadd/n4 [5]),
    .d(\fadd/n4 [4]),
    .e(\fadd/sglc_f_t [31]),
    .o(_al_u1182_o));
  AL_MAP_LUT5 #(
    .EQN("~((~E*~D)*~((~B*~A))*~(C)+(~E*~D)*(~B*~A)*~(C)+~((~E*~D))*(~B*~A)*C+(~E*~D)*(~B*~A)*C)"),
    .INIT(32'hefefefe0))
    _al_u1183 (
    .a(\fadd/n4 [15]),
    .b(\fadd/n4 [14]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [15]),
    .e(\fadd/sglc_f_t [14]),
    .o(\fadd/eq0/or_xor_i0[14]_i1[14]_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("~((~E*~D)*~((~B*~A))*~(C)+(~E*~D)*(~B*~A)*~(C)+~((~E*~D))*(~B*~A)*C+(~E*~D)*(~B*~A)*C)"),
    .INIT(32'hefefefe0))
    _al_u1184 (
    .a(\fadd/n4 [13]),
    .b(\fadd/n4 [12]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [13]),
    .e(\fadd/sglc_f_t [12]),
    .o(\fadd/eq0/or_xor_i0[12]_i1[12]_o_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u1185 (
    .a(_al_u1182_o),
    .b(\fadd/eq0/or_xor_i0[14]_i1[14]_o_lutinv ),
    .c(\fadd/eq0/or_xor_i0[12]_i1[12]_o_lutinv ),
    .o(_al_u1185_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1186 (
    .a(\fadd/n4 [28]),
    .b(\fadd/sglc_f_t [31]),
    .o(_al_u1186_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u1187 (
    .a(\fadd/sglc_f_t [31]),
    .b(\fadd/sglc_f_t [29]),
    .c(\fadd/sglc_f_t [28]),
    .o(_al_u1187_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~(~D*~C*~B*A))"),
    .INIT(32'h0000fffd))
    _al_u1188 (
    .a(_al_u1186_o),
    .b(\fadd/n4 [31]),
    .c(\fadd/n4 [30]),
    .d(\fadd/n4 [29]),
    .e(_al_u1187_o),
    .o(_al_u1188_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1189 (
    .a(\fadd/n4 [20]),
    .b(\fadd/sglc_f_t [31]),
    .o(_al_u1189_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u1190 (
    .a(\fadd/sglc_f_t [31]),
    .b(\fadd/sglc_f_t [23]),
    .c(\fadd/sglc_f_t [22]),
    .d(\fadd/sglc_f_t [21]),
    .e(\fadd/sglc_f_t [20]),
    .o(_al_u1190_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(~E*~D*~C*A))"),
    .INIT(32'h33333331))
    _al_u1191 (
    .a(_al_u1189_o),
    .b(_al_u1190_o),
    .c(\fadd/n4 [23]),
    .d(\fadd/n4 [22]),
    .e(\fadd/n4 [21]),
    .o(\fadd/eq0/or_or_xor_i0[20]_i1[_o_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1192 (
    .a(\fadd/n4 [16]),
    .b(\fadd/sglc_f_t [31]),
    .o(_al_u1192_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*~A)"),
    .INIT(32'h00000001))
    _al_u1193 (
    .a(\fadd/sglc_f_t [31]),
    .b(\fadd/sglc_f_t [19]),
    .c(\fadd/sglc_f_t [18]),
    .d(\fadd/sglc_f_t [17]),
    .e(\fadd/sglc_f_t [16]),
    .o(_al_u1193_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(~E*~D*~C*A))"),
    .INIT(32'h33333331))
    _al_u1194 (
    .a(_al_u1192_o),
    .b(_al_u1193_o),
    .c(\fadd/n4 [19]),
    .d(\fadd/n4 [18]),
    .e(\fadd/n4 [17]),
    .o(\fadd/eq0/or_or_xor_i0[16]_i1[_o_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u1195 (
    .a(_al_u1179_o),
    .b(_al_u1185_o),
    .c(_al_u1188_o),
    .d(\fadd/eq0/or_or_xor_i0[20]_i1[_o_lutinv ),
    .e(\fadd/eq0/or_or_xor_i0[16]_i1[_o_lutinv ),
    .o(sglc_r_fadd[42]));
  AL_MAP_LUT5 #(
    .EQN("(~C*(~(A)*B*~(D)*~(E)+~(A)*B*D*~(E)+~(A)*~(B)*~(D)*E+~(A)*~(B)*D*E+A*~(B)*D*E+A*B*D*E))"),
    .INIT(32'h0b010404))
    _al_u1196 (
    .a(sglc_r_fadd[42]),
    .b(\fadd/sglc_f_t [31]),
    .c(sglc_r_fadd[43]),
    .d(sglb_r[41]),
    .e(sgla_r[41]),
    .o(_al_u1196_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1197 (
    .a(\sglb/n110_lutinv ),
    .b(\sglb/n107_lutinv ),
    .o(sglb_r[44]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1198 (
    .a(\sgla/n131_lutinv ),
    .b(\sgla/n182_lutinv ),
    .o(sgla_r[44]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1199 (
    .a(sglb_r[44]),
    .b(sgla_r[44]),
    .o(_al_u1199_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1200 (
    .a(sglb_r[43]),
    .b(sgla_r[43]),
    .o(\fdiv/n6_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~B*A*~(D*C)))"),
    .INIT(32'hfddd0000))
    _al_u1201 (
    .a(_al_u1199_o),
    .b(\fdiv/n6_lutinv ),
    .c(_al_u1040_o),
    .d(_al_u1079_o),
    .e(fctl_ccmd_div),
    .o(_al_u1201_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~A*~(C*~B))"),
    .INIT(16'h0045))
    _al_u1202 (
    .a(_al_u1201_o),
    .b(_al_u924_o),
    .c(fctl_ccmd_div),
    .d(fctl_ccmd_mul),
    .o(_al_u1202_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*C)*~(D*B))"),
    .INIT(32'h020a22aa))
    _al_u1203 (
    .a(_al_u1199_o),
    .b(sglb_r[43]),
    .c(sgla_r[43]),
    .d(_al_u1040_o),
    .e(_al_u1079_o),
    .o(_al_u1203_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1204 (
    .a(_al_u1203_o),
    .b(fctl_ccmd_mul),
    .o(_al_u1204_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u1205 (
    .a(_al_u1040_o),
    .b(\sgla/mux41_b32_sel_is_2_o ),
    .c(_al_u1030_o),
    .o(_al_u1205_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~B*~(A)*~(E)+~B*A*~(E)+~(~B)*A*E+~B*A*E)*~(D)*~(C)+~(~B*~(A)*~(E)+~B*A*~(E)+~(~B)*A*E+~B*A*E)*D*~(C)+~(~(~B*~(A)*~(E)+~B*A*~(E)+~(~B)*A*E+~B*A*E))*D*C+~(~B*~(A)*~(E)+~B*A*~(E)+~(~B)*A*E+~B*A*E)*D*C)"),
    .INIT(32'h0afa03f3))
    _al_u1206 (
    .a(_al_u1205_o),
    .b(_al_u1032_o),
    .c(_al_u1033_o),
    .d(sglb_r[41]),
    .e(sgla_r[41]),
    .o(_al_u1206_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*B)*~(~(D*~C)*A))"),
    .INIT(32'h13115f55))
    _al_u1207 (
    .a(_al_u1202_o),
    .b(_al_u1204_o),
    .c(_al_u1206_o),
    .d(_al_u1044_o),
    .e(_al_u924_o),
    .o(\norm/n2 [41]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1208 (
    .a(\fadd/inf_nan ),
    .b(_al_u1199_o),
    .o(_al_u1208_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u1209 (
    .a(_al_u1208_o),
    .b(\fadd/inf_s ),
    .c(sglc_r_fadd[43]),
    .o(_al_u1209_o));
  AL_MAP_LUT4 #(
    .EQN("~(~B*~((C*~A))*~(D)+~B*(C*~A)*~(D)+~(~B)*(C*~A)*D+~B*(C*~A)*D)"),
    .INIT(16'hafcc))
    _al_u1210 (
    .a(_al_u1196_o),
    .b(\norm/n2 [41]),
    .c(_al_u1209_o),
    .d(fctl_ccmd_add),
    .o(\norm/sglc_r [41]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u1211 (
    .a(\sgla/n182_lutinv ),
    .b(\sglb/n107_lutinv ),
    .c(_al_u1079_o),
    .o(\fctl/n114_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("~(~E*~D*C*B*A)"),
    .INIT(32'hffffff7f))
    _al_u1212 (
    .a(\fctl/n114_lutinv ),
    .b(\fctl/stat [0]),
    .c(\fctl/stat [1]),
    .d(\fctl/stat [2]),
    .e(\fctl/stat [3]),
    .o(\fctl/n164 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~A*~(D*~C*B))"),
    .INIT(32'h00005155))
    _al_u1213 (
    .a(_al_u1201_o),
    .b(sgla_r[44]),
    .c(_al_u1037_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(fctl_ccmd_mul),
    .o(_al_u1213_o));
  AL_MAP_LUT4 #(
    .EQN("~(~(~B*~A)*~(C)*~(D)+~(~B*~A)*C*~(D)+~(~(~B*~A))*C*D+~(~B*~A)*C*D)"),
    .INIT(16'h0f11))
    _al_u1214 (
    .a(_al_u1213_o),
    .b(_al_u1204_o),
    .c(_al_u1208_o),
    .d(fctl_ccmd_add),
    .o(\norm/sglc_r [44]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1215 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[27]),
    .d(sgla_r[28]),
    .e(sgla_r[29]),
    .o(_al_u1215_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1216 (
    .a(_al_u1215_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[21]),
    .e(sgla_r[25]),
    .o(_al_u1216_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))"),
    .INIT(16'h0d01))
    _al_u1217 (
    .a(_al_u1216_o),
    .b(_al_u1064_o),
    .c(_al_u1122_o),
    .d(sgla_r[13]),
    .o(\sgla/n70 [29]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1218 (
    .a(\sgla/n8 ),
    .b(\sgla/sgla_e_dif [1]),
    .o(_al_u1218_o));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'hfef20e02))
    _al_u1219 (
    .a(\sgla/n70 [29]),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[30]),
    .e(sgla_r[31]),
    .o(\sgla/n74 [29]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u1220 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[10]),
    .d(sglb_r[11]),
    .e(sglb_r[9]),
    .o(_al_u1220_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1221 (
    .a(_al_u1220_o),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[13]),
    .e(sglb_r[17]),
    .o(_al_u1221_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1222 (
    .a(_al_u1221_o),
    .b(_al_u1087_o),
    .c(sglb_r[25]),
    .o(\sglb/n98 [9]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u1223 (
    .a(_al_u1106_o),
    .b(\sglb/mux15_b0_sel_is_0_o ),
    .c(bbus[4]),
    .d(\sglb/n98 [9]),
    .o(\sglb/n103 [9]));
  AL_MAP_LUT5 #(
    .EQN("~((D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B)*~(C)*~(A)+(D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B)*C*~(A)+~((D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B))*C*A+(D*~(E)*~(B)+D*E*~(B)+~(D)*E*B+D*E*B)*C*A)"),
    .INIT(32'h0a1b4e5f))
    _al_u1224 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[10]),
    .d(sglb_r[8]),
    .e(sglb_r[9]),
    .o(_al_u1224_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1225 (
    .a(_al_u1224_o),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[12]),
    .e(sglb_r[16]),
    .o(_al_u1225_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1226 (
    .a(_al_u1225_o),
    .b(_al_u1087_o),
    .c(sglb_r[24]),
    .o(\sglb/n98 [8]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u1227 (
    .a(_al_u1106_o),
    .b(\sglb/mux15_b0_sel_is_0_o ),
    .c(bbus[3]),
    .d(\sglb/n98 [8]),
    .o(\sglb/n103 [8]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u1228 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[7]),
    .d(sglb_r[8]),
    .e(sglb_r[9]),
    .o(_al_u1228_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1229 (
    .a(_al_u1228_o),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[11]),
    .e(sglb_r[15]),
    .o(_al_u1229_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1230 (
    .a(_al_u1229_o),
    .b(_al_u1087_o),
    .c(sglb_r[23]),
    .o(\sglb/n98 [7]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u1231 (
    .a(_al_u1106_o),
    .b(\sglb/mux15_b0_sel_is_0_o ),
    .c(bbus[2]),
    .d(\sglb/n98 [7]),
    .o(\sglb/n103 [7]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u1232 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[6]),
    .d(sglb_r[7]),
    .e(sglb_r[8]),
    .o(_al_u1232_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1233 (
    .a(_al_u1232_o),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[10]),
    .e(sglb_r[14]),
    .o(_al_u1233_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1234 (
    .a(_al_u1233_o),
    .b(_al_u1087_o),
    .c(sglb_r[22]),
    .o(\sglb/n98 [6]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u1235 (
    .a(_al_u1106_o),
    .b(\sglb/mux15_b0_sel_is_0_o ),
    .c(bbus[1]),
    .d(\sglb/n98 [6]),
    .o(\sglb/n103 [6]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u1236 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[5]),
    .d(sglb_r[6]),
    .e(sglb_r[7]),
    .o(_al_u1236_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u1237 (
    .a(_al_u1236_o),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[13]),
    .e(sglb_r[9]),
    .o(_al_u1237_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1238 (
    .a(_al_u1237_o),
    .b(_al_u1087_o),
    .c(sglb_r[21]),
    .o(\sglb/n98 [5]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u1239 (
    .a(_al_u1106_o),
    .b(\sglb/mux15_b0_sel_is_0_o ),
    .c(bbus[0]),
    .d(\sglb/n98 [5]),
    .o(\sglb/n103 [5]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u1240 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[13]),
    .d(sglb_r[14]),
    .e(sglb_r[15]),
    .o(_al_u1240_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1241 (
    .a(_al_u1240_o),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[17]),
    .e(sglb_r[21]),
    .o(_al_u1241_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1242 (
    .a(_al_u1241_o),
    .b(_al_u1087_o),
    .c(sglb_r[29]),
    .o(\sglb/n98 [13]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u1243 (
    .a(_al_u1106_o),
    .b(\sglb/mux15_b0_sel_is_0_o ),
    .c(bbus[8]),
    .d(\sglb/n98 [13]),
    .o(\sglb/n103 [13]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u1244 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[12]),
    .d(sglb_r[13]),
    .e(sglb_r[14]),
    .o(_al_u1244_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1245 (
    .a(_al_u1244_o),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[16]),
    .e(sglb_r[20]),
    .o(_al_u1245_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1246 (
    .a(_al_u1245_o),
    .b(_al_u1087_o),
    .c(sglb_r[28]),
    .o(\sglb/n98 [12]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u1247 (
    .a(_al_u1106_o),
    .b(\sglb/mux15_b0_sel_is_0_o ),
    .c(bbus[7]),
    .d(\sglb/n98 [12]),
    .o(\sglb/n103 [12]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u1248 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[11]),
    .d(sglb_r[12]),
    .e(sglb_r[13]),
    .o(_al_u1248_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1249 (
    .a(_al_u1248_o),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[15]),
    .e(sglb_r[19]),
    .o(_al_u1249_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1250 (
    .a(_al_u1249_o),
    .b(_al_u1087_o),
    .c(sglb_r[27]),
    .o(\sglb/n98 [11]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u1251 (
    .a(_al_u1106_o),
    .b(\sglb/mux15_b0_sel_is_0_o ),
    .c(bbus[6]),
    .d(\sglb/n98 [11]),
    .o(\sglb/n103 [11]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'h0145abef))
    _al_u1252 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(sglb_r[10]),
    .d(sglb_r[11]),
    .e(sglb_r[12]),
    .o(_al_u1252_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1253 (
    .a(_al_u1252_o),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(sglb_r[14]),
    .e(sglb_r[18]),
    .o(_al_u1253_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1254 (
    .a(_al_u1253_o),
    .b(_al_u1087_o),
    .c(sglb_r[26]),
    .o(\sglb/n98 [10]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*B)*~(C*A))"),
    .INIT(16'heca0))
    _al_u1255 (
    .a(_al_u1106_o),
    .b(\sglb/mux15_b0_sel_is_0_o ),
    .c(bbus[5]),
    .d(\sglb/n98 [10]),
    .o(\sglb/n103 [10]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u1256 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(\sglb/n75 [7]),
    .d(\sglb/n86 [8]),
    .e(sglb_e[8]),
    .o(\sglb/n91 [8]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u1257 (
    .a(\sglb/n91 [8]),
    .b(_al_u1085_o),
    .c(\sglb/n62 [6]),
    .o(\sglb/n93 [8]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1258 (
    .a(\sglb/n93 [8]),
    .b(_al_u1087_o),
    .c(_al_u1088_o),
    .d(\sglb/n45 [5]),
    .e(\sglb/n20 [4]),
    .o(\sglb/n97 [8]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*~(B)*~(A)+(C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*B*~(A)+~((C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D))*B*A+(C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*B*A)"),
    .INIT(32'hddd888d8))
    _al_u1259 (
    .a(fctl_load_a),
    .b(\sglb/n1 [8]),
    .c(\sglb/n97 [8]),
    .d(_al_u1020_o),
    .e(\sglb/n11 [8]),
    .o(\sglb/n102 [8]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1260 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(\sglb/n75 [6]),
    .d(\sglb/n86 [7]),
    .e(sglb_e[7]),
    .o(_al_u1260_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u1261 (
    .a(_al_u1260_o),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(\sglb/n45 [4]),
    .e(\sglb/n62 [5]),
    .o(_al_u1261_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u1262 (
    .a(_al_u1261_o),
    .b(_al_u1020_o),
    .c(_al_u1087_o),
    .d(\sglb/n11 [7]),
    .e(\sglb/n20 [3]),
    .o(_al_u1262_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h8d))
    _al_u1263 (
    .a(fctl_load_a),
    .b(\sglb/n1 [7]),
    .c(_al_u1262_o),
    .o(\sglb/n102 [7]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u1264 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(\sglb/n75 [5]),
    .d(\sglb/n86 [6]),
    .e(sglb_e[6]),
    .o(\sglb/n91 [6]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u1265 (
    .a(\sglb/n91 [6]),
    .b(_al_u1085_o),
    .c(\sglb/n62 [4]),
    .o(\sglb/n93 [6]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1266 (
    .a(\sglb/n93 [6]),
    .b(_al_u1087_o),
    .c(_al_u1088_o),
    .d(\sglb/n45 [3]),
    .e(\sglb/n20 [2]),
    .o(\sglb/n97 [6]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*~(B)*~(A)+(C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*B*~(A)+~((C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D))*B*A+(C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*B*A)"),
    .INIT(32'hddd888d8))
    _al_u1267 (
    .a(fctl_load_a),
    .b(\sglb/n1 [6]),
    .c(\sglb/n97 [6]),
    .d(_al_u1020_o),
    .e(\sglb/n11 [6]),
    .o(\sglb/n102 [6]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1268 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(\sglb/n75 [4]),
    .d(\sglb/n86 [5]),
    .e(sglb_e[5]),
    .o(_al_u1268_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u1269 (
    .a(_al_u1268_o),
    .b(_al_u1088_o),
    .c(_al_u1085_o),
    .d(\sglb/n45 [2]),
    .e(\sglb/n62 [3]),
    .o(_al_u1269_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u1270 (
    .a(_al_u1269_o),
    .b(_al_u1020_o),
    .c(_al_u1087_o),
    .d(\sglb/n11 [5]),
    .e(\sglb/n20 [1]),
    .o(_al_u1270_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h8d))
    _al_u1271 (
    .a(fctl_load_a),
    .b(\sglb/n1 [5]),
    .c(_al_u1270_o),
    .o(\sglb/n102 [5]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u1272 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(\sglb/n75 [3]),
    .d(\sglb/n86 [4]),
    .e(sglb_e[4]),
    .o(\sglb/n91 [4]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u1273 (
    .a(\sglb/n91 [4]),
    .b(_al_u1085_o),
    .c(\sglb/n62 [2]),
    .o(\sglb/n93 [4]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1274 (
    .a(\sglb/n93 [4]),
    .b(_al_u1087_o),
    .c(_al_u1088_o),
    .d(\sglb/n45 [1]),
    .e(\sglb/n20 [0]),
    .o(\sglb/n97 [4]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*~(B)*~(A)+(C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*B*~(A)+~((C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D))*B*A+(C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*B*A)"),
    .INIT(32'hddd888d8))
    _al_u1275 (
    .a(fctl_load_a),
    .b(\sglb/n1 [4]),
    .c(\sglb/n97 [4]),
    .d(_al_u1020_o),
    .e(\sglb/n11 [4]),
    .o(\sglb/n102 [4]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u1276 (
    .a(_al_u1023_o),
    .b(_al_u1024_o),
    .c(\sglb/n75 [2]),
    .d(\sglb/n86 [3]),
    .e(sglb_e[3]),
    .o(\sglb/n91 [3]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u1277 (
    .a(\sglb/n91 [3]),
    .b(_al_u1085_o),
    .c(\sglb/n62 [1]),
    .o(\sglb/n93 [3]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1278 (
    .a(\sglb/n93 [3]),
    .b(_al_u1087_o),
    .c(_al_u1088_o),
    .d(\sglb/n45 [0]),
    .e(sglb_e[3]),
    .o(\sglb/n97 [3]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*~(B)*~(A)+(C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*B*~(A)+~((C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D))*B*A+(C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*B*A)"),
    .INIT(32'hddd888d8))
    _al_u1279 (
    .a(fctl_load_a),
    .b(\sglb/n1 [3]),
    .c(\sglb/n97 [3]),
    .d(_al_u1020_o),
    .e(\sglb/n11 [3]),
    .o(\sglb/n102 [3]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u1280 (
    .a(_al_u1024_o),
    .b(sglb_r[28]),
    .c(sglb_r[29]),
    .o(_al_u1280_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~(~E*~D*C*B))"),
    .INIT(32'haaaaaaea))
    _al_u1281 (
    .a(_al_u1106_o),
    .b(\sglb/mux15_b0_sel_is_0_o ),
    .c(\sglb/mux10_b28_sel_is_2_o ),
    .d(_al_u1280_o),
    .e(_al_u1023_o),
    .o(\sglb/n103 [28]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1282 (
    .a(\sgla/mux30_b29_sel_is_2_o ),
    .b(_al_u1218_o),
    .o(\sgla/mux30_b30_sel_is_2_o ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1283 (
    .a(\sgla/mux14_b31_sel_is_0_o ),
    .b(_al_u1064_o),
    .c(_al_u1062_o),
    .o(_al_u1283_o));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1284 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[2]),
    .d(sgla_r[3]),
    .e(sgla_r[4]),
    .o(_al_u1284_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1285 (
    .a(_al_u1283_o),
    .b(_al_u1284_o),
    .c(_al_u1061_o),
    .d(sgla_r[0]),
    .o(_al_u1285_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1286 (
    .a(_al_u1285_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[5]),
    .e(sgla_r[6]),
    .o(_al_u1286_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u1287 (
    .a(_al_u1286_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[12]),
    .e(sgla_r[8]),
    .o(_al_u1287_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1288 (
    .a(_al_u1287_o),
    .b(_al_u1164_o),
    .c(sgla_r[20]),
    .o(\sgla/n80 [4]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D)*~((~C*B*A))+E*D*~((~C*B*A))+~(E)*D*(~C*B*A)+E*D*(~C*B*A))"),
    .INIT(32'hfff70800))
    _al_u1289 (
    .a(\sglb/mux10_b28_sel_is_2_o ),
    .b(_al_u1024_o),
    .c(\fdiv/n18 [1]),
    .d(\sglb/n86 [0]),
    .e(sglb_e[0]),
    .o(\sglb/n97 [0]));
  AL_MAP_LUT5 #(
    .EQN("(A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*B*~(C)*D*~(E)+A*B*C*D*~(E)+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hffd888d8))
    _al_u1290 (
    .a(fctl_load_a),
    .b(\sglb/n1 [0]),
    .c(\sglb/n97 [0]),
    .d(_al_u1020_o),
    .e(\sglb/n11 [0]),
    .o(\sglb/n102 [0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1291 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [48]),
    .c(sgla_r[30]),
    .o(\fdiv/den [48]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1292 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [47]),
    .c(sgla_r[29]),
    .o(\fdiv/den [47]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1293 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [46]),
    .c(sgla_r[28]),
    .o(\fdiv/den [46]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1294 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [45]),
    .c(sgla_r[27]),
    .o(\fdiv/den [45]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1295 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [44]),
    .c(sgla_r[26]),
    .o(\fdiv/den [44]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1296 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [43]),
    .c(sgla_r[25]),
    .o(\fdiv/den [43]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1297 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [42]),
    .c(sgla_r[24]),
    .o(\fdiv/den [42]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1298 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [41]),
    .c(sgla_r[23]),
    .o(\fdiv/den [41]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1299 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [40]),
    .c(sgla_r[22]),
    .o(\fdiv/den [40]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1300 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [39]),
    .c(sgla_r[21]),
    .o(\fdiv/den [39]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1301 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [38]),
    .c(sgla_r[20]),
    .o(\fdiv/den [38]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1302 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [37]),
    .c(sgla_r[19]),
    .o(\fdiv/den [37]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1303 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [36]),
    .c(sgla_r[18]),
    .o(\fdiv/den [36]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1304 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [35]),
    .c(sgla_r[17]),
    .o(\fdiv/den [35]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1305 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [34]),
    .c(sgla_r[16]),
    .o(\fdiv/den [34]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1306 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [33]),
    .c(sgla_r[15]),
    .o(\fdiv/den [33]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1307 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [32]),
    .c(sgla_r[14]),
    .o(\fdiv/den [32]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1308 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [31]),
    .c(sgla_r[13]),
    .o(\fdiv/den [31]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1309 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [30]),
    .c(sgla_r[12]),
    .o(\fdiv/den [30]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1310 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [29]),
    .c(sgla_r[11]),
    .o(\fdiv/den [29]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1311 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [28]),
    .c(sgla_r[10]),
    .o(\fdiv/den [28]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1312 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [27]),
    .c(sgla_r[9]),
    .o(\fdiv/den [27]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1313 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [26]),
    .c(sgla_r[8]),
    .o(\fdiv/den [26]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1314 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [25]),
    .c(sgla_r[7]),
    .o(\fdiv/den [25]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1315 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [24]),
    .c(sgla_r[6]),
    .o(\fdiv/den [24]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    _al_u1316 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [23]),
    .c(sgla_r[5]),
    .o(\fdiv/den [23]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1317 (
    .a(\fctl/n164 ),
    .b(sgla_r[4]),
    .o(\fdiv/den [22]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1318 (
    .a(\fctl/n164 ),
    .b(sgla_r[3]),
    .o(\fdiv/den [21]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1319 (
    .a(\fctl/n164 ),
    .b(sgla_r[2]),
    .o(\fdiv/den [20]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1320 (
    .a(\fctl/n164 ),
    .b(sgla_r[1]),
    .o(\fdiv/den [19]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1321 (
    .a(\fctl/n164 ),
    .b(sgla_r[0]),
    .o(\fdiv/n9 [18]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u1322 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fdiv/fdiv/rem4 [26]),
    .c(\fdiv/fquo [19]),
    .o(sglc_r_fdiv[8]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u1323 (
    .a(\fdiv/fquo [17]),
    .b(\fdiv/fquo [18]),
    .c(\fdiv/fquo [19]),
    .d(\fdiv/fquo [4]),
    .o(_al_u1323_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    _al_u1324 (
    .a(\fdiv/rem [25]),
    .b(sglc_r_fdiv[8]),
    .c(_al_u1323_o),
    .o(_al_u1324_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u1325 (
    .a(\fdiv/fquo [19]),
    .b(\fdiv/fquo [8]),
    .c(\fdiv/fquo [9]),
    .o(_al_u1325_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1326 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(_al_u1325_o),
    .o(_al_u1326_o));
  AL_MAP_LUT5 #(
    .EQN("~((~D*A)*~((~E*B))*~(C)+(~D*A)*(~E*B)*~(C)+~((~D*A))*(~E*B)*C+(~D*A)*(~E*B)*C)"),
    .INIT(32'hfff53f35))
    _al_u1327 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fdiv/fdiv/rem3 [26]),
    .c(\fdiv/fquo [19]),
    .d(\fdiv/fquo [6]),
    .e(\fdiv/fquo [7]),
    .o(_al_u1327_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'h3a))
    _al_u1328 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fdiv/fquo [0]),
    .c(\fdiv/fquo [19]),
    .o(_al_u1328_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u1329 (
    .a(\fdiv/fquo [19]),
    .b(\fdiv/fquo [7]),
    .c(\fdiv/fquo [8]),
    .o(_al_u1329_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u1330 (
    .a(\fdiv/fquo [10]),
    .b(\fdiv/fquo [19]),
    .c(\fdiv/fquo [9]),
    .o(_al_u1330_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*A)"),
    .INIT(32'h20000000))
    _al_u1331 (
    .a(_al_u1326_o),
    .b(_al_u1327_o),
    .c(_al_u1328_o),
    .d(_al_u1329_o),
    .e(_al_u1330_o),
    .o(_al_u1331_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~A)*~((~E*~C))*~(D)+(~B*~A)*(~E*~C)*~(D)+~((~B*~A))*(~E*~C)*D+(~B*~A)*(~E*~C)*D)"),
    .INIT(32'hffeef0ee))
    _al_u1332 (
    .a(\fdiv/fquo [1]),
    .b(\fdiv/fquo [14]),
    .c(\fdiv/fquo [15]),
    .d(\fdiv/fquo [19]),
    .e(\fdiv/fquo [2]),
    .o(_al_u1332_o));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u1333 (
    .a(\fdiv/fquo [19]),
    .b(\fdiv/fquo [5]),
    .c(\fdiv/fquo [6]),
    .o(_al_u1333_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u1334 (
    .a(_al_u1332_o),
    .b(_al_u1333_o),
    .c(\fdiv/fquo [12]),
    .o(_al_u1334_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~A)*~((~D*~B))*~(E)+(~C*~A)*(~D*~B)*~(E)+~((~C*~A))*(~D*~B)*E+(~C*~A)*(~D*~B)*E)"),
    .INIT(32'hffccfafa))
    _al_u1335 (
    .a(\fdiv/fquo [13]),
    .b(\fdiv/fquo [14]),
    .c(\fdiv/fquo [16]),
    .d(\fdiv/fquo [17]),
    .e(\fdiv/fquo [19]),
    .o(_al_u1335_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u1336 (
    .a(\fdiv/fquo [0]),
    .b(\fdiv/fquo [1]),
    .c(\fdiv/fquo [19]),
    .o(_al_u1336_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u1337 (
    .a(\fdiv/fquo [15]),
    .b(\fdiv/fquo [16]),
    .c(\fdiv/fquo [19]),
    .o(_al_u1337_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*A)"),
    .INIT(32'h08000000))
    _al_u1338 (
    .a(_al_u1331_o),
    .b(_al_u1334_o),
    .c(_al_u1335_o),
    .d(_al_u1336_o),
    .e(_al_u1337_o),
    .o(_al_u1338_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1339 (
    .a(sglb_r[43]),
    .b(sgla_r[43]),
    .o(\fdiv/inf_zer_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(B*~(D)*~(A)+B*D*~(A)+~(B)*D*A+B*D*A))"),
    .INIT(16'h010b))
    _al_u1340 (
    .a(\fdiv/fquo [19]),
    .b(\fdiv/fquo [2]),
    .c(\fdiv/fquo [3]),
    .d(\fdiv/fquo [4]),
    .o(_al_u1340_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1341 (
    .a(_al_u1340_o),
    .b(\fdiv/fquo [10]),
    .c(\fdiv/fquo [11]),
    .o(_al_u1341_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1342 (
    .a(fctl_ccmd_div),
    .b(fctl_ccmd_mul),
    .o(_al_u1342_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~C*~(D*B*A)))"),
    .INIT(32'hf8f00000))
    _al_u1343 (
    .a(_al_u1324_o),
    .b(_al_u1338_o),
    .c(\fdiv/inf_zer_lutinv ),
    .d(_al_u1341_o),
    .e(_al_u1342_o),
    .o(_al_u1343_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1344 (
    .a(\norm/mux1_b0_sel_is_2_o ),
    .b(fctl_ccmd_mul),
    .o(\norm/mux2_b0_sel_is_2_o ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u1345 (
    .a(\norm/mux2_b0_sel_is_2_o ),
    .b(\sgla/sgla_i [27]),
    .c(\sgla/sgla_i [30]),
    .d(sgla_r[41]),
    .o(_al_u1345_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1346 (
    .a(sfpu_dsp_c[39]),
    .b(sfpu_dsp_c[30]),
    .o(_al_u1346_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1347 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[25]),
    .c(sfpu_dsp_c[24]),
    .o(_al_u1347_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    _al_u1348 (
    .a(_al_u1346_o),
    .b(_al_u1347_o),
    .c(sfpu_dsp_c[33]),
    .o(_al_u1348_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1349 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[27]),
    .c(sfpu_dsp_c[26]),
    .o(_al_u1349_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1350 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[30]),
    .c(sfpu_dsp_c[29]),
    .o(_al_u1350_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1351 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[24]),
    .c(sfpu_dsp_c[23]),
    .o(_al_u1351_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1352 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[28]),
    .c(sfpu_dsp_c[27]),
    .o(_al_u1352_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u1353 (
    .a(_al_u1348_o),
    .b(_al_u1349_o),
    .c(_al_u1350_o),
    .d(_al_u1351_o),
    .e(_al_u1352_o),
    .o(_al_u1353_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1354 (
    .a(sfpu_dsp_c[40]),
    .b(sfpu_dsp_c[38]),
    .o(_al_u1354_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u1355 (
    .a(_al_u1354_o),
    .b(sfpu_dsp_c[45]),
    .c(sfpu_dsp_c[44]),
    .d(sfpu_dsp_c[37]),
    .e(sfpu_dsp_c[35]),
    .o(_al_u1355_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1356 (
    .a(sfpu_dsp_c[32]),
    .b(sfpu_dsp_c[28]),
    .o(_al_u1356_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u1357 (
    .a(_al_u1356_o),
    .b(sfpu_dsp_c[47]),
    .c(sfpu_dsp_c[46]),
    .d(sfpu_dsp_c[43]),
    .e(sfpu_dsp_c[36]),
    .o(_al_u1357_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1358 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[42]),
    .c(sfpu_dsp_c[41]),
    .o(_al_u1358_o));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1359 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[43]),
    .c(sfpu_dsp_c[42]),
    .o(_al_u1359_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    _al_u1360 (
    .a(_al_u1358_o),
    .b(_al_u1359_o),
    .c(sfpu_dsp_c[34]),
    .d(sfpu_dsp_c[31]),
    .o(_al_u1360_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))"),
    .INIT(16'h2700))
    _al_u1361 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[26]),
    .c(sfpu_dsp_c[25]),
    .d(fctl_ccmd_mul),
    .o(_al_u1361_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u1362 (
    .a(_al_u1353_o),
    .b(_al_u1355_o),
    .c(_al_u1357_o),
    .d(_al_u1360_o),
    .e(_al_u1361_o),
    .o(_al_u1362_o));
  AL_MAP_LUT5 #(
    .EQN("~(E*~((D*C*A))*~(B)+E*(D*C*A)*~(B)+~(E)*(D*C*A)*B+E*(D*C*A)*B)"),
    .INIT(32'h4ccc7fff))
    _al_u1363 (
    .a(\sgla/n131_lutinv ),
    .b(_al_u1345_o),
    .c(_al_u1039_o),
    .d(_al_u1042_o),
    .e(_al_u1362_o),
    .o(_al_u1363_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u1364 (
    .a(_al_u1040_o),
    .b(\sgla/n184 ),
    .c(\sgla/n182_lutinv ),
    .o(\sgla/n185_neg_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(~(C*~B)*~(E*D*A))"),
    .INIT(32'h45cfcfcf))
    _al_u1365 (
    .a(\sgla/n185_neg_lutinv ),
    .b(_al_u1037_o),
    .c(_al_u1040_o),
    .d(\sgla/n186 ),
    .e(_al_u1035_o),
    .o(_al_u1365_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u1366 (
    .a(_al_u1365_o),
    .b(_al_u1044_o),
    .c(fctl_ccmd_mul),
    .o(_al_u1366_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~D*B*~A)*~(C)*~(E)+~(~D*B*~A)*C*~(E)+~(~(~D*B*~A))*C*E+~(~D*B*~A)*C*E)"),
    .INIT(32'hf0f0ffbb))
    _al_u1367 (
    .a(_al_u1343_o),
    .b(_al_u1363_o),
    .c(sglc_r_fadd[42]),
    .d(_al_u1366_o),
    .e(fctl_ccmd_add),
    .o(\norm/sglc_r [42]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1368 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[26]),
    .d(sgla_r[27]),
    .e(sgla_r[28]),
    .o(_al_u1368_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1369 (
    .a(_al_u1368_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[20]),
    .e(sgla_r[24]),
    .o(_al_u1369_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u1370 (
    .a(_al_u1369_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(sgla_r[12]),
    .o(_al_u1370_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*~A*~(D*B))"),
    .INIT(16'h0105))
    _al_u1371 (
    .a(_al_u1370_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[29]),
    .o(_al_u1371_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(~D*C))"),
    .INIT(16'h2202))
    _al_u1372 (
    .a(_al_u1166_o),
    .b(_al_u1371_o),
    .c(_al_u1218_o),
    .d(sgla_r[30]),
    .o(_al_u1372_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u1373 (
    .a(abus[30]),
    .b(abus[29]),
    .c(abus[28]),
    .d(abus[27]),
    .o(_al_u1373_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u1374 (
    .a(_al_u1373_o),
    .b(abus[26]),
    .c(abus[25]),
    .d(abus[24]),
    .e(abus[23]),
    .o(_al_u1374_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u1375 (
    .a(_al_u1374_o),
    .b(fctl_load_a),
    .o(_al_u1375_o));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(~C*A))"),
    .INIT(8'hce))
    _al_u1376 (
    .a(_al_u1372_o),
    .b(_al_u1375_o),
    .c(_al_u1167_o),
    .o(\sgla/n85 [28]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u1377 (
    .a(\sgla/sgla_e_difl [4]),
    .b(\sgla/sgla_e_difl [3]),
    .c(\sgla/sgla_e_difl [2]),
    .d(\sgla/sgla_e_difl [1]),
    .o(_al_u1377_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(E*~(D)*~((C*A))+E*D*~((C*A))+~(E)*D*(C*A)+E*D*(C*A)))"),
    .INIT(32'h00201333))
    _al_u1378 (
    .a(_al_u1059_o),
    .b(_al_u1122_o),
    .c(_al_u1377_o),
    .d(\sgla/n58 [0]),
    .e(sgla_e[0]),
    .o(_al_u1378_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(~D*C))*~(E)*~(B)+(~A*~(~D*C))*E*~(B)+~((~A*~(~D*C)))*E*B+(~A*~(~D*C))*E*B)"),
    .INIT(32'hddcd1101))
    _al_u1379 (
    .a(_al_u1378_o),
    .b(_al_u1121_o),
    .c(_al_u1122_o),
    .d(\sgla/n48 [0]),
    .e(\sgla/n39 [0]),
    .o(\sgla/n71 [0]));
  AL_MAP_LUT5 #(
    .EQN("~(E*~(B)*~((~D*~C*A))+E*B*~((~D*~C*A))+~(E)*B*(~D*~C*A)+E*B*(~D*~C*A))"),
    .INIT(32'h0002fff7))
    _al_u1380 (
    .a(\sgla/mux21_b2_sel_is_0_o ),
    .b(\sgla/n71 [0]),
    .c(_al_u1167_o),
    .d(_al_u1218_o),
    .e(sgla_e[0]),
    .o(_al_u1380_o));
  AL_MAP_LUT5 #(
    .EQN("((~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D)*~(B)*~(A)+(~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D)*B*~(A)+~((~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D))*B*A+(~C*~(E)*~(D)+~C*E*~(D)+~(~C)*E*D+~C*E*D)*B*A)"),
    .INIT(32'hdd8d888d))
    _al_u1381 (
    .a(fctl_load_a),
    .b(\sgla/n2 [0]),
    .c(_al_u1380_o),
    .d(_al_u1027_o),
    .e(\sgla/n11 [0]),
    .o(\sgla/n84 [0]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    _al_u1382 (
    .a(_al_u1064_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .o(\sgla/mux10_b2_sel_is_2_o ));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u1383 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[1]),
    .d(sgla_r[2]),
    .e(sgla_r[3]),
    .o(\sgla/n62 [3]));
  AL_MAP_LUT5 #(
    .EQN("~((~D*B*A)*~(E)*~(C)+(~D*B*A)*E*~(C)+~((~D*B*A))*E*C+(~D*B*A)*E*C)"),
    .INIT(32'h0f07fff7))
    _al_u1384 (
    .a(\sgla/mux10_b2_sel_is_2_o ),
    .b(\sgla/n62 [3]),
    .c(_al_u1121_o),
    .d(_al_u1122_o),
    .e(sgla_r[4]),
    .o(_al_u1384_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u1385 (
    .a(_al_u1384_o),
    .b(_al_u1167_o),
    .c(_al_u1218_o),
    .d(sgla_r[5]),
    .e(sgla_r[7]),
    .o(\sgla/n76 [3]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'hfef20e02))
    _al_u1386 (
    .a(\sgla/n76 [3]),
    .b(_al_u1163_o),
    .c(_al_u1164_o),
    .d(sgla_r[11]),
    .e(sgla_r[19]),
    .o(\sgla/n80 [3]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'hf5b1e4a0))
    _al_u1387 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[0]),
    .d(sgla_r[1]),
    .e(sgla_r[2]),
    .o(\sgla/n62 [2]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1388 (
    .a(\sgla/mux14_b31_sel_is_0_o ),
    .b(\sgla/mux10_b2_sel_is_2_o ),
    .c(\sgla/n62 [2]),
    .o(_al_u1388_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1389 (
    .a(_al_u1388_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[3]),
    .e(sgla_r[4]),
    .o(_al_u1389_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u1390 (
    .a(_al_u1389_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[10]),
    .e(sgla_r[6]),
    .o(_al_u1390_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1391 (
    .a(_al_u1390_o),
    .b(_al_u1164_o),
    .c(sgla_r[18]),
    .o(\sgla/n80 [2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1392 (
    .a(\sgla/mux30_b30_sel_is_2_o ),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .o(\sgla/mux30_b31_sel_is_2_o ));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1393 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [9]),
    .d(sglb_r[14]),
    .o(\fdiv/fdiv/n7 [9]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1394 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [9]),
    .d(sglb_r[14]),
    .o(\fdiv/fdiv/n9 [9]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1395 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [9]),
    .d(sglb_r[14]),
    .o(\fdiv/fdiv/n3 [9]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1396 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [9]),
    .d(sglb_r[14]),
    .o(\fdiv/fdiv/n5 [9]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1397 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [8]),
    .d(sglb_r[13]),
    .o(\fdiv/fdiv/n7 [8]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1398 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [8]),
    .d(sglb_r[13]),
    .o(\fdiv/fdiv/n9 [8]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1399 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [8]),
    .d(sglb_r[13]),
    .o(\fdiv/fdiv/n3 [8]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1400 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [8]),
    .d(sglb_r[13]),
    .o(\fdiv/fdiv/n5 [8]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1401 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [7]),
    .d(sglb_r[12]),
    .o(\fdiv/fdiv/n5 [7]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1402 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [7]),
    .d(sglb_r[12]),
    .o(\fdiv/fdiv/n7 [7]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1403 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [7]),
    .d(sglb_r[12]),
    .o(\fdiv/fdiv/n9 [7]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1404 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [7]),
    .d(sglb_r[12]),
    .o(\fdiv/fdiv/n3 [7]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1405 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [6]),
    .d(sglb_r[11]),
    .o(\fdiv/fdiv/n5 [6]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1406 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [6]),
    .d(sglb_r[11]),
    .o(\fdiv/fdiv/n7 [6]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1407 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [6]),
    .d(sglb_r[11]),
    .o(\fdiv/fdiv/n9 [6]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1408 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [6]),
    .d(sglb_r[11]),
    .o(\fdiv/fdiv/n3 [6]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1409 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [5]),
    .d(sglb_r[10]),
    .o(\fdiv/fdiv/n5 [5]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1410 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [5]),
    .d(sglb_r[10]),
    .o(\fdiv/fdiv/n7 [5]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1411 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [5]),
    .d(sglb_r[10]),
    .o(\fdiv/fdiv/n9 [5]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1412 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [5]),
    .d(sglb_r[10]),
    .o(\fdiv/fdiv/n3 [5]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1413 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [4]),
    .d(sglb_r[9]),
    .o(\fdiv/fdiv/n5 [4]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1414 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [4]),
    .d(sglb_r[9]),
    .o(\fdiv/fdiv/n7 [4]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1415 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [4]),
    .d(sglb_r[9]),
    .o(\fdiv/fdiv/n9 [4]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1416 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [4]),
    .d(sglb_r[9]),
    .o(\fdiv/fdiv/n3 [4]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1417 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [3]),
    .d(sglb_r[8]),
    .o(\fdiv/fdiv/n5 [3]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1418 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [3]),
    .d(sglb_r[8]),
    .o(\fdiv/fdiv/n7 [3]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1419 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [3]),
    .d(sglb_r[8]),
    .o(\fdiv/fdiv/n9 [3]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1420 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [3]),
    .d(sglb_r[8]),
    .o(\fdiv/fdiv/n3 [3]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1421 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [24]),
    .d(sglb_r[29]),
    .o(\fdiv/fdiv/n7 [24]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1422 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [24]),
    .d(sglb_r[29]),
    .o(\fdiv/fdiv/n9 [24]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1423 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [24]),
    .d(sglb_r[29]),
    .o(\fdiv/fdiv/n3 [24]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1424 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [24]),
    .d(sglb_r[29]),
    .o(\fdiv/fdiv/n5 [24]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1425 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [23]),
    .d(sglb_r[28]),
    .o(\fdiv/fdiv/n7 [23]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1426 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [23]),
    .d(sglb_r[28]),
    .o(\fdiv/fdiv/n9 [23]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1427 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [23]),
    .d(sglb_r[28]),
    .o(\fdiv/fdiv/n3 [23]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1428 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [23]),
    .d(sglb_r[28]),
    .o(\fdiv/fdiv/n5 [23]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1429 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [22]),
    .d(sglb_r[27]),
    .o(\fdiv/fdiv/n7 [22]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1430 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [22]),
    .d(sglb_r[27]),
    .o(\fdiv/fdiv/n9 [22]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1431 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [22]),
    .d(sglb_r[27]),
    .o(\fdiv/fdiv/n3 [22]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1432 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [22]),
    .d(sglb_r[27]),
    .o(\fdiv/fdiv/n5 [22]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1433 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [21]),
    .d(sglb_r[26]),
    .o(\fdiv/fdiv/n7 [21]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1434 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [21]),
    .d(sglb_r[26]),
    .o(\fdiv/fdiv/n9 [21]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1435 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [21]),
    .d(sglb_r[26]),
    .o(\fdiv/fdiv/n3 [21]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1436 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [21]),
    .d(sglb_r[26]),
    .o(\fdiv/fdiv/n5 [21]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1437 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [20]),
    .d(sglb_r[25]),
    .o(\fdiv/fdiv/n7 [20]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1438 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [20]),
    .d(sglb_r[25]),
    .o(\fdiv/fdiv/n9 [20]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1439 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [20]),
    .d(sglb_r[25]),
    .o(\fdiv/fdiv/n3 [20]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1440 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [20]),
    .d(sglb_r[25]),
    .o(\fdiv/fdiv/n5 [20]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1441 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [2]),
    .d(sglb_r[7]),
    .o(\fdiv/fdiv/n5 [2]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1442 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [2]),
    .d(sglb_r[7]),
    .o(\fdiv/fdiv/n7 [2]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1443 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [2]),
    .d(sglb_r[7]),
    .o(\fdiv/fdiv/n9 [2]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1444 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [2]),
    .d(sglb_r[7]),
    .o(\fdiv/fdiv/n3 [2]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1445 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [19]),
    .d(sglb_r[24]),
    .o(\fdiv/fdiv/n7 [19]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1446 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [19]),
    .d(sglb_r[24]),
    .o(\fdiv/fdiv/n9 [19]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1447 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [19]),
    .d(sglb_r[24]),
    .o(\fdiv/fdiv/n3 [19]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1448 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [19]),
    .d(sglb_r[24]),
    .o(\fdiv/fdiv/n5 [19]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1449 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [18]),
    .d(sglb_r[23]),
    .o(\fdiv/fdiv/n7 [18]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1450 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [18]),
    .d(sglb_r[23]),
    .o(\fdiv/fdiv/n9 [18]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1451 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [18]),
    .d(sglb_r[23]),
    .o(\fdiv/fdiv/n3 [18]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1452 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [18]),
    .d(sglb_r[23]),
    .o(\fdiv/fdiv/n5 [18]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1453 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [17]),
    .d(sglb_r[22]),
    .o(\fdiv/fdiv/n7 [17]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1454 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [17]),
    .d(sglb_r[22]),
    .o(\fdiv/fdiv/n9 [17]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1455 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [17]),
    .d(sglb_r[22]),
    .o(\fdiv/fdiv/n3 [17]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1456 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [17]),
    .d(sglb_r[22]),
    .o(\fdiv/fdiv/n5 [17]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1457 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [16]),
    .d(sglb_r[21]),
    .o(\fdiv/fdiv/n7 [16]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1458 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [16]),
    .d(sglb_r[21]),
    .o(\fdiv/fdiv/n9 [16]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1459 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [16]),
    .d(sglb_r[21]),
    .o(\fdiv/fdiv/n3 [16]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1460 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [16]),
    .d(sglb_r[21]),
    .o(\fdiv/fdiv/n5 [16]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1461 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [15]),
    .d(sglb_r[20]),
    .o(\fdiv/fdiv/n7 [15]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1462 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [15]),
    .d(sglb_r[20]),
    .o(\fdiv/fdiv/n9 [15]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1463 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [15]),
    .d(sglb_r[20]),
    .o(\fdiv/fdiv/n3 [15]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1464 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [15]),
    .d(sglb_r[20]),
    .o(\fdiv/fdiv/n5 [15]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1465 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [14]),
    .d(sglb_r[19]),
    .o(\fdiv/fdiv/n7 [14]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1466 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [14]),
    .d(sglb_r[19]),
    .o(\fdiv/fdiv/n9 [14]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1467 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [14]),
    .d(sglb_r[19]),
    .o(\fdiv/fdiv/n3 [14]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1468 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [14]),
    .d(sglb_r[19]),
    .o(\fdiv/fdiv/n5 [14]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1469 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [13]),
    .d(sglb_r[18]),
    .o(\fdiv/fdiv/n7 [13]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1470 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [13]),
    .d(sglb_r[18]),
    .o(\fdiv/fdiv/n9 [13]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1471 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [13]),
    .d(sglb_r[18]),
    .o(\fdiv/fdiv/n3 [13]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1472 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [13]),
    .d(sglb_r[18]),
    .o(\fdiv/fdiv/n5 [13]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1473 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [12]),
    .d(sglb_r[17]),
    .o(\fdiv/fdiv/n7 [12]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1474 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [12]),
    .d(sglb_r[17]),
    .o(\fdiv/fdiv/n9 [12]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1475 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [12]),
    .d(sglb_r[17]),
    .o(\fdiv/fdiv/n3 [12]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1476 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [12]),
    .d(sglb_r[17]),
    .o(\fdiv/fdiv/n5 [12]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1477 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [11]),
    .d(sglb_r[16]),
    .o(\fdiv/fdiv/n7 [11]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1478 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [11]),
    .d(sglb_r[16]),
    .o(\fdiv/fdiv/n9 [11]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1479 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [11]),
    .d(sglb_r[16]),
    .o(\fdiv/fdiv/n3 [11]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1480 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [11]),
    .d(sglb_r[16]),
    .o(\fdiv/fdiv/n5 [11]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1481 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [10]),
    .d(sglb_r[15]),
    .o(\fdiv/fdiv/n7 [10]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1482 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [10]),
    .d(sglb_r[15]),
    .o(\fdiv/fdiv/n9 [10]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1483 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [10]),
    .d(sglb_r[15]),
    .o(\fdiv/fdiv/n3 [10]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1484 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [10]),
    .d(sglb_r[15]),
    .o(\fdiv/fdiv/n5 [10]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1485 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [1]),
    .d(sglb_r[6]),
    .o(\fdiv/fdiv/n5 [1]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1486 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [1]),
    .d(sglb_r[6]),
    .o(\fdiv/fdiv/n7 [1]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1487 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [1]),
    .d(sglb_r[6]),
    .o(\fdiv/fdiv/n9 [1]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1488 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [1]),
    .d(sglb_r[6]),
    .o(\fdiv/fdiv/n3 [1]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1489 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [0]),
    .d(sglb_r[5]),
    .o(\fdiv/fdiv/n9 [0]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1490 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [0]),
    .d(sglb_r[5]),
    .o(\fdiv/fdiv/n7 [0]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1491 (
    .a(\fdiv/fdiv/rem3 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [0]),
    .d(sglb_r[5]),
    .o(\fdiv/fdiv/n5 [0]));
  AL_MAP_LUT4 #(
    .EQN("(A@~(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'ha695))
    _al_u1492 (
    .a(\fdiv/fdiv/rem4 [26]),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [0]),
    .d(sglb_r[5]),
    .o(\fdiv/fdiv/n3 [0]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    _al_u1493 (
    .a(\fctl/n164 ),
    .b(\fdiv/den_r [49]),
    .c(sgla_r[31]),
    .o(\fdiv/fdiv/n0 ));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1494 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[25]),
    .d(sgla_r[26]),
    .e(sgla_r[27]),
    .o(_al_u1494_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1495 (
    .a(_al_u1494_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[19]),
    .e(sgla_r[23]),
    .o(_al_u1495_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))"),
    .INIT(16'h0d01))
    _al_u1496 (
    .a(_al_u1495_o),
    .b(_al_u1064_o),
    .c(_al_u1122_o),
    .d(sgla_r[11]),
    .o(\sgla/n70 [27]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'h010df1fd))
    _al_u1497 (
    .a(\sgla/n70 [27]),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[28]),
    .e(sgla_r[29]),
    .o(_al_u1497_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1498 (
    .a(_al_u1497_o),
    .b(_al_u1167_o),
    .c(sgla_r[31]),
    .o(\sgla/n76 [27]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1499 (
    .a(_al_u1166_o),
    .b(_al_u1375_o),
    .c(abus[22]),
    .d(\sgla/n76 [27]),
    .o(\sgla/n85 [27]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1500 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[24]),
    .d(sgla_r[25]),
    .e(sgla_r[26]),
    .o(_al_u1500_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1501 (
    .a(_al_u1500_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[18]),
    .e(sgla_r[22]),
    .o(_al_u1501_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))"),
    .INIT(16'h0d01))
    _al_u1502 (
    .a(_al_u1501_o),
    .b(_al_u1064_o),
    .c(_al_u1122_o),
    .d(sgla_r[10]),
    .o(\sgla/n70 [26]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'h010df1fd))
    _al_u1503 (
    .a(\sgla/n70 [26]),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[27]),
    .e(sgla_r[28]),
    .o(_al_u1503_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1504 (
    .a(_al_u1503_o),
    .b(_al_u1167_o),
    .c(sgla_r[30]),
    .o(\sgla/n76 [26]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1505 (
    .a(_al_u1166_o),
    .b(_al_u1375_o),
    .c(abus[21]),
    .d(\sgla/n76 [26]),
    .o(\sgla/n85 [26]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1506 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[23]),
    .d(sgla_r[24]),
    .e(sgla_r[25]),
    .o(_al_u1506_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1507 (
    .a(_al_u1506_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[17]),
    .e(sgla_r[21]),
    .o(_al_u1507_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))"),
    .INIT(16'h0d01))
    _al_u1508 (
    .a(_al_u1507_o),
    .b(_al_u1064_o),
    .c(_al_u1122_o),
    .d(sgla_r[9]),
    .o(\sgla/n70 [25]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'h010df1fd))
    _al_u1509 (
    .a(\sgla/n70 [25]),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[26]),
    .e(sgla_r[27]),
    .o(_al_u1509_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1510 (
    .a(_al_u1509_o),
    .b(_al_u1167_o),
    .c(sgla_r[29]),
    .o(\sgla/n76 [25]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1511 (
    .a(_al_u1166_o),
    .b(_al_u1375_o),
    .c(abus[20]),
    .d(\sgla/n76 [25]),
    .o(\sgla/n85 [25]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1512 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[22]),
    .d(sgla_r[23]),
    .e(sgla_r[24]),
    .o(_al_u1512_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1513 (
    .a(_al_u1512_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[16]),
    .e(sgla_r[20]),
    .o(_al_u1513_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))"),
    .INIT(16'h0d01))
    _al_u1514 (
    .a(_al_u1513_o),
    .b(_al_u1064_o),
    .c(_al_u1122_o),
    .d(sgla_r[8]),
    .o(\sgla/n70 [24]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'h010df1fd))
    _al_u1515 (
    .a(\sgla/n70 [24]),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[25]),
    .e(sgla_r[26]),
    .o(_al_u1515_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1516 (
    .a(_al_u1515_o),
    .b(_al_u1167_o),
    .c(sgla_r[28]),
    .o(\sgla/n76 [24]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1517 (
    .a(_al_u1166_o),
    .b(_al_u1375_o),
    .c(abus[19]),
    .d(\sgla/n76 [24]),
    .o(\sgla/n85 [24]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'h04ae15bf))
    _al_u1518 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(\sgla/n58 [1]),
    .d(n11[0]),
    .e(sgla_e[1]),
    .o(_al_u1518_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~E*~(B)*~(A)+~E*B*~(A)+~(~E)*B*A+~E*B*A)*~(D)*~(C)+~(~E*~(B)*~(A)+~E*B*~(A)+~(~E)*B*A+~E*B*A)*D*~(C)+~(~(~E*~(B)*~(A)+~E*B*~(A)+~(~E)*B*A+~E*B*A))*D*C+~(~E*~(B)*~(A)+~E*B*~(A)+~(~E)*B*A+~E*B*A)*D*C)"),
    .INIT(32'h08f80dfd))
    _al_u1519 (
    .a(\sgla/mux10_b2_sel_is_2_o ),
    .b(_al_u1518_o),
    .c(_al_u1122_o),
    .d(\sgla/n48 [1]),
    .e(sgla_e[1]),
    .o(_al_u1519_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'h020ef2fe))
    _al_u1520 (
    .a(_al_u1519_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(\sgla/n39 [1]),
    .e(\sgla/n33 [0]),
    .o(_al_u1520_o));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~(A)*~((~C*B))+~D*A*~((~C*B))+~(~D)*A*(~C*B)+~D*A*(~C*B))"),
    .INIT(16'hf704))
    _al_u1521 (
    .a(_al_u1520_o),
    .b(\sgla/mux21_b2_sel_is_0_o ),
    .c(_al_u1167_o),
    .d(sgla_e[1]),
    .o(\sgla/n79 [1]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*~(B)*~(A)+(C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*B*~(A)+~((C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D))*B*A+(C*~(E)*~(D)+C*E*~(D)+~(C)*E*D+C*E*D)*B*A)"),
    .INIT(32'hddd888d8))
    _al_u1522 (
    .a(fctl_load_a),
    .b(\sgla/n2 [1]),
    .c(\sgla/n79 [1]),
    .d(_al_u1027_o),
    .e(\sgla/n11 [1]),
    .o(\sgla/n84 [1]));
  AL_MAP_LUT4 #(
    .EQN("(~A*(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h5140))
    _al_u1523 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[0]),
    .d(sgla_r[1]),
    .o(_al_u1523_o));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u1524 (
    .a(\sgla/mux14_b31_sel_is_0_o ),
    .b(\sgla/mux10_b2_sel_is_2_o ),
    .c(_al_u1523_o),
    .o(_al_u1524_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1525 (
    .a(_al_u1524_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[2]),
    .e(sgla_r[3]),
    .o(_al_u1525_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1526 (
    .a(_al_u1525_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[5]),
    .e(sgla_r[9]),
    .o(_al_u1526_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1527 (
    .a(_al_u1526_o),
    .b(_al_u1164_o),
    .c(sgla_r[17]),
    .o(\sgla/n80 [1]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1528 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[5]),
    .d(sgla_r[6]),
    .e(sgla_r[7]),
    .o(_al_u1528_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1529 (
    .a(_al_u1283_o),
    .b(_al_u1528_o),
    .c(_al_u1061_o),
    .d(sgla_r[3]),
    .o(_al_u1529_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1530 (
    .a(_al_u1529_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[8]),
    .e(sgla_r[9]),
    .o(_al_u1530_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1531 (
    .a(_al_u1530_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[11]),
    .e(sgla_r[15]),
    .o(_al_u1531_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1532 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(_al_u1531_o),
    .c(_al_u1164_o),
    .d(sgla_r[23]),
    .o(_al_u1532_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u1533 (
    .a(_al_u1532_o),
    .b(_al_u1375_o),
    .c(abus[2]),
    .o(\sgla/n85 [7]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1534 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[4]),
    .d(sgla_r[5]),
    .e(sgla_r[6]),
    .o(_al_u1534_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1535 (
    .a(_al_u1283_o),
    .b(_al_u1534_o),
    .c(_al_u1061_o),
    .d(sgla_r[2]),
    .o(_al_u1535_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1536 (
    .a(_al_u1535_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[7]),
    .e(sgla_r[8]),
    .o(_al_u1536_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1537 (
    .a(_al_u1536_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[10]),
    .e(sgla_r[14]),
    .o(_al_u1537_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1538 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(_al_u1537_o),
    .c(_al_u1164_o),
    .d(sgla_r[22]),
    .o(_al_u1538_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u1539 (
    .a(_al_u1538_o),
    .b(_al_u1375_o),
    .c(abus[1]),
    .o(\sgla/n85 [6]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1540 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[3]),
    .d(sgla_r[4]),
    .e(sgla_r[5]),
    .o(_al_u1540_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1541 (
    .a(_al_u1283_o),
    .b(_al_u1540_o),
    .c(_al_u1061_o),
    .d(sgla_r[1]),
    .o(_al_u1541_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1542 (
    .a(_al_u1541_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[6]),
    .e(sgla_r[7]),
    .o(_al_u1542_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u1543 (
    .a(_al_u1542_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[13]),
    .e(sgla_r[9]),
    .o(_al_u1543_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1544 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(_al_u1543_o),
    .c(_al_u1164_o),
    .d(sgla_r[21]),
    .o(_al_u1544_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u1545 (
    .a(_al_u1544_o),
    .b(_al_u1375_o),
    .c(abus[0]),
    .o(\sgla/n85 [5]));
  AL_MAP_LUT4 #(
    .EQN("(A*~(B)*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D)"),
    .INIT(16'h3fa0))
    _al_u1546 (
    .a(_al_u1015_o),
    .b(\fctl/n114_lutinv ),
    .c(\fctl/stat [0]),
    .d(\fctl/stat [1]),
    .o(_al_u1546_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E)"),
    .INIT(32'h000cc0aa))
    _al_u1547 (
    .a(_al_u1546_o),
    .b(\fctl/stat [0]),
    .c(\fctl/stat [1]),
    .d(\fctl/stat [2]),
    .e(\fctl/stat [3]),
    .o(fctl_load_c));
  AL_MAP_LUT5 #(
    .EQN("(A*(B*~(C)*~(D)*~(E)+B*C*~(D)*~(E)+B*~(C)*D*~(E)+~(B)*C*D*~(E)+B*~(C)*~(D)*E+~(B)*C*~(D)*E+~(B)*C*D*E))"),
    .INIT(32'h20282888))
    _al_u1548 (
    .a(_al_u996_o),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(_al_u1548_o));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u1549 (
    .a(\fctl/stat [0]),
    .b(\fctl/stat [1]),
    .c(\fctl/stat [2]),
    .d(\fctl/stat [3]),
    .o(fctl_norm_enb_lutinv));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1550 (
    .a(\fctl/n154_lutinv ),
    .b(fctl_norm_enb_lutinv),
    .o(\fctl/n153_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~E*~D*~C*~A))"),
    .INIT(32'hccccccc8))
    _al_u1551 (
    .a(_al_u1548_o),
    .b(rst_n),
    .c(fctl_load_c),
    .d(\fctl/n153_lutinv ),
    .e(\fctl/n123_lutinv ),
    .o(\fctl/mux0_b3_sel_is_3_o ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1552 (
    .a(_al_u1546_o),
    .b(\fctl/stat [2]),
    .c(\fctl/stat [3]),
    .o(_al_u1552_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hfff3007f))
    _al_u1553 (
    .a(\fctl/n114_lutinv ),
    .b(\fctl/stat [0]),
    .c(\fctl/stat [1]),
    .d(\fctl/stat [2]),
    .e(\fctl/stat [3]),
    .o(_al_u1553_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(D*~C*~B))"),
    .INIT(16'ha8aa))
    _al_u1554 (
    .a(rst_n),
    .b(_al_u1552_o),
    .c(\fctl/n153_lutinv ),
    .d(_al_u1553_o),
    .o(\fctl/mux0_b2_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(A*(B*~(C)*~(D)*~(E)+~(B)*C*~(D)*~(E)+~(B)*~(C)*D*E+~(B)*C*D*E))"),
    .INIT(32'h22000028))
    _al_u1555 (
    .a(_al_u996_o),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(_al_u1555_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E)"),
    .INIT(32'h7fc303ff))
    _al_u1556 (
    .a(\fctl/n154_lutinv ),
    .b(\fctl/stat [0]),
    .c(\fctl/stat [1]),
    .d(\fctl/stat [2]),
    .e(\fctl/stat [3]),
    .o(_al_u1556_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(D*~C*~A))"),
    .INIT(16'hc8cc))
    _al_u1557 (
    .a(_al_u1555_o),
    .b(rst_n),
    .c(_al_u1552_o),
    .d(_al_u1556_o),
    .o(\fctl/mux0_b1_sel_is_3_o ));
  AL_MAP_LUT5 #(
    .EQN("(A*(~(B)*C*~(D)*~(E)+~(B)*~(C)*D*~(E)+~(B)*C*D*~(E)+~(B)*~(C)*~(D)*E+B*~(C)*D*E))"),
    .INIT(32'h08022220))
    _al_u1558 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(_al_u1558_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u1559 (
    .a(_al_u1558_o),
    .b(_al_u995_o),
    .o(_al_u1559_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E)"),
    .INIT(32'h002cf33c))
    _al_u1560 (
    .a(_al_u1015_o),
    .b(\fctl/stat [0]),
    .c(\fctl/stat [1]),
    .d(\fctl/stat [2]),
    .e(\fctl/stat [3]),
    .o(_al_u1560_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~E*~D*~C*~A))"),
    .INIT(32'hccccccc8))
    _al_u1561 (
    .a(_al_u1559_o),
    .b(rst_n),
    .c(_al_u1560_o),
    .d(\fctl/n153_lutinv ),
    .e(_al_u1552_o),
    .o(\fctl/mux0_b0_sel_is_3_o ));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1562 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [24]),
    .d(sglb_r[29]),
    .o(\fdiv/fdiv/n1 [24]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1563 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [23]),
    .d(sglb_r[28]),
    .o(\fdiv/fdiv/n1 [23]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1564 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [22]),
    .d(sglb_r[27]),
    .o(\fdiv/fdiv/n1 [22]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1565 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [21]),
    .d(sglb_r[26]),
    .o(\fdiv/fdiv/n1 [21]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1566 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [20]),
    .d(sglb_r[25]),
    .o(\fdiv/fdiv/n1 [20]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1567 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [19]),
    .d(sglb_r[24]),
    .o(\fdiv/fdiv/n1 [19]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1568 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [18]),
    .d(sglb_r[23]),
    .o(\fdiv/fdiv/n1 [18]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1569 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [17]),
    .d(sglb_r[22]),
    .o(\fdiv/fdiv/n1 [17]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1570 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [16]),
    .d(sglb_r[21]),
    .o(\fdiv/fdiv/n1 [16]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1571 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [15]),
    .d(sglb_r[20]),
    .o(\fdiv/fdiv/n1 [15]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1572 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [14]),
    .d(sglb_r[19]),
    .o(\fdiv/fdiv/n1 [14]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1573 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [13]),
    .d(sglb_r[18]),
    .o(\fdiv/fdiv/n1 [13]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1574 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [12]),
    .d(sglb_r[17]),
    .o(\fdiv/fdiv/n1 [12]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1575 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [11]),
    .d(sglb_r[16]),
    .o(\fdiv/fdiv/n1 [11]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1576 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [10]),
    .d(sglb_r[15]),
    .o(\fdiv/fdiv/n1 [10]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1577 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [9]),
    .d(sglb_r[14]),
    .o(\fdiv/fdiv/n1 [9]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1578 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [8]),
    .d(sglb_r[13]),
    .o(\fdiv/fdiv/n1 [8]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1579 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [7]),
    .d(sglb_r[12]),
    .o(\fdiv/fdiv/n1 [7]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1580 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [6]),
    .d(sglb_r[11]),
    .o(\fdiv/fdiv/n1 [6]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1581 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [5]),
    .d(sglb_r[10]),
    .o(\fdiv/fdiv/n1 [5]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1582 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [4]),
    .d(sglb_r[9]),
    .o(\fdiv/fdiv/n1 [4]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1583 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [3]),
    .d(sglb_r[8]),
    .o(\fdiv/fdiv/n1 [3]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1584 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [2]),
    .d(sglb_r[7]),
    .o(\fdiv/fdiv/n1 [2]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1585 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [1]),
    .d(sglb_r[6]),
    .o(\fdiv/fdiv/n1 [1]));
  AL_MAP_LUT4 #(
    .EQN("(A@(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))"),
    .INIT(16'h596a))
    _al_u1586 (
    .a(\fdiv/fdiv/n0 ),
    .b(\fctl/n164 ),
    .c(\fdiv/dso_r [0]),
    .d(sglb_r[5]),
    .o(\fdiv/fdiv/n1 [0]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(~C*B))"),
    .INIT(8'h5d))
    _al_u1587 (
    .a(\fctl/n164 ),
    .b(\fctl/stat [2]),
    .c(\fctl/stat [3]),
    .o(fctl_dsft_enb));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1588 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[7]),
    .d(sgla_r[8]),
    .e(sgla_r[9]),
    .o(_al_u1588_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1589 (
    .a(_al_u1588_o),
    .b(_al_u1061_o),
    .c(sgla_r[5]),
    .o(_al_u1589_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h0c040004))
    _al_u1590 (
    .a(_al_u1589_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(_al_u1062_o),
    .e(sgla_r[1]),
    .o(_al_u1590_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1591 (
    .a(_al_u1590_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[10]),
    .e(sgla_r[11]),
    .o(_al_u1591_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1592 (
    .a(_al_u1591_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[13]),
    .e(sgla_r[17]),
    .o(_al_u1592_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1593 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(_al_u1592_o),
    .c(_al_u1164_o),
    .d(sgla_r[25]),
    .o(_al_u1593_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u1594 (
    .a(_al_u1593_o),
    .b(_al_u1375_o),
    .c(abus[4]),
    .o(\sgla/n85 [9]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1595 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[6]),
    .d(sgla_r[7]),
    .e(sgla_r[8]),
    .o(_al_u1595_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1596 (
    .a(_al_u1595_o),
    .b(_al_u1061_o),
    .c(sgla_r[4]),
    .o(_al_u1596_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h0c040004))
    _al_u1597 (
    .a(_al_u1596_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(_al_u1062_o),
    .e(sgla_r[0]),
    .o(_al_u1597_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(E*B))*~(D)*~(C)+~(~A*~(E*B))*D*~(C)+~(~(~A*~(E*B)))*D*C+~(~A*~(E*B))*D*C)"),
    .INIT(32'h01f105f5))
    _al_u1598 (
    .a(_al_u1597_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[10]),
    .e(sgla_r[9]),
    .o(_al_u1598_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1599 (
    .a(_al_u1598_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[12]),
    .e(sgla_r[16]),
    .o(_al_u1599_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1600 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(_al_u1599_o),
    .c(_al_u1164_o),
    .d(sgla_r[24]),
    .o(_al_u1600_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u1601 (
    .a(_al_u1600_o),
    .b(_al_u1375_o),
    .c(abus[3]),
    .o(\sgla/n85 [8]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1602 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(_al_u1164_o),
    .o(_al_u1602_o));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1603 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[21]),
    .d(sgla_r[22]),
    .e(sgla_r[23]),
    .o(_al_u1603_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1604 (
    .a(_al_u1603_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[15]),
    .e(sgla_r[19]),
    .o(_al_u1604_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u1605 (
    .a(_al_u1604_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(sgla_r[7]),
    .o(_al_u1605_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1606 (
    .a(_al_u1605_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[24]),
    .e(sgla_r[25]),
    .o(_al_u1606_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1607 (
    .a(_al_u1606_o),
    .b(_al_u1167_o),
    .c(sgla_r[27]),
    .o(\sgla/n76 [23]));
  AL_MAP_LUT4 #(
    .EQN("(A*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))"),
    .INIT(16'ha808))
    _al_u1608 (
    .a(_al_u1602_o),
    .b(\sgla/n76 [23]),
    .c(_al_u1163_o),
    .d(sgla_r[31]),
    .o(_al_u1608_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u1609 (
    .a(_al_u1608_o),
    .b(_al_u1375_o),
    .c(abus[18]),
    .o(\sgla/n85 [23]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1610 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[20]),
    .d(sgla_r[21]),
    .e(sgla_r[22]),
    .o(_al_u1610_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1611 (
    .a(_al_u1610_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[14]),
    .e(sgla_r[18]),
    .o(_al_u1611_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u1612 (
    .a(_al_u1611_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(sgla_r[6]),
    .o(_al_u1612_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1613 (
    .a(_al_u1612_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[23]),
    .e(sgla_r[24]),
    .o(_al_u1613_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u1614 (
    .a(_al_u1613_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[26]),
    .e(sgla_r[30]),
    .o(\sgla/n78 [22]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1615 (
    .a(_al_u1602_o),
    .b(_al_u1375_o),
    .c(abus[17]),
    .d(\sgla/n78 [22]),
    .o(\sgla/n85 [22]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1616 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[19]),
    .d(sgla_r[20]),
    .e(sgla_r[21]),
    .o(_al_u1616_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1617 (
    .a(_al_u1616_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[13]),
    .e(sgla_r[17]),
    .o(_al_u1617_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u1618 (
    .a(_al_u1617_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(sgla_r[5]),
    .o(_al_u1618_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1619 (
    .a(_al_u1618_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[22]),
    .e(sgla_r[23]),
    .o(_al_u1619_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u1620 (
    .a(_al_u1619_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[25]),
    .e(sgla_r[29]),
    .o(\sgla/n78 [21]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1621 (
    .a(_al_u1602_o),
    .b(_al_u1375_o),
    .c(abus[16]),
    .d(\sgla/n78 [21]),
    .o(\sgla/n85 [21]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1622 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[18]),
    .d(sgla_r[19]),
    .e(sgla_r[20]),
    .o(_al_u1622_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1623 (
    .a(_al_u1622_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[12]),
    .e(sgla_r[16]),
    .o(_al_u1623_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u1624 (
    .a(_al_u1623_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(sgla_r[4]),
    .o(_al_u1624_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1625 (
    .a(_al_u1624_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[21]),
    .e(sgla_r[22]),
    .o(_al_u1625_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u1626 (
    .a(_al_u1625_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[24]),
    .e(sgla_r[28]),
    .o(\sgla/n78 [20]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1627 (
    .a(_al_u1602_o),
    .b(_al_u1375_o),
    .c(abus[15]),
    .d(\sgla/n78 [20]),
    .o(\sgla/n85 [20]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1628 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[17]),
    .d(sgla_r[18]),
    .e(sgla_r[19]),
    .o(_al_u1628_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1629 (
    .a(_al_u1628_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[11]),
    .e(sgla_r[15]),
    .o(_al_u1629_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u1630 (
    .a(_al_u1629_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(sgla_r[3]),
    .o(_al_u1630_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1631 (
    .a(_al_u1630_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[20]),
    .e(sgla_r[21]),
    .o(_al_u1631_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u1632 (
    .a(_al_u1631_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[23]),
    .e(sgla_r[27]),
    .o(\sgla/n78 [19]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1633 (
    .a(_al_u1602_o),
    .b(_al_u1375_o),
    .c(abus[14]),
    .d(\sgla/n78 [19]),
    .o(\sgla/n85 [19]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1634 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[16]),
    .d(sgla_r[17]),
    .e(sgla_r[18]),
    .o(_al_u1634_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*~(D)*~(C)+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*~(C)+~((~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B))*D*C+(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)*D*C)"),
    .INIT(32'h02f20efe))
    _al_u1635 (
    .a(_al_u1634_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[10]),
    .e(sgla_r[14]),
    .o(_al_u1635_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u1636 (
    .a(_al_u1635_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(sgla_r[2]),
    .o(_al_u1636_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1637 (
    .a(_al_u1636_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[19]),
    .e(sgla_r[20]),
    .o(_al_u1637_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u1638 (
    .a(_al_u1637_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[22]),
    .e(sgla_r[26]),
    .o(\sgla/n78 [18]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1639 (
    .a(_al_u1602_o),
    .b(_al_u1375_o),
    .c(abus[13]),
    .d(\sgla/n78 [18]),
    .o(\sgla/n85 [18]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1640 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[15]),
    .d(sgla_r[16]),
    .e(sgla_r[17]),
    .o(_al_u1640_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'h020ef2fe))
    _al_u1641 (
    .a(_al_u1640_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[13]),
    .e(sgla_r[9]),
    .o(_al_u1641_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u1642 (
    .a(_al_u1641_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(sgla_r[1]),
    .o(_al_u1642_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1643 (
    .a(_al_u1642_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[18]),
    .e(sgla_r[19]),
    .o(_al_u1643_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u1644 (
    .a(_al_u1643_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[21]),
    .e(sgla_r[25]),
    .o(\sgla/n78 [17]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1645 (
    .a(_al_u1602_o),
    .b(_al_u1375_o),
    .c(abus[12]),
    .d(\sgla/n78 [17]),
    .o(\sgla/n85 [17]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1646 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[14]),
    .d(sgla_r[15]),
    .e(sgla_r[16]),
    .o(_al_u1646_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'h020ef2fe))
    _al_u1647 (
    .a(_al_u1646_o),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(sgla_r[12]),
    .e(sgla_r[8]),
    .o(_al_u1647_o));
  AL_MAP_LUT4 #(
    .EQN("(B*(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))"),
    .INIT(16'hc404))
    _al_u1648 (
    .a(_al_u1647_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(sgla_r[0]),
    .o(_al_u1648_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1649 (
    .a(_al_u1648_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[17]),
    .e(sgla_r[18]),
    .o(_al_u1649_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'hfdcd3101))
    _al_u1650 (
    .a(_al_u1649_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[20]),
    .e(sgla_r[24]),
    .o(\sgla/n78 [16]));
  AL_MAP_LUT4 #(
    .EQN("~(~(C*B)*~(D*A))"),
    .INIT(16'heac0))
    _al_u1651 (
    .a(_al_u1602_o),
    .b(_al_u1375_o),
    .c(abus[11]),
    .d(\sgla/n78 [16]),
    .o(\sgla/n85 [16]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1652 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[13]),
    .d(sgla_r[14]),
    .e(sgla_r[15]),
    .o(_al_u1652_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1653 (
    .a(_al_u1652_o),
    .b(_al_u1061_o),
    .c(sgla_r[11]),
    .o(_al_u1653_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h0c040004))
    _al_u1654 (
    .a(_al_u1653_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(_al_u1062_o),
    .e(sgla_r[7]),
    .o(_al_u1654_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1655 (
    .a(_al_u1654_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[16]),
    .e(sgla_r[17]),
    .o(_al_u1655_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1656 (
    .a(_al_u1655_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[19]),
    .e(sgla_r[23]),
    .o(_al_u1656_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1657 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(_al_u1656_o),
    .c(_al_u1164_o),
    .d(sgla_r[31]),
    .o(_al_u1657_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u1658 (
    .a(_al_u1657_o),
    .b(_al_u1375_o),
    .c(abus[10]),
    .o(\sgla/n85 [15]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1659 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[12]),
    .d(sgla_r[13]),
    .e(sgla_r[14]),
    .o(_al_u1659_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1660 (
    .a(_al_u1659_o),
    .b(_al_u1061_o),
    .c(sgla_r[10]),
    .o(_al_u1660_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h0c040004))
    _al_u1661 (
    .a(_al_u1660_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(_al_u1062_o),
    .e(sgla_r[6]),
    .o(_al_u1661_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1662 (
    .a(_al_u1661_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[15]),
    .e(sgla_r[16]),
    .o(_al_u1662_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1663 (
    .a(_al_u1662_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[18]),
    .e(sgla_r[22]),
    .o(_al_u1663_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1664 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(_al_u1663_o),
    .c(_al_u1164_o),
    .d(sgla_r[30]),
    .o(_al_u1664_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u1665 (
    .a(_al_u1664_o),
    .b(_al_u1375_o),
    .c(abus[9]),
    .o(\sgla/n85 [14]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1666 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[11]),
    .d(sgla_r[12]),
    .e(sgla_r[13]),
    .o(_al_u1666_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1667 (
    .a(_al_u1666_o),
    .b(_al_u1061_o),
    .c(sgla_r[9]),
    .o(_al_u1667_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h0c040004))
    _al_u1668 (
    .a(_al_u1667_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(_al_u1062_o),
    .e(sgla_r[5]),
    .o(_al_u1668_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1669 (
    .a(_al_u1668_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[14]),
    .e(sgla_r[15]),
    .o(_al_u1669_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1670 (
    .a(_al_u1669_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[17]),
    .e(sgla_r[21]),
    .o(_al_u1670_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1671 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(_al_u1670_o),
    .c(_al_u1164_o),
    .d(sgla_r[29]),
    .o(_al_u1671_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u1672 (
    .a(_al_u1671_o),
    .b(_al_u1375_o),
    .c(abus[8]),
    .o(\sgla/n85 [13]));
  AL_MAP_LUT5 #(
    .EQN("~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*~(C)*~(A)+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*~(A)+~((E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B))*C*A+(E*~(D)*~(B)+E*D*~(B)+~(E)*D*B+E*D*B)*C*A)"),
    .INIT(32'h0a4e1b5f))
    _al_u1673 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[10]),
    .d(sgla_r[11]),
    .e(sgla_r[12]),
    .o(_al_u1673_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1674 (
    .a(_al_u1673_o),
    .b(_al_u1061_o),
    .c(sgla_r[8]),
    .o(_al_u1674_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h0c040004))
    _al_u1675 (
    .a(_al_u1674_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(_al_u1062_o),
    .e(sgla_r[4]),
    .o(_al_u1675_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1676 (
    .a(_al_u1675_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[13]),
    .e(sgla_r[14]),
    .o(_al_u1676_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1677 (
    .a(_al_u1676_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[16]),
    .e(sgla_r[20]),
    .o(_al_u1677_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1678 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(_al_u1677_o),
    .c(_al_u1164_o),
    .d(sgla_r[28]),
    .o(_al_u1678_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u1679 (
    .a(_al_u1678_o),
    .b(_al_u1375_o),
    .c(abus[7]),
    .o(\sgla/n85 [12]));
  AL_MAP_LUT5 #(
    .EQN("~((D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B)*~(E)*~(A)+(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B)*E*~(A)+~((D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B))*E*A+(D*~(C)*~(B)+D*C*~(B)+~(D)*C*B+D*C*B)*E*A)"),
    .INIT(32'h0415aebf))
    _al_u1680 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[10]),
    .d(sgla_r[11]),
    .e(sgla_r[9]),
    .o(_al_u1680_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1681 (
    .a(_al_u1680_o),
    .b(_al_u1061_o),
    .c(sgla_r[7]),
    .o(_al_u1681_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h0c040004))
    _al_u1682 (
    .a(_al_u1681_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(_al_u1062_o),
    .e(sgla_r[3]),
    .o(_al_u1682_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1683 (
    .a(_al_u1682_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[12]),
    .e(sgla_r[13]),
    .o(_al_u1683_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1684 (
    .a(_al_u1683_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[15]),
    .e(sgla_r[19]),
    .o(_al_u1684_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1685 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(_al_u1684_o),
    .c(_al_u1164_o),
    .d(sgla_r[27]),
    .o(_al_u1685_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u1686 (
    .a(_al_u1685_o),
    .b(_al_u1375_o),
    .c(abus[6]),
    .o(\sgla/n85 [11]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'h01ab45ef))
    _al_u1687 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(sgla_r[10]),
    .d(sgla_r[8]),
    .e(sgla_r[9]),
    .o(_al_u1687_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'h2e))
    _al_u1688 (
    .a(_al_u1687_o),
    .b(_al_u1061_o),
    .c(sgla_r[6]),
    .o(_al_u1688_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))"),
    .INIT(32'h0c040004))
    _al_u1689 (
    .a(_al_u1688_o),
    .b(\sgla/mux14_b31_sel_is_0_o ),
    .c(_al_u1064_o),
    .d(_al_u1062_o),
    .e(sgla_r[2]),
    .o(_al_u1689_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1690 (
    .a(_al_u1689_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[11]),
    .e(sgla_r[12]),
    .o(_al_u1690_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1691 (
    .a(_al_u1690_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[14]),
    .e(sgla_r[18]),
    .o(_al_u1691_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))"),
    .INIT(16'ha202))
    _al_u1692 (
    .a(\sgla/mux27_b0_sel_is_0_o ),
    .b(_al_u1691_o),
    .c(_al_u1164_o),
    .d(sgla_r[26]),
    .o(_al_u1692_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*B))"),
    .INIT(8'hea))
    _al_u1693 (
    .a(_al_u1692_o),
    .b(_al_u1375_o),
    .c(abus[5]),
    .o(\sgla/n85 [10]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u1694 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(\sgla/n58 [2]),
    .d(n11[1]),
    .e(sgla_e[2]),
    .o(\sgla/n61 [2]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u1695 (
    .a(\sgla/n61 [2]),
    .b(_al_u1061_o),
    .c(n10[0]),
    .o(\sgla/n63 [2]));
  AL_MAP_LUT4 #(
    .EQN("(D*~(A)*~((~C*~B))+D*A*~((~C*~B))+~(D)*A*(~C*~B)+D*A*(~C*~B))"),
    .INIT(16'hfe02))
    _al_u1696 (
    .a(\sgla/n63 [2]),
    .b(_al_u1064_o),
    .c(_al_u1062_o),
    .d(sgla_e[2]),
    .o(\sgla/n67 [2]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1697 (
    .a(\sgla/n67 [2]),
    .b(_al_u1121_o),
    .c(_al_u1122_o),
    .d(\sgla/n48 [2]),
    .e(\sgla/n39 [2]),
    .o(\sgla/n71 [2]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u1698 (
    .a(\sgla/n71 [2]),
    .b(_al_u1167_o),
    .c(_al_u1218_o),
    .d(\sgla/n33 [1]),
    .e(\sgla/n28 [0]),
    .o(\sgla/n75 [2]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u1699 (
    .a(\sgla/n75 [2]),
    .b(\sgla/mux21_b2_sel_is_0_o ),
    .c(sgla_e[2]),
    .o(_al_u1699_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+A*B*C*~(D)*~(E)+A*B*~(C)*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hff8d888d))
    _al_u1700 (
    .a(fctl_load_a),
    .b(\sgla/n2 [2]),
    .c(_al_u1699_o),
    .d(_al_u1027_o),
    .e(\sgla/n11 [2]),
    .o(\sgla/n84 [2]));
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*B*A)"),
    .INIT(32'h00080000))
    _al_u1701 (
    .a(\sgla/mux14_b31_sel_is_0_o ),
    .b(\sgla/mux10_b2_sel_is_2_o ),
    .c(_al_u1058_o),
    .d(_al_u1059_o),
    .e(sgla_r[0]),
    .o(_al_u1701_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u1702 (
    .a(_al_u1701_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(sgla_r[1]),
    .e(sgla_r[2]),
    .o(_al_u1702_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u1703 (
    .a(_al_u1702_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(sgla_r[4]),
    .e(sgla_r[8]),
    .o(_al_u1703_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    _al_u1704 (
    .a(_al_u1703_o),
    .b(_al_u1164_o),
    .c(sgla_r[16]),
    .o(\sgla/n80 [0]));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*~B*A)"),
    .INIT(32'h20000000))
    _al_u1705 (
    .a(\sgla/n185_neg_lutinv ),
    .b(\sgla/n186 ),
    .c(\sgla/n187 ),
    .d(\sgla/n188 ),
    .e(_al_u1035_o),
    .o(_al_u1705_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u1706 (
    .a(\sgla/n190 [8]),
    .b(\sgla/n190 [7]),
    .c(\sgla/n190 [6]),
    .d(\sgla/n190 [5]),
    .o(\sgla/n152_neg_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1707 (
    .a(\sgla/n152_neg_lutinv ),
    .b(\sgla/n190 [4]),
    .o(\sgla/u152_sel_is_0_o ));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*~B))"),
    .INIT(8'ha8))
    _al_u1708 (
    .a(\sgla/n190 [2]),
    .b(\sgla/n190 [1]),
    .c(\sgla/n190 [0]),
    .o(_al_u1708_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(A*~(~E*~C*B)))"),
    .INIT(32'h0055005d))
    _al_u1709 (
    .a(_al_u1705_o),
    .b(\sgla/u152_sel_is_0_o ),
    .c(_al_u1708_o),
    .d(\sgla/mux41_b32_sel_is_2_o ),
    .e(\sgla/n190 [3]),
    .o(_al_u1709_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(C*~A*~(D*~B)))"),
    .INIT(32'hbfaf0000))
    _al_u1710 (
    .a(_al_u1709_o),
    .b(_al_u1040_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(_al_u1030_o),
    .e(sgla_r[9]),
    .o(_al_u1710_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~(~B*~A*~(E*C)))"),
    .INIT(32'hfe00ee00))
    _al_u1711 (
    .a(_al_u1710_o),
    .b(_al_u1031_o),
    .c(_al_u1042_o),
    .d(fctl_ccmd_reg),
    .e(\sgla/sgla_i [9]),
    .o(\norm/n0 [9]));
  AL_MAP_LUT5 #(
    .EQN("((~C*~(A)*~(D)+~C*A*~(D)+~(~C)*A*D+~C*A*D)*~(B)*~(E)+(~C*~(A)*~(D)+~C*A*~(D)+~(~C)*A*D+~C*A*D)*B*~(E)+~((~C*~(A)*~(D)+~C*A*~(D)+~(~C)*A*D+~C*A*D))*B*E+(~C*~(A)*~(D)+~C*A*~(D)+~(~C)*A*D+~C*A*D)*B*E)"),
    .INIT(32'hccccaa0f))
    _al_u1712 (
    .a(_al_u1328_o),
    .b(_al_u1352_o),
    .c(\norm/n0 [9]),
    .d(fctl_ccmd_div),
    .e(fctl_ccmd_mul),
    .o(_al_u1712_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'h303faaaa))
    _al_u1713 (
    .a(_al_u1712_o),
    .b(\fadd/n4 [9]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [9]),
    .e(fctl_ccmd_add),
    .o(_al_u1713_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*~(A)+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(A)+~(E)*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A)"),
    .INIT(32'hfd75a820))
    _al_u1714 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [27]),
    .c(\norm/sglc_f [7]),
    .d(\norm/sglc_f [8]),
    .e(\norm/sglc_f [9]),
    .o(\norm/n28 [9]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'h01ab45ef))
    _al_u1715 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(\norm/n28 [9]),
    .d(\norm/sglc_f [3]),
    .e(\norm/sglc_f [5]),
    .o(_al_u1715_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u1716 (
    .a(_al_u1003_o),
    .b(_al_u1715_o),
    .c(\norm/sglc_f [1]),
    .o(\norm/n34 [9]));
  AL_MAP_LUT4 #(
    .EQN("~((~B*A)*~(C)*~(D)+(~B*A)*C*~(D)+~((~B*A))*C*D+(~B*A)*C*D)"),
    .INIT(16'h0fdd))
    _al_u1717 (
    .a(\norm/n34 [9]),
    .b(_al_u1004_o),
    .c(\norm/sglc_f [10]),
    .d(\norm/sglc_f [29]),
    .o(_al_u1717_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'hf0f0cc55))
    _al_u1718 (
    .a(_al_u1717_o),
    .b(\norm/sglc_f [11]),
    .c(\norm/sglc_f [12]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n48 [9]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(A)*~(B)+~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*~(B)+~(~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*A*B+~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*B)"),
    .INIT(32'h74777444))
    _al_u1719 (
    .a(_al_u1713_o),
    .b(fctl_load_c),
    .c(\norm/n48 [9]),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [9]),
    .o(\norm/n53 [9]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1720 (
    .a(_al_u1705_o),
    .b(\sgla/u152_sel_is_0_o ),
    .o(_al_u1720_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1721 (
    .a(_al_u1720_o),
    .b(_al_u1205_o),
    .o(_al_u1721_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1722 (
    .a(\sgla/n190 [3]),
    .b(\sgla/n190 [2]),
    .o(\sgla/n200_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u1723 (
    .a(_al_u1721_o),
    .b(_al_u1705_o),
    .c(\sgla/n200_lutinv ),
    .o(_al_u1723_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+~(A)*~(B)*C*D+~(A)*B*C*D)"),
    .INIT(16'h5077))
    _al_u1724 (
    .a(_al_u1723_o),
    .b(_al_u1031_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(sgla_r[8]),
    .o(_al_u1724_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(D*B)))"),
    .INIT(16'hd050))
    _al_u1725 (
    .a(_al_u1724_o),
    .b(_al_u1042_o),
    .c(fctl_ccmd_reg),
    .d(\sgla/sgla_i [8]),
    .o(\norm/n0 [8]));
  AL_MAP_LUT5 #(
    .EQN("(~(C*~(A)*~(D)+C*A*~(D)+~(C)*A*D+C*A*D)*~(B)*~(E)+~(C*~(A)*~(D)+C*A*~(D)+~(C)*A*D+C*A*D)*B*~(E)+~(~(C*~(A)*~(D)+C*A*~(D)+~(C)*A*D+C*A*D))*B*E+~(C*~(A)*~(D)+C*A*~(D)+~(C)*A*D+C*A*D)*B*E)"),
    .INIT(32'hcccc550f))
    _al_u1726 (
    .a(sglc_r_fdiv[8]),
    .b(_al_u1349_o),
    .c(\norm/n0 [8]),
    .d(fctl_ccmd_div),
    .e(fctl_ccmd_mul),
    .o(_al_u1726_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'hcfc05555))
    _al_u1727 (
    .a(_al_u1726_o),
    .b(\fadd/n4 [8]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [8]),
    .e(fctl_ccmd_add),
    .o(\norm/sglc_r [8]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*~(A)+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(A)+~(E)*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A)"),
    .INIT(32'hfd75a820))
    _al_u1728 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [27]),
    .c(\norm/sglc_f [6]),
    .d(\norm/sglc_f [7]),
    .e(\norm/sglc_f [8]),
    .o(\norm/n28 [8]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'h01ab45ef))
    _al_u1729 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(\norm/n28 [8]),
    .d(\norm/sglc_f [2]),
    .e(\norm/sglc_f [4]),
    .o(_al_u1729_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u1730 (
    .a(_al_u1003_o),
    .b(_al_u1729_o),
    .c(\norm/sglc_f [0]),
    .o(\norm/n34 [8]));
  AL_MAP_LUT4 #(
    .EQN("~((~B*A)*~(D)*~(C)+(~B*A)*D*~(C)+~((~B*A))*D*C+(~B*A)*D*C)"),
    .INIT(16'h0dfd))
    _al_u1731 (
    .a(\norm/n34 [8]),
    .b(_al_u1004_o),
    .c(\norm/sglc_f [29]),
    .d(\norm/sglc_f [9]),
    .o(_al_u1731_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'hf0f0cc55))
    _al_u1732 (
    .a(_al_u1731_o),
    .b(\norm/sglc_f [10]),
    .c(\norm/sglc_f [11]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n48 [8]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(A)*~(B)+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*~(B)+~((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*A*B+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*B)"),
    .INIT(32'hb8bbb888))
    _al_u1733 (
    .a(\norm/sglc_r [8]),
    .b(fctl_load_c),
    .c(\norm/n48 [8]),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [8]),
    .o(\norm/n53 [8]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u1734 (
    .a(\sgla/n200_lutinv ),
    .b(\sgla/n190 [1]),
    .c(\sgla/n190 [0]),
    .o(\sgla/n199_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D*~(A*~(~C*B))))"),
    .INIT(32'ha2ff0000))
    _al_u1735 (
    .a(_al_u1721_o),
    .b(_al_u1705_o),
    .c(\sgla/n199_lutinv ),
    .d(\sgla/mux44_b0_sel_is_0_o ),
    .e(sgla_r[7]),
    .o(_al_u1735_o));
  AL_MAP_LUT5 #(
    .EQN("(D*(~(~B*~A)*~(E)*~(C)+~(~B*~A)*E*~(C)+~(~(~B*~A))*E*C+~(~B*~A)*E*C))"),
    .INIT(32'hfe000e00))
    _al_u1736 (
    .a(_al_u1735_o),
    .b(_al_u1031_o),
    .c(_al_u1042_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(\sgla/sgla_i [7]),
    .o(_al_u1736_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(D*~(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)))"),
    .INIT(32'h0c0f0a0f))
    _al_u1737 (
    .a(\fdiv/fdiv/rem2 [26]),
    .b(\fdiv/fdiv/rem3 [26]),
    .c(_al_u1736_o),
    .d(fctl_ccmd_div),
    .e(\fdiv/fquo [19]),
    .o(_al_u1737_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1738 (
    .a(_al_u1737_o),
    .b(fctl_ccmd_mul),
    .o(_al_u1738_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u1739 (
    .a(_al_u1361_o),
    .b(fctl_ccmd_add),
    .o(_al_u1739_o));
  AL_MAP_LUT4 #(
    .EQN("(D*(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B))"),
    .INIT(16'hb800))
    _al_u1740 (
    .a(\fadd/n4 [7]),
    .b(\fadd/sglc_f_t [31]),
    .c(\fadd/sglc_f_t [7]),
    .d(fctl_ccmd_add),
    .o(_al_u1740_o));
  AL_MAP_LUT5 #(
    .EQN("~(E*~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*~(A)+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(A)+~(E)*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A)"),
    .INIT(32'h028a57df))
    _al_u1741 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [27]),
    .c(\norm/sglc_f [5]),
    .d(\norm/sglc_f [6]),
    .e(\norm/sglc_f [7]),
    .o(_al_u1741_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u1742 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(_al_u1741_o),
    .d(\norm/sglc_f [1]),
    .e(\norm/sglc_f [3]),
    .o(_al_u1742_o));
  AL_MAP_LUT4 #(
    .EQN("~((~B*~A)*~(D)*~(C)+(~B*~A)*D*~(C)+~((~B*~A))*D*C+(~B*~A)*D*C)"),
    .INIT(16'h0efe))
    _al_u1743 (
    .a(_al_u1003_o),
    .b(_al_u1742_o),
    .c(\norm/sglc_f [29]),
    .d(\norm/sglc_f [8]),
    .o(_al_u1743_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(B)*~(D)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*B*~(D)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*B*D+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*B*D)"),
    .INIT(32'hccf5cc05))
    _al_u1744 (
    .a(_al_u1743_o),
    .b(\norm/sglc_f [10]),
    .c(\norm/sglc_f [30]),
    .d(\norm/sglc_f [31]),
    .e(\norm/sglc_f [9]),
    .o(\norm/n48 [7]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u1745 (
    .a(\norm/n48 [7]),
    .b(fctl_norm_enb_lutinv),
    .c(\norm/sglc_f [7]),
    .o(_al_u1745_o));
  AL_MAP_LUT5 #(
    .EQN("~(E*~((~D*~(B*~A)))*~(C)+E*(~D*~(B*~A))*~(C)+~(E)*(~D*~(B*~A))*C+E*(~D*~(B*~A))*C)"),
    .INIT(32'hf040ff4f))
    _al_u1746 (
    .a(_al_u1738_o),
    .b(_al_u1739_o),
    .c(fctl_load_c),
    .d(_al_u1740_o),
    .e(_al_u1745_o),
    .o(\norm/n53 [7]));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(C*~(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)))"),
    .INIT(32'h00cf00af))
    _al_u1747 (
    .a(\fdiv/fdiv/rem1 [26]),
    .b(\fdiv/fdiv/rem2 [26]),
    .c(fctl_ccmd_div),
    .d(fctl_ccmd_mul),
    .e(\fdiv/fquo [19]),
    .o(_al_u1747_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u1748 (
    .a(_al_u1347_o),
    .b(fctl_ccmd_add),
    .c(fctl_ccmd_mul),
    .o(_al_u1748_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(B*~(~D*C)))"),
    .INIT(16'h22a2))
    _al_u1749 (
    .a(_al_u1721_o),
    .b(_al_u1705_o),
    .c(\sgla/n200_lutinv ),
    .d(\sgla/n190 [1]),
    .o(_al_u1749_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+~(A)*~(B)*C*D+~(A)*B*C*D)"),
    .INIT(16'h5077))
    _al_u1750 (
    .a(_al_u1749_o),
    .b(_al_u1031_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(sgla_r[6]),
    .o(_al_u1750_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u1751 (
    .a(_al_u1750_o),
    .b(_al_u1042_o),
    .c(\sgla/sgla_i [6]),
    .o(_al_u1751_o));
  AL_MAP_LUT4 #(
    .EQN("(D*(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B))"),
    .INIT(16'hb800))
    _al_u1752 (
    .a(\fadd/n4 [6]),
    .b(\fadd/sglc_f_t [31]),
    .c(\fadd/sglc_f_t [6]),
    .d(fctl_ccmd_add),
    .o(_al_u1752_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(B*~(A*~(E*~C))))"),
    .INIT(32'h00b300bb))
    _al_u1753 (
    .a(_al_u1747_o),
    .b(_al_u1748_o),
    .c(_al_u1751_o),
    .d(_al_u1752_o),
    .e(\norm/mux1_b0_sel_is_2_o ),
    .o(_al_u1753_o));
  AL_MAP_LUT5 #(
    .EQN("~(E*~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*~(A)+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(A)+~(E)*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A)"),
    .INIT(32'h028a57df))
    _al_u1754 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [27]),
    .c(\norm/sglc_f [4]),
    .d(\norm/sglc_f [5]),
    .e(\norm/sglc_f [6]),
    .o(_al_u1754_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u1755 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(_al_u1754_o),
    .d(\norm/sglc_f [0]),
    .e(\norm/sglc_f [2]),
    .o(_al_u1755_o));
  AL_MAP_LUT4 #(
    .EQN("~((~B*~A)*~(D)*~(C)+(~B*~A)*D*~(C)+~((~B*~A))*D*C+(~B*~A)*D*C)"),
    .INIT(16'h0efe))
    _al_u1756 (
    .a(_al_u1003_o),
    .b(_al_u1755_o),
    .c(\norm/sglc_f [29]),
    .d(\norm/sglc_f [7]),
    .o(_al_u1756_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'hfdf10d01))
    _al_u1757 (
    .a(_al_u1756_o),
    .b(\norm/sglc_f [30]),
    .c(\norm/sglc_f [31]),
    .d(\norm/sglc_f [8]),
    .e(\norm/sglc_f [9]),
    .o(\norm/n48 [6]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(A)*~(B)+~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*~(B)+~(~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*A*B+~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*B)"),
    .INIT(32'h74777444))
    _al_u1758 (
    .a(_al_u1753_o),
    .b(fctl_load_c),
    .c(\norm/n48 [6]),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [6]),
    .o(\norm/n53 [6]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1759 (
    .a(\sgla/n200_lutinv ),
    .b(\sgla/n190 [1]),
    .c(\sgla/n190 [0]),
    .o(\sgla/n197_lutinv ));
  AL_MAP_LUT5 #(
    .EQN("(E*~(D*~(A*~(~C*B))))"),
    .INIT(32'ha2ff0000))
    _al_u1760 (
    .a(_al_u1721_o),
    .b(_al_u1705_o),
    .c(\sgla/n197_lutinv ),
    .d(\sgla/mux44_b0_sel_is_0_o ),
    .e(sgla_r[5]),
    .o(_al_u1760_o));
  AL_MAP_LUT5 #(
    .EQN("(D*(~(~B*~A)*~(E)*~(C)+~(~B*~A)*E*~(C)+~(~(~B*~A))*E*C+~(~B*~A)*E*C))"),
    .INIT(32'hfe000e00))
    _al_u1761 (
    .a(_al_u1760_o),
    .b(_al_u1031_o),
    .c(_al_u1042_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(\sgla/sgla_i [5]),
    .o(_al_u1761_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(D*~(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)))"),
    .INIT(32'h0c0f0a0f))
    _al_u1762 (
    .a(\fdiv/rem [25]),
    .b(\fdiv/fdiv/rem1 [26]),
    .c(_al_u1761_o),
    .d(fctl_ccmd_div),
    .e(\fdiv/fquo [19]),
    .o(_al_u1762_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    _al_u1763 (
    .a(\fadd/n4 [5]),
    .b(\fadd/sglc_f_t [31]),
    .c(\fadd/sglc_f_t [5]),
    .o(sglc_r_fadd[5]));
  AL_MAP_LUT5 #(
    .EQN("(~(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)*~(D)+~(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C*~(D)+~(~(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*C*D+~(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C*D)"),
    .INIT(32'hf033f055))
    _al_u1764 (
    .a(_al_u1762_o),
    .b(_al_u1351_o),
    .c(sglc_r_fadd[5]),
    .d(fctl_ccmd_add),
    .e(fctl_ccmd_mul),
    .o(\norm/sglc_r [5]));
  AL_MAP_LUT5 #(
    .EQN("~(E*~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*~(A)+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(A)+~(E)*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A+E*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*A)"),
    .INIT(32'h028a57df))
    _al_u1765 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [27]),
    .c(\norm/sglc_f [3]),
    .d(\norm/sglc_f [4]),
    .e(\norm/sglc_f [5]),
    .o(_al_u1765_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*(~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B))"),
    .INIT(16'h4501))
    _al_u1766 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(_al_u1765_o),
    .d(\norm/sglc_f [1]),
    .o(\norm/n42 [5]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'h010df1fd))
    _al_u1767 (
    .a(\norm/n42 [5]),
    .b(\norm/sglc_f [29]),
    .c(\norm/sglc_f [30]),
    .d(\norm/sglc_f [6]),
    .e(\norm/sglc_f [7]),
    .o(_al_u1767_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*~(B)+D*(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(B)+~(D)*(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*B+D*(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*B)"),
    .INIT(32'hf7c43704))
    _al_u1768 (
    .a(_al_u1767_o),
    .b(fctl_norm_enb_lutinv),
    .c(\norm/sglc_f [31]),
    .d(\norm/sglc_f [5]),
    .e(\norm/sglc_f [8]),
    .o(\norm/n50 [5]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    _al_u1769 (
    .a(\norm/sglc_r [5]),
    .b(fctl_load_c),
    .c(\norm/n50 [5]),
    .o(\norm/n53 [5]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1770 (
    .a(_al_u1075_o),
    .b(_al_u1705_o),
    .o(_al_u1770_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~(E*B)*~(D*A)))"),
    .INIT(32'he0c0a000))
    _al_u1771 (
    .a(_al_u1770_o),
    .b(_al_u1042_o),
    .c(fctl_ccmd_reg),
    .d(sgla_r[4]),
    .e(\sgla/sgla_i [4]),
    .o(\norm/n0 [4]));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(B*~((E*~A))*~(C)+B*(E*~A)*~(C)+~(B)*(E*~A)*C+B*(E*~A)*C))"),
    .INIT(32'h00a300f3))
    _al_u1772 (
    .a(\fdiv/rem [25]),
    .b(\norm/n0 [4]),
    .c(fctl_ccmd_div),
    .d(fctl_ccmd_mul),
    .e(\fdiv/fquo [19]),
    .o(_al_u1772_o));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(D*~(B*A)))"),
    .INIT(16'h080f))
    _al_u1773 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[23]),
    .c(fctl_ccmd_add),
    .d(fctl_ccmd_mul),
    .o(_al_u1773_o));
  AL_MAP_LUT4 #(
    .EQN("(D*(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B))"),
    .INIT(16'hb800))
    _al_u1774 (
    .a(\fadd/n4 [4]),
    .b(\fadd/sglc_f_t [31]),
    .c(\fadd/sglc_f_t [4]),
    .d(fctl_ccmd_add),
    .o(_al_u1774_o));
  AL_MAP_LUT5 #(
    .EQN("~(E*~((B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))*~(A)+E*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*~(A)+~(E)*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*A+E*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*A)"),
    .INIT(32'h02a257f7))
    _al_u1775 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [2]),
    .c(\norm/sglc_f [27]),
    .d(\norm/sglc_f [3]),
    .e(\norm/sglc_f [4]),
    .o(_al_u1775_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*(~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B))"),
    .INIT(16'h4501))
    _al_u1776 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(_al_u1775_o),
    .d(\norm/sglc_f [0]),
    .o(\norm/n42 [4]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*~(E)*~(C)+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*~(C)+~((A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))*E*C+(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B)*E*C)"),
    .INIT(32'h010df1fd))
    _al_u1777 (
    .a(\norm/n42 [4]),
    .b(\norm/sglc_f [29]),
    .c(\norm/sglc_f [30]),
    .d(\norm/sglc_f [5]),
    .e(\norm/sglc_f [6]),
    .o(_al_u1777_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*~(B)+D*(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(B)+~(D)*(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*B+D*(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*B)"),
    .INIT(32'hf7c43704))
    _al_u1778 (
    .a(_al_u1777_o),
    .b(fctl_norm_enb_lutinv),
    .c(\norm/sglc_f [31]),
    .d(\norm/sglc_f [4]),
    .e(\norm/sglc_f [7]),
    .o(\norm/n50 [4]));
  AL_MAP_LUT5 #(
    .EQN("~(~E*~((~D*~(B*~A)))*~(C)+~E*(~D*~(B*~A))*~(C)+~(~E)*(~D*~(B*~A))*C+~E*(~D*~(B*~A))*C)"),
    .INIT(32'hff4ff040))
    _al_u1779 (
    .a(_al_u1772_o),
    .b(_al_u1773_o),
    .c(fctl_load_c),
    .d(_al_u1774_o),
    .e(\norm/n50 [4]),
    .o(\norm/n53 [4]));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B*~(~C*~(E*D))))"),
    .INIT(32'h222a2a2a))
    _al_u1780 (
    .a(\sgla/n152_neg_lutinv ),
    .b(\sgla/n190 [3]),
    .c(\sgla/n190 [2]),
    .d(\sgla/n190 [1]),
    .e(\sgla/n190 [0]),
    .o(_al_u1780_o));
  AL_MAP_LUT4 #(
    .EQN("(D*A*~(~C*B))"),
    .INIT(16'ha200))
    _al_u1781 (
    .a(_al_u1075_o),
    .b(_al_u1720_o),
    .c(_al_u1780_o),
    .d(sgla_r[31]),
    .o(_al_u1781_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(~A*~(D*C)))"),
    .INIT(16'hc888))
    _al_u1782 (
    .a(_al_u1781_o),
    .b(\norm/mux2_b0_sel_is_2_o ),
    .c(_al_u1042_o),
    .d(sgla_r[41]),
    .o(\norm/n2 [31]));
  AL_MAP_LUT4 #(
    .EQN("~(B*~((C*A))*~(D)+B*(C*A)*~(D)+~(B)*(C*A)*D+B*(C*A)*D)"),
    .INIT(16'h5f33))
    _al_u1783 (
    .a(\fadd/n4 [31]),
    .b(\norm/n2 [31]),
    .c(\fadd/sglc_f_t [31]),
    .d(fctl_ccmd_add),
    .o(_al_u1783_o));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~C)*~(A)*~(B)+~(D*~C)*A*~(B)+~(~(D*~C))*A*B+~(D*~C)*A*B)"),
    .INIT(16'h4744))
    _al_u1784 (
    .a(_al_u1783_o),
    .b(fctl_load_c),
    .c(fctl_norm_enb_lutinv),
    .d(\norm/sglc_f [31]),
    .o(\norm/n53 [31]));
  AL_MAP_LUT4 #(
    .EQN("(A*~(B*~(~D*~C)))"),
    .INIT(16'h222a))
    _al_u1785 (
    .a(\sgla/n152_neg_lutinv ),
    .b(\sgla/n190 [3]),
    .c(\sgla/n190 [2]),
    .d(\sgla/n190 [1]),
    .o(_al_u1785_o));
  AL_MAP_LUT4 #(
    .EQN("(D*A*~(~C*B))"),
    .INIT(16'ha200))
    _al_u1786 (
    .a(_al_u1075_o),
    .b(_al_u1720_o),
    .c(_al_u1785_o),
    .d(sgla_r[30]),
    .o(_al_u1786_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(~A*~(D*C)))"),
    .INIT(16'hc888))
    _al_u1787 (
    .a(_al_u1786_o),
    .b(\norm/mux2_b0_sel_is_2_o ),
    .c(_al_u1042_o),
    .d(\sgla/sgla_i [30]),
    .o(\norm/n2 [30]));
  AL_MAP_LUT5 #(
    .EQN("~(B*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(E)+B*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(E)+~(B)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*E+B*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*E)"),
    .INIT(32'h505f3333))
    _al_u1788 (
    .a(\fadd/n4 [30]),
    .b(\norm/n2 [30]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [30]),
    .e(fctl_ccmd_add),
    .o(_al_u1788_o));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~C)*~(B)*~(A)+~(D*~C)*B*~(A)+~(~(D*~C))*B*A+~(D*~C)*B*A)"),
    .INIT(16'h2722))
    _al_u1789 (
    .a(fctl_load_c),
    .b(_al_u1788_o),
    .c(fctl_norm_enb_lutinv),
    .d(\norm/sglc_f [30]),
    .o(\norm/n53 [30]));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~(E*C)*~(D*A)))"),
    .INIT(32'hc8c08800))
    _al_u1790 (
    .a(_al_u1770_o),
    .b(\norm/mux2_b0_sel_is_2_o ),
    .c(_al_u1042_o),
    .d(sgla_r[3]),
    .e(\sgla/sgla_i [3]),
    .o(\norm/n2 [3]));
  AL_MAP_LUT5 #(
    .EQN("(B*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(E)+B*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(E)+~(B)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*E+B*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*E)"),
    .INIT(32'hafa0cccc))
    _al_u1791 (
    .a(\fadd/n4 [3]),
    .b(\norm/n2 [3]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [3]),
    .e(fctl_ccmd_add),
    .o(\norm/sglc_r [3]));
  AL_MAP_LUT5 #(
    .EQN("(E*~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*~(A)+E*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(A)+~(E)*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*A+E*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*A)"),
    .INIT(32'hf5dda088))
    _al_u1792 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [1]),
    .c(\norm/sglc_f [2]),
    .d(\norm/sglc_f [27]),
    .e(\norm/sglc_f [3]),
    .o(\norm/n28 [3]));
  AL_MAP_LUT4 #(
    .EQN("~((B*~A)*~(D)*~(C)+(B*~A)*D*~(C)+~((B*~A))*D*C+(B*~A)*D*C)"),
    .INIT(16'h0bfb))
    _al_u1793 (
    .a(_al_u1001_o),
    .b(\norm/n28 [3]),
    .c(\norm/sglc_f [29]),
    .d(\norm/sglc_f [4]),
    .o(_al_u1793_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'hfdf10d01))
    _al_u1794 (
    .a(_al_u1793_o),
    .b(\norm/sglc_f [30]),
    .c(\norm/sglc_f [31]),
    .d(\norm/sglc_f [5]),
    .e(\norm/sglc_f [6]),
    .o(\norm/n48 [3]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(B)*~(A)+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*B*~(A)+~((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*B*A+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*B*A)"),
    .INIT(32'hd8ddd888))
    _al_u1795 (
    .a(fctl_load_c),
    .b(\norm/sglc_r [3]),
    .c(\norm/n48 [3]),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [3]),
    .o(\norm/n53 [3]));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B*~(~E*~D*~C)))"),
    .INIT(32'h2222222a))
    _al_u1796 (
    .a(\sgla/n152_neg_lutinv ),
    .b(\sgla/n190 [3]),
    .c(\sgla/n190 [2]),
    .d(\sgla/n190 [1]),
    .e(\sgla/n190 [0]),
    .o(_al_u1796_o));
  AL_MAP_LUT4 #(
    .EQN("(D*A*~(~C*B))"),
    .INIT(16'ha200))
    _al_u1797 (
    .a(_al_u1075_o),
    .b(_al_u1720_o),
    .c(_al_u1796_o),
    .d(sgla_r[29]),
    .o(_al_u1797_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(~A*~(D*C)))"),
    .INIT(16'hc888))
    _al_u1798 (
    .a(_al_u1797_o),
    .b(\norm/mux2_b0_sel_is_2_o ),
    .c(_al_u1042_o),
    .d(\sgla/sgla_i [29]),
    .o(\norm/n2 [29]));
  AL_MAP_LUT5 #(
    .EQN("(B*~((D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C))*~(E)+B*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*~(E)+~(B)*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*E+B*(D*~(A)*~(C)+D*A*~(C)+~(D)*A*C+D*A*C)*E)"),
    .INIT(32'hafa0cccc))
    _al_u1799 (
    .a(\fadd/n4 [29]),
    .b(\norm/n2 [29]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [29]),
    .e(fctl_ccmd_add),
    .o(\norm/sglc_r [29]));
  AL_MAP_LUT4 #(
    .EQN("((D*~C)*~(B)*~(A)+(D*~C)*B*~(A)+~((D*~C))*B*A+(D*~C)*B*A)"),
    .INIT(16'h8d88))
    _al_u1800 (
    .a(fctl_load_c),
    .b(\norm/sglc_r [29]),
    .c(fctl_norm_enb_lutinv),
    .d(\norm/sglc_f [29]),
    .o(\norm/n53 [29]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u1801 (
    .a(\sgla/n152_neg_lutinv ),
    .b(\sgla/n190 [3]),
    .o(_al_u1801_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(~E*~B)*~(~C*A))"),
    .INIT(32'h00f500c4))
    _al_u1802 (
    .a(_al_u1720_o),
    .b(_al_u1031_o),
    .c(_al_u1801_o),
    .d(_al_u1205_o),
    .e(sgla_r[28]),
    .o(_al_u1802_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(E*C)*~(D*~B))"),
    .INIT(32'h04054455))
    _al_u1803 (
    .a(_al_u1802_o),
    .b(\sgla/mux44_b0_sel_is_0_o ),
    .c(_al_u1042_o),
    .d(sgla_r[28]),
    .e(\sgla/sgla_i [28]),
    .o(_al_u1803_o));
  AL_MAP_LUT5 #(
    .EQN("(~(C*~A)*~((~E*~D))*~(B)+~(C*~A)*(~E*~D)*~(B)+~(~(C*~A))*(~E*~D)*B+~(C*~A)*(~E*~D)*B)"),
    .INIT(32'h232323ef))
    _al_u1804 (
    .a(_al_u1803_o),
    .b(fctl_ccmd_div),
    .c(fctl_ccmd_reg),
    .d(\fdiv/fquo [18]),
    .e(\fdiv/fquo [19]),
    .o(_al_u1804_o));
  AL_MAP_LUT4 #(
    .EQN("~(C*~((~B*~A))*~(D)+C*(~B*~A)*~(D)+~(C)*(~B*~A)*D+C*(~B*~A)*D)"),
    .INIT(16'hee0f))
    _al_u1805 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[46]),
    .c(_al_u1804_o),
    .d(fctl_ccmd_mul),
    .o(\norm/n2 [28]));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'h303f5555))
    _al_u1806 (
    .a(\norm/n2 [28]),
    .b(\fadd/n4 [28]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [28]),
    .e(fctl_ccmd_add),
    .o(_al_u1806_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1807 (
    .a(_al_u1005_o),
    .b(\norm/sglc_f [15]),
    .c(\norm/sglc_f [16]),
    .o(_al_u1807_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u1808 (
    .a(_al_u1807_o),
    .b(\norm/sglc_f [13]),
    .c(\norm/sglc_f [14]),
    .o(_al_u1808_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*A*~(~C*B))"),
    .INIT(32'h000000a2))
    _al_u1809 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [24]),
    .c(\norm/sglc_f [25]),
    .d(\norm/sglc_f [26]),
    .e(\norm/sglc_f [27]),
    .o(_al_u1809_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(A*~(~E*~(~D*C))))"),
    .INIT(32'h4444cc4c))
    _al_u1810 (
    .a(_al_u1002_o),
    .b(_al_u1809_o),
    .c(\norm/sglc_f [20]),
    .d(\norm/sglc_f [21]),
    .e(\norm/sglc_f [22]),
    .o(_al_u1810_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u1811 (
    .a(_al_u1004_o),
    .b(_al_u1810_o),
    .c(\norm/sglc_f [18]),
    .o(_al_u1811_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(A*~(~E*~(~D*C))))"),
    .INIT(32'h11113313))
    _al_u1812 (
    .a(_al_u1005_o),
    .b(_al_u1811_o),
    .c(\norm/sglc_f [14]),
    .d(\norm/sglc_f [15]),
    .e(\norm/sglc_f [16]),
    .o(_al_u1812_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~E*~C)*~(B*~(D*A)))"),
    .INIT(32'hbb33b030))
    _al_u1813 (
    .a(_al_u1808_o),
    .b(_al_u1812_o),
    .c(fctl_norm_enb_lutinv),
    .d(\norm/sglc_f [12]),
    .e(\norm/sglc_f [28]),
    .o(\norm/n50 [28]));
  AL_MAP_LUT3 #(
    .EQN("~(~C*~(A)*~(B)+~C*A*~(B)+~(~C)*A*B+~C*A*B)"),
    .INIT(8'h74))
    _al_u1814 (
    .a(_al_u1806_o),
    .b(fctl_load_c),
    .c(\norm/n50 [28]),
    .o(\norm/n53 [28]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1815 (
    .a(\sgla/n190 [3]),
    .b(\sgla/n190 [2]),
    .c(\sgla/n190 [1]),
    .o(\sgla/n202_lutinv ));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*~B))"),
    .INIT(8'h54))
    _al_u1816 (
    .a(\sgla/n202_lutinv ),
    .b(\sgla/n190 [3]),
    .c(\sgla/n190 [0]),
    .o(_al_u1816_o));
  AL_MAP_LUT4 #(
    .EQN("~(~C*~((D*~B))*~(A)+~C*(D*~B)*~(A)+~(~C)*(D*~B)*A+~C*(D*~B)*A)"),
    .INIT(16'hd8fa))
    _al_u1817 (
    .a(_al_u1720_o),
    .b(_al_u1816_o),
    .c(_al_u1205_o),
    .d(\sgla/n152_neg_lutinv ),
    .o(_al_u1817_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+A*B*C*~(D)+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'ha0bb))
    _al_u1818 (
    .a(_al_u1817_o),
    .b(_al_u1031_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(sgla_r[27]),
    .o(_al_u1818_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))"),
    .INIT(16'ha088))
    _al_u1819 (
    .a(fctl_ccmd_div),
    .b(\fdiv/fquo [17]),
    .c(\fdiv/fquo [18]),
    .d(\fdiv/fquo [19]),
    .o(_al_u1819_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(D*~(A*~(E*B))))"),
    .INIT(32'h020f0a0f))
    _al_u1820 (
    .a(_al_u1818_o),
    .b(_al_u1042_o),
    .c(_al_u1819_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(\sgla/sgla_i [27]),
    .o(_al_u1820_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u1821 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[46]),
    .c(sfpu_dsp_c[45]),
    .d(_al_u1820_o),
    .e(fctl_ccmd_mul),
    .o(_al_u1821_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'hcfc05555))
    _al_u1822 (
    .a(_al_u1821_o),
    .b(\fadd/n4 [27]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [27]),
    .e(fctl_ccmd_add),
    .o(\norm/sglc_r [27]));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~C*~(~D*B)))"),
    .INIT(16'ha0a8))
    _al_u1823 (
    .a(_al_u1003_o),
    .b(\norm/sglc_f [17]),
    .c(\norm/sglc_f [19]),
    .d(\norm/sglc_f [20]),
    .o(_al_u1823_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E)"),
    .INIT(32'h00aa5f57))
    _al_u1824 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [23]),
    .c(\norm/sglc_f [25]),
    .d(\norm/sglc_f [26]),
    .e(\norm/sglc_f [27]),
    .o(_al_u1824_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~A*~(D*B))"),
    .INIT(16'h1050))
    _al_u1825 (
    .a(_al_u1823_o),
    .b(_al_u1002_o),
    .c(_al_u1824_o),
    .d(\norm/sglc_f [21]),
    .o(_al_u1825_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(~E*~(~B*~(~C*A))))"),
    .INIT(32'h00ff0031))
    _al_u1826 (
    .a(\norm/sglc_f [11]),
    .b(\norm/sglc_f [13]),
    .c(\norm/sglc_f [14]),
    .d(\norm/sglc_f [15]),
    .e(\norm/sglc_f [16]),
    .o(_al_u1826_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u1827 (
    .a(_al_u1005_o),
    .b(_al_u1825_o),
    .c(_al_u1826_o),
    .o(_al_u1827_o));
  AL_MAP_LUT5 #(
    .EQN("(A*~(B)*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*B*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+A*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E)"),
    .INIT(32'h00ff0f3a))
    _al_u1828 (
    .a(_al_u1827_o),
    .b(\norm/sglc_f [28]),
    .c(\norm/sglc_f [29]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(_al_u1828_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D)*~(A)*~(B)+~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D)*A*~(B)+~(~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D))*A*B+~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D)*A*B)"),
    .INIT(32'h8bbb8b88))
    _al_u1829 (
    .a(\norm/sglc_r [27]),
    .b(fctl_load_c),
    .c(_al_u1828_o),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [27]),
    .o(\norm/n53 [27]));
  AL_MAP_LUT4 #(
    .EQN("~(~B*~((D*C))*~(A)+~B*(D*C)*~(A)+~(~B)*(D*C)*A+~B*(D*C)*A)"),
    .INIT(16'h4eee))
    _al_u1830 (
    .a(_al_u1720_o),
    .b(_al_u1205_o),
    .c(\sgla/n152_neg_lutinv ),
    .d(\sgla/n202_lutinv ),
    .o(_al_u1830_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+A*B*C*~(D)+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'ha0bb))
    _al_u1831 (
    .a(_al_u1830_o),
    .b(_al_u1031_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(sgla_r[26]),
    .o(_al_u1831_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))"),
    .INIT(16'ha088))
    _al_u1832 (
    .a(fctl_ccmd_div),
    .b(\fdiv/fquo [16]),
    .c(\fdiv/fquo [17]),
    .d(\fdiv/fquo [19]),
    .o(_al_u1832_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(D*~(A*~(E*B))))"),
    .INIT(32'h020f0a0f))
    _al_u1833 (
    .a(_al_u1831_o),
    .b(_al_u1042_o),
    .c(_al_u1832_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(\sgla/sgla_i [26]),
    .o(_al_u1833_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u1834 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[45]),
    .c(sfpu_dsp_c[44]),
    .d(_al_u1833_o),
    .e(fctl_ccmd_mul),
    .o(_al_u1834_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'hcfc05555))
    _al_u1835 (
    .a(_al_u1834_o),
    .b(\fadd/n4 [26]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [26]),
    .e(fctl_ccmd_add),
    .o(\norm/sglc_r [26]));
  AL_MAP_LUT5 #(
    .EQN("~(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'h0a5f2277))
    _al_u1836 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [24]),
    .c(\norm/sglc_f [25]),
    .d(\norm/sglc_f [26]),
    .e(\norm/sglc_f [27]),
    .o(_al_u1836_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u1837 (
    .a(_al_u1001_o),
    .b(_al_u1836_o),
    .c(\norm/sglc_f [22]),
    .o(\norm/n30 [26]));
  AL_MAP_LUT5 #(
    .EQN("((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'hfe54ae04))
    _al_u1838 (
    .a(_al_u1003_o),
    .b(\norm/n30 [26]),
    .c(_al_u1002_o),
    .d(\norm/sglc_f [18]),
    .e(\norm/sglc_f [20]),
    .o(\norm/n34 [26]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'hfe54ba10))
    _al_u1839 (
    .a(_al_u1005_o),
    .b(_al_u1004_o),
    .c(\norm/n34 [26]),
    .d(\norm/sglc_f [14]),
    .e(\norm/sglc_f [16]),
    .o(\norm/n38 [26]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'hfe54ba10))
    _al_u1840 (
    .a(_al_u1808_o),
    .b(_al_u1807_o),
    .c(\norm/n38 [26]),
    .d(\norm/sglc_f [10]),
    .e(\norm/sglc_f [12]),
    .o(\norm/n42 [26]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u1841 (
    .a(\norm/n42 [26]),
    .b(\norm/sglc_f [27]),
    .c(\norm/sglc_f [28]),
    .d(\norm/sglc_f [29]),
    .e(\norm/sglc_f [30]),
    .o(\norm/n46 [26]));
  AL_MAP_LUT5 #(
    .EQN("(C*~((A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E))*~(B)+C*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*~(B)+~(C)*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*B+C*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*B)"),
    .INIT(32'hfc30b8b8))
    _al_u1842 (
    .a(\norm/n46 [26]),
    .b(fctl_norm_enb_lutinv),
    .c(\norm/sglc_f [26]),
    .d(\norm/sglc_f [29]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n50 [26]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u1843 (
    .a(\norm/sglc_r [26]),
    .b(\norm/n50 [26]),
    .c(fctl_load_c),
    .o(\norm/n53 [26]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~(A*~(~C*B)))"),
    .INIT(16'h005d))
    _al_u1844 (
    .a(_al_u1720_o),
    .b(_al_u1801_o),
    .c(_al_u1708_o),
    .d(\sgla/mux41_b32_sel_is_2_o ),
    .o(_al_u1844_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~A*~(D*~B))"),
    .INIT(16'h4050))
    _al_u1845 (
    .a(_al_u1844_o),
    .b(_al_u1040_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(_al_u1030_o),
    .o(_al_u1845_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*~B))"),
    .INIT(8'h54))
    _al_u1846 (
    .a(_al_u1845_o),
    .b(_al_u1031_o),
    .c(sgla_r[25]),
    .o(_al_u1846_o));
  AL_MAP_LUT4 #(
    .EQN("(C*(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))"),
    .INIT(16'he020))
    _al_u1847 (
    .a(_al_u1846_o),
    .b(_al_u1042_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(\sgla/sgla_i [25]),
    .o(_al_u1847_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*~B))"),
    .INIT(8'h45))
    _al_u1848 (
    .a(_al_u1847_o),
    .b(_al_u1337_o),
    .c(fctl_ccmd_div),
    .o(_al_u1848_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u1849 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[44]),
    .c(sfpu_dsp_c[43]),
    .d(_al_u1848_o),
    .e(fctl_ccmd_mul),
    .o(_al_u1849_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'h303faaaa))
    _al_u1850 (
    .a(_al_u1849_o),
    .b(\fadd/n4 [25]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [25]),
    .e(fctl_ccmd_add),
    .o(_al_u1850_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'h0a5f2277))
    _al_u1851 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [23]),
    .c(\norm/sglc_f [24]),
    .d(\norm/sglc_f [25]),
    .e(\norm/sglc_f [27]),
    .o(_al_u1851_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u1852 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(_al_u1851_o),
    .d(\norm/sglc_f [19]),
    .e(\norm/sglc_f [21]),
    .o(_al_u1852_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u1853 (
    .a(_al_u1003_o),
    .b(_al_u1852_o),
    .c(\norm/sglc_f [17]),
    .o(\norm/n34 [25]));
  AL_MAP_LUT5 #(
    .EQN("((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'hfe54ae04))
    _al_u1854 (
    .a(_al_u1005_o),
    .b(\norm/n34 [25]),
    .c(_al_u1004_o),
    .d(\norm/sglc_f [13]),
    .e(\norm/sglc_f [15]),
    .o(\norm/n38 [25]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1855 (
    .a(_al_u1808_o),
    .b(_al_u1807_o),
    .c(\norm/n38 [25]),
    .d(\norm/sglc_f [11]),
    .e(\norm/sglc_f [9]),
    .o(\norm/n42 [25]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u1856 (
    .a(\norm/n42 [25]),
    .b(\norm/sglc_f [26]),
    .c(\norm/sglc_f [27]),
    .d(\norm/sglc_f [29]),
    .e(\norm/sglc_f [30]),
    .o(\norm/n46 [25]));
  AL_MAP_LUT5 #(
    .EQN("(C*~((A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E))*~(B)+C*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*~(B)+~(C)*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*B+C*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*B)"),
    .INIT(32'hfc30b8b8))
    _al_u1857 (
    .a(\norm/n46 [25]),
    .b(fctl_norm_enb_lutinv),
    .c(\norm/sglc_f [25]),
    .d(\norm/sglc_f [28]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n50 [25]));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'h5c))
    _al_u1858 (
    .a(_al_u1850_o),
    .b(\norm/n50 [25]),
    .c(fctl_load_c),
    .o(\norm/n53 [25]));
  AL_MAP_LUT5 #(
    .EQN("(D*~A*~(~E*C*B))"),
    .INIT(32'h55001500))
    _al_u1859 (
    .a(_al_u1721_o),
    .b(\sgla/n152_neg_lutinv ),
    .c(\sgla/n200_lutinv ),
    .d(\sgla/mux44_b0_sel_is_0_o ),
    .e(\sgla/mux41_b32_sel_is_2_o ),
    .o(_al_u1859_o));
  AL_MAP_LUT5 #(
    .EQN("(~B*~(E*C)*~(D*~A))"),
    .INIT(32'h02032233))
    _al_u1860 (
    .a(_al_u1859_o),
    .b(_al_u1031_o),
    .c(_al_u1042_o),
    .d(sgla_r[24]),
    .e(\sgla/sgla_i [24]),
    .o(_al_u1860_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))"),
    .INIT(16'ha088))
    _al_u1861 (
    .a(fctl_ccmd_div),
    .b(\fdiv/fquo [14]),
    .c(\fdiv/fquo [15]),
    .d(\fdiv/fquo [19]),
    .o(_al_u1861_o));
  AL_MAP_LUT5 #(
    .EQN("((~C*~(D*~B))*~(A)*~(E)+(~C*~(D*~B))*A*~(E)+~((~C*~(D*~B)))*A*E+(~C*~(D*~B))*A*E)"),
    .INIT(32'haaaa0c0f))
    _al_u1862 (
    .a(_al_u1359_o),
    .b(_al_u1860_o),
    .c(_al_u1861_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(fctl_ccmd_mul),
    .o(_al_u1862_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'hcfc05555))
    _al_u1863 (
    .a(_al_u1862_o),
    .b(\fadd/n4 [24]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [24]),
    .e(fctl_ccmd_add),
    .o(\norm/sglc_r [24]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'hf5a0dd88))
    _al_u1864 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [22]),
    .c(\norm/sglc_f [23]),
    .d(\norm/sglc_f [24]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n28 [24]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'h01ab45ef))
    _al_u1865 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(\norm/n28 [24]),
    .d(\norm/sglc_f [18]),
    .e(\norm/sglc_f [20]),
    .o(_al_u1865_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u1866 (
    .a(_al_u1003_o),
    .b(_al_u1865_o),
    .c(\norm/sglc_f [16]),
    .o(\norm/n34 [24]));
  AL_MAP_LUT5 #(
    .EQN("((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'hfe54ae04))
    _al_u1867 (
    .a(_al_u1005_o),
    .b(\norm/n34 [24]),
    .c(_al_u1004_o),
    .d(\norm/sglc_f [12]),
    .e(\norm/sglc_f [14]),
    .o(\norm/n38 [24]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*~(E)*~(A)+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*~(A)+~((C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))*E*A+(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B)*E*A)"),
    .INIT(32'hfeba5410))
    _al_u1868 (
    .a(_al_u1808_o),
    .b(_al_u1807_o),
    .c(\norm/n38 [24]),
    .d(\norm/sglc_f [10]),
    .e(\norm/sglc_f [8]),
    .o(\norm/n42 [24]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u1869 (
    .a(\norm/n42 [24]),
    .b(\norm/sglc_f [25]),
    .c(\norm/sglc_f [26]),
    .d(\norm/sglc_f [29]),
    .e(\norm/sglc_f [30]),
    .o(\norm/n46 [24]));
  AL_MAP_LUT5 #(
    .EQN("(C*~((A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E))*~(B)+C*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*~(B)+~(C)*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*B+C*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*B)"),
    .INIT(32'hfc30b8b8))
    _al_u1870 (
    .a(\norm/n46 [24]),
    .b(fctl_norm_enb_lutinv),
    .c(\norm/sglc_f [24]),
    .d(\norm/sglc_f [27]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n50 [24]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u1871 (
    .a(\norm/sglc_r [24]),
    .b(\norm/n50 [24]),
    .c(fctl_load_c),
    .o(\norm/n53 [24]));
  AL_MAP_LUT3 #(
    .EQN("~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'h47))
    _al_u1872 (
    .a(\fadd/n4 [23]),
    .b(\fadd/sglc_f_t [31]),
    .c(\fadd/sglc_f_t [23]),
    .o(_al_u1872_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*~C)*~(~D*B*A))"),
    .INIT(32'hf070ff77))
    _al_u1873 (
    .a(\sgla/n199_lutinv ),
    .b(\sgla/n152_neg_lutinv ),
    .c(_al_u1040_o),
    .d(\sgla/mux41_b32_sel_is_2_o ),
    .e(_al_u1030_o),
    .o(_al_u1873_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(C*B*~(~D*~A)))"),
    .INIT(32'h3f7f0000))
    _al_u1874 (
    .a(_al_u1720_o),
    .b(_al_u1873_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(\sgla/mux41_b32_sel_is_2_o ),
    .e(sgla_r[23]),
    .o(_al_u1874_o));
  AL_MAP_LUT5 #(
    .EQN("(D*(~(~B*~A)*~(E)*~(C)+~(~B*~A)*E*~(C)+~(~(~B*~A))*E*C+~(~B*~A)*E*C))"),
    .INIT(32'hfe000e00))
    _al_u1875 (
    .a(_al_u1874_o),
    .b(_al_u1031_o),
    .c(_al_u1042_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(\sgla/sgla_i [23]),
    .o(_al_u1875_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~(B*(C*~(D)*~(E)+C*D*~(E)+~(C)*D*E+C*D*E)))"),
    .INIT(32'h11551515))
    _al_u1876 (
    .a(_al_u1875_o),
    .b(fctl_ccmd_div),
    .c(\fdiv/fquo [13]),
    .d(\fdiv/fquo [14]),
    .e(\fdiv/fquo [19]),
    .o(_al_u1876_o));
  AL_MAP_LUT5 #(
    .EQN("((C*~(A)*~(E)+C*A*~(E)+~(C)*A*E+C*A*E)*~(B)*~(D)+(C*~(A)*~(E)+C*A*~(E)+~(C)*A*E+C*A*E)*B*~(D)+~((C*~(A)*~(E)+C*A*~(E)+~(C)*A*E+C*A*E))*B*D+(C*~(A)*~(E)+C*A*~(E)+~(C)*A*E+C*A*E)*B*D)"),
    .INIT(32'hccaaccf0))
    _al_u1877 (
    .a(_al_u1358_o),
    .b(_al_u1872_o),
    .c(_al_u1876_o),
    .d(fctl_ccmd_add),
    .e(fctl_ccmd_mul),
    .o(_al_u1877_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'hf5a0dd88))
    _al_u1878 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [21]),
    .c(\norm/sglc_f [22]),
    .d(\norm/sglc_f [23]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n28 [23]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'h01ab45ef))
    _al_u1879 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(\norm/n28 [23]),
    .d(\norm/sglc_f [17]),
    .e(\norm/sglc_f [19]),
    .o(_al_u1879_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u1880 (
    .a(_al_u1003_o),
    .b(_al_u1879_o),
    .c(\norm/sglc_f [15]),
    .o(\norm/n34 [23]));
  AL_MAP_LUT5 #(
    .EQN("((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'hfe54ae04))
    _al_u1881 (
    .a(_al_u1005_o),
    .b(\norm/n34 [23]),
    .c(_al_u1004_o),
    .d(\norm/sglc_f [11]),
    .e(\norm/sglc_f [13]),
    .o(\norm/n38 [23]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'hfe54ba10))
    _al_u1882 (
    .a(_al_u1808_o),
    .b(_al_u1807_o),
    .c(\norm/n38 [23]),
    .d(\norm/sglc_f [7]),
    .e(\norm/sglc_f [9]),
    .o(\norm/n42 [23]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u1883 (
    .a(\norm/n42 [23]),
    .b(\norm/sglc_f [24]),
    .c(\norm/sglc_f [25]),
    .d(\norm/sglc_f [29]),
    .e(\norm/sglc_f [30]),
    .o(\norm/n46 [23]));
  AL_MAP_LUT5 #(
    .EQN("(C*~((A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E))*~(B)+C*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*~(B)+~(C)*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*B+C*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*B)"),
    .INIT(32'hfc30b8b8))
    _al_u1884 (
    .a(\norm/n46 [23]),
    .b(fctl_norm_enb_lutinv),
    .c(\norm/sglc_f [23]),
    .d(\norm/sglc_f [26]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n50 [23]));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'h5c))
    _al_u1885 (
    .a(_al_u1877_o),
    .b(\norm/n50 [23]),
    .c(fctl_load_c),
    .o(\norm/n53 [23]));
  AL_MAP_LUT4 #(
    .EQN("(A*~(~D*C*B))"),
    .INIT(16'haa2a))
    _al_u1886 (
    .a(_al_u1720_o),
    .b(\sgla/n152_neg_lutinv ),
    .c(\sgla/n200_lutinv ),
    .d(\sgla/n190 [1]),
    .o(_al_u1886_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(~C*~A))"),
    .INIT(8'hc8))
    _al_u1887 (
    .a(_al_u1886_o),
    .b(\sgla/mux44_b0_sel_is_0_o ),
    .c(\sgla/mux41_b32_sel_is_2_o ),
    .o(_al_u1887_o));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+A*~(B)*~(C)*~(D)*E+A*B*~(C)*~(D)*E+A*~(B)*C*~(D)*E+A*B*C*~(D)*E+A*~(B)*C*D*E)"),
    .INIT(32'h20aa33ff))
    _al_u1888 (
    .a(_al_u1887_o),
    .b(sgla_r[43]),
    .c(_al_u1040_o),
    .d(_al_u1030_o),
    .e(sgla_r[22]),
    .o(_al_u1888_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))"),
    .INIT(16'ha088))
    _al_u1889 (
    .a(fctl_ccmd_div),
    .b(\fdiv/fquo [12]),
    .c(\fdiv/fquo [13]),
    .d(\fdiv/fquo [19]),
    .o(_al_u1889_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(D*~(A*~(E*B))))"),
    .INIT(32'h020f0a0f))
    _al_u1890 (
    .a(_al_u1888_o),
    .b(_al_u1042_o),
    .c(_al_u1889_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(\sgla/sgla_i [22]),
    .o(_al_u1890_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u1891 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[41]),
    .c(sfpu_dsp_c[40]),
    .d(_al_u1890_o),
    .e(fctl_ccmd_mul),
    .o(_al_u1891_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'h303faaaa))
    _al_u1892 (
    .a(_al_u1891_o),
    .b(\fadd/n4 [22]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [22]),
    .e(fctl_ccmd_add),
    .o(_al_u1892_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'h0a5f2277))
    _al_u1893 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [20]),
    .c(\norm/sglc_f [21]),
    .d(\norm/sglc_f [22]),
    .e(\norm/sglc_f [27]),
    .o(_al_u1893_o));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'h4e))
    _al_u1894 (
    .a(_al_u1001_o),
    .b(_al_u1893_o),
    .c(\norm/sglc_f [18]),
    .o(_al_u1894_o));
  AL_MAP_LUT5 #(
    .EQN("((~B*~(E)*~(C)+~B*E*~(C)+~(~B)*E*C+~B*E*C)*~(D)*~(A)+(~B*~(E)*~(C)+~B*E*~(C)+~(~B)*E*C+~B*E*C)*D*~(A)+~((~B*~(E)*~(C)+~B*E*~(C)+~(~B)*E*C+~B*E*C))*D*A+(~B*~(E)*~(C)+~B*E*~(C)+~(~B)*E*C+~B*E*C)*D*A)"),
    .INIT(32'hfb51ab01))
    _al_u1895 (
    .a(_al_u1003_o),
    .b(_al_u1894_o),
    .c(_al_u1002_o),
    .d(\norm/sglc_f [14]),
    .e(\norm/sglc_f [16]),
    .o(\norm/n34 [22]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u1896 (
    .a(_al_u1004_o),
    .b(\norm/n34 [22]),
    .c(\norm/sglc_f [12]),
    .o(_al_u1896_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C)*~(E)*~(A)+(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C)*E*~(A)+~((~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C))*E*A+(~B*~(D)*~(C)+~B*D*~(C)+~(~B)*D*C+~B*D*C)*E*A)"),
    .INIT(32'h0454aefe))
    _al_u1897 (
    .a(_al_u1807_o),
    .b(_al_u1896_o),
    .c(_al_u1005_o),
    .d(\norm/sglc_f [10]),
    .e(\norm/sglc_f [8]),
    .o(_al_u1897_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~(E)*~(A)+~B*E*~(A)+~(~B)*E*A+~B*E*A)*~(C)*~(D)+(~B*~(E)*~(A)+~B*E*~(A)+~(~B)*E*A+~B*E*A)*C*~(D)+~((~B*~(E)*~(A)+~B*E*~(A)+~(~B)*E*A+~B*E*A))*C*D+(~B*~(E)*~(A)+~B*E*~(A)+~(~B)*E*A+~B*E*A)*C*D)"),
    .INIT(32'h0f440fee))
    _al_u1898 (
    .a(_al_u1808_o),
    .b(_al_u1897_o),
    .c(\norm/sglc_f [23]),
    .d(\norm/sglc_f [29]),
    .e(\norm/sglc_f [6]),
    .o(_al_u1898_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u1899 (
    .a(_al_u1898_o),
    .b(\norm/sglc_f [24]),
    .c(\norm/sglc_f [30]),
    .o(\norm/n46 [22]));
  AL_MAP_LUT5 #(
    .EQN("(C*~((A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E))*~(B)+C*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*~(B)+~(C)*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*B+C*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*B)"),
    .INIT(32'hfc30b8b8))
    _al_u1900 (
    .a(\norm/n46 [22]),
    .b(fctl_norm_enb_lutinv),
    .c(\norm/sglc_f [22]),
    .d(\norm/sglc_f [25]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n50 [22]));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'h5c))
    _al_u1901 (
    .a(_al_u1892_o),
    .b(\norm/n50 [22]),
    .c(fctl_load_c),
    .o(\norm/n53 [22]));
  AL_MAP_LUT4 #(
    .EQN("~(~B*~((D*C))*~(A)+~B*(D*C)*~(A)+~(~B)*(D*C)*A+~B*(D*C)*A)"),
    .INIT(16'h4eee))
    _al_u1902 (
    .a(_al_u1720_o),
    .b(_al_u1205_o),
    .c(\sgla/n197_lutinv ),
    .d(\sgla/n152_neg_lutinv ),
    .o(_al_u1902_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+A*B*C*~(D)+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'ha0bb))
    _al_u1903 (
    .a(_al_u1902_o),
    .b(_al_u1031_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(sgla_r[21]),
    .o(_al_u1903_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u1904 (
    .a(_al_u1903_o),
    .b(_al_u1042_o),
    .c(\sgla/sgla_i [21]),
    .o(_al_u1904_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u1905 (
    .a(\fdiv/fquo [11]),
    .b(\fdiv/fquo [12]),
    .c(\fdiv/fquo [19]),
    .o(sglc_r_fdiv[21]));
  AL_MAP_LUT4 #(
    .EQN("~((D*~A)*~(B)*~(C)+(D*~A)*B*~(C)+~((D*~A))*B*C+(D*~A)*B*C)"),
    .INIT(16'h3a3f))
    _al_u1906 (
    .a(_al_u1904_o),
    .b(sglc_r_fdiv[21]),
    .c(fctl_ccmd_div),
    .d(fctl_ccmd_reg),
    .o(_al_u1906_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'hd8d800ff))
    _al_u1907 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[40]),
    .c(sfpu_dsp_c[39]),
    .d(_al_u1906_o),
    .e(fctl_ccmd_mul),
    .o(\norm/n2 [21]));
  AL_MAP_LUT5 #(
    .EQN("~(A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'h303f5555))
    _al_u1908 (
    .a(\norm/n2 [21]),
    .b(\fadd/n4 [21]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [21]),
    .e(fctl_ccmd_add),
    .o(_al_u1908_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'hf5a0dd88))
    _al_u1909 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [19]),
    .c(\norm/sglc_f [20]),
    .d(\norm/sglc_f [21]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n28 [21]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'h01ab45ef))
    _al_u1910 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(\norm/n28 [21]),
    .d(\norm/sglc_f [15]),
    .e(\norm/sglc_f [17]),
    .o(_al_u1910_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u1911 (
    .a(_al_u1003_o),
    .b(_al_u1910_o),
    .c(\norm/sglc_f [13]),
    .o(\norm/n34 [21]));
  AL_MAP_LUT5 #(
    .EQN("((B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*~(E)*~(A)+(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*E*~(A)+~((B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))*E*A+(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*E*A)"),
    .INIT(32'hfeae5404))
    _al_u1912 (
    .a(_al_u1005_o),
    .b(\norm/n34 [21]),
    .c(_al_u1004_o),
    .d(\norm/sglc_f [11]),
    .e(\norm/sglc_f [9]),
    .o(\norm/n38 [21]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'hfe54ba10))
    _al_u1913 (
    .a(_al_u1808_o),
    .b(_al_u1807_o),
    .c(\norm/n38 [21]),
    .d(\norm/sglc_f [5]),
    .e(\norm/sglc_f [7]),
    .o(\norm/n42 [21]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u1914 (
    .a(\norm/n42 [21]),
    .b(\norm/sglc_f [22]),
    .c(\norm/sglc_f [23]),
    .d(\norm/sglc_f [29]),
    .e(\norm/sglc_f [30]),
    .o(\norm/n46 [21]));
  AL_MAP_LUT5 #(
    .EQN("(C*~((A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E))*~(B)+C*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*~(B)+~(C)*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*B+C*(A*~(D)*~(E)+A*D*~(E)+~(A)*D*E+A*D*E)*B)"),
    .INIT(32'hfc30b8b8))
    _al_u1915 (
    .a(\norm/n46 [21]),
    .b(fctl_norm_enb_lutinv),
    .c(\norm/sglc_f [21]),
    .d(\norm/sglc_f [24]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n50 [21]));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'h5c))
    _al_u1916 (
    .a(_al_u1908_o),
    .b(\norm/n50 [21]),
    .c(fctl_load_c),
    .o(\norm/n53 [21]));
  AL_MAP_LUT5 #(
    .EQN("(~D*~B*~(E*~(C*~A)))"),
    .INIT(32'h00100033))
    _al_u1917 (
    .a(_al_u1721_o),
    .b(_al_u1031_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(_al_u1042_o),
    .e(sgla_r[20]),
    .o(_al_u1917_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))"),
    .INIT(16'ha088))
    _al_u1918 (
    .a(fctl_ccmd_div),
    .b(\fdiv/fquo [10]),
    .c(\fdiv/fquo [11]),
    .d(\fdiv/fquo [19]),
    .o(_al_u1918_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(D*~A*~(~E*B)))"),
    .INIT(32'h0a0f0e0f))
    _al_u1919 (
    .a(_al_u1917_o),
    .b(_al_u1042_o),
    .c(_al_u1918_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(\sgla/sgla_i [20]),
    .o(_al_u1919_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u1920 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[39]),
    .c(sfpu_dsp_c[38]),
    .d(_al_u1919_o),
    .e(fctl_ccmd_mul),
    .o(_al_u1920_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'h303faaaa))
    _al_u1921 (
    .a(_al_u1920_o),
    .b(\fadd/n4 [20]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [20]),
    .e(fctl_ccmd_add),
    .o(_al_u1921_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'hf5a0dd88))
    _al_u1922 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [18]),
    .c(\norm/sglc_f [19]),
    .d(\norm/sglc_f [20]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n28 [20]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'h01ab45ef))
    _al_u1923 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(\norm/n28 [20]),
    .d(\norm/sglc_f [14]),
    .e(\norm/sglc_f [16]),
    .o(_al_u1923_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u1924 (
    .a(_al_u1004_o),
    .b(_al_u1003_o),
    .c(_al_u1923_o),
    .d(\norm/sglc_f [10]),
    .e(\norm/sglc_f [12]),
    .o(_al_u1924_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u1925 (
    .a(_al_u1807_o),
    .b(_al_u1005_o),
    .c(_al_u1924_o),
    .d(\norm/sglc_f [6]),
    .e(\norm/sglc_f [8]),
    .o(_al_u1925_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~(E)*~(A)+~B*E*~(A)+~(~B)*E*A+~B*E*A)*~(C)*~(D)+(~B*~(E)*~(A)+~B*E*~(A)+~(~B)*E*A+~B*E*A)*C*~(D)+~((~B*~(E)*~(A)+~B*E*~(A)+~(~B)*E*A+~B*E*A))*C*D+(~B*~(E)*~(A)+~B*E*~(A)+~(~B)*E*A+~B*E*A)*C*D)"),
    .INIT(32'h0f440fee))
    _al_u1926 (
    .a(_al_u1808_o),
    .b(_al_u1925_o),
    .c(\norm/sglc_f [21]),
    .d(\norm/sglc_f [29]),
    .e(\norm/sglc_f [4]),
    .o(_al_u1926_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'h0f0f33aa))
    _al_u1927 (
    .a(_al_u1926_o),
    .b(\norm/sglc_f [22]),
    .c(\norm/sglc_f [23]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(_al_u1927_o));
  AL_MAP_LUT5 #(
    .EQN("~((~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*~(A)*~(C)+(~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*A*~(C)+~((~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D))*A*C+(~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*A*C)"),
    .INIT(32'h535f5350))
    _al_u1928 (
    .a(_al_u1921_o),
    .b(_al_u1927_o),
    .c(fctl_load_c),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [20]),
    .o(\norm/n53 [20]));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~(E*C)*~(D*A)))"),
    .INIT(32'hc8c08800))
    _al_u1929 (
    .a(_al_u1770_o),
    .b(\norm/mux2_b0_sel_is_2_o ),
    .c(_al_u1042_o),
    .d(sgla_r[2]),
    .e(\sgla/sgla_i [2]),
    .o(\norm/n2 [2]));
  AL_MAP_LUT5 #(
    .EQN("(A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'hcfc0aaaa))
    _al_u1930 (
    .a(\norm/n2 [2]),
    .b(\fadd/n4 [2]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [2]),
    .e(fctl_ccmd_add),
    .o(\norm/sglc_r [2]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'hf5a0dd88))
    _al_u1931 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [0]),
    .c(\norm/sglc_f [1]),
    .d(\norm/sglc_f [2]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n28 [2]));
  AL_MAP_LUT4 #(
    .EQN("~((B*~A)*~(D)*~(C)+(B*~A)*D*~(C)+~((B*~A))*D*C+(B*~A)*D*C)"),
    .INIT(16'h0bfb))
    _al_u1932 (
    .a(_al_u1001_o),
    .b(\norm/n28 [2]),
    .c(\norm/sglc_f [29]),
    .d(\norm/sglc_f [3]),
    .o(_al_u1932_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*~(E)*~(C)+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*~(C)+~((~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))*E*C+(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B)*E*C)"),
    .INIT(32'hfdf10d01))
    _al_u1933 (
    .a(_al_u1932_o),
    .b(\norm/sglc_f [30]),
    .c(\norm/sglc_f [31]),
    .d(\norm/sglc_f [4]),
    .e(\norm/sglc_f [5]),
    .o(\norm/n48 [2]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(B)*~(A)+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*B*~(A)+~((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*B*A+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*B*A)"),
    .INIT(32'hd8ddd888))
    _al_u1934 (
    .a(fctl_load_c),
    .b(\norm/sglc_r [2]),
    .c(\norm/n48 [2]),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [2]),
    .o(\norm/n53 [2]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u1935 (
    .a(_al_u1705_o),
    .b(\sgla/u152_sel_is_0_o ),
    .c(\sgla/n190 [3]),
    .o(_al_u1935_o));
  AL_MAP_LUT4 #(
    .EQN("(A*~(B*~(D*C)))"),
    .INIT(16'ha222))
    _al_u1936 (
    .a(_al_u1935_o),
    .b(\sgla/u152_sel_is_0_o ),
    .c(\sgla/n190 [2]),
    .d(\sgla/n190 [1]),
    .o(_al_u1936_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(~C*~A))"),
    .INIT(8'h32))
    _al_u1937 (
    .a(_al_u1031_o),
    .b(_al_u1205_o),
    .c(sgla_r[19]),
    .o(_al_u1937_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*B)*~(C*~A))"),
    .INIT(16'h23af))
    _al_u1938 (
    .a(\sgla/mux44_b0_sel_is_0_o ),
    .b(_al_u1042_o),
    .c(sgla_r[19]),
    .d(\sgla/sgla_i [19]),
    .o(_al_u1938_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~(B*~(A*~(~E*C))))"),
    .INIT(32'hbb003b00))
    _al_u1939 (
    .a(_al_u1936_o),
    .b(_al_u1937_o),
    .c(\sgla/u152_sel_is_0_o ),
    .d(_al_u1938_o),
    .e(\sgla/n190 [0]),
    .o(_al_u1939_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*~B)*~(C*~A))"),
    .INIT(16'h8caf))
    _al_u1940 (
    .a(_al_u1939_o),
    .b(_al_u1330_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(fctl_ccmd_div),
    .o(_al_u1940_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u1941 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[38]),
    .c(sfpu_dsp_c[37]),
    .d(_al_u1940_o),
    .e(fctl_ccmd_mul),
    .o(_al_u1941_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'h303faaaa))
    _al_u1942 (
    .a(_al_u1941_o),
    .b(\fadd/n4 [19]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [19]),
    .e(fctl_ccmd_add),
    .o(_al_u1942_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'hf5a0dd88))
    _al_u1943 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [17]),
    .c(\norm/sglc_f [18]),
    .d(\norm/sglc_f [19]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n28 [19]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'h01ab45ef))
    _al_u1944 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(\norm/n28 [19]),
    .d(\norm/sglc_f [13]),
    .e(\norm/sglc_f [15]),
    .o(_al_u1944_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B)*~(E)*~(A)+(~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B)*E*~(A)+~((~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B))*E*A+(~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B)*E*A)"),
    .INIT(32'h1054bafe))
    _al_u1945 (
    .a(_al_u1004_o),
    .b(_al_u1003_o),
    .c(_al_u1944_o),
    .d(\norm/sglc_f [11]),
    .e(\norm/sglc_f [9]),
    .o(_al_u1945_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u1946 (
    .a(_al_u1807_o),
    .b(_al_u1005_o),
    .c(_al_u1945_o),
    .d(\norm/sglc_f [5]),
    .e(\norm/sglc_f [7]),
    .o(_al_u1946_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~(E)*~(A)+~B*E*~(A)+~(~B)*E*A+~B*E*A)*~(C)*~(D)+(~B*~(E)*~(A)+~B*E*~(A)+~(~B)*E*A+~B*E*A)*C*~(D)+~((~B*~(E)*~(A)+~B*E*~(A)+~(~B)*E*A+~B*E*A))*C*D+(~B*~(E)*~(A)+~B*E*~(A)+~(~B)*E*A+~B*E*A)*C*D)"),
    .INIT(32'h0f440fee))
    _al_u1947 (
    .a(_al_u1808_o),
    .b(_al_u1946_o),
    .c(\norm/sglc_f [20]),
    .d(\norm/sglc_f [29]),
    .e(\norm/sglc_f [3]),
    .o(_al_u1947_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'h0f0f33aa))
    _al_u1948 (
    .a(_al_u1947_o),
    .b(\norm/sglc_f [21]),
    .c(\norm/sglc_f [22]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(_al_u1948_o));
  AL_MAP_LUT5 #(
    .EQN("~((~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*~(A)*~(C)+(~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*A*~(C)+~((~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D))*A*C+(~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*A*C)"),
    .INIT(32'h535f5350))
    _al_u1949 (
    .a(_al_u1942_o),
    .b(_al_u1948_o),
    .c(fctl_load_c),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [19]),
    .o(\norm/n53 [19]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~((~C*~A))*~(D)*~(E)+B*~((~C*~A))*~(D)*~(E)+~(B)*(~C*~A)*~(D)*~(E)+~(B)*~((~C*~A))*D*~(E)+B*~((~C*~A))*D*~(E)+~(B)*(~C*~A)*D*~(E)+~(B)*~((~C*~A))*D*E+B*~((~C*~A))*D*E)"),
    .INIT(32'hfa00fbfb))
    _al_u1950 (
    .a(_al_u1936_o),
    .b(_al_u1031_o),
    .c(_al_u1205_o),
    .d(\sgla/mux44_b0_sel_is_0_o ),
    .e(sgla_r[18]),
    .o(_al_u1950_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u1951 (
    .a(_al_u1950_o),
    .b(_al_u1042_o),
    .c(\sgla/sgla_i [18]),
    .o(_al_u1951_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*~A)*~(B)*~(C)+~(D*~A)*B*~(C)+~(~(D*~A))*B*C+~(D*~A)*B*C)"),
    .INIT(16'hcacf))
    _al_u1952 (
    .a(_al_u1951_o),
    .b(_al_u1325_o),
    .c(fctl_ccmd_div),
    .d(fctl_ccmd_reg),
    .o(_al_u1952_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u1953 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[37]),
    .c(sfpu_dsp_c[36]),
    .d(_al_u1952_o),
    .e(fctl_ccmd_mul),
    .o(_al_u1953_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'h303faaaa))
    _al_u1954 (
    .a(_al_u1953_o),
    .b(\fadd/n4 [18]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [18]),
    .e(fctl_ccmd_add),
    .o(_al_u1954_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'hf5a0dd88))
    _al_u1955 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [16]),
    .c(\norm/sglc_f [17]),
    .d(\norm/sglc_f [18]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n28 [18]));
  AL_MAP_LUT5 #(
    .EQN("~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'h01ab45ef))
    _al_u1956 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(\norm/n28 [18]),
    .d(\norm/sglc_f [12]),
    .e(\norm/sglc_f [14]),
    .o(_al_u1956_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B)*~(E)*~(A)+(~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B)*E*~(A)+~((~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B))*E*A+(~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B)*E*A)"),
    .INIT(32'h1054bafe))
    _al_u1957 (
    .a(_al_u1004_o),
    .b(_al_u1003_o),
    .c(_al_u1956_o),
    .d(\norm/sglc_f [10]),
    .e(\norm/sglc_f [8]),
    .o(_al_u1957_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u1958 (
    .a(_al_u1807_o),
    .b(_al_u1005_o),
    .c(_al_u1957_o),
    .d(\norm/sglc_f [4]),
    .e(\norm/sglc_f [6]),
    .o(_al_u1958_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*~(C)*~(E)+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*~(E)+~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A))*C*E+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*E)"),
    .INIT(32'h0f0f44ee))
    _al_u1959 (
    .a(_al_u1808_o),
    .b(_al_u1958_o),
    .c(\norm/sglc_f [19]),
    .d(\norm/sglc_f [2]),
    .e(\norm/sglc_f [29]),
    .o(_al_u1959_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'h0f0f33aa))
    _al_u1960 (
    .a(_al_u1959_o),
    .b(\norm/sglc_f [20]),
    .c(\norm/sglc_f [21]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(_al_u1960_o));
  AL_MAP_LUT5 #(
    .EQN("~((~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*~(A)*~(C)+(~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*A*~(C)+~((~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D))*A*C+(~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*A*C)"),
    .INIT(32'h535f5350))
    _al_u1961 (
    .a(_al_u1954_o),
    .b(_al_u1960_o),
    .c(fctl_load_c),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [18]),
    .o(\norm/n53 [18]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(A*~(~D*B)))"),
    .INIT(16'h050d))
    _al_u1962 (
    .a(_al_u1935_o),
    .b(\sgla/u152_sel_is_0_o ),
    .c(_al_u1205_o),
    .d(_al_u1708_o),
    .o(_al_u1962_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+~(A)*~(B)*C*D+~(A)*B*C*D)"),
    .INIT(16'h5077))
    _al_u1963 (
    .a(_al_u1962_o),
    .b(_al_u1031_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(sgla_r[17]),
    .o(_al_u1963_o));
  AL_MAP_LUT4 #(
    .EQN("(C*(~A*~(D)*~(B)+~A*D*~(B)+~(~A)*D*B+~A*D*B))"),
    .INIT(16'hd010))
    _al_u1964 (
    .a(_al_u1963_o),
    .b(_al_u1042_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(\sgla/sgla_i [17]),
    .o(_al_u1964_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*~B))"),
    .INIT(8'h45))
    _al_u1965 (
    .a(_al_u1964_o),
    .b(_al_u1329_o),
    .c(fctl_ccmd_div),
    .o(_al_u1965_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u1966 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[36]),
    .c(sfpu_dsp_c[35]),
    .d(_al_u1965_o),
    .e(fctl_ccmd_mul),
    .o(_al_u1966_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'h303faaaa))
    _al_u1967 (
    .a(_al_u1966_o),
    .b(\fadd/n4 [17]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [17]),
    .e(fctl_ccmd_add),
    .o(_al_u1967_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'h0a5f2277))
    _al_u1968 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [15]),
    .c(\norm/sglc_f [16]),
    .d(\norm/sglc_f [17]),
    .e(\norm/sglc_f [27]),
    .o(_al_u1968_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u1969 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(_al_u1968_o),
    .d(\norm/sglc_f [11]),
    .e(\norm/sglc_f [13]),
    .o(_al_u1969_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u1970 (
    .a(_al_u1003_o),
    .b(_al_u1969_o),
    .c(\norm/sglc_f [9]),
    .o(\norm/n34 [17]));
  AL_MAP_LUT5 #(
    .EQN("((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'hfe54ae04))
    _al_u1971 (
    .a(_al_u1005_o),
    .b(\norm/n34 [17]),
    .c(_al_u1004_o),
    .d(\norm/sglc_f [5]),
    .e(\norm/sglc_f [7]),
    .o(\norm/n38 [17]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'hfe54ba10))
    _al_u1972 (
    .a(_al_u1808_o),
    .b(_al_u1807_o),
    .c(\norm/n38 [17]),
    .d(\norm/sglc_f [1]),
    .e(\norm/sglc_f [3]),
    .o(\norm/n42 [17]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u1973 (
    .a(\norm/n42 [17]),
    .b(\norm/sglc_f [18]),
    .c(\norm/sglc_f [29]),
    .o(_al_u1973_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'h0f0f33aa))
    _al_u1974 (
    .a(_al_u1973_o),
    .b(\norm/sglc_f [19]),
    .c(\norm/sglc_f [20]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(_al_u1974_o));
  AL_MAP_LUT5 #(
    .EQN("~((~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*~(A)*~(C)+(~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*A*~(C)+~((~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D))*A*C+(~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*A*C)"),
    .INIT(32'h535f5350))
    _al_u1975 (
    .a(_al_u1967_o),
    .b(_al_u1974_o),
    .c(fctl_load_c),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [17]),
    .o(\norm/n53 [17]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(A*~(~D*B)))"),
    .INIT(16'h050d))
    _al_u1976 (
    .a(_al_u1935_o),
    .b(\sgla/u152_sel_is_0_o ),
    .c(_al_u1205_o),
    .d(\sgla/n190 [2]),
    .o(_al_u1976_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+~(A)*~(B)*C*D+~(A)*B*C*D)"),
    .INIT(16'h5077))
    _al_u1977 (
    .a(_al_u1976_o),
    .b(_al_u1031_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(sgla_r[16]),
    .o(_al_u1977_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'ha820))
    _al_u1978 (
    .a(fctl_ccmd_div),
    .b(\fdiv/fquo [19]),
    .c(\fdiv/fquo [6]),
    .d(\fdiv/fquo [7]),
    .o(_al_u1978_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(D*(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)))"),
    .INIT(32'h020f0e0f))
    _al_u1979 (
    .a(_al_u1977_o),
    .b(_al_u1042_o),
    .c(_al_u1978_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(\sgla/sgla_i [16]),
    .o(_al_u1979_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u1980 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[35]),
    .c(sfpu_dsp_c[34]),
    .d(_al_u1979_o),
    .e(fctl_ccmd_mul),
    .o(_al_u1980_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'hcfc05555))
    _al_u1981 (
    .a(_al_u1980_o),
    .b(\fadd/n4 [16]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [16]),
    .e(fctl_ccmd_add),
    .o(_al_u1981_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'h0a5f2277))
    _al_u1982 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [14]),
    .c(\norm/sglc_f [15]),
    .d(\norm/sglc_f [16]),
    .e(\norm/sglc_f [27]),
    .o(_al_u1982_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u1983 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(_al_u1982_o),
    .d(\norm/sglc_f [10]),
    .e(\norm/sglc_f [12]),
    .o(_al_u1983_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u1984 (
    .a(_al_u1003_o),
    .b(_al_u1983_o),
    .c(\norm/sglc_f [8]),
    .o(\norm/n34 [16]));
  AL_MAP_LUT5 #(
    .EQN("((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'hfe54ae04))
    _al_u1985 (
    .a(_al_u1005_o),
    .b(\norm/n34 [16]),
    .c(_al_u1004_o),
    .d(\norm/sglc_f [4]),
    .e(\norm/sglc_f [6]),
    .o(\norm/n38 [16]));
  AL_MAP_LUT5 #(
    .EQN("((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*~(D)*~(A)+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*~(A)+~((C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B))*D*A+(C*~(E)*~(B)+C*E*~(B)+~(C)*E*B+C*E*B)*D*A)"),
    .INIT(32'hfe54ba10))
    _al_u1986 (
    .a(_al_u1808_o),
    .b(_al_u1807_o),
    .c(\norm/n38 [16]),
    .d(\norm/sglc_f [0]),
    .e(\norm/sglc_f [2]),
    .o(\norm/n42 [16]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u1987 (
    .a(\norm/n42 [16]),
    .b(\norm/sglc_f [17]),
    .c(\norm/sglc_f [29]),
    .o(_al_u1987_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'h0f0f33aa))
    _al_u1988 (
    .a(_al_u1987_o),
    .b(\norm/sglc_f [18]),
    .c(\norm/sglc_f [19]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(_al_u1988_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*~(A)*~(C)+~(~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*A*~(C)+~(~(~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D))*A*C+~(~E*~(B)*~(D)+~E*B*~(D)+~(~E)*B*D+~E*B*D)*A*C)"),
    .INIT(32'ha3afa3a0))
    _al_u1989 (
    .a(_al_u1981_o),
    .b(_al_u1988_o),
    .c(fctl_load_c),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [16]),
    .o(\norm/n53 [16]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(A*~(~D*B)))"),
    .INIT(16'h050d))
    _al_u1990 (
    .a(_al_u1705_o),
    .b(_al_u1780_o),
    .c(_al_u1205_o),
    .d(\sgla/n190 [4]),
    .o(_al_u1990_o));
  AL_MAP_LUT4 #(
    .EQN("(A*B*~(C)*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*B*~(C)*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'haf88))
    _al_u1991 (
    .a(_al_u1990_o),
    .b(_al_u1031_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(sgla_r[15]),
    .o(_al_u1991_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*B))"),
    .INIT(8'h15))
    _al_u1992 (
    .a(_al_u1991_o),
    .b(_al_u1042_o),
    .c(\sgla/sgla_i [15]),
    .o(_al_u1992_o));
  AL_MAP_LUT4 #(
    .EQN("(~(D*~B)*~(C*~A))"),
    .INIT(16'h8caf))
    _al_u1993 (
    .a(_al_u1992_o),
    .b(_al_u1333_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(fctl_ccmd_div),
    .o(_al_u1993_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u1994 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[34]),
    .c(sfpu_dsp_c[33]),
    .d(_al_u1993_o),
    .e(fctl_ccmd_mul),
    .o(_al_u1994_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'hcfc05555))
    _al_u1995 (
    .a(_al_u1994_o),
    .b(\fadd/n4 [15]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [15]),
    .e(fctl_ccmd_add),
    .o(_al_u1995_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'h0a5f2277))
    _al_u1996 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [13]),
    .c(\norm/sglc_f [14]),
    .d(\norm/sglc_f [15]),
    .e(\norm/sglc_f [27]),
    .o(_al_u1996_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B)*~(E)*~(A)+(~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B)*E*~(A)+~((~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B))*E*A+(~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B)*E*A)"),
    .INIT(32'h1054bafe))
    _al_u1997 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(_al_u1996_o),
    .d(\norm/sglc_f [11]),
    .e(\norm/sglc_f [9]),
    .o(_al_u1997_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u1998 (
    .a(_al_u1004_o),
    .b(_al_u1003_o),
    .c(_al_u1997_o),
    .d(\norm/sglc_f [5]),
    .e(\norm/sglc_f [7]),
    .o(_al_u1998_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u1999 (
    .a(_al_u1807_o),
    .b(_al_u1005_o),
    .c(_al_u1998_o),
    .d(\norm/sglc_f [1]),
    .e(\norm/sglc_f [3]),
    .o(_al_u1999_o));
  AL_MAP_LUT4 #(
    .EQN("~((~B*~A)*~(C)*~(D)+(~B*~A)*C*~(D)+~((~B*~A))*C*D+(~B*~A)*C*D)"),
    .INIT(16'h0fee))
    _al_u2000 (
    .a(_al_u1808_o),
    .b(_al_u1999_o),
    .c(\norm/sglc_f [16]),
    .d(\norm/sglc_f [29]),
    .o(_al_u2000_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'hf0f0cc55))
    _al_u2001 (
    .a(_al_u2000_o),
    .b(\norm/sglc_f [17]),
    .c(\norm/sglc_f [18]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n48 [15]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*~(A)*~(C)+(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*A*~(C)+~((E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D))*A*C+(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*A*C)"),
    .INIT(32'hacafaca0))
    _al_u2002 (
    .a(_al_u1995_o),
    .b(\norm/n48 [15]),
    .c(fctl_load_c),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [15]),
    .o(\norm/n53 [15]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(A*~(~D*B)))"),
    .INIT(16'h050d))
    _al_u2003 (
    .a(_al_u1705_o),
    .b(_al_u1785_o),
    .c(_al_u1205_o),
    .d(\sgla/n190 [4]),
    .o(_al_u2003_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+~(A)*~(B)*C*D+~(A)*B*C*D)"),
    .INIT(16'h5077))
    _al_u2004 (
    .a(_al_u2003_o),
    .b(_al_u1031_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(sgla_r[14]),
    .o(_al_u2004_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'ha820))
    _al_u2005 (
    .a(fctl_ccmd_div),
    .b(\fdiv/fquo [19]),
    .c(\fdiv/fquo [4]),
    .d(\fdiv/fquo [5]),
    .o(_al_u2005_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(D*(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)))"),
    .INIT(32'h020f0e0f))
    _al_u2006 (
    .a(_al_u2004_o),
    .b(_al_u1042_o),
    .c(_al_u2005_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(\sgla/sgla_i [14]),
    .o(_al_u2006_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u2007 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[33]),
    .c(sfpu_dsp_c[32]),
    .d(_al_u2006_o),
    .e(fctl_ccmd_mul),
    .o(_al_u2007_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'h303faaaa))
    _al_u2008 (
    .a(_al_u2007_o),
    .b(\fadd/n4 [14]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [14]),
    .e(fctl_ccmd_add),
    .o(_al_u2008_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'h0a5f2277))
    _al_u2009 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [12]),
    .c(\norm/sglc_f [13]),
    .d(\norm/sglc_f [14]),
    .e(\norm/sglc_f [27]),
    .o(_al_u2009_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B)*~(E)*~(A)+(~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B)*E*~(A)+~((~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B))*E*A+(~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B)*E*A)"),
    .INIT(32'h1054bafe))
    _al_u2010 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(_al_u2009_o),
    .d(\norm/sglc_f [10]),
    .e(\norm/sglc_f [8]),
    .o(_al_u2010_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2011 (
    .a(_al_u1004_o),
    .b(_al_u1003_o),
    .c(_al_u2010_o),
    .d(\norm/sglc_f [4]),
    .e(\norm/sglc_f [6]),
    .o(_al_u2011_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u2012 (
    .a(_al_u1005_o),
    .b(_al_u2011_o),
    .c(\norm/sglc_f [2]),
    .o(\norm/n38 [14]));
  AL_MAP_LUT4 #(
    .EQN("(~A*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))"),
    .INIT(16'h5404))
    _al_u2013 (
    .a(_al_u1808_o),
    .b(\norm/n38 [14]),
    .c(_al_u1807_o),
    .d(\norm/sglc_f [0]),
    .o(\norm/n42 [14]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    _al_u2014 (
    .a(\norm/n42 [14]),
    .b(\norm/sglc_f [15]),
    .c(\norm/sglc_f [29]),
    .o(\norm/n44 [14]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u2015 (
    .a(\norm/n44 [14]),
    .b(\norm/sglc_f [16]),
    .c(\norm/sglc_f [17]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n48 [14]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*~(A)*~(C)+~(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*A*~(C)+~(~(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D))*A*C+~(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*A*C)"),
    .INIT(32'h5c5f5c50))
    _al_u2016 (
    .a(_al_u2008_o),
    .b(\norm/n48 [14]),
    .c(fctl_load_c),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [14]),
    .o(\norm/n53 [14]));
  AL_MAP_LUT5 #(
    .EQN("(~(~(~D*C)*B)*~(~E*~A))"),
    .INIT(32'h33f322a2))
    _al_u2017 (
    .a(_al_u1031_o),
    .b(_al_u1705_o),
    .c(_al_u1796_o),
    .d(\sgla/n190 [4]),
    .e(sgla_r[13]),
    .o(_al_u2017_o));
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+A*~(B)*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hfb2b))
    _al_u2018 (
    .a(_al_u2017_o),
    .b(_al_u1205_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(_al_u1042_o),
    .o(_al_u2018_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'ha820))
    _al_u2019 (
    .a(fctl_ccmd_div),
    .b(\fdiv/fquo [19]),
    .c(\fdiv/fquo [3]),
    .d(\fdiv/fquo [4]),
    .o(_al_u2019_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(D*A*~(~E*B)))"),
    .INIT(32'h050f0d0f))
    _al_u2020 (
    .a(_al_u2018_o),
    .b(_al_u1042_o),
    .c(_al_u2019_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(\sgla/sgla_i [13]),
    .o(_al_u2020_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u2021 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[32]),
    .c(sfpu_dsp_c[31]),
    .d(_al_u2020_o),
    .e(fctl_ccmd_mul),
    .o(_al_u2021_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'h303faaaa))
    _al_u2022 (
    .a(_al_u2021_o),
    .b(\fadd/n4 [13]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [13]),
    .e(fctl_ccmd_add),
    .o(_al_u2022_o));
  AL_MAP_LUT5 #(
    .EQN("~(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'h0a5f2277))
    _al_u2023 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [11]),
    .c(\norm/sglc_f [12]),
    .d(\norm/sglc_f [13]),
    .e(\norm/sglc_f [27]),
    .o(_al_u2023_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2024 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(_al_u2023_o),
    .d(\norm/sglc_f [7]),
    .e(\norm/sglc_f [9]),
    .o(_al_u2024_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u2025 (
    .a(_al_u1003_o),
    .b(_al_u2024_o),
    .c(\norm/sglc_f [5]),
    .o(\norm/n34 [13]));
  AL_MAP_LUT5 #(
    .EQN("((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'hfe54ae04))
    _al_u2026 (
    .a(_al_u1005_o),
    .b(\norm/n34 [13]),
    .c(_al_u1004_o),
    .d(\norm/sglc_f [1]),
    .e(\norm/sglc_f [3]),
    .o(\norm/n38 [13]));
  AL_MAP_LUT4 #(
    .EQN("~((B*~A)*~(C)*~(D)+(B*~A)*C*~(D)+~((B*~A))*C*D+(B*~A)*C*D)"),
    .INIT(16'h0fbb))
    _al_u2027 (
    .a(_al_u1807_o),
    .b(\norm/n38 [13]),
    .c(\norm/sglc_f [14]),
    .d(\norm/sglc_f [29]),
    .o(_al_u2027_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'hf0f0cc55))
    _al_u2028 (
    .a(_al_u2027_o),
    .b(\norm/sglc_f [15]),
    .c(\norm/sglc_f [16]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n48 [13]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(A)*~(B)+~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*~(B)+~(~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*A*B+~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*B)"),
    .INIT(32'h74777444))
    _al_u2029 (
    .a(_al_u2022_o),
    .b(fctl_load_c),
    .c(\norm/n48 [13]),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [13]),
    .o(\norm/n53 [13]));
  AL_MAP_LUT5 #(
    .EQN("(~(B)*~((~C*~A))*~(D)*~(E)+B*~((~C*~A))*~(D)*~(E)+~(B)*(~C*~A)*~(D)*~(E)+~(B)*~((~C*~A))*D*~(E)+B*~((~C*~A))*D*~(E)+~(B)*(~C*~A)*D*~(E)+~(B)*~((~C*~A))*D*E+B*~((~C*~A))*D*E)"),
    .INIT(32'hfa00fbfb))
    _al_u2030 (
    .a(_al_u1935_o),
    .b(_al_u1031_o),
    .c(_al_u1205_o),
    .d(\sgla/mux44_b0_sel_is_0_o ),
    .e(sgla_r[12]),
    .o(_al_u2030_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'ha820))
    _al_u2031 (
    .a(fctl_ccmd_div),
    .b(\fdiv/fquo [19]),
    .c(\fdiv/fquo [2]),
    .d(\fdiv/fquo [3]),
    .o(_al_u2031_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(D*(~A*~(E)*~(B)+~A*E*~(B)+~(~A)*E*B+~A*E*B)))"),
    .INIT(32'h020f0e0f))
    _al_u2032 (
    .a(_al_u2030_o),
    .b(_al_u1042_o),
    .c(_al_u2031_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(\sgla/sgla_i [12]),
    .o(_al_u2032_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u2033 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[31]),
    .c(sfpu_dsp_c[30]),
    .d(_al_u2032_o),
    .e(fctl_ccmd_mul),
    .o(_al_u2033_o));
  AL_MAP_LUT5 #(
    .EQN("(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'hcfc05555))
    _al_u2034 (
    .a(_al_u2033_o),
    .b(\fadd/n4 [12]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [12]),
    .e(fctl_ccmd_add),
    .o(\norm/sglc_r [12]));
  AL_MAP_LUT5 #(
    .EQN("~(D*~((B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E))*~(A)+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*~(A)+~(D)*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A+D*(B*~(C)*~(E)+B*C*~(E)+~(B)*C*E+B*C*E)*A)"),
    .INIT(32'h0a5f2277))
    _al_u2035 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [10]),
    .c(\norm/sglc_f [11]),
    .d(\norm/sglc_f [12]),
    .e(\norm/sglc_f [27]),
    .o(_al_u2035_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2036 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(_al_u2035_o),
    .d(\norm/sglc_f [6]),
    .e(\norm/sglc_f [8]),
    .o(_al_u2036_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2037 (
    .a(_al_u1004_o),
    .b(_al_u1003_o),
    .c(_al_u2036_o),
    .d(\norm/sglc_f [2]),
    .e(\norm/sglc_f [4]),
    .o(_al_u2037_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*(~C*~(D)*~(B)+~C*D*~(B)+~(~C)*D*B+~C*D*B))"),
    .INIT(16'h4501))
    _al_u2038 (
    .a(_al_u1807_o),
    .b(_al_u1005_o),
    .c(_al_u2037_o),
    .d(\norm/sglc_f [0]),
    .o(\norm/n42 [12]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'h0f0f3355))
    _al_u2039 (
    .a(\norm/n42 [12]),
    .b(\norm/sglc_f [13]),
    .c(\norm/sglc_f [14]),
    .d(\norm/sglc_f [29]),
    .e(\norm/sglc_f [30]),
    .o(_al_u2039_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~((~A*~(D)*~(E)+~A*D*~(E)+~(~A)*D*E+~A*D*E))*~(B)+C*(~A*~(D)*~(E)+~A*D*~(E)+~(~A)*D*E+~A*D*E)*~(B)+~(C)*(~A*~(D)*~(E)+~A*D*~(E)+~(~A)*D*E+~A*D*E)*B+C*(~A*~(D)*~(E)+~A*D*~(E)+~(~A)*D*E+~A*D*E)*B)"),
    .INIT(32'hfc307474))
    _al_u2040 (
    .a(_al_u2039_o),
    .b(fctl_norm_enb_lutinv),
    .c(\norm/sglc_f [12]),
    .d(\norm/sglc_f [15]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n50 [12]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    _al_u2041 (
    .a(\norm/sglc_r [12]),
    .b(fctl_load_c),
    .c(\norm/n50 [12]),
    .o(\norm/n53 [12]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u2042 (
    .a(_al_u1721_o),
    .b(_al_u1705_o),
    .c(_al_u1816_o),
    .o(_al_u2042_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*(~(A)*~(B)*~(C)*~(E)+A*~(B)*~(C)*~(E)+~(A)*B*~(C)*~(E)+~(A)*~(B)*C*~(E)+A*~(B)*C*~(E)+~(A)*B*C*~(E)+~(A)*~(B)*C*E+~(A)*B*C*E))"),
    .INIT(32'h00500077))
    _al_u2043 (
    .a(_al_u2042_o),
    .b(_al_u1031_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(_al_u1042_o),
    .e(sgla_r[11]),
    .o(_al_u2043_o));
  AL_MAP_LUT4 #(
    .EQN("(A*(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))"),
    .INIT(16'ha808))
    _al_u2044 (
    .a(fctl_ccmd_div),
    .b(\fdiv/fquo [1]),
    .c(\fdiv/fquo [19]),
    .d(\fdiv/fquo [2]),
    .o(_al_u2044_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(D*~A*~(~E*B)))"),
    .INIT(32'h0a0f0e0f))
    _al_u2045 (
    .a(_al_u2043_o),
    .b(_al_u1042_o),
    .c(_al_u2044_o),
    .d(\norm/mux1_b0_sel_is_2_o ),
    .e(\sgla/sgla_i [11]),
    .o(_al_u2045_o));
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    _al_u2046 (
    .a(\fadd/n4 [11]),
    .b(\fadd/sglc_f_t [31]),
    .c(\fadd/sglc_f_t [11]),
    .o(sglc_r_fadd[11]));
  AL_MAP_LUT5 #(
    .EQN("(~(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*~(C)*~(D)+~(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*C*~(D)+~(~(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E))*C*D+~(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*C*D)"),
    .INIT(32'hf055f033))
    _al_u2047 (
    .a(_al_u1350_o),
    .b(_al_u2045_o),
    .c(sglc_r_fadd[11]),
    .d(fctl_ccmd_add),
    .e(fctl_ccmd_mul),
    .o(\norm/sglc_r [11]));
  AL_MAP_LUT5 #(
    .EQN("~(C*~((E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D))*~(A)+C*(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*~(A)+~(C)*(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*A+C*(E*~(B)*~(D)+E*B*~(D)+~(E)*B*D+E*B*D)*A)"),
    .INIT(32'h270527af))
    _al_u2048 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [10]),
    .c(\norm/sglc_f [11]),
    .d(\norm/sglc_f [27]),
    .e(\norm/sglc_f [9]),
    .o(_al_u2048_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2049 (
    .a(_al_u1002_o),
    .b(_al_u1001_o),
    .c(_al_u2048_o),
    .d(\norm/sglc_f [5]),
    .e(\norm/sglc_f [7]),
    .o(_al_u2049_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2050 (
    .a(_al_u1004_o),
    .b(_al_u1003_o),
    .c(_al_u2049_o),
    .d(\norm/sglc_f [1]),
    .e(\norm/sglc_f [3]),
    .o(_al_u2050_o));
  AL_MAP_LUT4 #(
    .EQN("~((~B*~A)*~(C)*~(D)+(~B*~A)*C*~(D)+~((~B*~A))*C*D+(~B*~A)*C*D)"),
    .INIT(16'h0fee))
    _al_u2051 (
    .a(_al_u1005_o),
    .b(_al_u2050_o),
    .c(\norm/sglc_f [12]),
    .d(\norm/sglc_f [29]),
    .o(_al_u2051_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'hf0f0cc55))
    _al_u2052 (
    .a(_al_u2051_o),
    .b(\norm/sglc_f [13]),
    .c(\norm/sglc_f [14]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n48 [11]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(A)*~(B)+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*~(B)+~((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*A*B+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*B)"),
    .INIT(32'hb8bbb888))
    _al_u2053 (
    .a(\norm/sglc_r [11]),
    .b(fctl_load_c),
    .c(\norm/n48 [11]),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [11]),
    .o(\norm/n53 [11]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*B))"),
    .INIT(8'ha2))
    _al_u2054 (
    .a(_al_u1721_o),
    .b(_al_u1705_o),
    .c(\sgla/n202_lutinv ),
    .o(_al_u2054_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*(~(A)*~(B)*~(C)*~(E)+A*~(B)*~(C)*~(E)+~(A)*B*~(C)*~(E)+~(A)*~(B)*C*~(E)+A*~(B)*C*~(E)+~(A)*B*C*~(E)+~(A)*~(B)*C*E+~(A)*B*C*E))"),
    .INIT(32'h00500077))
    _al_u2055 (
    .a(_al_u2054_o),
    .b(_al_u1031_o),
    .c(\sgla/mux44_b0_sel_is_0_o ),
    .d(_al_u1042_o),
    .e(sgla_r[10]),
    .o(_al_u2055_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~A*~(~D*B))"),
    .INIT(16'h5010))
    _al_u2056 (
    .a(_al_u2055_o),
    .b(_al_u1042_o),
    .c(\norm/mux1_b0_sel_is_2_o ),
    .d(\sgla/sgla_i [10]),
    .o(_al_u2056_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*~B))"),
    .INIT(8'h45))
    _al_u2057 (
    .a(_al_u2056_o),
    .b(_al_u1336_o),
    .c(fctl_ccmd_div),
    .o(_al_u2057_o));
  AL_MAP_LUT5 #(
    .EQN("~(~D*~((C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A))*~(E)+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*~(E)+~(~D)*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E+~D*(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)*E)"),
    .INIT(32'h2727ff00))
    _al_u2058 (
    .a(sfpu_dsp_c[47]),
    .b(sfpu_dsp_c[29]),
    .c(sfpu_dsp_c[28]),
    .d(_al_u2057_o),
    .e(fctl_ccmd_mul),
    .o(_al_u2058_o));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~((D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C))*~(E)+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*~(E)+~(~A)*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E+~A*(D*~(B)*~(C)+D*B*~(C)+~(D)*B*C+D*B*C)*E)"),
    .INIT(32'h303faaaa))
    _al_u2059 (
    .a(_al_u2058_o),
    .b(\fadd/n4 [10]),
    .c(\fadd/sglc_f_t [31]),
    .d(\fadd/sglc_f_t [10]),
    .e(fctl_ccmd_add),
    .o(_al_u2059_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~((D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C))*~(A)+B*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*~(A)+~(B)*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A+B*(D*~(E)*~(C)+D*E*~(C)+~(D)*E*C+D*E*C)*A)"),
    .INIT(32'heee44e44))
    _al_u2060 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [10]),
    .c(\norm/sglc_f [27]),
    .d(\norm/sglc_f [8]),
    .e(\norm/sglc_f [9]),
    .o(\norm/n28 [10]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    _al_u2061 (
    .a(_al_u1001_o),
    .b(\norm/n28 [10]),
    .c(\norm/sglc_f [6]),
    .o(\norm/n30 [10]));
  AL_MAP_LUT5 #(
    .EQN("((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'hfe54ae04))
    _al_u2062 (
    .a(_al_u1003_o),
    .b(\norm/n30 [10]),
    .c(_al_u1002_o),
    .d(\norm/sglc_f [2]),
    .e(\norm/sglc_f [4]),
    .o(\norm/n34 [10]));
  AL_MAP_LUT4 #(
    .EQN("(~A*(C*~(D)*~(B)+C*D*~(B)+~(C)*D*B+C*D*B))"),
    .INIT(16'h5410))
    _al_u2063 (
    .a(_al_u1005_o),
    .b(_al_u1004_o),
    .c(\norm/n34 [10]),
    .d(\norm/sglc_f [0]),
    .o(\norm/n42 [10]));
  AL_MAP_LUT5 #(
    .EQN("~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'h0f0f3355))
    _al_u2064 (
    .a(\norm/n42 [10]),
    .b(\norm/sglc_f [11]),
    .c(\norm/sglc_f [12]),
    .d(\norm/sglc_f [29]),
    .e(\norm/sglc_f [30]),
    .o(_al_u2064_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u2065 (
    .a(_al_u2064_o),
    .b(\norm/sglc_f [13]),
    .c(\norm/sglc_f [31]),
    .o(\norm/n48 [10]));
  AL_MAP_LUT5 #(
    .EQN("~(~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(A)*~(B)+~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*~(B)+~(~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*A*B+~(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*A*B)"),
    .INIT(32'h74777444))
    _al_u2066 (
    .a(_al_u2059_o),
    .b(fctl_load_c),
    .c(\norm/n48 [10]),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [10]),
    .o(\norm/n53 [10]));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~(E*C)*~(D*A)))"),
    .INIT(32'hc8c08800))
    _al_u2067 (
    .a(_al_u1770_o),
    .b(\norm/mux2_b0_sel_is_2_o ),
    .c(_al_u1042_o),
    .d(sgla_r[1]),
    .e(\sgla/sgla_i [1]),
    .o(\norm/n2 [1]));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'h5c))
    _al_u2068 (
    .a(_al_u1175_o),
    .b(\norm/n2 [1]),
    .c(fctl_ccmd_add),
    .o(\norm/sglc_r [1]));
  AL_MAP_LUT4 #(
    .EQN("~(C*~((D*B))*~(A)+C*(D*B)*~(A)+~(C)*(D*B)*A+C*(D*B)*A)"),
    .INIT(16'h27af))
    _al_u2069 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [0]),
    .c(\norm/sglc_f [1]),
    .d(\norm/sglc_f [27]),
    .o(_al_u2069_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'h3a))
    _al_u2070 (
    .a(_al_u2069_o),
    .b(\norm/sglc_f [2]),
    .c(\norm/sglc_f [29]),
    .o(_al_u2070_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)*~(E)*~(D)+(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)*E*~(D)+~((~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C))*E*D+(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)*E*D)"),
    .INIT(32'h003aff3a))
    _al_u2071 (
    .a(_al_u2070_o),
    .b(\norm/sglc_f [3]),
    .c(\norm/sglc_f [30]),
    .d(\norm/sglc_f [31]),
    .e(\norm/sglc_f [4]),
    .o(_al_u2071_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D)*~(B)*~(A)+~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D)*B*~(A)+~(~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D))*B*A+~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D)*B*A)"),
    .INIT(32'h8ddd8d88))
    _al_u2072 (
    .a(fctl_load_c),
    .b(\norm/sglc_r [1]),
    .c(_al_u2071_o),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [1]),
    .o(\norm/n53 [1]));
  AL_MAP_LUT5 #(
    .EQN("(B*~(~(E*C)*~(D*A)))"),
    .INIT(32'hc8c08800))
    _al_u2073 (
    .a(_al_u1770_o),
    .b(\norm/mux2_b0_sel_is_2_o ),
    .c(_al_u1042_o),
    .d(sgla_r[0]),
    .e(\sgla/sgla_i [0]),
    .o(\norm/n2 [0]));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'h5c))
    _al_u2074 (
    .a(_al_u1178_o),
    .b(\norm/n2 [0]),
    .c(fctl_ccmd_add),
    .o(\norm/sglc_r [0]));
  AL_MAP_LUT4 #(
    .EQN("~((B*~A)*~(C)*~(D)+(B*~A)*C*~(D)+~((B*~A))*C*D+(B*~A)*C*D)"),
    .INIT(16'h0fbb))
    _al_u2075 (
    .a(_al_u1000_o),
    .b(\norm/sglc_f [0]),
    .c(\norm/sglc_f [1]),
    .d(\norm/sglc_f [29]),
    .o(_al_u2075_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*~(C)*~(E)+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*~(E)+~((~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D))*C*E+(~A*~(B)*~(D)+~A*B*~(D)+~(~A)*B*D+~A*B*D)*C*E)"),
    .INIT(32'hf0f0cc55))
    _al_u2076 (
    .a(_al_u2075_o),
    .b(\norm/sglc_f [2]),
    .c(\norm/sglc_f [3]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n48 [0]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*~(B)*~(A)+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*B*~(A)+~((E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D))*B*A+(E*~(C)*~(D)+E*C*~(D)+~(E)*C*D+E*C*D)*B*A)"),
    .INIT(32'hd8ddd888))
    _al_u2077 (
    .a(fctl_load_c),
    .b(\norm/sglc_r [0]),
    .c(\norm/n48 [0]),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_f [0]),
    .o(\norm/n53 [0]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    _al_u2078 (
    .a(_al_u1075_o),
    .b(fctl_ccmd_reg),
    .c(sgla_e[8]),
    .o(\norm/n0 [40]));
  AL_MAP_LUT5 #(
    .EQN("~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*~(A)*~(E)+(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*A*~(E)+~((B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))*A*E+(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D)*A*E)"),
    .INIT(32'h55550f33))
    _al_u2079 (
    .a(sglc_r_fmul[40]),
    .b(\norm/n0 [40]),
    .c(sglc_r_fdiv[40]),
    .d(fctl_ccmd_div),
    .e(fctl_ccmd_mul),
    .o(_al_u2079_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~((B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E))*~(C)+D*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*~(C)+~(D)*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*C+D*(B*~(A)*~(E)+B*A*~(E)+~(B)*A*E+B*A*E)*C)"),
    .INIT(32'hafa0cfc0))
    _al_u2080 (
    .a(\norm/n24 [8]),
    .b(n7[7]),
    .c(_al_u1000_o),
    .d(\norm/sglc_e [8]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n27 [8]));
  AL_MAP_LUT5 #(
    .EQN("~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'h01ab51fb))
    _al_u2081 (
    .a(_al_u1002_o),
    .b(\norm/n27 [8]),
    .c(_al_u1001_o),
    .d(n5[7]),
    .e(n6[6]),
    .o(_al_u2081_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2082 (
    .a(_al_u1004_o),
    .b(_al_u1003_o),
    .c(_al_u2081_o),
    .d(n3[7]),
    .e(n4[5]),
    .o(_al_u2082_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2083 (
    .a(_al_u1807_o),
    .b(_al_u1005_o),
    .c(_al_u2082_o),
    .d(n1[7]),
    .e(n2[6]),
    .o(_al_u2083_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*~(C)*~(E)+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*~(E)+~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A))*C*E+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*E)"),
    .INIT(32'h0f0f44ee))
    _al_u2084 (
    .a(_al_u1808_o),
    .b(_al_u2083_o),
    .c(\norm/n6 [8]),
    .d(n0[4]),
    .e(\norm/sglc_f [29]),
    .o(_al_u2084_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u2085 (
    .a(_al_u2084_o),
    .b(\norm/n5 [7]),
    .c(\norm/sglc_f [30]),
    .o(\norm/n45 [8]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*~(C)+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)+~(D)*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C)"),
    .INIT(32'hcfc0afa0))
    _al_u2086 (
    .a(\norm/n45 [8]),
    .b(\norm/n4 [8]),
    .c(fctl_norm_enb_lutinv),
    .d(\norm/sglc_e [8]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n49 [8]));
  AL_MAP_LUT5 #(
    .EQN("(B*~((~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D))*~(C)+B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)*~(C)+~(B)*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)*C+B*(~A*~(E)*~(D)+~A*E*~(D)+~(~A)*E*D+~A*E*D)*C)"),
    .INIT(32'hfc5c0c5c))
    _al_u2087 (
    .a(_al_u2079_o),
    .b(\norm/n49 [8]),
    .c(fctl_load_c),
    .d(fctl_ccmd_add),
    .e(sgla_e[8]),
    .o(\norm/n52 [8]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((C*~(A)*~(E)+C*A*~(E)+~(C)*A*E+C*A*E))*~(B)+D*(C*~(A)*~(E)+C*A*~(E)+~(C)*A*E+C*A*E)*~(B)+~(D)*(C*~(A)*~(E)+C*A*~(E)+~(C)*A*E+C*A*E)*B+D*(C*~(A)*~(E)+C*A*~(E)+~(C)*A*E+C*A*E)*B)"),
    .INIT(32'hbb88f3c0))
    _al_u2088 (
    .a(\norm/n24 [7]),
    .b(_al_u1000_o),
    .c(n7[6]),
    .d(\norm/sglc_e [7]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n27 [7]));
  AL_MAP_LUT5 #(
    .EQN("~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'h01ab51fb))
    _al_u2089 (
    .a(_al_u1002_o),
    .b(\norm/n27 [7]),
    .c(_al_u1001_o),
    .d(n5[6]),
    .e(n6[5]),
    .o(_al_u2089_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2090 (
    .a(_al_u1004_o),
    .b(_al_u1003_o),
    .c(_al_u2089_o),
    .d(n3[6]),
    .e(n4[4]),
    .o(_al_u2090_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2091 (
    .a(_al_u1807_o),
    .b(_al_u1005_o),
    .c(_al_u2090_o),
    .d(n1[6]),
    .e(n2[5]),
    .o(_al_u2091_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*~(C)*~(E)+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*~(E)+~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A))*C*E+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*E)"),
    .INIT(32'h0f0f44ee))
    _al_u2092 (
    .a(_al_u1808_o),
    .b(_al_u2091_o),
    .c(\norm/n6 [7]),
    .d(n0[3]),
    .e(\norm/sglc_f [29]),
    .o(_al_u2092_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u2093 (
    .a(_al_u2092_o),
    .b(\norm/n5 [6]),
    .c(\norm/sglc_f [30]),
    .o(\norm/n45 [7]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*~(C)+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)+~(D)*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C)"),
    .INIT(32'hcfc0afa0))
    _al_u2094 (
    .a(\norm/n45 [7]),
    .b(\norm/n4 [7]),
    .c(fctl_norm_enb_lutinv),
    .d(\norm/sglc_e [7]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n49 [7]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u2095 (
    .a(\norm/sglc_r [39]),
    .b(\norm/n49 [7]),
    .c(fctl_load_c),
    .o(\norm/n52 [7]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E))*~(A)+D*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*~(A)+~(D)*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*A+D*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*A)"),
    .INIT(32'hdd88f5a0))
    _al_u2096 (
    .a(_al_u1000_o),
    .b(\norm/n24 [6]),
    .c(n7[5]),
    .d(\norm/sglc_e [6]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n27 [6]));
  AL_MAP_LUT5 #(
    .EQN("~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'h01ab51fb))
    _al_u2097 (
    .a(_al_u1002_o),
    .b(\norm/n27 [6]),
    .c(_al_u1001_o),
    .d(n5[5]),
    .e(n6[4]),
    .o(_al_u2097_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2098 (
    .a(_al_u1004_o),
    .b(_al_u1003_o),
    .c(_al_u2097_o),
    .d(n3[5]),
    .e(n4[3]),
    .o(_al_u2098_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2099 (
    .a(_al_u1807_o),
    .b(_al_u1005_o),
    .c(_al_u2098_o),
    .d(n1[5]),
    .e(n2[4]),
    .o(_al_u2099_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*~(C)*~(E)+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*~(E)+~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A))*C*E+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*E)"),
    .INIT(32'h0f0f44ee))
    _al_u2100 (
    .a(_al_u1808_o),
    .b(_al_u2099_o),
    .c(\norm/n6 [6]),
    .d(n0[2]),
    .e(\norm/sglc_f [29]),
    .o(_al_u2100_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u2101 (
    .a(_al_u2100_o),
    .b(\norm/n5 [5]),
    .c(\norm/sglc_f [30]),
    .o(\norm/n45 [6]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*~(C)+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)+~(D)*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C)"),
    .INIT(32'hcfc0afa0))
    _al_u2102 (
    .a(\norm/n45 [6]),
    .b(\norm/n4 [6]),
    .c(fctl_norm_enb_lutinv),
    .d(\norm/sglc_e [6]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n49 [6]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u2103 (
    .a(\norm/sglc_r [38]),
    .b(\norm/n49 [6]),
    .c(fctl_load_c),
    .o(\norm/n52 [6]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E))*~(A)+D*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*~(A)+~(D)*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*A+D*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*A)"),
    .INIT(32'hdd88f5a0))
    _al_u2104 (
    .a(_al_u1000_o),
    .b(\norm/n24 [5]),
    .c(n7[4]),
    .d(\norm/sglc_e [5]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n27 [5]));
  AL_MAP_LUT5 #(
    .EQN("~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'h01ab51fb))
    _al_u2105 (
    .a(_al_u1002_o),
    .b(\norm/n27 [5]),
    .c(_al_u1001_o),
    .d(n5[4]),
    .e(n6[3]),
    .o(_al_u2105_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2106 (
    .a(_al_u1004_o),
    .b(_al_u1003_o),
    .c(_al_u2105_o),
    .d(n3[4]),
    .e(n4[2]),
    .o(_al_u2106_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2107 (
    .a(_al_u1807_o),
    .b(_al_u1005_o),
    .c(_al_u2106_o),
    .d(n1[4]),
    .e(n2[3]),
    .o(_al_u2107_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*~(C)*~(E)+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*~(E)+~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A))*C*E+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*E)"),
    .INIT(32'h0f0f44ee))
    _al_u2108 (
    .a(_al_u1808_o),
    .b(_al_u2107_o),
    .c(\norm/n6 [5]),
    .d(n0[1]),
    .e(\norm/sglc_f [29]),
    .o(_al_u2108_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u2109 (
    .a(_al_u2108_o),
    .b(\norm/n5 [4]),
    .c(\norm/sglc_f [30]),
    .o(\norm/n45 [5]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*~(C)+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)+~(D)*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C)"),
    .INIT(32'hcfc0afa0))
    _al_u2110 (
    .a(\norm/n45 [5]),
    .b(\norm/n4 [5]),
    .c(fctl_norm_enb_lutinv),
    .d(\norm/sglc_e [5]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n49 [5]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u2111 (
    .a(\norm/sglc_r [37]),
    .b(\norm/n49 [5]),
    .c(fctl_load_c),
    .o(\norm/n52 [5]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E))*~(A)+D*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*~(A)+~(D)*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*A+D*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*A)"),
    .INIT(32'hdd88f5a0))
    _al_u2112 (
    .a(_al_u1000_o),
    .b(\norm/n24 [4]),
    .c(n7[3]),
    .d(\norm/sglc_e [4]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n27 [4]));
  AL_MAP_LUT5 #(
    .EQN("~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'h01ab51fb))
    _al_u2113 (
    .a(_al_u1002_o),
    .b(\norm/n27 [4]),
    .c(_al_u1001_o),
    .d(n5[3]),
    .e(n6[2]),
    .o(_al_u2113_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2114 (
    .a(_al_u1004_o),
    .b(_al_u1003_o),
    .c(_al_u2113_o),
    .d(n3[3]),
    .e(n4[1]),
    .o(_al_u2114_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2115 (
    .a(_al_u1807_o),
    .b(_al_u1005_o),
    .c(_al_u2114_o),
    .d(n1[3]),
    .e(n2[2]),
    .o(_al_u2115_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*~(C)*~(E)+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*~(E)+~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A))*C*E+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*E)"),
    .INIT(32'h0f0f44ee))
    _al_u2116 (
    .a(_al_u1808_o),
    .b(_al_u2115_o),
    .c(\norm/n6 [4]),
    .d(n0[0]),
    .e(\norm/sglc_f [29]),
    .o(_al_u2116_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u2117 (
    .a(_al_u2116_o),
    .b(\norm/n5 [3]),
    .c(\norm/sglc_f [30]),
    .o(\norm/n45 [4]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*~(C)+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)+~(D)*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C)"),
    .INIT(32'hcfc0afa0))
    _al_u2118 (
    .a(\norm/n45 [4]),
    .b(\norm/n4 [4]),
    .c(fctl_norm_enb_lutinv),
    .d(\norm/sglc_e [4]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n49 [4]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u2119 (
    .a(\norm/sglc_r [36]),
    .b(\norm/n49 [4]),
    .c(fctl_load_c),
    .o(\norm/n52 [4]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E))*~(A)+D*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*~(A)+~(D)*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*A+D*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*A)"),
    .INIT(32'hdd88f5a0))
    _al_u2120 (
    .a(_al_u1000_o),
    .b(\norm/n24 [3]),
    .c(n7[2]),
    .d(\norm/sglc_e [3]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n27 [3]));
  AL_MAP_LUT5 #(
    .EQN("~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*~(D)*~(A)+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*~(A)+~((B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C))*D*A+(B*~(E)*~(C)+B*E*~(C)+~(B)*E*C+B*E*C)*D*A)"),
    .INIT(32'h01ab51fb))
    _al_u2121 (
    .a(_al_u1002_o),
    .b(\norm/n27 [3]),
    .c(_al_u1001_o),
    .d(n5[2]),
    .e(n6[1]),
    .o(_al_u2121_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2122 (
    .a(_al_u1004_o),
    .b(_al_u1003_o),
    .c(_al_u2121_o),
    .d(n3[2]),
    .e(n4[0]),
    .o(_al_u2122_o));
  AL_MAP_LUT5 #(
    .EQN("~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*~(D)*~(A)+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*~(A)+~((~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B))*D*A+(~C*~(E)*~(B)+~C*E*~(B)+~(~C)*E*B+~C*E*B)*D*A)"),
    .INIT(32'h10ba54fe))
    _al_u2123 (
    .a(_al_u1807_o),
    .b(_al_u1005_o),
    .c(_al_u2122_o),
    .d(n1[2]),
    .e(n2[1]),
    .o(_al_u2123_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*~(C)*~(E)+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*~(E)+~((~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A))*C*E+(~B*~(D)*~(A)+~B*D*~(A)+~(~B)*D*A+~B*D*A)*C*E)"),
    .INIT(32'h0f0f44ee))
    _al_u2124 (
    .a(_al_u1808_o),
    .b(_al_u2123_o),
    .c(\norm/n6 [3]),
    .d(\norm/sglc_e [3]),
    .e(\norm/sglc_f [29]),
    .o(_al_u2124_o));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(B)*~(C)+~A*B*~(C)+~(~A)*B*C+~A*B*C)"),
    .INIT(8'hc5))
    _al_u2125 (
    .a(_al_u2124_o),
    .b(\norm/n5 [2]),
    .c(\norm/sglc_f [30]),
    .o(\norm/n45 [3]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*~(C)+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)+~(D)*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C)"),
    .INIT(32'hcfc0afa0))
    _al_u2126 (
    .a(\norm/n45 [3]),
    .b(\norm/n4 [3]),
    .c(fctl_norm_enb_lutinv),
    .d(\norm/sglc_e [3]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n49 [3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u2127 (
    .a(\norm/sglc_r [35]),
    .b(\norm/n49 [3]),
    .c(fctl_load_c),
    .o(\norm/n52 [3]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E))*~(A)+D*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*~(A)+~(D)*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*A+D*(C*~(B)*~(E)+C*B*~(E)+~(C)*B*E+C*B*E)*A)"),
    .INIT(32'hdd88f5a0))
    _al_u2128 (
    .a(_al_u1000_o),
    .b(\norm/n24 [2]),
    .c(n7[1]),
    .d(\norm/sglc_e [2]),
    .e(\norm/sglc_f [27]),
    .o(\norm/n27 [2]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u2129 (
    .a(\norm/n27 [2]),
    .b(_al_u1001_o),
    .c(n6[0]),
    .o(\norm/n29 [2]));
  AL_MAP_LUT5 #(
    .EQN("((B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*~(E)*~(A)+(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*E*~(A)+~((B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C))*E*A+(B*~(D)*~(C)+B*D*~(C)+~(B)*D*C+B*D*C)*E*A)"),
    .INIT(32'hfeae5404))
    _al_u2130 (
    .a(_al_u1003_o),
    .b(\norm/n29 [2]),
    .c(_al_u1002_o),
    .d(n5[1]),
    .e(\norm/sglc_e [2]),
    .o(\norm/n33 [2]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    _al_u2131 (
    .a(_al_u1004_o),
    .b(\norm/n33 [2]),
    .c(n3[1]),
    .o(_al_u2131_o));
  AL_MAP_LUT5 #(
    .EQN("~((~B*~(E)*~(C)+~B*E*~(C)+~(~B)*E*C+~B*E*C)*~(D)*~(A)+(~B*~(E)*~(C)+~B*E*~(C)+~(~B)*E*C+~B*E*C)*D*~(A)+~((~B*~(E)*~(C)+~B*E*~(C)+~(~B)*E*C+~B*E*C))*D*A+(~B*~(E)*~(C)+~B*E*~(C)+~(~B)*E*C+~B*E*C)*D*A)"),
    .INIT(32'h04ae54fe))
    _al_u2132 (
    .a(_al_u1807_o),
    .b(_al_u2131_o),
    .c(_al_u1005_o),
    .d(n1[1]),
    .e(n2[0]),
    .o(_al_u2132_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C)*~(A)+~B*C*~(A)+~(~B)*C*A+~B*C*A)"),
    .INIT(8'hb1))
    _al_u2133 (
    .a(_al_u1808_o),
    .b(_al_u2132_o),
    .c(\norm/sglc_e [2]),
    .o(\norm/n41 [2]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u2134 (
    .a(\norm/n41 [2]),
    .b(\norm/n6 [2]),
    .c(\norm/n5 [1]),
    .d(\norm/sglc_f [29]),
    .e(\norm/sglc_f [30]),
    .o(\norm/n45 [2]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*~(C)+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)+~(D)*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C)"),
    .INIT(32'hcfc0afa0))
    _al_u2135 (
    .a(\norm/n45 [2]),
    .b(\norm/n4 [2]),
    .c(fctl_norm_enb_lutinv),
    .d(\norm/sglc_e [2]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n49 [2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u2136 (
    .a(\norm/sglc_r [34]),
    .b(\norm/n49 [2]),
    .c(fctl_load_c),
    .o(\norm/n52 [2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u2137 (
    .a(\norm/n24 [1]),
    .b(n7[0]),
    .c(\norm/sglc_f [27]),
    .o(_al_u2137_o));
  AL_MAP_LUT4 #(
    .EQN("(D*~(B)*~((C*~A))+D*B*~((C*~A))+~(D)*B*(C*~A)+D*B*(C*~A))"),
    .INIT(16'hef40))
    _al_u2138 (
    .a(_al_u1001_o),
    .b(_al_u2137_o),
    .c(_al_u1000_o),
    .d(\norm/sglc_e [1]),
    .o(\norm/n29 [1]));
  AL_MAP_LUT4 #(
    .EQN("(B*~(D)*~((C*~A))+B*D*~((C*~A))+~(B)*D*(C*~A)+B*D*(C*~A))"),
    .INIT(16'hdc8c))
    _al_u2139 (
    .a(_al_u1003_o),
    .b(\norm/n29 [1]),
    .c(_al_u1002_o),
    .d(n5[0]),
    .o(\norm/n33 [1]));
  AL_MAP_LUT4 #(
    .EQN("(C*~(D)*~((B*~A))+C*D*~((B*~A))+~(C)*D*(B*~A)+C*D*(B*~A))"),
    .INIT(16'hf4b0))
    _al_u2140 (
    .a(_al_u1005_o),
    .b(_al_u1004_o),
    .c(\norm/n33 [1]),
    .d(n3[0]),
    .o(\norm/n37 [1]));
  AL_MAP_LUT4 #(
    .EQN("(C*~(D)*~((B*~A))+C*D*~((B*~A))+~(C)*D*(B*~A)+C*D*(B*~A))"),
    .INIT(16'hf4b0))
    _al_u2141 (
    .a(_al_u1808_o),
    .b(_al_u1807_o),
    .c(\norm/n37 [1]),
    .d(n1[0]),
    .o(\norm/n41 [1]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*~(C)*~(E)+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*~(E)+~((A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))*C*E+(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D)*C*E)"),
    .INIT(32'hf0f0ccaa))
    _al_u2142 (
    .a(\norm/n41 [1]),
    .b(\norm/n6 [1]),
    .c(\norm/n5 [0]),
    .d(\norm/sglc_f [29]),
    .e(\norm/sglc_f [30]),
    .o(\norm/n45 [1]));
  AL_MAP_LUT5 #(
    .EQN("(D*~((A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E))*~(C)+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*~(C)+~(D)*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C+D*(A*~(B)*~(E)+A*B*~(E)+~(A)*B*E+A*B*E)*C)"),
    .INIT(32'hcfc0afa0))
    _al_u2143 (
    .a(\norm/n45 [1]),
    .b(\norm/n4 [1]),
    .c(fctl_norm_enb_lutinv),
    .d(\norm/sglc_e [1]),
    .e(\norm/sglc_f [31]),
    .o(\norm/n49 [1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(A)*~(C)+B*A*~(C)+~(B)*A*C+B*A*C)"),
    .INIT(8'hac))
    _al_u2144 (
    .a(\norm/sglc_r [33]),
    .b(\norm/n49 [1]),
    .c(fctl_load_c),
    .o(\norm/n52 [1]));
  AL_MAP_LUT4 #(
    .EQN("(C*~(B)*~((D*A))+C*B*~((D*A))+~(C)*B*(D*A)+C*B*(D*A))"),
    .INIT(16'hd8f0))
    _al_u2145 (
    .a(_al_u1000_o),
    .b(\norm/n24 [0]),
    .c(\norm/sglc_e [0]),
    .d(\norm/sglc_f [27]),
    .o(\norm/n41 [0]));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    _al_u2146 (
    .a(\norm/n41 [0]),
    .b(\norm/n6 [0]),
    .c(\norm/sglc_f [29]),
    .o(_al_u2146_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*~(B)*~(E)+(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*~(E)+~((~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D))*B*E+(~A*~(C)*~(D)+~A*C*~(D)+~(~A)*C*D+~A*C*D)*B*E)"),
    .INIT(32'h33330faa))
    _al_u2147 (
    .a(_al_u2146_o),
    .b(\norm/n4 [0]),
    .c(\norm/sglc_e [0]),
    .d(\norm/sglc_f [30]),
    .e(\norm/sglc_f [31]),
    .o(_al_u2147_o));
  AL_MAP_LUT5 #(
    .EQN("(~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D)*~(A)*~(B)+~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D)*A*~(B)+~(~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D))*A*B+~(~E*~(C)*~(D)+~E*C*~(D)+~(~E)*C*D+~E*C*D)*A*B)"),
    .INIT(32'h8bbb8b88))
    _al_u2148 (
    .a(\norm/sglc_r [32]),
    .b(fctl_load_c),
    .c(_al_u2147_o),
    .d(fctl_norm_enb_lutinv),
    .e(\norm/sglc_e [0]),
    .o(\norm/n52 [0]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u2149 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(\sgla/n58 [8]),
    .d(n11[7]),
    .e(sgla_e[8]),
    .o(\sgla/n61 [8]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))"),
    .INIT(16'h010d))
    _al_u2150 (
    .a(\sgla/n61 [8]),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(n10[6]),
    .o(_al_u2150_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(~D*C))*~(E)*~(B)+(~A*~(~D*C))*E*~(B)+~((~A*~(~D*C)))*E*B+(~A*~(~D*C))*E*B)"),
    .INIT(32'hddcd1101))
    _al_u2151 (
    .a(_al_u2150_o),
    .b(_al_u1064_o),
    .c(_al_u1062_o),
    .d(n9[5]),
    .e(n8[4]),
    .o(\sgla/n67 [8]));
  AL_MAP_LUT4 #(
    .EQN("(~B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'h3202))
    _al_u2152 (
    .a(\sgla/n67 [8]),
    .b(_al_u1121_o),
    .c(_al_u1122_o),
    .d(\sgla/n48 [8]),
    .o(_al_u2152_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u2153 (
    .a(_al_u2152_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(\sgla/n39 [8]),
    .e(\sgla/n33 [7]),
    .o(_al_u2153_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u2154 (
    .a(_al_u2153_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(\sgla/n28 [6]),
    .e(\sgla/n20 [5]),
    .o(_al_u2154_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u2155 (
    .a(_al_u2154_o),
    .b(_al_u1027_o),
    .c(_al_u1164_o),
    .d(\sgla/n11 [8]),
    .e(\sgla/n15 [4]),
    .o(_al_u2155_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h8d))
    _al_u2156 (
    .a(fctl_load_a),
    .b(\sgla/n2 [8]),
    .c(_al_u2155_o),
    .o(\sgla/n84 [8]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u2157 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(\sgla/n58 [7]),
    .d(n11[6]),
    .e(sgla_e[7]),
    .o(\sgla/n61 [7]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u2158 (
    .a(\sgla/n61 [7]),
    .b(_al_u1061_o),
    .c(n10[5]),
    .o(\sgla/n63 [7]));
  AL_MAP_LUT5 #(
    .EQN("((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*~(E)*~(B)+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*~(B)+~((A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))*E*B+(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C)*E*B)"),
    .INIT(32'hfece3202))
    _al_u2159 (
    .a(\sgla/n63 [7]),
    .b(_al_u1064_o),
    .c(_al_u1062_o),
    .d(n9[4]),
    .e(n8[3]),
    .o(\sgla/n67 [7]));
  AL_MAP_LUT4 #(
    .EQN("(~B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'h3202))
    _al_u2160 (
    .a(\sgla/n67 [7]),
    .b(_al_u1121_o),
    .c(_al_u1122_o),
    .d(\sgla/n48 [7]),
    .o(_al_u2160_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u2161 (
    .a(_al_u2160_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(\sgla/n39 [7]),
    .e(\sgla/n33 [6]),
    .o(_al_u2161_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u2162 (
    .a(_al_u2161_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(\sgla/n28 [5]),
    .e(\sgla/n20 [4]),
    .o(_al_u2162_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u2163 (
    .a(_al_u2162_o),
    .b(_al_u1027_o),
    .c(_al_u1164_o),
    .d(\sgla/n11 [7]),
    .e(\sgla/n15 [3]),
    .o(_al_u2163_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h8d))
    _al_u2164 (
    .a(fctl_load_a),
    .b(\sgla/n2 [7]),
    .c(_al_u2163_o),
    .o(\sgla/n84 [7]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u2165 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(\sgla/n58 [6]),
    .d(n11[5]),
    .e(sgla_e[6]),
    .o(\sgla/n61 [6]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))"),
    .INIT(16'h010d))
    _al_u2166 (
    .a(\sgla/n61 [6]),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(n10[4]),
    .o(_al_u2166_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(~D*C))*~(E)*~(B)+(~A*~(~D*C))*E*~(B)+~((~A*~(~D*C)))*E*B+(~A*~(~D*C))*E*B)"),
    .INIT(32'hddcd1101))
    _al_u2167 (
    .a(_al_u2166_o),
    .b(_al_u1064_o),
    .c(_al_u1062_o),
    .d(n9[3]),
    .e(n8[2]),
    .o(\sgla/n67 [6]));
  AL_MAP_LUT4 #(
    .EQN("(~B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'h3202))
    _al_u2168 (
    .a(\sgla/n67 [6]),
    .b(_al_u1121_o),
    .c(_al_u1122_o),
    .d(\sgla/n48 [6]),
    .o(_al_u2168_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u2169 (
    .a(_al_u2168_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(\sgla/n39 [6]),
    .e(\sgla/n33 [5]),
    .o(_al_u2169_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u2170 (
    .a(_al_u2169_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(\sgla/n28 [4]),
    .e(\sgla/n20 [3]),
    .o(_al_u2170_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u2171 (
    .a(_al_u2170_o),
    .b(_al_u1027_o),
    .c(_al_u1164_o),
    .d(\sgla/n11 [6]),
    .e(\sgla/n15 [2]),
    .o(_al_u2171_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h8d))
    _al_u2172 (
    .a(fctl_load_a),
    .b(\sgla/n2 [6]),
    .c(_al_u2171_o),
    .o(\sgla/n84 [6]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u2173 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(\sgla/n58 [5]),
    .d(n11[4]),
    .e(sgla_e[5]),
    .o(\sgla/n61 [5]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))"),
    .INIT(16'h010d))
    _al_u2174 (
    .a(\sgla/n61 [5]),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(n10[3]),
    .o(_al_u2174_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(~D*C))*~(E)*~(B)+(~A*~(~D*C))*E*~(B)+~((~A*~(~D*C)))*E*B+(~A*~(~D*C))*E*B)"),
    .INIT(32'hddcd1101))
    _al_u2175 (
    .a(_al_u2174_o),
    .b(_al_u1064_o),
    .c(_al_u1062_o),
    .d(n9[2]),
    .e(n8[1]),
    .o(\sgla/n67 [5]));
  AL_MAP_LUT4 #(
    .EQN("(~B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'h3202))
    _al_u2176 (
    .a(\sgla/n67 [5]),
    .b(_al_u1121_o),
    .c(_al_u1122_o),
    .d(\sgla/n48 [5]),
    .o(_al_u2176_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u2177 (
    .a(_al_u2176_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(\sgla/n39 [5]),
    .e(\sgla/n33 [4]),
    .o(_al_u2177_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u2178 (
    .a(_al_u2177_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(\sgla/n28 [3]),
    .e(\sgla/n20 [2]),
    .o(_al_u2178_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u2179 (
    .a(_al_u2178_o),
    .b(_al_u1027_o),
    .c(_al_u1164_o),
    .d(\sgla/n11 [5]),
    .e(\sgla/n15 [1]),
    .o(_al_u2179_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h8d))
    _al_u2180 (
    .a(fctl_load_a),
    .b(\sgla/n2 [5]),
    .c(_al_u2179_o),
    .o(\sgla/n84 [5]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u2181 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(\sgla/n58 [4]),
    .d(n11[3]),
    .e(sgla_e[4]),
    .o(\sgla/n61 [4]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))"),
    .INIT(16'h010d))
    _al_u2182 (
    .a(\sgla/n61 [4]),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(n10[2]),
    .o(_al_u2182_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(~D*C))*~(E)*~(B)+(~A*~(~D*C))*E*~(B)+~((~A*~(~D*C)))*E*B+(~A*~(~D*C))*E*B)"),
    .INIT(32'hddcd1101))
    _al_u2183 (
    .a(_al_u2182_o),
    .b(_al_u1064_o),
    .c(_al_u1062_o),
    .d(n9[1]),
    .e(n8[0]),
    .o(\sgla/n67 [4]));
  AL_MAP_LUT4 #(
    .EQN("(~B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'h3202))
    _al_u2184 (
    .a(\sgla/n67 [4]),
    .b(_al_u1121_o),
    .c(_al_u1122_o),
    .d(\sgla/n48 [4]),
    .o(_al_u2184_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u2185 (
    .a(_al_u2184_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(\sgla/n39 [4]),
    .e(\sgla/n33 [3]),
    .o(_al_u2185_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u2186 (
    .a(_al_u2185_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(\sgla/n28 [2]),
    .e(\sgla/n20 [1]),
    .o(_al_u2186_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u2187 (
    .a(_al_u2186_o),
    .b(_al_u1027_o),
    .c(_al_u1164_o),
    .d(\sgla/n11 [4]),
    .e(\sgla/n15 [0]),
    .o(_al_u2187_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h8d))
    _al_u2188 (
    .a(fctl_load_a),
    .b(\sgla/n2 [4]),
    .c(_al_u2187_o),
    .o(\sgla/n84 [4]));
  AL_MAP_LUT5 #(
    .EQN("((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*~(D)*~(A)+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*~(A)+~((E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B))*D*A+(E*~(C)*~(B)+E*C*~(B)+~(E)*C*B+E*C*B)*D*A)"),
    .INIT(32'hfb51ea40))
    _al_u2189 (
    .a(_al_u1058_o),
    .b(_al_u1059_o),
    .c(\sgla/n58 [3]),
    .d(n11[2]),
    .e(sgla_e[3]),
    .o(\sgla/n61 [3]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(A*~(D)*~(B)+A*D*~(B)+~(A)*D*B+A*D*B))"),
    .INIT(16'h010d))
    _al_u2190 (
    .a(\sgla/n61 [3]),
    .b(_al_u1061_o),
    .c(_al_u1062_o),
    .d(n10[1]),
    .o(_al_u2190_o));
  AL_MAP_LUT5 #(
    .EQN("((~A*~(~D*C))*~(E)*~(B)+(~A*~(~D*C))*E*~(B)+~((~A*~(~D*C)))*E*B+(~A*~(~D*C))*E*B)"),
    .INIT(32'hddcd1101))
    _al_u2191 (
    .a(_al_u2190_o),
    .b(_al_u1064_o),
    .c(_al_u1062_o),
    .d(n9[0]),
    .e(sgla_e[3]),
    .o(\sgla/n67 [3]));
  AL_MAP_LUT4 #(
    .EQN("(~B*(A*~(D)*~(C)+A*D*~(C)+~(A)*D*C+A*D*C))"),
    .INIT(16'h3202))
    _al_u2192 (
    .a(\sgla/n67 [3]),
    .b(_al_u1121_o),
    .c(_al_u1122_o),
    .d(\sgla/n48 [3]),
    .o(_al_u2192_o));
  AL_MAP_LUT5 #(
    .EQN("~(~(~A*~(D*B))*~(E)*~(C)+~(~A*~(D*B))*E*~(C)+~(~(~A*~(D*B)))*E*C+~(~A*~(D*B))*E*C)"),
    .INIT(32'h0105f1f5))
    _al_u2193 (
    .a(_al_u2192_o),
    .b(_al_u1121_o),
    .c(_al_u1218_o),
    .d(\sgla/n39 [3]),
    .e(\sgla/n33 [2]),
    .o(_al_u2193_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*~(E)*~(B)+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*~(B)+~((~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C))*E*B+(~A*~(D)*~(C)+~A*D*~(C)+~(~A)*D*C+~A*D*C)*E*B)"),
    .INIT(32'h0232cefe))
    _al_u2194 (
    .a(_al_u2193_o),
    .b(_al_u1163_o),
    .c(_al_u1167_o),
    .d(\sgla/n28 [1]),
    .e(\sgla/n20 [0]),
    .o(_al_u2194_o));
  AL_MAP_LUT5 #(
    .EQN("~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*~(D)*~(B)+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*~(B)+~((~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C))*D*B+(~A*~(E)*~(C)+~A*E*~(C)+~(~A)*E*C+~A*E*C)*D*B)"),
    .INIT(32'h02ce32fe))
    _al_u2195 (
    .a(_al_u2194_o),
    .b(_al_u1027_o),
    .c(_al_u1164_o),
    .d(\sgla/n11 [3]),
    .e(sgla_e[3]),
    .o(_al_u2195_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h8d))
    _al_u2196 (
    .a(fctl_load_a),
    .b(\sgla/n2 [3]),
    .c(_al_u2195_o),
    .o(\sgla/n84 [3]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u2197 (
    .a(\norm/sglc_r [44]),
    .b(fctl_ccmd_hlf),
    .o(_al_u2197_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2198 (
    .a(fctl_ccmd_hlf),
    .b(fctl_ccmd_reg),
    .c(\norm/sglc_i [42]),
    .o(_al_u2198_o));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~E*D)*~(B*~A))"),
    .INIT(32'hb0b000b0))
    _al_u2199 (
    .a(\norm/sglc_r [41]),
    .b(_al_u2197_o),
    .c(_al_u2198_o),
    .d(fctl_ccmd_hlf),
    .e(\norm/sglc_i [41]),
    .o(_al_u2199_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u2200 (
    .a(fctl_ccmd_cmp),
    .b(fctl_ccmd_reg),
    .o(_al_u2200_o));
  AL_MAP_LUT4 #(
    .EQN("(~A*~(B*~(~D*~C)))"),
    .INIT(16'h1115))
    _al_u2201 (
    .a(_al_u2199_o),
    .b(_al_u2200_o),
    .c(\norm/sglc_i [41]),
    .d(\norm/sglc_i [44]),
    .o(_al_u2201_o));
  AL_MAP_LUT4 #(
    .EQN("(C*~(A*~(B)*~(D)+A*B*~(D)+~(A)*B*D+A*B*D))"),
    .INIT(16'h3050))
    _al_u2202 (
    .a(_al_u2201_o),
    .b(_al_u1783_o),
    .c(fctl_cbus_out_lutinv),
    .d(fctl_ccmd_int),
    .o(cbus[31]));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    _al_u2203 (
    .a(_al_u1366_o),
    .b(fctl_ccmd_add),
    .c(_al_u1363_o),
    .o(_al_u2203_o));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u2204 (
    .a(sglc_r_fadd[42]),
    .b(fctl_ccmd_add),
    .o(_al_u2204_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u2205 (
    .a(_al_u2197_o),
    .b(\norm/sglc_r [43]),
    .o(_al_u2205_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(C*~(~D*~(B*~A))))"),
    .INIT(32'h0fbf0000))
    _al_u2206 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(\norm/n61 [7]),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2206_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2207 (
    .a(_al_u1788_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2207_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    _al_u2208 (
    .a(\norm/udfl ),
    .b(_al_u2200_o),
    .c(\norm/sglc_i [42]),
    .o(_al_u2208_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u2209 (
    .a(_al_u2208_o),
    .b(\norm/ovfl ),
    .c(\norm/sglc_i [43]),
    .d(\norm/sglc_i [44]),
    .o(_al_u2209_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(B*~(~E*~D*~A)))"),
    .INIT(32'h03030307))
    _al_u2210 (
    .a(\norm/ovfl ),
    .b(_al_u2200_o),
    .c(fctl_ccmd_int),
    .d(\norm/sglc_i [43]),
    .e(\norm/sglc_i [44]),
    .o(_al_u2210_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2211 (
    .a(_al_u2209_o),
    .b(_al_u2210_o),
    .c(\norm/n60 [7]),
    .o(_al_u2211_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2212 (
    .a(\norm/n60 [7]),
    .b(_al_u2198_o),
    .c(fctl_ccmd_hlf),
    .o(_al_u2212_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(C*~(D*~A)))"),
    .INIT(16'h4c0c))
    _al_u2213 (
    .a(_al_u2206_o),
    .b(_al_u2207_o),
    .c(_al_u2211_o),
    .d(_al_u2212_o),
    .o(cbus[30]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(C*~(~D*~(B*~A))))"),
    .INIT(32'h0fbf0000))
    _al_u2214 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(\norm/n61 [6]),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2214_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2215 (
    .a(\norm/sglc_r [29]),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2215_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2216 (
    .a(_al_u2209_o),
    .b(_al_u2210_o),
    .c(\norm/n60 [6]),
    .o(_al_u2216_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2217 (
    .a(\norm/n60 [6]),
    .b(_al_u2198_o),
    .c(fctl_ccmd_hlf),
    .o(_al_u2217_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(C*~(D*~A)))"),
    .INIT(16'h4c0c))
    _al_u2218 (
    .a(_al_u2214_o),
    .b(_al_u2215_o),
    .c(_al_u2216_o),
    .d(_al_u2217_o),
    .o(cbus[29]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(C*~(~D*~(B*~A))))"),
    .INIT(32'h0fbf0000))
    _al_u2219 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(\norm/n61 [5]),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2219_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2220 (
    .a(_al_u1806_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2220_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2221 (
    .a(_al_u2209_o),
    .b(_al_u2210_o),
    .c(\norm/n60 [5]),
    .o(_al_u2221_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2222 (
    .a(\norm/n60 [5]),
    .b(_al_u2198_o),
    .c(fctl_ccmd_hlf),
    .o(_al_u2222_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(C*~(D*~A)))"),
    .INIT(16'h4c0c))
    _al_u2223 (
    .a(_al_u2219_o),
    .b(_al_u2220_o),
    .c(_al_u2221_o),
    .d(_al_u2222_o),
    .o(cbus[28]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(C*~(~D*~(B*~A))))"),
    .INIT(32'h0fbf0000))
    _al_u2224 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(\norm/n61 [4]),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2224_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2225 (
    .a(\norm/sglc_r [27]),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2225_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2226 (
    .a(_al_u2209_o),
    .b(_al_u2210_o),
    .c(\norm/n60 [4]),
    .o(_al_u2226_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2227 (
    .a(\norm/n60 [4]),
    .b(_al_u2198_o),
    .c(fctl_ccmd_hlf),
    .o(_al_u2227_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(C*~(D*~A)))"),
    .INIT(16'h4c0c))
    _al_u2228 (
    .a(_al_u2224_o),
    .b(_al_u2225_o),
    .c(_al_u2226_o),
    .d(_al_u2227_o),
    .o(cbus[27]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(C*~(~D*~(B*~A))))"),
    .INIT(32'h0fbf0000))
    _al_u2229 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(\norm/n61 [3]),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2229_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2230 (
    .a(\norm/sglc_r [26]),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2230_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2231 (
    .a(_al_u2209_o),
    .b(_al_u2210_o),
    .c(\norm/n60 [3]),
    .o(_al_u2231_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2232 (
    .a(\norm/n60 [3]),
    .b(_al_u2198_o),
    .c(fctl_ccmd_hlf),
    .o(_al_u2232_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(C*~(D*~A)))"),
    .INIT(16'h4c0c))
    _al_u2233 (
    .a(_al_u2229_o),
    .b(_al_u2230_o),
    .c(_al_u2231_o),
    .d(_al_u2232_o),
    .o(cbus[26]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(C*~(~D*~(B*~A))))"),
    .INIT(32'h0fbf0000))
    _al_u2234 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(\norm/n61 [2]),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2234_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2235 (
    .a(_al_u1850_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2235_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2236 (
    .a(_al_u2209_o),
    .b(_al_u2210_o),
    .c(\norm/n60 [2]),
    .o(_al_u2236_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2237 (
    .a(\norm/n60 [2]),
    .b(_al_u2198_o),
    .c(fctl_ccmd_hlf),
    .o(_al_u2237_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(C*~(D*~A)))"),
    .INIT(16'h4c0c))
    _al_u2238 (
    .a(_al_u2234_o),
    .b(_al_u2235_o),
    .c(_al_u2236_o),
    .d(_al_u2237_o),
    .o(cbus[25]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(C*~(~D*~(B*~A))))"),
    .INIT(32'h0fbf0000))
    _al_u2239 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(\norm/n61 [1]),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2239_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2240 (
    .a(\norm/sglc_r [24]),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2240_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2241 (
    .a(_al_u2209_o),
    .b(_al_u2210_o),
    .c(\norm/n60 [1]),
    .o(_al_u2241_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2242 (
    .a(\norm/n60 [1]),
    .b(_al_u2198_o),
    .c(fctl_ccmd_hlf),
    .o(_al_u2242_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(C*~(D*~A)))"),
    .INIT(16'h4c0c))
    _al_u2243 (
    .a(_al_u2239_o),
    .b(_al_u2240_o),
    .c(_al_u2241_o),
    .d(_al_u2242_o),
    .o(cbus[24]));
  AL_MAP_LUT5 #(
    .EQN("(E*~(C*~(~D*~(B*~A))))"),
    .INIT(32'h0fbf0000))
    _al_u2244 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(\norm/n61 [0]),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2244_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2245 (
    .a(_al_u1877_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2245_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2246 (
    .a(_al_u2209_o),
    .b(_al_u2210_o),
    .c(\norm/n60 [0]),
    .o(_al_u2246_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2247 (
    .a(\norm/n60 [0]),
    .b(_al_u2198_o),
    .c(fctl_ccmd_hlf),
    .o(_al_u2247_o));
  AL_MAP_LUT4 #(
    .EQN("(B*~(C*~(D*~A)))"),
    .INIT(16'h4c0c))
    _al_u2248 (
    .a(_al_u2244_o),
    .b(_al_u2245_o),
    .c(_al_u2246_o),
    .d(_al_u2247_o),
    .o(cbus[23]));
  AL_MAP_LUT5 #(
    .EQN("(E*C*~(~D*~(B*~A)))"),
    .INIT(32'hf0400000))
    _al_u2249 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(\norm/sglc_r [27]),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2249_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2250 (
    .a(_al_u1892_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2250_o));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'h1d))
    _al_u2251 (
    .a(\norm/sglc_r [44]),
    .b(fctl_ccmd_hlf),
    .c(\norm/sglc_f [27]),
    .o(_al_u2251_o));
  AL_MAP_LUT5 #(
    .EQN("(~C*~(E*B)*~(D*A))"),
    .INIT(32'h0103050f))
    _al_u2252 (
    .a(_al_u2209_o),
    .b(_al_u2200_o),
    .c(fctl_ccmd_int),
    .d(\norm/sglc_f [27]),
    .e(\norm/sglc_i [44]),
    .o(_al_u2252_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(D*~(E*~(C*~A))))"),
    .INIT(32'h8ccc00cc))
    _al_u2253 (
    .a(_al_u2249_o),
    .b(_al_u2250_o),
    .c(_al_u2251_o),
    .d(_al_u2252_o),
    .e(_al_u2198_o),
    .o(cbus[22]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*~(~D*~(B*~A)))"),
    .INIT(32'h0f040000))
    _al_u2254 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(_al_u2008_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2254_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2255 (
    .a(_al_u1713_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2255_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2256 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [14]),
    .o(_al_u2256_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2257 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [14]),
    .o(_al_u2257_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2258 (
    .a(_al_u2254_o),
    .b(_al_u2255_o),
    .c(_al_u2256_o),
    .d(_al_u2198_o),
    .e(_al_u2257_o),
    .o(cbus[9]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*~(~D*~(B*~A)))"),
    .INIT(32'h0f040000))
    _al_u2259 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(_al_u2022_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2259_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2260 (
    .a(\norm/sglc_r [8]),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2260_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2261 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [13]),
    .o(_al_u2261_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2262 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [13]),
    .o(_al_u2262_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2263 (
    .a(_al_u2259_o),
    .b(_al_u2260_o),
    .c(_al_u2261_o),
    .d(_al_u2198_o),
    .e(_al_u2262_o),
    .o(cbus[8]));
  AL_MAP_LUT5 #(
    .EQN("(E*C*~(~D*~(B*~A)))"),
    .INIT(32'hf0400000))
    _al_u2264 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(\norm/sglc_r [12]),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2264_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B*~A))"),
    .INIT(8'h0b))
    _al_u2265 (
    .a(_al_u1738_o),
    .b(_al_u1739_o),
    .c(_al_u1740_o),
    .o(_al_u2265_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2266 (
    .a(_al_u2265_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2266_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u2267 (
    .a(fctl_ccmd_cmp),
    .b(fctl_ccmd_reg),
    .o(_al_u2267_o));
  AL_MAP_LUT5 #(
    .EQN("(~(E*C)*~(D*~(B*~A)))"),
    .INIT(32'h040f44ff))
    _al_u2268 (
    .a(_al_u1196_o),
    .b(_al_u1209_o),
    .c(_al_u2209_o),
    .d(_al_u2267_o),
    .e(\norm/sglc_f [12]),
    .o(_al_u2268_o));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u2269 (
    .a(_al_u2268_o),
    .b(fctl_ccmd_int),
    .o(_al_u2269_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2270 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [12]),
    .o(_al_u2270_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2271 (
    .a(_al_u2264_o),
    .b(_al_u2266_o),
    .c(_al_u2269_o),
    .d(_al_u2198_o),
    .e(_al_u2270_o),
    .o(cbus[7]));
  AL_MAP_LUT5 #(
    .EQN("(E*C*~(~D*~(B*~A)))"),
    .INIT(32'hf0400000))
    _al_u2272 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(\norm/sglc_r [11]),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2272_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2273 (
    .a(_al_u1753_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2273_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~(C*B*A))"),
    .INIT(16'h007f))
    _al_u2274 (
    .a(sglc_r_fadd[42]),
    .b(_al_u1208_o),
    .c(_al_u2267_o),
    .d(fctl_ccmd_int),
    .o(_al_u2274_o));
  AL_MAP_LUT5 #(
    .EQN("(E*~(~(C*B)*~(~D*A)))"),
    .INIT(32'hc0ea0000))
    _al_u2275 (
    .a(\fdiv/n6_lutinv ),
    .b(sglb_r[44]),
    .c(sgla_r[44]),
    .d(_al_u924_o),
    .e(_al_u2267_o),
    .o(_al_u2275_o));
  AL_MAP_LUT4 #(
    .EQN("(~B*A*~(D*C))"),
    .INIT(16'h0222))
    _al_u2276 (
    .a(_al_u2274_o),
    .b(_al_u2275_o),
    .c(_al_u2209_o),
    .d(\norm/sglc_f [11]),
    .o(_al_u2276_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2277 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [11]),
    .o(_al_u2277_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2278 (
    .a(_al_u2272_o),
    .b(_al_u2273_o),
    .c(_al_u2276_o),
    .d(_al_u2198_o),
    .e(_al_u2277_o),
    .o(cbus[6]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*~(~D*~(B*~A)))"),
    .INIT(32'h0f040000))
    _al_u2279 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(_al_u2059_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2279_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2280 (
    .a(\norm/sglc_r [5]),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2280_o));
  AL_MAP_LUT5 #(
    .EQN("(~D*~(E*B)*~(C*~A))"),
    .INIT(32'h002300af))
    _al_u2281 (
    .a(_al_u1208_o),
    .b(_al_u2209_o),
    .c(_al_u2267_o),
    .d(fctl_ccmd_int),
    .e(\norm/sglc_f [10]),
    .o(_al_u2281_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2282 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [10]),
    .o(_al_u2282_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2283 (
    .a(_al_u2279_o),
    .b(_al_u2280_o),
    .c(_al_u2281_o),
    .d(_al_u2198_o),
    .e(_al_u2282_o),
    .o(cbus[5]));
  AL_MAP_LUT5 #(
    .EQN("(E*~B*~(~D*~(C*~A)))"),
    .INIT(32'h33100000))
    _al_u2284 (
    .a(_al_u1343_o),
    .b(_al_u1713_o),
    .c(_al_u2203_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2284_o));
  AL_MAP_LUT5 #(
    .EQN("(D*~(E*~C*~(B*~A)))"),
    .INIT(32'hf400ff00))
    _al_u2285 (
    .a(_al_u1772_o),
    .b(_al_u1773_o),
    .c(_al_u1774_o),
    .d(fctl_cbus_out_lutinv),
    .e(fctl_ccmd_int),
    .o(_al_u2285_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*B))"),
    .INIT(8'h2a))
    _al_u2286 (
    .a(_al_u2274_o),
    .b(_al_u2209_o),
    .c(\norm/sglc_f [9]),
    .o(_al_u2286_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2287 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [9]),
    .o(_al_u2287_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2288 (
    .a(_al_u2284_o),
    .b(_al_u2285_o),
    .c(_al_u2286_o),
    .d(_al_u2198_o),
    .e(_al_u2287_o),
    .o(cbus[4]));
  AL_MAP_LUT5 #(
    .EQN("(E*B*~(~D*~(C*~A)))"),
    .INIT(32'hcc400000))
    _al_u2289 (
    .a(_al_u1343_o),
    .b(\norm/sglc_r [8]),
    .c(_al_u2203_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2289_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*~B))"),
    .INIT(8'h8a))
    _al_u2290 (
    .a(fctl_cbus_out_lutinv),
    .b(\norm/sglc_r [3]),
    .c(fctl_ccmd_int),
    .o(_al_u2290_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2291 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [8]),
    .o(_al_u2291_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2292 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [8]),
    .o(_al_u2292_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2293 (
    .a(_al_u2289_o),
    .b(_al_u2290_o),
    .c(_al_u2291_o),
    .d(_al_u2198_o),
    .e(_al_u2292_o),
    .o(cbus[3]));
  AL_MAP_LUT5 #(
    .EQN("(E*~B*~(~D*~(C*~A)))"),
    .INIT(32'h33100000))
    _al_u2294 (
    .a(_al_u1343_o),
    .b(_al_u2265_o),
    .c(_al_u2203_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2294_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C*~B))"),
    .INIT(8'h8a))
    _al_u2295 (
    .a(fctl_cbus_out_lutinv),
    .b(\norm/sglc_r [2]),
    .c(fctl_ccmd_int),
    .o(_al_u2295_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2296 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [7]),
    .o(_al_u2296_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2297 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [7]),
    .o(_al_u2297_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2298 (
    .a(_al_u2294_o),
    .b(_al_u2295_o),
    .c(_al_u2296_o),
    .d(_al_u2198_o),
    .e(_al_u2297_o),
    .o(cbus[2]));
  AL_MAP_LUT5 #(
    .EQN("(E*C*~(~D*~(B*~A)))"),
    .INIT(32'hf0400000))
    _al_u2299 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(\norm/sglc_r [26]),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2299_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2300 (
    .a(_al_u1908_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2300_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2301 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [26]),
    .o(_al_u2301_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2302 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [26]),
    .o(_al_u2302_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2303 (
    .a(_al_u2299_o),
    .b(_al_u2300_o),
    .c(_al_u2301_o),
    .d(_al_u2198_o),
    .e(_al_u2302_o),
    .o(cbus[21]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*~(~D*~(B*~A)))"),
    .INIT(32'h0f040000))
    _al_u2304 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(_al_u1850_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2304_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2305 (
    .a(_al_u1921_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2305_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2306 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [25]),
    .o(_al_u2306_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2307 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [25]),
    .o(_al_u2307_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2308 (
    .a(_al_u2304_o),
    .b(_al_u2305_o),
    .c(_al_u2306_o),
    .d(_al_u2198_o),
    .e(_al_u2307_o),
    .o(cbus[20]));
  AL_MAP_LUT5 #(
    .EQN("(E*~B*~(~D*~(C*~A)))"),
    .INIT(32'h33100000))
    _al_u2309 (
    .a(_al_u1343_o),
    .b(_al_u1753_o),
    .c(_al_u2203_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2309_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2310 (
    .a(\norm/sglc_r [1]),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2310_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2311 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [6]),
    .o(_al_u2311_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2312 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [6]),
    .o(_al_u2312_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2313 (
    .a(_al_u2309_o),
    .b(_al_u2310_o),
    .c(_al_u2311_o),
    .d(_al_u2198_o),
    .e(_al_u2312_o),
    .o(cbus[1]));
  AL_MAP_LUT5 #(
    .EQN("(E*C*~(~D*~(B*~A)))"),
    .INIT(32'hf0400000))
    _al_u2314 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(\norm/sglc_r [24]),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2314_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2315 (
    .a(_al_u1942_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2315_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2316 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [24]),
    .o(_al_u2316_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2317 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [24]),
    .o(_al_u2317_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2318 (
    .a(_al_u2314_o),
    .b(_al_u2315_o),
    .c(_al_u2316_o),
    .d(_al_u2198_o),
    .e(_al_u2317_o),
    .o(cbus[19]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*~(~D*~(B*~A)))"),
    .INIT(32'h0f040000))
    _al_u2319 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(_al_u1877_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2319_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2320 (
    .a(_al_u1954_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2320_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2321 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [23]),
    .o(_al_u2321_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2322 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [23]),
    .o(_al_u2322_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2323 (
    .a(_al_u2319_o),
    .b(_al_u2320_o),
    .c(_al_u2321_o),
    .d(_al_u2198_o),
    .e(_al_u2322_o),
    .o(cbus[18]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*~(~D*~(B*~A)))"),
    .INIT(32'h0f040000))
    _al_u2324 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(_al_u1892_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2324_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2325 (
    .a(_al_u1967_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2325_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2326 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [22]),
    .o(_al_u2326_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2327 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [22]),
    .o(_al_u2327_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2328 (
    .a(_al_u2324_o),
    .b(_al_u2325_o),
    .c(_al_u2326_o),
    .d(_al_u2198_o),
    .e(_al_u2327_o),
    .o(cbus[17]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*~(~D*~(B*~A)))"),
    .INIT(32'h0f040000))
    _al_u2329 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(_al_u1908_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2329_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2330 (
    .a(_al_u1981_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2330_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2331 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [21]),
    .o(_al_u2331_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2332 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [21]),
    .o(_al_u2332_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2333 (
    .a(_al_u2329_o),
    .b(_al_u2330_o),
    .c(_al_u2331_o),
    .d(_al_u2198_o),
    .e(_al_u2332_o),
    .o(cbus[16]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*~(~D*~(B*~A)))"),
    .INIT(32'h0f040000))
    _al_u2334 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(_al_u1921_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2334_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2335 (
    .a(_al_u1995_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2335_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2336 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [20]),
    .o(_al_u2336_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2337 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [20]),
    .o(_al_u2337_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2338 (
    .a(_al_u2334_o),
    .b(_al_u2335_o),
    .c(_al_u2336_o),
    .d(_al_u2198_o),
    .e(_al_u2337_o),
    .o(cbus[15]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*~(~D*~(B*~A)))"),
    .INIT(32'h0f040000))
    _al_u2339 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(_al_u1942_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2339_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2340 (
    .a(_al_u2008_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2340_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2341 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [19]),
    .o(_al_u2341_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2342 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [19]),
    .o(_al_u2342_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2343 (
    .a(_al_u2339_o),
    .b(_al_u2340_o),
    .c(_al_u2341_o),
    .d(_al_u2198_o),
    .e(_al_u2342_o),
    .o(cbus[14]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*~(~D*~(B*~A)))"),
    .INIT(32'h0f040000))
    _al_u2344 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(_al_u1954_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2344_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2345 (
    .a(_al_u2022_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2345_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2346 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [18]),
    .o(_al_u2346_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2347 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [18]),
    .o(_al_u2347_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2348 (
    .a(_al_u2344_o),
    .b(_al_u2345_o),
    .c(_al_u2346_o),
    .d(_al_u2198_o),
    .e(_al_u2347_o),
    .o(cbus[13]));
  AL_MAP_LUT5 #(
    .EQN("(E*~C*~(~D*~(B*~A)))"),
    .INIT(32'h0f040000))
    _al_u2349 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(_al_u1967_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2349_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2350 (
    .a(\norm/sglc_r [12]),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2350_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2351 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [17]),
    .o(_al_u2351_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2352 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [17]),
    .o(_al_u2352_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2353 (
    .a(_al_u2349_o),
    .b(_al_u2350_o),
    .c(_al_u2351_o),
    .d(_al_u2198_o),
    .e(_al_u2352_o),
    .o(cbus[12]));
  AL_MAP_LUT5 #(
    .EQN("(E*C*~(~D*~(B*~A)))"),
    .INIT(32'hf0400000))
    _al_u2354 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(_al_u1981_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2354_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2355 (
    .a(\norm/sglc_r [11]),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2355_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2356 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [16]),
    .o(_al_u2356_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2357 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [16]),
    .o(_al_u2357_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2358 (
    .a(_al_u2354_o),
    .b(_al_u2355_o),
    .c(_al_u2356_o),
    .d(_al_u2198_o),
    .e(_al_u2357_o),
    .o(cbus[11]));
  AL_MAP_LUT5 #(
    .EQN("(E*C*~(~D*~(B*~A)))"),
    .INIT(32'hf0400000))
    _al_u2359 (
    .a(_al_u1343_o),
    .b(_al_u2203_o),
    .c(_al_u1995_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2359_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*A))"),
    .INIT(8'h4c))
    _al_u2360 (
    .a(_al_u2059_o),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2360_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2361 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [15]),
    .o(_al_u2361_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2362 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [15]),
    .o(_al_u2362_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2363 (
    .a(_al_u2359_o),
    .b(_al_u2360_o),
    .c(_al_u2361_o),
    .d(_al_u2198_o),
    .e(_al_u2362_o),
    .o(cbus[10]));
  AL_MAP_LUT5 #(
    .EQN("(E*B*~(~D*~(C*~A)))"),
    .INIT(32'hcc400000))
    _al_u2364 (
    .a(_al_u1343_o),
    .b(\norm/sglc_r [5]),
    .c(_al_u2203_o),
    .d(_al_u2204_o),
    .e(_al_u2205_o),
    .o(_al_u2364_o));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C*~A))"),
    .INIT(8'h8c))
    _al_u2365 (
    .a(\norm/sglc_r [0]),
    .b(fctl_cbus_out_lutinv),
    .c(fctl_ccmd_int),
    .o(_al_u2365_o));
  AL_MAP_LUT3 #(
    .EQN("(~B*~(C*A))"),
    .INIT(8'h13))
    _al_u2366 (
    .a(_al_u2209_o),
    .b(fctl_ccmd_int),
    .c(\norm/sglc_f [5]),
    .o(_al_u2366_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u2367 (
    .a(fctl_ccmd_hlf),
    .b(\norm/sglc_f [5]),
    .o(_al_u2367_o));
  AL_MAP_LUT5 #(
    .EQN("(B*~(C*~(D*~(~E*~A))))"),
    .INIT(32'hcc0c8c0c))
    _al_u2368 (
    .a(_al_u2364_o),
    .b(_al_u2365_o),
    .c(_al_u2366_o),
    .d(_al_u2198_o),
    .e(_al_u2367_o),
    .o(cbus[0]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u2369 (
    .a(\fdiv/fdiv/rem4 [26]),
    .o(\fdiv/quo [4]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u2370 (
    .a(\fdiv/fdiv/rem3 [26]),
    .o(\fdiv/quo [3]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u2371 (
    .a(\fdiv/fdiv/rem2 [26]),
    .o(\fdiv/quo [2]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u2372 (
    .a(\fdiv/fdiv/rem1 [26]),
    .o(\fdiv/quo [1]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u2373 (
    .a(\fdiv/rem [25]),
    .o(\fdiv/quo [0]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    _al_u2374 (
    .a(\fdiv/fquo [19]),
    .o(\fdiv/n19 ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u813 (
    .a(fctl_ccmd_add),
    .b(sgla_r[0]),
    .o(\fadd/sgla_f [0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u814 (
    .a(fctl_ccmd_add),
    .b(sgla_r[1]),
    .o(\fadd/sgla_f [1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u815 (
    .a(fctl_ccmd_add),
    .b(sgla_r[10]),
    .o(\fadd/sgla_f [10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u816 (
    .a(fctl_ccmd_add),
    .b(sgla_r[11]),
    .o(\fadd/sgla_f [11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u817 (
    .a(fctl_ccmd_add),
    .b(sgla_r[12]),
    .o(\fadd/sgla_f [12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u818 (
    .a(fctl_ccmd_add),
    .b(sgla_r[13]),
    .o(\fadd/sgla_f [13]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u819 (
    .a(fctl_ccmd_add),
    .b(sgla_r[14]),
    .o(\fadd/sgla_f [14]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u820 (
    .a(fctl_ccmd_add),
    .b(sgla_r[15]),
    .o(\fadd/sgla_f [15]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u821 (
    .a(fctl_ccmd_add),
    .b(sgla_r[16]),
    .o(\fadd/sgla_f [16]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u822 (
    .a(fctl_ccmd_add),
    .b(sgla_r[17]),
    .o(\fadd/sgla_f [17]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u823 (
    .a(fctl_ccmd_add),
    .b(sgla_r[18]),
    .o(\fadd/sgla_f [18]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u824 (
    .a(fctl_ccmd_add),
    .b(sgla_r[19]),
    .o(\fadd/sgla_f [19]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u825 (
    .a(fctl_ccmd_add),
    .b(sgla_r[2]),
    .o(\fadd/sgla_f [2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u826 (
    .a(fctl_ccmd_add),
    .b(sgla_r[20]),
    .o(\fadd/sgla_f [20]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u827 (
    .a(fctl_ccmd_add),
    .b(sgla_r[21]),
    .o(\fadd/sgla_f [21]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u828 (
    .a(fctl_ccmd_add),
    .b(sgla_r[22]),
    .o(\fadd/sgla_f [22]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u829 (
    .a(fctl_ccmd_add),
    .b(sgla_r[23]),
    .o(\fadd/sgla_f [23]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u830 (
    .a(fctl_ccmd_add),
    .b(sgla_r[24]),
    .o(\fadd/sgla_f [24]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u831 (
    .a(fctl_ccmd_add),
    .b(sgla_r[25]),
    .o(\fadd/sgla_f [25]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u832 (
    .a(fctl_ccmd_add),
    .b(sgla_r[26]),
    .o(\fadd/sgla_f [26]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u833 (
    .a(fctl_ccmd_add),
    .b(sgla_r[27]),
    .o(\fadd/sgla_f [27]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u834 (
    .a(fctl_ccmd_add),
    .b(sgla_r[28]),
    .o(\fadd/sgla_f [28]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u835 (
    .a(fctl_ccmd_add),
    .b(sgla_r[29]),
    .o(\fadd/sgla_f [29]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u836 (
    .a(fctl_ccmd_add),
    .b(sgla_r[3]),
    .o(\fadd/sgla_f [3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u837 (
    .a(fctl_ccmd_add),
    .b(sgla_r[30]),
    .o(\fadd/sgla_f [30]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u838 (
    .a(fctl_ccmd_add),
    .b(sgla_r[31]),
    .o(\fadd/sgla_f [31]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u839 (
    .a(fctl_ccmd_add),
    .b(sgla_r[4]),
    .o(\fadd/sgla_f [4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u840 (
    .a(fctl_ccmd_add),
    .b(sgla_r[5]),
    .o(\fadd/sgla_f [5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u841 (
    .a(fctl_ccmd_add),
    .b(sgla_r[6]),
    .o(\fadd/sgla_f [6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u842 (
    .a(fctl_ccmd_add),
    .b(sgla_r[7]),
    .o(\fadd/sgla_f [7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u843 (
    .a(fctl_ccmd_add),
    .b(sgla_r[8]),
    .o(\fadd/sgla_f [8]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u844 (
    .a(fctl_ccmd_add),
    .b(sgla_r[9]),
    .o(\fadd/sgla_f [9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u845 (
    .a(fctl_ccmd_add),
    .b(sglb_r[0]),
    .o(\fadd/sglb_f [0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u846 (
    .a(fctl_ccmd_add),
    .b(sglb_r[1]),
    .o(\fadd/sglb_f [1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u847 (
    .a(fctl_ccmd_add),
    .b(sglb_r[10]),
    .o(\fadd/sglb_f [10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u848 (
    .a(fctl_ccmd_add),
    .b(sglb_r[11]),
    .o(\fadd/sglb_f [11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u849 (
    .a(fctl_ccmd_add),
    .b(sglb_r[12]),
    .o(\fadd/sglb_f [12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u850 (
    .a(fctl_ccmd_add),
    .b(sglb_r[13]),
    .o(\fadd/sglb_f [13]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u851 (
    .a(fctl_ccmd_add),
    .b(sglb_r[14]),
    .o(\fadd/sglb_f [14]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u852 (
    .a(fctl_ccmd_add),
    .b(sglb_r[15]),
    .o(\fadd/sglb_f [15]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u853 (
    .a(fctl_ccmd_add),
    .b(sglb_r[16]),
    .o(\fadd/sglb_f [16]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u854 (
    .a(fctl_ccmd_add),
    .b(sglb_r[17]),
    .o(\fadd/sglb_f [17]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u855 (
    .a(fctl_ccmd_add),
    .b(sglb_r[18]),
    .o(\fadd/sglb_f [18]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u856 (
    .a(fctl_ccmd_add),
    .b(sglb_r[19]),
    .o(\fadd/sglb_f [19]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u857 (
    .a(fctl_ccmd_add),
    .b(sglb_r[2]),
    .o(\fadd/sglb_f [2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u858 (
    .a(fctl_ccmd_add),
    .b(sglb_r[20]),
    .o(\fadd/sglb_f [20]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u859 (
    .a(fctl_ccmd_add),
    .b(sglb_r[21]),
    .o(\fadd/sglb_f [21]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u860 (
    .a(fctl_ccmd_add),
    .b(sglb_r[22]),
    .o(\fadd/sglb_f [22]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u861 (
    .a(fctl_ccmd_add),
    .b(sglb_r[23]),
    .o(\fadd/sglb_f [23]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u862 (
    .a(fctl_ccmd_add),
    .b(sglb_r[24]),
    .o(\fadd/sglb_f [24]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u863 (
    .a(fctl_ccmd_add),
    .b(sglb_r[25]),
    .o(\fadd/sglb_f [25]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u864 (
    .a(fctl_ccmd_add),
    .b(sglb_r[26]),
    .o(\fadd/sglb_f [26]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u865 (
    .a(fctl_ccmd_add),
    .b(sglb_r[27]),
    .o(\fadd/sglb_f [27]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u866 (
    .a(fctl_ccmd_add),
    .b(sglb_r[28]),
    .o(\fadd/sglb_f [28]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u867 (
    .a(fctl_ccmd_add),
    .b(sglb_r[29]),
    .o(\fadd/sglb_f [29]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u868 (
    .a(fctl_ccmd_add),
    .b(sglb_r[3]),
    .o(\fadd/sglb_f [3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u869 (
    .a(fctl_ccmd_add),
    .b(sglb_r[4]),
    .o(\fadd/sglb_f [4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u870 (
    .a(fctl_ccmd_add),
    .b(sglb_r[5]),
    .o(\fadd/sglb_f [5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u871 (
    .a(fctl_ccmd_add),
    .b(sglb_r[6]),
    .o(\fadd/sglb_f [6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u872 (
    .a(fctl_ccmd_add),
    .b(sglb_r[7]),
    .o(\fadd/sglb_f [7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u873 (
    .a(fctl_ccmd_add),
    .b(sglb_r[8]),
    .o(\fadd/sglb_f [8]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u874 (
    .a(fctl_ccmd_add),
    .b(sglb_r[9]),
    .o(\fadd/sglb_f [9]));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    _al_u875 (
    .a(fctl_ccmd_sub),
    .b(\sglb/sglb_i [31]),
    .o(sglb_r[41]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u876 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[9]),
    .o(sfpu_dsp_b[4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u877 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[8]),
    .o(sfpu_dsp_b[3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u878 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[7]),
    .o(sfpu_dsp_b[2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u879 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[6]),
    .o(sfpu_dsp_b[1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u880 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[5]),
    .o(sfpu_dsp_b[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u881 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[28]),
    .o(sfpu_dsp_b[23]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u882 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[27]),
    .o(sfpu_dsp_b[22]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u883 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[26]),
    .o(sfpu_dsp_b[21]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u884 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[25]),
    .o(sfpu_dsp_b[20]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u885 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[24]),
    .o(sfpu_dsp_b[19]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u886 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[23]),
    .o(sfpu_dsp_b[18]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u887 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[22]),
    .o(sfpu_dsp_b[17]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u888 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[21]),
    .o(sfpu_dsp_b[16]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u889 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[20]),
    .o(sfpu_dsp_b[15]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u890 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[19]),
    .o(sfpu_dsp_b[14]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u891 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[18]),
    .o(sfpu_dsp_b[13]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u892 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[17]),
    .o(sfpu_dsp_b[12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u893 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[16]),
    .o(sfpu_dsp_b[11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u894 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[15]),
    .o(sfpu_dsp_b[10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u895 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[14]),
    .o(sfpu_dsp_b[9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u896 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[13]),
    .o(sfpu_dsp_b[8]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u897 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[12]),
    .o(sfpu_dsp_b[7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u898 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[11]),
    .o(sfpu_dsp_b[6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u899 (
    .a(fctl_ccmd_mul),
    .b(sglb_r[10]),
    .o(sfpu_dsp_b[5]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u900 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[9]),
    .o(sfpu_dsp_a[4]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u901 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[8]),
    .o(sfpu_dsp_a[3]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u902 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[7]),
    .o(sfpu_dsp_a[2]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u903 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[6]),
    .o(sfpu_dsp_a[1]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u904 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[5]),
    .o(sfpu_dsp_a[0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u905 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[28]),
    .o(sfpu_dsp_a[23]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u906 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[27]),
    .o(sfpu_dsp_a[22]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u907 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[26]),
    .o(sfpu_dsp_a[21]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u908 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[25]),
    .o(sfpu_dsp_a[20]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u909 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[24]),
    .o(sfpu_dsp_a[19]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u910 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[23]),
    .o(sfpu_dsp_a[18]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u911 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[22]),
    .o(sfpu_dsp_a[17]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u912 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[21]),
    .o(sfpu_dsp_a[16]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u913 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[20]),
    .o(sfpu_dsp_a[15]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u914 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[19]),
    .o(sfpu_dsp_a[14]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u915 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[18]),
    .o(sfpu_dsp_a[13]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u916 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[17]),
    .o(sfpu_dsp_a[12]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u917 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[16]),
    .o(sfpu_dsp_a[11]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u918 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[15]),
    .o(sfpu_dsp_a[10]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u919 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[14]),
    .o(sfpu_dsp_a[9]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u920 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[13]),
    .o(sfpu_dsp_a[8]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u921 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[12]),
    .o(sfpu_dsp_a[7]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u922 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[11]),
    .o(sfpu_dsp_a[6]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u923 (
    .a(fctl_ccmd_mul),
    .b(sgla_r[10]),
    .o(sfpu_dsp_a[5]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    _al_u924 (
    .a(sglb_r[41]),
    .b(sgla_r[41]),
    .o(_al_u924_o));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u925 (
    .a(\fadd/n2 [9]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [9]),
    .o(\fadd/n3 [9]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u926 (
    .a(\fadd/n2 [8]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [8]),
    .o(\fadd/n3 [8]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u927 (
    .a(\fadd/n2 [7]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [7]),
    .o(\fadd/n3 [7]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u928 (
    .a(\fadd/n2 [6]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [6]),
    .o(\fadd/n3 [6]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u929 (
    .a(\fadd/n2 [5]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [5]),
    .o(\fadd/n3 [5]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u930 (
    .a(\fadd/n2 [4]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [4]),
    .o(\fadd/n3 [4]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u931 (
    .a(\fadd/n2 [31]),
    .b(_al_u924_o),
    .o(\fadd/n3 [31]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    _al_u932 (
    .a(\fadd/n2 [30]),
    .b(_al_u924_o),
    .o(\fadd/n3 [30]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u933 (
    .a(\fadd/n2 [3]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [3]),
    .o(\fadd/n3 [3]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u934 (
    .a(\fadd/n2 [29]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [29]),
    .o(\fadd/n3 [29]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u935 (
    .a(\fadd/n2 [28]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [28]),
    .o(\fadd/n3 [28]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u936 (
    .a(\fadd/n2 [27]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [27]),
    .o(\fadd/n3 [27]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u937 (
    .a(\fadd/n2 [26]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [26]),
    .o(\fadd/n3 [26]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u938 (
    .a(\fadd/n2 [25]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [25]),
    .o(\fadd/n3 [25]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u939 (
    .a(\fadd/n2 [24]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [24]),
    .o(\fadd/n3 [24]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u940 (
    .a(\fadd/n2 [23]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [23]),
    .o(\fadd/n3 [23]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u941 (
    .a(\fadd/n2 [22]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [22]),
    .o(\fadd/n3 [22]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u942 (
    .a(\fadd/n2 [21]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [21]),
    .o(\fadd/n3 [21]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u943 (
    .a(\fadd/n2 [20]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [20]),
    .o(\fadd/n3 [20]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u944 (
    .a(\fadd/n2 [2]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [2]),
    .o(\fadd/n3 [2]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u945 (
    .a(\fadd/n2 [19]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [19]),
    .o(\fadd/n3 [19]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u946 (
    .a(\fadd/n2 [18]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [18]),
    .o(\fadd/n3 [18]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u947 (
    .a(\fadd/n2 [17]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [17]),
    .o(\fadd/n3 [17]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u948 (
    .a(\fadd/n2 [16]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [16]),
    .o(\fadd/n3 [16]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u949 (
    .a(\fadd/n2 [15]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [15]),
    .o(\fadd/n3 [15]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u950 (
    .a(\fadd/n2 [14]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [14]),
    .o(\fadd/n3 [14]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u951 (
    .a(\fadd/n2 [13]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [13]),
    .o(\fadd/n3 [13]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u952 (
    .a(\fadd/n2 [12]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [12]),
    .o(\fadd/n3 [12]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u953 (
    .a(\fadd/n2 [11]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [11]),
    .o(\fadd/n3 [11]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u954 (
    .a(\fadd/n2 [10]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [10]),
    .o(\fadd/n3 [10]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u955 (
    .a(\fadd/n2 [1]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [1]),
    .o(\fadd/n3 [1]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    _al_u956 (
    .a(\fadd/n2 [0]),
    .b(_al_u924_o),
    .c(\fadd/sglb_f [0]),
    .o(\fadd/n3 [0]));
  AL_MAP_LUT5 #(
    .EQN("(E*(A*B*C*~(D)+~(A)*~(B)*~(C)*D))"),
    .INIT(32'h01800000))
    _al_u957 (
    .a(\sgla/ccmd_f [0]),
    .b(\sgla/ccmd_f [1]),
    .c(\sgla/ccmd_f [2]),
    .d(\sgla/ccmd_f [3]),
    .e(\sgla/ccmd_f [4]),
    .o(_al_u957_o));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u958 (
    .a(_al_u957_o),
    .b(sglb_e[4]),
    .o(\sgla/sglb_et [4]));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u959 (
    .a(_al_u957_o),
    .b(sglb_e[3]),
    .o(\sgla/sglb_et [3]));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    _al_u960 (
    .a(_al_u957_o),
    .b(sglb_e[2]),
    .o(\sgla/sglb_et [2]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u961 (
    .a(_al_u957_o),
    .b(sglb_e[1]),
    .o(\sgla/sglb_et [1]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    _al_u962 (
    .a(_al_u957_o),
    .b(sglb_e[0]),
    .o(\sgla/sglb_et [0]));
  AL_MAP_LUT5 #(
    .EQN("(~E*D*C*~B*A)"),
    .INIT(32'h00002000))
    _al_u963 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\fctl/n17 ));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*~B*A)"),
    .INIT(32'h00000020))
    _al_u964 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\fctl/n16 ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*~B*A)"),
    .INIT(32'h02000000))
    _al_u965 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\fctl/n15 ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*B*A)"),
    .INIT(32'h08000000))
    _al_u966 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\fctl/n9 ));
  AL_MAP_LUT5 #(
    .EQN("(D*~C*A*~(E@B))"),
    .INIT(32'h08000200))
    _al_u967 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\fctl/n13 ));
  AL_MAP_LUT5 #(
    .EQN("(A*(B*~(C)*~(D)*~(E)+~(B)*C*D*E))"),
    .INIT(32'h20000008))
    _al_u968 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\fctl/n33 ));
  AL_MAP_LUT5 #(
    .EQN("(~C*A*(~(B)*D*~(E)+~(B)*~(D)*E+B*D*E))"),
    .INIT(32'h08020200))
    _al_u969 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\fctl/n10 ));
  AL_MAP_LUT5 #(
    .EQN("(E*D*~C*~B*~A)"),
    .INIT(32'h01000000))
    _al_u970 (
    .a(\sgla/ccmd_f [0]),
    .b(\sgla/ccmd_f [1]),
    .c(\sgla/ccmd_f [2]),
    .d(\sgla/ccmd_f [3]),
    .e(\sgla/ccmd_f [4]),
    .o(_al_u970_o));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*~B))"),
    .INIT(8'hba))
    _al_u971 (
    .a(_al_u970_o),
    .b(_al_u957_o),
    .c(sglb_e[8]),
    .o(\sgla/sglb_et [8]));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*~B))"),
    .INIT(8'hba))
    _al_u972 (
    .a(_al_u970_o),
    .b(_al_u957_o),
    .c(sglb_e[7]),
    .o(\sgla/sglb_et [7]));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*~B))"),
    .INIT(8'hba))
    _al_u973 (
    .a(_al_u970_o),
    .b(_al_u957_o),
    .c(sglb_e[6]),
    .o(\sgla/sglb_et [6]));
  AL_MAP_LUT3 #(
    .EQN("~(~A*~(C*~B))"),
    .INIT(8'hba))
    _al_u974 (
    .a(_al_u970_o),
    .b(_al_u957_o),
    .c(sglb_e[5]),
    .o(\sgla/sglb_et [5]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u975 (
    .a(\sgla/sgla_i [10]),
    .b(\sgla/sgla_i [12]),
    .c(\sgla/sgla_i [15]),
    .d(\sgla/sgla_i [9]),
    .o(_al_u975_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*A)"),
    .INIT(16'h0002))
    _al_u976 (
    .a(_al_u975_o),
    .b(\sgla/sgla_i [13]),
    .c(\sgla/sgla_i [14]),
    .d(\sgla/sgla_i [8]),
    .o(_al_u976_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u977 (
    .a(\sgla/sgla_i [4]),
    .b(\sgla/sgla_i [5]),
    .c(\sgla/sgla_i [6]),
    .d(\sgla/sgla_i [7]),
    .o(_al_u977_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u978 (
    .a(_al_u977_o),
    .b(\sgla/sgla_i [0]),
    .c(\sgla/sgla_i [1]),
    .d(\sgla/sgla_i [2]),
    .e(\sgla/sgla_i [3]),
    .o(_al_u978_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u979 (
    .a(\sgla/sgla_i [17]),
    .b(\sgla/sgla_i [18]),
    .c(\sgla/sgla_i [19]),
    .d(\sgla/sgla_i [22]),
    .o(_al_u979_o));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    _al_u980 (
    .a(_al_u979_o),
    .b(\sgla/sgla_i [20]),
    .c(\sgla/sgla_i [21]),
    .o(_al_u980_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*C*B*A)"),
    .INIT(32'h00000080))
    _al_u981 (
    .a(_al_u976_o),
    .b(_al_u978_o),
    .c(_al_u980_o),
    .d(\sgla/sgla_i [11]),
    .e(\sgla/sgla_i [16]),
    .o(\sgla/n131_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u982 (
    .a(\sgla/sgla_i [23]),
    .b(\sgla/sgla_i [24]),
    .c(\sgla/sgla_i [25]),
    .d(\sgla/sgla_i [26]),
    .o(_al_u982_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u983 (
    .a(_al_u982_o),
    .b(\sgla/sgla_i [27]),
    .c(\sgla/sgla_i [28]),
    .d(\sgla/sgla_i [29]),
    .e(\sgla/sgla_i [30]),
    .o(\sgla/n182_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u984 (
    .a(\sgla/n131_lutinv ),
    .b(\sgla/n182_lutinv ),
    .o(sgla_r[43]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u985 (
    .a(\sglb/sglb_i [16]),
    .b(\sglb/sglb_i [17]),
    .c(\sglb/sglb_i [18]),
    .d(\sglb/sglb_i [19]),
    .o(_al_u985_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u986 (
    .a(_al_u985_o),
    .b(\sglb/sglb_i [2]),
    .c(\sglb/sglb_i [20]),
    .d(\sglb/sglb_i [21]),
    .e(\sglb/sglb_i [22]),
    .o(_al_u986_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u987 (
    .a(\sglb/sglb_i [3]),
    .b(\sglb/sglb_i [4]),
    .c(\sglb/sglb_i [5]),
    .d(\sglb/sglb_i [6]),
    .o(_al_u987_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*B*A)"),
    .INIT(32'h00000008))
    _al_u988 (
    .a(_al_u986_o),
    .b(_al_u987_o),
    .c(\sglb/sglb_i [7]),
    .d(\sglb/sglb_i [8]),
    .e(\sglb/sglb_i [9]),
    .o(_al_u988_o));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u989 (
    .a(\sglb/sglb_i [0]),
    .b(\sglb/sglb_i [1]),
    .c(\sglb/sglb_i [10]),
    .d(\sglb/sglb_i [11]),
    .o(_al_u989_o));
  AL_MAP_LUT5 #(
    .EQN("(~E*~D*~C*~B*A)"),
    .INIT(32'h00000002))
    _al_u990 (
    .a(_al_u989_o),
    .b(\sglb/sglb_i [12]),
    .c(\sglb/sglb_i [13]),
    .d(\sglb/sglb_i [14]),
    .e(\sglb/sglb_i [15]),
    .o(_al_u990_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u991 (
    .a(_al_u988_o),
    .b(_al_u990_o),
    .o(\sglb/n110_lutinv ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    _al_u992 (
    .a(\sglb/sglb_i [27]),
    .b(\sglb/sglb_i [28]),
    .c(\sglb/sglb_i [29]),
    .d(\sglb/sglb_i [30]),
    .o(_al_u992_o));
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    _al_u993 (
    .a(_al_u992_o),
    .b(\sglb/sglb_i [23]),
    .c(\sglb/sglb_i [24]),
    .d(\sglb/sglb_i [25]),
    .e(\sglb/sglb_i [26]),
    .o(\sglb/n107_lutinv ));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u994 (
    .a(\sglb/n110_lutinv ),
    .b(\sglb/n107_lutinv ),
    .o(sglb_r[43]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    _al_u995 (
    .a(\fctl/stat [0]),
    .b(\fctl/stat [1]),
    .c(\fctl/stat [2]),
    .d(\fctl/stat [3]),
    .o(_al_u995_o));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    _al_u996 (
    .a(ccmd[4]),
    .b(_al_u995_o),
    .o(_al_u996_o));
  AL_MAP_LUT5 #(
    .EQN("(A*(~(B)*~(C)*~((~E*~D))+B*~(C)*~((~E*~D))+~(B)*C*~((~E*~D))+B*~(C)*(~E*~D)+~(B)*C*(~E*~D)+B*C*(~E*~D)))"),
    .INIT(32'h2a2a2aa8))
    _al_u997 (
    .a(_al_u996_o),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(fctl_load_a));
  AL_MAP_LUT5 #(
    .EQN("(A*(B*~(C)*~(D)*~(E)+B*C*~(D)*~(E)+B*~(C)*D*~(E)+~(B)*C*D*~(E)+B*~(C)*~(D)*E+~(B)*C*~(D)*E+~(B)*C*D*E))"),
    .INIT(32'h20282888))
    _al_u998 (
    .a(ccmd[4]),
    .b(ccmd[3]),
    .c(ccmd[2]),
    .d(ccmd[1]),
    .e(ccmd[0]),
    .o(\fctl/n29 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    _al_u999 (
    .a(\norm/sglc_f [30]),
    .b(\norm/sglc_f [31]),
    .o(\norm/mux27_b30_sel_is_0_o ));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u0  (
    .a(\fadd/sgla_f [0]),
    .b(\fadd/n3 [0]),
    .c(\fadd/add0/c0 ),
    .o({\fadd/add0/c1 ,\fadd/sglc_f_t [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u1  (
    .a(\fadd/sgla_f [1]),
    .b(\fadd/n3 [1]),
    .c(\fadd/add0/c1 ),
    .o({\fadd/add0/c2 ,\fadd/sglc_f_t [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u10  (
    .a(\fadd/sgla_f [10]),
    .b(\fadd/n3 [10]),
    .c(\fadd/add0/c10 ),
    .o({\fadd/add0/c11 ,\fadd/sglc_f_t [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u11  (
    .a(\fadd/sgla_f [11]),
    .b(\fadd/n3 [11]),
    .c(\fadd/add0/c11 ),
    .o({\fadd/add0/c12 ,\fadd/sglc_f_t [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u12  (
    .a(\fadd/sgla_f [12]),
    .b(\fadd/n3 [12]),
    .c(\fadd/add0/c12 ),
    .o({\fadd/add0/c13 ,\fadd/sglc_f_t [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u13  (
    .a(\fadd/sgla_f [13]),
    .b(\fadd/n3 [13]),
    .c(\fadd/add0/c13 ),
    .o({\fadd/add0/c14 ,\fadd/sglc_f_t [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u14  (
    .a(\fadd/sgla_f [14]),
    .b(\fadd/n3 [14]),
    .c(\fadd/add0/c14 ),
    .o({\fadd/add0/c15 ,\fadd/sglc_f_t [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u15  (
    .a(\fadd/sgla_f [15]),
    .b(\fadd/n3 [15]),
    .c(\fadd/add0/c15 ),
    .o({\fadd/add0/c16 ,\fadd/sglc_f_t [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u16  (
    .a(\fadd/sgla_f [16]),
    .b(\fadd/n3 [16]),
    .c(\fadd/add0/c16 ),
    .o({\fadd/add0/c17 ,\fadd/sglc_f_t [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u17  (
    .a(\fadd/sgla_f [17]),
    .b(\fadd/n3 [17]),
    .c(\fadd/add0/c17 ),
    .o({\fadd/add0/c18 ,\fadd/sglc_f_t [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u18  (
    .a(\fadd/sgla_f [18]),
    .b(\fadd/n3 [18]),
    .c(\fadd/add0/c18 ),
    .o({\fadd/add0/c19 ,\fadd/sglc_f_t [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u19  (
    .a(\fadd/sgla_f [19]),
    .b(\fadd/n3 [19]),
    .c(\fadd/add0/c19 ),
    .o({\fadd/add0/c20 ,\fadd/sglc_f_t [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u2  (
    .a(\fadd/sgla_f [2]),
    .b(\fadd/n3 [2]),
    .c(\fadd/add0/c2 ),
    .o({\fadd/add0/c3 ,\fadd/sglc_f_t [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u20  (
    .a(\fadd/sgla_f [20]),
    .b(\fadd/n3 [20]),
    .c(\fadd/add0/c20 ),
    .o({\fadd/add0/c21 ,\fadd/sglc_f_t [20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u21  (
    .a(\fadd/sgla_f [21]),
    .b(\fadd/n3 [21]),
    .c(\fadd/add0/c21 ),
    .o({\fadd/add0/c22 ,\fadd/sglc_f_t [21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u22  (
    .a(\fadd/sgla_f [22]),
    .b(\fadd/n3 [22]),
    .c(\fadd/add0/c22 ),
    .o({\fadd/add0/c23 ,\fadd/sglc_f_t [22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u23  (
    .a(\fadd/sgla_f [23]),
    .b(\fadd/n3 [23]),
    .c(\fadd/add0/c23 ),
    .o({\fadd/add0/c24 ,\fadd/sglc_f_t [23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u24  (
    .a(\fadd/sgla_f [24]),
    .b(\fadd/n3 [24]),
    .c(\fadd/add0/c24 ),
    .o({\fadd/add0/c25 ,\fadd/sglc_f_t [24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u25  (
    .a(\fadd/sgla_f [25]),
    .b(\fadd/n3 [25]),
    .c(\fadd/add0/c25 ),
    .o({\fadd/add0/c26 ,\fadd/sglc_f_t [25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u26  (
    .a(\fadd/sgla_f [26]),
    .b(\fadd/n3 [26]),
    .c(\fadd/add0/c26 ),
    .o({\fadd/add0/c27 ,\fadd/sglc_f_t [26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u27  (
    .a(\fadd/sgla_f [27]),
    .b(\fadd/n3 [27]),
    .c(\fadd/add0/c27 ),
    .o({\fadd/add0/c28 ,\fadd/sglc_f_t [27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u28  (
    .a(\fadd/sgla_f [28]),
    .b(\fadd/n3 [28]),
    .c(\fadd/add0/c28 ),
    .o({\fadd/add0/c29 ,\fadd/sglc_f_t [28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u29  (
    .a(\fadd/sgla_f [29]),
    .b(\fadd/n3 [29]),
    .c(\fadd/add0/c29 ),
    .o({\fadd/add0/c30 ,\fadd/sglc_f_t [29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u3  (
    .a(\fadd/sgla_f [3]),
    .b(\fadd/n3 [3]),
    .c(\fadd/add0/c3 ),
    .o({\fadd/add0/c4 ,\fadd/sglc_f_t [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u30  (
    .a(\fadd/sgla_f [30]),
    .b(\fadd/n3 [30]),
    .c(\fadd/add0/c30 ),
    .o({\fadd/add0/c31 ,\fadd/sglc_f_t [30]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u31  (
    .a(\fadd/sgla_f [31]),
    .b(\fadd/n3 [31]),
    .c(\fadd/add0/c31 ),
    .o({open_n0,\fadd/sglc_f_t [31]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u4  (
    .a(\fadd/sgla_f [4]),
    .b(\fadd/n3 [4]),
    .c(\fadd/add0/c4 ),
    .o({\fadd/add0/c5 ,\fadd/sglc_f_t [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u5  (
    .a(\fadd/sgla_f [5]),
    .b(\fadd/n3 [5]),
    .c(\fadd/add0/c5 ),
    .o({\fadd/add0/c6 ,\fadd/sglc_f_t [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u6  (
    .a(\fadd/sgla_f [6]),
    .b(\fadd/n3 [6]),
    .c(\fadd/add0/c6 ),
    .o({\fadd/add0/c7 ,\fadd/sglc_f_t [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u7  (
    .a(\fadd/sgla_f [7]),
    .b(\fadd/n3 [7]),
    .c(\fadd/add0/c7 ),
    .o({\fadd/add0/c8 ,\fadd/sglc_f_t [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u8  (
    .a(\fadd/sgla_f [8]),
    .b(\fadd/n3 [8]),
    .c(\fadd/add0/c8 ),
    .o({\fadd/add0/c9 ,\fadd/sglc_f_t [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fadd/add0/u9  (
    .a(\fadd/sgla_f [9]),
    .b(\fadd/n3 [9]),
    .c(\fadd/add0/c9 ),
    .o({\fadd/add0/c10 ,\fadd/sglc_f_t [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \fadd/add0/ucin  (
    .a(1'b0),
    .o({\fadd/add0/c0 ,open_n3}));
  AL_MAP_LUT4 #(
    .EQN("(A*B*~C*~D+A*B*C*~D+~A*~B*C*D+A*~B*C*D+A*B*C*D)"),
    .INIT(16'b1011000010001000))
    \fadd/mux2_rom0  (
    .a(sglb_r[41]),
    .b(sglb_r[43]),
    .c(sgla_r[41]),
    .d(sgla_r[43]),
    .o(\fadd/inf_s ));
  AL_MAP_LUT4 #(
    .EQN("(A*B*~C*D+~A*B*C*D)"),
    .INIT(16'b0100100000000000))
    \fadd/mux3_rom0  (
    .a(sglb_r[41]),
    .b(sglb_r[43]),
    .c(sgla_r[41]),
    .d(sgla_r[43]),
    .o(\fadd/inf_nan ));
  AL_MAP_LUT4 #(
    .EQN("(~A*B*~C*~D+A*B*~C*~D+~A*B*C*~D+A*B*C*~D+~A*~B*~C*D+A*~B*~C*D+~A*B*~C*D+~A*~B*C*D+A*~B*C*D+A*B*C*D)"),
    .INIT(16'b1011011111001100))
    \fadd/mux4_rom0  (
    .a(sglb_r[41]),
    .b(sglb_r[43]),
    .c(sgla_r[41]),
    .d(sgla_r[43]),
    .o(sglc_r_fadd[43]));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u0  (
    .a(1'b0),
    .b(\fadd/sglb_f [0]),
    .c(\fadd/neg0/c0 ),
    .o({\fadd/neg0/c1 ,\fadd/n2 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u1  (
    .a(1'b0),
    .b(\fadd/sglb_f [1]),
    .c(\fadd/neg0/c1 ),
    .o({\fadd/neg0/c2 ,\fadd/n2 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u10  (
    .a(1'b0),
    .b(\fadd/sglb_f [10]),
    .c(\fadd/neg0/c10 ),
    .o({\fadd/neg0/c11 ,\fadd/n2 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u11  (
    .a(1'b0),
    .b(\fadd/sglb_f [11]),
    .c(\fadd/neg0/c11 ),
    .o({\fadd/neg0/c12 ,\fadd/n2 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u12  (
    .a(1'b0),
    .b(\fadd/sglb_f [12]),
    .c(\fadd/neg0/c12 ),
    .o({\fadd/neg0/c13 ,\fadd/n2 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u13  (
    .a(1'b0),
    .b(\fadd/sglb_f [13]),
    .c(\fadd/neg0/c13 ),
    .o({\fadd/neg0/c14 ,\fadd/n2 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u14  (
    .a(1'b0),
    .b(\fadd/sglb_f [14]),
    .c(\fadd/neg0/c14 ),
    .o({\fadd/neg0/c15 ,\fadd/n2 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u15  (
    .a(1'b0),
    .b(\fadd/sglb_f [15]),
    .c(\fadd/neg0/c15 ),
    .o({\fadd/neg0/c16 ,\fadd/n2 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u16  (
    .a(1'b0),
    .b(\fadd/sglb_f [16]),
    .c(\fadd/neg0/c16 ),
    .o({\fadd/neg0/c17 ,\fadd/n2 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u17  (
    .a(1'b0),
    .b(\fadd/sglb_f [17]),
    .c(\fadd/neg0/c17 ),
    .o({\fadd/neg0/c18 ,\fadd/n2 [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u18  (
    .a(1'b0),
    .b(\fadd/sglb_f [18]),
    .c(\fadd/neg0/c18 ),
    .o({\fadd/neg0/c19 ,\fadd/n2 [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u19  (
    .a(1'b0),
    .b(\fadd/sglb_f [19]),
    .c(\fadd/neg0/c19 ),
    .o({\fadd/neg0/c20 ,\fadd/n2 [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u2  (
    .a(1'b0),
    .b(\fadd/sglb_f [2]),
    .c(\fadd/neg0/c2 ),
    .o({\fadd/neg0/c3 ,\fadd/n2 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u20  (
    .a(1'b0),
    .b(\fadd/sglb_f [20]),
    .c(\fadd/neg0/c20 ),
    .o({\fadd/neg0/c21 ,\fadd/n2 [20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u21  (
    .a(1'b0),
    .b(\fadd/sglb_f [21]),
    .c(\fadd/neg0/c21 ),
    .o({\fadd/neg0/c22 ,\fadd/n2 [21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u22  (
    .a(1'b0),
    .b(\fadd/sglb_f [22]),
    .c(\fadd/neg0/c22 ),
    .o({\fadd/neg0/c23 ,\fadd/n2 [22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u23  (
    .a(1'b0),
    .b(\fadd/sglb_f [23]),
    .c(\fadd/neg0/c23 ),
    .o({\fadd/neg0/c24 ,\fadd/n2 [23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u24  (
    .a(1'b0),
    .b(\fadd/sglb_f [24]),
    .c(\fadd/neg0/c24 ),
    .o({\fadd/neg0/c25 ,\fadd/n2 [24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u25  (
    .a(1'b0),
    .b(\fadd/sglb_f [25]),
    .c(\fadd/neg0/c25 ),
    .o({\fadd/neg0/c26 ,\fadd/n2 [25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u26  (
    .a(1'b0),
    .b(\fadd/sglb_f [26]),
    .c(\fadd/neg0/c26 ),
    .o({\fadd/neg0/c27 ,\fadd/n2 [26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u27  (
    .a(1'b0),
    .b(\fadd/sglb_f [27]),
    .c(\fadd/neg0/c27 ),
    .o({\fadd/neg0/c28 ,\fadd/n2 [27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u28  (
    .a(1'b0),
    .b(\fadd/sglb_f [28]),
    .c(\fadd/neg0/c28 ),
    .o({\fadd/neg0/c29 ,\fadd/n2 [28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u29  (
    .a(1'b0),
    .b(\fadd/sglb_f [29]),
    .c(\fadd/neg0/c29 ),
    .o({\fadd/neg0/c30 ,\fadd/n2 [29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u3  (
    .a(1'b0),
    .b(\fadd/sglb_f [3]),
    .c(\fadd/neg0/c3 ),
    .o({\fadd/neg0/c4 ,\fadd/n2 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u30  (
    .a(1'b0),
    .b(1'b0),
    .c(\fadd/neg0/c30 ),
    .o({\fadd/neg0/c31 ,\fadd/n2 [30]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u31  (
    .a(1'b0),
    .b(1'b0),
    .c(\fadd/neg0/c31 ),
    .o({open_n4,\fadd/n2 [31]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u4  (
    .a(1'b0),
    .b(\fadd/sglb_f [4]),
    .c(\fadd/neg0/c4 ),
    .o({\fadd/neg0/c5 ,\fadd/n2 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u5  (
    .a(1'b0),
    .b(\fadd/sglb_f [5]),
    .c(\fadd/neg0/c5 ),
    .o({\fadd/neg0/c6 ,\fadd/n2 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u6  (
    .a(1'b0),
    .b(\fadd/sglb_f [6]),
    .c(\fadd/neg0/c6 ),
    .o({\fadd/neg0/c7 ,\fadd/n2 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u7  (
    .a(1'b0),
    .b(\fadd/sglb_f [7]),
    .c(\fadd/neg0/c7 ),
    .o({\fadd/neg0/c8 ,\fadd/n2 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u8  (
    .a(1'b0),
    .b(\fadd/sglb_f [8]),
    .c(\fadd/neg0/c8 ),
    .o({\fadd/neg0/c9 ,\fadd/n2 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg0/u9  (
    .a(1'b0),
    .b(\fadd/sglb_f [9]),
    .c(\fadd/neg0/c9 ),
    .o({\fadd/neg0/c10 ,\fadd/n2 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \fadd/neg0/ucin  (
    .a(1'b0),
    .o({\fadd/neg0/c0 ,open_n7}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u0  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [0]),
    .c(\fadd/neg1/c0 ),
    .o({\fadd/neg1/c1 ,\fadd/n4 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u1  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [1]),
    .c(\fadd/neg1/c1 ),
    .o({\fadd/neg1/c2 ,\fadd/n4 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u10  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [10]),
    .c(\fadd/neg1/c10 ),
    .o({\fadd/neg1/c11 ,\fadd/n4 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u11  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [11]),
    .c(\fadd/neg1/c11 ),
    .o({\fadd/neg1/c12 ,\fadd/n4 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u12  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [12]),
    .c(\fadd/neg1/c12 ),
    .o({\fadd/neg1/c13 ,\fadd/n4 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u13  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [13]),
    .c(\fadd/neg1/c13 ),
    .o({\fadd/neg1/c14 ,\fadd/n4 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u14  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [14]),
    .c(\fadd/neg1/c14 ),
    .o({\fadd/neg1/c15 ,\fadd/n4 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u15  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [15]),
    .c(\fadd/neg1/c15 ),
    .o({\fadd/neg1/c16 ,\fadd/n4 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u16  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [16]),
    .c(\fadd/neg1/c16 ),
    .o({\fadd/neg1/c17 ,\fadd/n4 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u17  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [17]),
    .c(\fadd/neg1/c17 ),
    .o({\fadd/neg1/c18 ,\fadd/n4 [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u18  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [18]),
    .c(\fadd/neg1/c18 ),
    .o({\fadd/neg1/c19 ,\fadd/n4 [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u19  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [19]),
    .c(\fadd/neg1/c19 ),
    .o({\fadd/neg1/c20 ,\fadd/n4 [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u2  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [2]),
    .c(\fadd/neg1/c2 ),
    .o({\fadd/neg1/c3 ,\fadd/n4 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u20  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [20]),
    .c(\fadd/neg1/c20 ),
    .o({\fadd/neg1/c21 ,\fadd/n4 [20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u21  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [21]),
    .c(\fadd/neg1/c21 ),
    .o({\fadd/neg1/c22 ,\fadd/n4 [21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u22  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [22]),
    .c(\fadd/neg1/c22 ),
    .o({\fadd/neg1/c23 ,\fadd/n4 [22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u23  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [23]),
    .c(\fadd/neg1/c23 ),
    .o({\fadd/neg1/c24 ,\fadd/n4 [23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u24  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [24]),
    .c(\fadd/neg1/c24 ),
    .o({\fadd/neg1/c25 ,\fadd/n4 [24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u25  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [25]),
    .c(\fadd/neg1/c25 ),
    .o({\fadd/neg1/c26 ,\fadd/n4 [25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u26  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [26]),
    .c(\fadd/neg1/c26 ),
    .o({\fadd/neg1/c27 ,\fadd/n4 [26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u27  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [27]),
    .c(\fadd/neg1/c27 ),
    .o({\fadd/neg1/c28 ,\fadd/n4 [27]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u28  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [28]),
    .c(\fadd/neg1/c28 ),
    .o({\fadd/neg1/c29 ,\fadd/n4 [28]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u29  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [29]),
    .c(\fadd/neg1/c29 ),
    .o({\fadd/neg1/c30 ,\fadd/n4 [29]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u3  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [3]),
    .c(\fadd/neg1/c3 ),
    .o({\fadd/neg1/c4 ,\fadd/n4 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u30  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [30]),
    .c(\fadd/neg1/c30 ),
    .o({\fadd/neg1/c31 ,\fadd/n4 [30]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u31  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [31]),
    .c(\fadd/neg1/c31 ),
    .o({open_n8,\fadd/n4 [31]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u4  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [4]),
    .c(\fadd/neg1/c4 ),
    .o({\fadd/neg1/c5 ,\fadd/n4 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u5  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [5]),
    .c(\fadd/neg1/c5 ),
    .o({\fadd/neg1/c6 ,\fadd/n4 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u6  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [6]),
    .c(\fadd/neg1/c6 ),
    .o({\fadd/neg1/c7 ,\fadd/n4 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u7  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [7]),
    .c(\fadd/neg1/c7 ),
    .o({\fadd/neg1/c8 ,\fadd/n4 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u8  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [8]),
    .c(\fadd/neg1/c8 ),
    .o({\fadd/neg1/c9 ,\fadd/n4 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fadd/neg1/u9  (
    .a(1'b0),
    .b(\fadd/sglc_f_t [9]),
    .c(\fadd/neg1/c9 ),
    .o({\fadd/neg1/c10 ,\fadd/n4 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \fadd/neg1/ucin  (
    .a(1'b0),
    .o({\fadd/neg1/c0 ,open_n11}));
  reg_sr_as_w1 \fctl/crdy_f_reg  (
    .clk(clk),
    .d(\fctl/crdy_t ),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fctl/crdy_f ));  // rtl/sfpu_fsm.v(198)
  reg_sr_as_w1 \fctl/fctl_ccmd_add_reg  (
    .clk(clk),
    .d(\fctl/n10 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fctl_ccmd_add));  // rtl/sfpu_fsm.v(143)
  reg_sr_as_w1 \fctl/fctl_ccmd_cmp_reg  (
    .clk(clk),
    .d(\fctl/n9 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fctl_ccmd_cmp));  // rtl/sfpu_fsm.v(143)
  reg_sr_as_w1 \fctl/fctl_ccmd_div_reg  (
    .clk(clk),
    .d(\fctl/n16 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fctl_ccmd_div));  // rtl/sfpu_fsm.v(143)
  reg_sr_as_w1 \fctl/fctl_ccmd_hlf_reg  (
    .clk(clk),
    .d(\fctl/n17 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fctl_ccmd_hlf));  // rtl/sfpu_fsm.v(143)
  reg_sr_as_w1 \fctl/fctl_ccmd_int_reg  (
    .clk(clk),
    .d(\fctl/n33 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fctl_ccmd_int));  // rtl/sfpu_fsm.v(143)
  reg_sr_as_w1 \fctl/fctl_ccmd_mul_reg  (
    .clk(clk),
    .d(\fctl/n15 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fctl_ccmd_mul));  // rtl/sfpu_fsm.v(143)
  reg_sr_as_w1 \fctl/fctl_ccmd_reg_reg  (
    .clk(clk),
    .d(\fctl/n29 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fctl_ccmd_reg));  // rtl/sfpu_fsm.v(143)
  reg_sr_as_w1 \fctl/fctl_ccmd_sub_reg  (
    .clk(clk),
    .d(\fctl/n13 ),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(fctl_ccmd_sub));  // rtl/sfpu_fsm.v(143)
  reg_sr_as_w1 \fctl/reg0_b0  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\fctl/mux0_b0_sel_is_3_o ),
    .set(1'b0),
    .q(\fctl/stat [0]));  // rtl/sfpu_fsm.v(190)
  reg_sr_as_w1 \fctl/reg0_b1  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\fctl/mux0_b1_sel_is_3_o ),
    .set(1'b0),
    .q(\fctl/stat [1]));  // rtl/sfpu_fsm.v(190)
  reg_sr_as_w1 \fctl/reg0_b2  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\fctl/mux0_b2_sel_is_3_o ),
    .set(1'b0),
    .q(\fctl/stat [2]));  // rtl/sfpu_fsm.v(190)
  reg_sr_as_w1 \fctl/reg0_b3  (
    .clk(clk),
    .d(1'b1),
    .en(1'b1),
    .reset(~\fctl/mux0_b3_sel_is_3_o ),
    .set(1'b0),
    .q(\fctl/stat [3]));  // rtl/sfpu_fsm.v(190)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u0  (
    .a(\fdiv/den [23]),
    .b(\fdiv/fdiv/n1 [0]),
    .c(\fdiv/fdiv/add0_2/c0 ),
    .o({\fdiv/fdiv/add0_2/c1 ,\fdiv/fdiv/rem4 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u1  (
    .a(\fdiv/den [24]),
    .b(\fdiv/fdiv/n1 [1]),
    .c(\fdiv/fdiv/add0_2/c1 ),
    .o({\fdiv/fdiv/add0_2/c2 ,\fdiv/fdiv/rem4 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u10  (
    .a(\fdiv/den [33]),
    .b(\fdiv/fdiv/n1 [10]),
    .c(\fdiv/fdiv/add0_2/c10 ),
    .o({\fdiv/fdiv/add0_2/c11 ,\fdiv/fdiv/rem4 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u11  (
    .a(\fdiv/den [34]),
    .b(\fdiv/fdiv/n1 [11]),
    .c(\fdiv/fdiv/add0_2/c11 ),
    .o({\fdiv/fdiv/add0_2/c12 ,\fdiv/fdiv/rem4 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u12  (
    .a(\fdiv/den [35]),
    .b(\fdiv/fdiv/n1 [12]),
    .c(\fdiv/fdiv/add0_2/c12 ),
    .o({\fdiv/fdiv/add0_2/c13 ,\fdiv/fdiv/rem4 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u13  (
    .a(\fdiv/den [36]),
    .b(\fdiv/fdiv/n1 [13]),
    .c(\fdiv/fdiv/add0_2/c13 ),
    .o({\fdiv/fdiv/add0_2/c14 ,\fdiv/fdiv/rem4 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u14  (
    .a(\fdiv/den [37]),
    .b(\fdiv/fdiv/n1 [14]),
    .c(\fdiv/fdiv/add0_2/c14 ),
    .o({\fdiv/fdiv/add0_2/c15 ,\fdiv/fdiv/rem4 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u15  (
    .a(\fdiv/den [38]),
    .b(\fdiv/fdiv/n1 [15]),
    .c(\fdiv/fdiv/add0_2/c15 ),
    .o({\fdiv/fdiv/add0_2/c16 ,\fdiv/fdiv/rem4 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u16  (
    .a(\fdiv/den [39]),
    .b(\fdiv/fdiv/n1 [16]),
    .c(\fdiv/fdiv/add0_2/c16 ),
    .o({\fdiv/fdiv/add0_2/c17 ,\fdiv/fdiv/rem4 [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u17  (
    .a(\fdiv/den [40]),
    .b(\fdiv/fdiv/n1 [17]),
    .c(\fdiv/fdiv/add0_2/c17 ),
    .o({\fdiv/fdiv/add0_2/c18 ,\fdiv/fdiv/rem4 [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u18  (
    .a(\fdiv/den [41]),
    .b(\fdiv/fdiv/n1 [18]),
    .c(\fdiv/fdiv/add0_2/c18 ),
    .o({\fdiv/fdiv/add0_2/c19 ,\fdiv/fdiv/rem4 [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u19  (
    .a(\fdiv/den [42]),
    .b(\fdiv/fdiv/n1 [19]),
    .c(\fdiv/fdiv/add0_2/c19 ),
    .o({\fdiv/fdiv/add0_2/c20 ,\fdiv/fdiv/rem4 [20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u2  (
    .a(\fdiv/den [25]),
    .b(\fdiv/fdiv/n1 [2]),
    .c(\fdiv/fdiv/add0_2/c2 ),
    .o({\fdiv/fdiv/add0_2/c3 ,\fdiv/fdiv/rem4 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u20  (
    .a(\fdiv/den [43]),
    .b(\fdiv/fdiv/n1 [20]),
    .c(\fdiv/fdiv/add0_2/c20 ),
    .o({\fdiv/fdiv/add0_2/c21 ,\fdiv/fdiv/rem4 [21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u21  (
    .a(\fdiv/den [44]),
    .b(\fdiv/fdiv/n1 [21]),
    .c(\fdiv/fdiv/add0_2/c21 ),
    .o({\fdiv/fdiv/add0_2/c22 ,\fdiv/fdiv/rem4 [22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u22  (
    .a(\fdiv/den [45]),
    .b(\fdiv/fdiv/n1 [22]),
    .c(\fdiv/fdiv/add0_2/c22 ),
    .o({\fdiv/fdiv/add0_2/c23 ,\fdiv/fdiv/rem4 [23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u23  (
    .a(\fdiv/den [46]),
    .b(\fdiv/fdiv/n1 [23]),
    .c(\fdiv/fdiv/add0_2/c23 ),
    .o({\fdiv/fdiv/add0_2/c24 ,\fdiv/fdiv/rem4 [24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u24  (
    .a(\fdiv/den [47]),
    .b(\fdiv/fdiv/n1 [24]),
    .c(\fdiv/fdiv/add0_2/c24 ),
    .o({\fdiv/fdiv/add0_2/c25 ,\fdiv/fdiv/rem4 [25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u25  (
    .a(\fdiv/den [48]),
    .b(\fdiv/fdiv/n0 ),
    .c(\fdiv/fdiv/add0_2/c25 ),
    .o({open_n12,\fdiv/fdiv/rem4 [26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u3  (
    .a(\fdiv/den [26]),
    .b(\fdiv/fdiv/n1 [3]),
    .c(\fdiv/fdiv/add0_2/c3 ),
    .o({\fdiv/fdiv/add0_2/c4 ,\fdiv/fdiv/rem4 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u4  (
    .a(\fdiv/den [27]),
    .b(\fdiv/fdiv/n1 [4]),
    .c(\fdiv/fdiv/add0_2/c4 ),
    .o({\fdiv/fdiv/add0_2/c5 ,\fdiv/fdiv/rem4 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u5  (
    .a(\fdiv/den [28]),
    .b(\fdiv/fdiv/n1 [5]),
    .c(\fdiv/fdiv/add0_2/c5 ),
    .o({\fdiv/fdiv/add0_2/c6 ,\fdiv/fdiv/rem4 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u6  (
    .a(\fdiv/den [29]),
    .b(\fdiv/fdiv/n1 [6]),
    .c(\fdiv/fdiv/add0_2/c6 ),
    .o({\fdiv/fdiv/add0_2/c7 ,\fdiv/fdiv/rem4 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u7  (
    .a(\fdiv/den [30]),
    .b(\fdiv/fdiv/n1 [7]),
    .c(\fdiv/fdiv/add0_2/c7 ),
    .o({\fdiv/fdiv/add0_2/c8 ,\fdiv/fdiv/rem4 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u8  (
    .a(\fdiv/den [31]),
    .b(\fdiv/fdiv/n1 [8]),
    .c(\fdiv/fdiv/add0_2/c8 ),
    .o({\fdiv/fdiv/add0_2/c9 ,\fdiv/fdiv/rem4 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add0_2/u9  (
    .a(\fdiv/den [32]),
    .b(\fdiv/fdiv/n1 [9]),
    .c(\fdiv/fdiv/add0_2/c9 ),
    .o({\fdiv/fdiv/add0_2/c10 ,\fdiv/fdiv/rem4 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \fdiv/fdiv/add0_2/ucin  (
    .a(\fdiv/fdiv/n0 ),
    .o({\fdiv/fdiv/add0_2/c0 ,open_n15}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u0  (
    .a(\fdiv/den [22]),
    .b(\fdiv/fdiv/n3 [0]),
    .c(\fdiv/fdiv/add1_2/c0 ),
    .o({\fdiv/fdiv/add1_2/c1 ,\fdiv/fdiv/rem3 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u1  (
    .a(\fdiv/fdiv/rem4 [1]),
    .b(\fdiv/fdiv/n3 [1]),
    .c(\fdiv/fdiv/add1_2/c1 ),
    .o({\fdiv/fdiv/add1_2/c2 ,\fdiv/fdiv/rem3 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u10  (
    .a(\fdiv/fdiv/rem4 [10]),
    .b(\fdiv/fdiv/n3 [10]),
    .c(\fdiv/fdiv/add1_2/c10 ),
    .o({\fdiv/fdiv/add1_2/c11 ,\fdiv/fdiv/rem3 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u11  (
    .a(\fdiv/fdiv/rem4 [11]),
    .b(\fdiv/fdiv/n3 [11]),
    .c(\fdiv/fdiv/add1_2/c11 ),
    .o({\fdiv/fdiv/add1_2/c12 ,\fdiv/fdiv/rem3 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u12  (
    .a(\fdiv/fdiv/rem4 [12]),
    .b(\fdiv/fdiv/n3 [12]),
    .c(\fdiv/fdiv/add1_2/c12 ),
    .o({\fdiv/fdiv/add1_2/c13 ,\fdiv/fdiv/rem3 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u13  (
    .a(\fdiv/fdiv/rem4 [13]),
    .b(\fdiv/fdiv/n3 [13]),
    .c(\fdiv/fdiv/add1_2/c13 ),
    .o({\fdiv/fdiv/add1_2/c14 ,\fdiv/fdiv/rem3 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u14  (
    .a(\fdiv/fdiv/rem4 [14]),
    .b(\fdiv/fdiv/n3 [14]),
    .c(\fdiv/fdiv/add1_2/c14 ),
    .o({\fdiv/fdiv/add1_2/c15 ,\fdiv/fdiv/rem3 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u15  (
    .a(\fdiv/fdiv/rem4 [15]),
    .b(\fdiv/fdiv/n3 [15]),
    .c(\fdiv/fdiv/add1_2/c15 ),
    .o({\fdiv/fdiv/add1_2/c16 ,\fdiv/fdiv/rem3 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u16  (
    .a(\fdiv/fdiv/rem4 [16]),
    .b(\fdiv/fdiv/n3 [16]),
    .c(\fdiv/fdiv/add1_2/c16 ),
    .o({\fdiv/fdiv/add1_2/c17 ,\fdiv/fdiv/rem3 [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u17  (
    .a(\fdiv/fdiv/rem4 [17]),
    .b(\fdiv/fdiv/n3 [17]),
    .c(\fdiv/fdiv/add1_2/c17 ),
    .o({\fdiv/fdiv/add1_2/c18 ,\fdiv/fdiv/rem3 [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u18  (
    .a(\fdiv/fdiv/rem4 [18]),
    .b(\fdiv/fdiv/n3 [18]),
    .c(\fdiv/fdiv/add1_2/c18 ),
    .o({\fdiv/fdiv/add1_2/c19 ,\fdiv/fdiv/rem3 [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u19  (
    .a(\fdiv/fdiv/rem4 [19]),
    .b(\fdiv/fdiv/n3 [19]),
    .c(\fdiv/fdiv/add1_2/c19 ),
    .o({\fdiv/fdiv/add1_2/c20 ,\fdiv/fdiv/rem3 [20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u2  (
    .a(\fdiv/fdiv/rem4 [2]),
    .b(\fdiv/fdiv/n3 [2]),
    .c(\fdiv/fdiv/add1_2/c2 ),
    .o({\fdiv/fdiv/add1_2/c3 ,\fdiv/fdiv/rem3 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u20  (
    .a(\fdiv/fdiv/rem4 [20]),
    .b(\fdiv/fdiv/n3 [20]),
    .c(\fdiv/fdiv/add1_2/c20 ),
    .o({\fdiv/fdiv/add1_2/c21 ,\fdiv/fdiv/rem3 [21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u21  (
    .a(\fdiv/fdiv/rem4 [21]),
    .b(\fdiv/fdiv/n3 [21]),
    .c(\fdiv/fdiv/add1_2/c21 ),
    .o({\fdiv/fdiv/add1_2/c22 ,\fdiv/fdiv/rem3 [22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u22  (
    .a(\fdiv/fdiv/rem4 [22]),
    .b(\fdiv/fdiv/n3 [22]),
    .c(\fdiv/fdiv/add1_2/c22 ),
    .o({\fdiv/fdiv/add1_2/c23 ,\fdiv/fdiv/rem3 [23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u23  (
    .a(\fdiv/fdiv/rem4 [23]),
    .b(\fdiv/fdiv/n3 [23]),
    .c(\fdiv/fdiv/add1_2/c23 ),
    .o({\fdiv/fdiv/add1_2/c24 ,\fdiv/fdiv/rem3 [24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u24  (
    .a(\fdiv/fdiv/rem4 [24]),
    .b(\fdiv/fdiv/n3 [24]),
    .c(\fdiv/fdiv/add1_2/c24 ),
    .o({\fdiv/fdiv/add1_2/c25 ,\fdiv/fdiv/rem3 [25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u25  (
    .a(\fdiv/fdiv/rem4 [25]),
    .b(\fdiv/quo [4]),
    .c(\fdiv/fdiv/add1_2/c25 ),
    .o({open_n16,\fdiv/fdiv/rem3 [26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u3  (
    .a(\fdiv/fdiv/rem4 [3]),
    .b(\fdiv/fdiv/n3 [3]),
    .c(\fdiv/fdiv/add1_2/c3 ),
    .o({\fdiv/fdiv/add1_2/c4 ,\fdiv/fdiv/rem3 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u4  (
    .a(\fdiv/fdiv/rem4 [4]),
    .b(\fdiv/fdiv/n3 [4]),
    .c(\fdiv/fdiv/add1_2/c4 ),
    .o({\fdiv/fdiv/add1_2/c5 ,\fdiv/fdiv/rem3 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u5  (
    .a(\fdiv/fdiv/rem4 [5]),
    .b(\fdiv/fdiv/n3 [5]),
    .c(\fdiv/fdiv/add1_2/c5 ),
    .o({\fdiv/fdiv/add1_2/c6 ,\fdiv/fdiv/rem3 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u6  (
    .a(\fdiv/fdiv/rem4 [6]),
    .b(\fdiv/fdiv/n3 [6]),
    .c(\fdiv/fdiv/add1_2/c6 ),
    .o({\fdiv/fdiv/add1_2/c7 ,\fdiv/fdiv/rem3 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u7  (
    .a(\fdiv/fdiv/rem4 [7]),
    .b(\fdiv/fdiv/n3 [7]),
    .c(\fdiv/fdiv/add1_2/c7 ),
    .o({\fdiv/fdiv/add1_2/c8 ,\fdiv/fdiv/rem3 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u8  (
    .a(\fdiv/fdiv/rem4 [8]),
    .b(\fdiv/fdiv/n3 [8]),
    .c(\fdiv/fdiv/add1_2/c8 ),
    .o({\fdiv/fdiv/add1_2/c9 ,\fdiv/fdiv/rem3 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add1_2/u9  (
    .a(\fdiv/fdiv/rem4 [9]),
    .b(\fdiv/fdiv/n3 [9]),
    .c(\fdiv/fdiv/add1_2/c9 ),
    .o({\fdiv/fdiv/add1_2/c10 ,\fdiv/fdiv/rem3 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \fdiv/fdiv/add1_2/ucin  (
    .a(\fdiv/quo [4]),
    .o({\fdiv/fdiv/add1_2/c0 ,open_n19}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u0  (
    .a(\fdiv/den [21]),
    .b(\fdiv/fdiv/n5 [0]),
    .c(\fdiv/fdiv/add2_2/c0 ),
    .o({\fdiv/fdiv/add2_2/c1 ,\fdiv/fdiv/rem2 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u1  (
    .a(\fdiv/fdiv/rem3 [1]),
    .b(\fdiv/fdiv/n5 [1]),
    .c(\fdiv/fdiv/add2_2/c1 ),
    .o({\fdiv/fdiv/add2_2/c2 ,\fdiv/fdiv/rem2 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u10  (
    .a(\fdiv/fdiv/rem3 [10]),
    .b(\fdiv/fdiv/n5 [10]),
    .c(\fdiv/fdiv/add2_2/c10 ),
    .o({\fdiv/fdiv/add2_2/c11 ,\fdiv/fdiv/rem2 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u11  (
    .a(\fdiv/fdiv/rem3 [11]),
    .b(\fdiv/fdiv/n5 [11]),
    .c(\fdiv/fdiv/add2_2/c11 ),
    .o({\fdiv/fdiv/add2_2/c12 ,\fdiv/fdiv/rem2 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u12  (
    .a(\fdiv/fdiv/rem3 [12]),
    .b(\fdiv/fdiv/n5 [12]),
    .c(\fdiv/fdiv/add2_2/c12 ),
    .o({\fdiv/fdiv/add2_2/c13 ,\fdiv/fdiv/rem2 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u13  (
    .a(\fdiv/fdiv/rem3 [13]),
    .b(\fdiv/fdiv/n5 [13]),
    .c(\fdiv/fdiv/add2_2/c13 ),
    .o({\fdiv/fdiv/add2_2/c14 ,\fdiv/fdiv/rem2 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u14  (
    .a(\fdiv/fdiv/rem3 [14]),
    .b(\fdiv/fdiv/n5 [14]),
    .c(\fdiv/fdiv/add2_2/c14 ),
    .o({\fdiv/fdiv/add2_2/c15 ,\fdiv/fdiv/rem2 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u15  (
    .a(\fdiv/fdiv/rem3 [15]),
    .b(\fdiv/fdiv/n5 [15]),
    .c(\fdiv/fdiv/add2_2/c15 ),
    .o({\fdiv/fdiv/add2_2/c16 ,\fdiv/fdiv/rem2 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u16  (
    .a(\fdiv/fdiv/rem3 [16]),
    .b(\fdiv/fdiv/n5 [16]),
    .c(\fdiv/fdiv/add2_2/c16 ),
    .o({\fdiv/fdiv/add2_2/c17 ,\fdiv/fdiv/rem2 [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u17  (
    .a(\fdiv/fdiv/rem3 [17]),
    .b(\fdiv/fdiv/n5 [17]),
    .c(\fdiv/fdiv/add2_2/c17 ),
    .o({\fdiv/fdiv/add2_2/c18 ,\fdiv/fdiv/rem2 [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u18  (
    .a(\fdiv/fdiv/rem3 [18]),
    .b(\fdiv/fdiv/n5 [18]),
    .c(\fdiv/fdiv/add2_2/c18 ),
    .o({\fdiv/fdiv/add2_2/c19 ,\fdiv/fdiv/rem2 [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u19  (
    .a(\fdiv/fdiv/rem3 [19]),
    .b(\fdiv/fdiv/n5 [19]),
    .c(\fdiv/fdiv/add2_2/c19 ),
    .o({\fdiv/fdiv/add2_2/c20 ,\fdiv/fdiv/rem2 [20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u2  (
    .a(\fdiv/fdiv/rem3 [2]),
    .b(\fdiv/fdiv/n5 [2]),
    .c(\fdiv/fdiv/add2_2/c2 ),
    .o({\fdiv/fdiv/add2_2/c3 ,\fdiv/fdiv/rem2 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u20  (
    .a(\fdiv/fdiv/rem3 [20]),
    .b(\fdiv/fdiv/n5 [20]),
    .c(\fdiv/fdiv/add2_2/c20 ),
    .o({\fdiv/fdiv/add2_2/c21 ,\fdiv/fdiv/rem2 [21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u21  (
    .a(\fdiv/fdiv/rem3 [21]),
    .b(\fdiv/fdiv/n5 [21]),
    .c(\fdiv/fdiv/add2_2/c21 ),
    .o({\fdiv/fdiv/add2_2/c22 ,\fdiv/fdiv/rem2 [22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u22  (
    .a(\fdiv/fdiv/rem3 [22]),
    .b(\fdiv/fdiv/n5 [22]),
    .c(\fdiv/fdiv/add2_2/c22 ),
    .o({\fdiv/fdiv/add2_2/c23 ,\fdiv/fdiv/rem2 [23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u23  (
    .a(\fdiv/fdiv/rem3 [23]),
    .b(\fdiv/fdiv/n5 [23]),
    .c(\fdiv/fdiv/add2_2/c23 ),
    .o({\fdiv/fdiv/add2_2/c24 ,\fdiv/fdiv/rem2 [24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u24  (
    .a(\fdiv/fdiv/rem3 [24]),
    .b(\fdiv/fdiv/n5 [24]),
    .c(\fdiv/fdiv/add2_2/c24 ),
    .o({\fdiv/fdiv/add2_2/c25 ,\fdiv/fdiv/rem2 [25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u25  (
    .a(\fdiv/fdiv/rem3 [25]),
    .b(\fdiv/quo [3]),
    .c(\fdiv/fdiv/add2_2/c25 ),
    .o({open_n20,\fdiv/fdiv/rem2 [26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u3  (
    .a(\fdiv/fdiv/rem3 [3]),
    .b(\fdiv/fdiv/n5 [3]),
    .c(\fdiv/fdiv/add2_2/c3 ),
    .o({\fdiv/fdiv/add2_2/c4 ,\fdiv/fdiv/rem2 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u4  (
    .a(\fdiv/fdiv/rem3 [4]),
    .b(\fdiv/fdiv/n5 [4]),
    .c(\fdiv/fdiv/add2_2/c4 ),
    .o({\fdiv/fdiv/add2_2/c5 ,\fdiv/fdiv/rem2 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u5  (
    .a(\fdiv/fdiv/rem3 [5]),
    .b(\fdiv/fdiv/n5 [5]),
    .c(\fdiv/fdiv/add2_2/c5 ),
    .o({\fdiv/fdiv/add2_2/c6 ,\fdiv/fdiv/rem2 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u6  (
    .a(\fdiv/fdiv/rem3 [6]),
    .b(\fdiv/fdiv/n5 [6]),
    .c(\fdiv/fdiv/add2_2/c6 ),
    .o({\fdiv/fdiv/add2_2/c7 ,\fdiv/fdiv/rem2 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u7  (
    .a(\fdiv/fdiv/rem3 [7]),
    .b(\fdiv/fdiv/n5 [7]),
    .c(\fdiv/fdiv/add2_2/c7 ),
    .o({\fdiv/fdiv/add2_2/c8 ,\fdiv/fdiv/rem2 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u8  (
    .a(\fdiv/fdiv/rem3 [8]),
    .b(\fdiv/fdiv/n5 [8]),
    .c(\fdiv/fdiv/add2_2/c8 ),
    .o({\fdiv/fdiv/add2_2/c9 ,\fdiv/fdiv/rem2 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add2_2/u9  (
    .a(\fdiv/fdiv/rem3 [9]),
    .b(\fdiv/fdiv/n5 [9]),
    .c(\fdiv/fdiv/add2_2/c9 ),
    .o({\fdiv/fdiv/add2_2/c10 ,\fdiv/fdiv/rem2 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \fdiv/fdiv/add2_2/ucin  (
    .a(\fdiv/quo [3]),
    .o({\fdiv/fdiv/add2_2/c0 ,open_n23}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u0  (
    .a(\fdiv/den [20]),
    .b(\fdiv/fdiv/n7 [0]),
    .c(\fdiv/fdiv/add3_2/c0 ),
    .o({\fdiv/fdiv/add3_2/c1 ,\fdiv/fdiv/rem1 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u1  (
    .a(\fdiv/fdiv/rem2 [1]),
    .b(\fdiv/fdiv/n7 [1]),
    .c(\fdiv/fdiv/add3_2/c1 ),
    .o({\fdiv/fdiv/add3_2/c2 ,\fdiv/fdiv/rem1 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u10  (
    .a(\fdiv/fdiv/rem2 [10]),
    .b(\fdiv/fdiv/n7 [10]),
    .c(\fdiv/fdiv/add3_2/c10 ),
    .o({\fdiv/fdiv/add3_2/c11 ,\fdiv/fdiv/rem1 [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u11  (
    .a(\fdiv/fdiv/rem2 [11]),
    .b(\fdiv/fdiv/n7 [11]),
    .c(\fdiv/fdiv/add3_2/c11 ),
    .o({\fdiv/fdiv/add3_2/c12 ,\fdiv/fdiv/rem1 [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u12  (
    .a(\fdiv/fdiv/rem2 [12]),
    .b(\fdiv/fdiv/n7 [12]),
    .c(\fdiv/fdiv/add3_2/c12 ),
    .o({\fdiv/fdiv/add3_2/c13 ,\fdiv/fdiv/rem1 [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u13  (
    .a(\fdiv/fdiv/rem2 [13]),
    .b(\fdiv/fdiv/n7 [13]),
    .c(\fdiv/fdiv/add3_2/c13 ),
    .o({\fdiv/fdiv/add3_2/c14 ,\fdiv/fdiv/rem1 [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u14  (
    .a(\fdiv/fdiv/rem2 [14]),
    .b(\fdiv/fdiv/n7 [14]),
    .c(\fdiv/fdiv/add3_2/c14 ),
    .o({\fdiv/fdiv/add3_2/c15 ,\fdiv/fdiv/rem1 [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u15  (
    .a(\fdiv/fdiv/rem2 [15]),
    .b(\fdiv/fdiv/n7 [15]),
    .c(\fdiv/fdiv/add3_2/c15 ),
    .o({\fdiv/fdiv/add3_2/c16 ,\fdiv/fdiv/rem1 [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u16  (
    .a(\fdiv/fdiv/rem2 [16]),
    .b(\fdiv/fdiv/n7 [16]),
    .c(\fdiv/fdiv/add3_2/c16 ),
    .o({\fdiv/fdiv/add3_2/c17 ,\fdiv/fdiv/rem1 [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u17  (
    .a(\fdiv/fdiv/rem2 [17]),
    .b(\fdiv/fdiv/n7 [17]),
    .c(\fdiv/fdiv/add3_2/c17 ),
    .o({\fdiv/fdiv/add3_2/c18 ,\fdiv/fdiv/rem1 [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u18  (
    .a(\fdiv/fdiv/rem2 [18]),
    .b(\fdiv/fdiv/n7 [18]),
    .c(\fdiv/fdiv/add3_2/c18 ),
    .o({\fdiv/fdiv/add3_2/c19 ,\fdiv/fdiv/rem1 [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u19  (
    .a(\fdiv/fdiv/rem2 [19]),
    .b(\fdiv/fdiv/n7 [19]),
    .c(\fdiv/fdiv/add3_2/c19 ),
    .o({\fdiv/fdiv/add3_2/c20 ,\fdiv/fdiv/rem1 [20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u2  (
    .a(\fdiv/fdiv/rem2 [2]),
    .b(\fdiv/fdiv/n7 [2]),
    .c(\fdiv/fdiv/add3_2/c2 ),
    .o({\fdiv/fdiv/add3_2/c3 ,\fdiv/fdiv/rem1 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u20  (
    .a(\fdiv/fdiv/rem2 [20]),
    .b(\fdiv/fdiv/n7 [20]),
    .c(\fdiv/fdiv/add3_2/c20 ),
    .o({\fdiv/fdiv/add3_2/c21 ,\fdiv/fdiv/rem1 [21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u21  (
    .a(\fdiv/fdiv/rem2 [21]),
    .b(\fdiv/fdiv/n7 [21]),
    .c(\fdiv/fdiv/add3_2/c21 ),
    .o({\fdiv/fdiv/add3_2/c22 ,\fdiv/fdiv/rem1 [22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u22  (
    .a(\fdiv/fdiv/rem2 [22]),
    .b(\fdiv/fdiv/n7 [22]),
    .c(\fdiv/fdiv/add3_2/c22 ),
    .o({\fdiv/fdiv/add3_2/c23 ,\fdiv/fdiv/rem1 [23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u23  (
    .a(\fdiv/fdiv/rem2 [23]),
    .b(\fdiv/fdiv/n7 [23]),
    .c(\fdiv/fdiv/add3_2/c23 ),
    .o({\fdiv/fdiv/add3_2/c24 ,\fdiv/fdiv/rem1 [24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u24  (
    .a(\fdiv/fdiv/rem2 [24]),
    .b(\fdiv/fdiv/n7 [24]),
    .c(\fdiv/fdiv/add3_2/c24 ),
    .o({\fdiv/fdiv/add3_2/c25 ,\fdiv/fdiv/rem1 [25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u25  (
    .a(\fdiv/fdiv/rem2 [25]),
    .b(\fdiv/quo [2]),
    .c(\fdiv/fdiv/add3_2/c25 ),
    .o({open_n24,\fdiv/fdiv/rem1 [26]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u3  (
    .a(\fdiv/fdiv/rem2 [3]),
    .b(\fdiv/fdiv/n7 [3]),
    .c(\fdiv/fdiv/add3_2/c3 ),
    .o({\fdiv/fdiv/add3_2/c4 ,\fdiv/fdiv/rem1 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u4  (
    .a(\fdiv/fdiv/rem2 [4]),
    .b(\fdiv/fdiv/n7 [4]),
    .c(\fdiv/fdiv/add3_2/c4 ),
    .o({\fdiv/fdiv/add3_2/c5 ,\fdiv/fdiv/rem1 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u5  (
    .a(\fdiv/fdiv/rem2 [5]),
    .b(\fdiv/fdiv/n7 [5]),
    .c(\fdiv/fdiv/add3_2/c5 ),
    .o({\fdiv/fdiv/add3_2/c6 ,\fdiv/fdiv/rem1 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u6  (
    .a(\fdiv/fdiv/rem2 [6]),
    .b(\fdiv/fdiv/n7 [6]),
    .c(\fdiv/fdiv/add3_2/c6 ),
    .o({\fdiv/fdiv/add3_2/c7 ,\fdiv/fdiv/rem1 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u7  (
    .a(\fdiv/fdiv/rem2 [7]),
    .b(\fdiv/fdiv/n7 [7]),
    .c(\fdiv/fdiv/add3_2/c7 ),
    .o({\fdiv/fdiv/add3_2/c8 ,\fdiv/fdiv/rem1 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u8  (
    .a(\fdiv/fdiv/rem2 [8]),
    .b(\fdiv/fdiv/n7 [8]),
    .c(\fdiv/fdiv/add3_2/c8 ),
    .o({\fdiv/fdiv/add3_2/c9 ,\fdiv/fdiv/rem1 [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add3_2/u9  (
    .a(\fdiv/fdiv/rem2 [9]),
    .b(\fdiv/fdiv/n7 [9]),
    .c(\fdiv/fdiv/add3_2/c9 ),
    .o({\fdiv/fdiv/add3_2/c10 ,\fdiv/fdiv/rem1 [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \fdiv/fdiv/add3_2/ucin  (
    .a(\fdiv/quo [2]),
    .o({\fdiv/fdiv/add3_2/c0 ,open_n27}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u0  (
    .a(\fdiv/den [19]),
    .b(\fdiv/fdiv/n9 [0]),
    .c(\fdiv/fdiv/add4_2/c0 ),
    .o({\fdiv/fdiv/add4_2/c1 ,\fdiv/rem [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u1  (
    .a(\fdiv/fdiv/rem1 [1]),
    .b(\fdiv/fdiv/n9 [1]),
    .c(\fdiv/fdiv/add4_2/c1 ),
    .o({\fdiv/fdiv/add4_2/c2 ,\fdiv/rem [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u10  (
    .a(\fdiv/fdiv/rem1 [10]),
    .b(\fdiv/fdiv/n9 [10]),
    .c(\fdiv/fdiv/add4_2/c10 ),
    .o({\fdiv/fdiv/add4_2/c11 ,\fdiv/rem [10]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u11  (
    .a(\fdiv/fdiv/rem1 [11]),
    .b(\fdiv/fdiv/n9 [11]),
    .c(\fdiv/fdiv/add4_2/c11 ),
    .o({\fdiv/fdiv/add4_2/c12 ,\fdiv/rem [11]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u12  (
    .a(\fdiv/fdiv/rem1 [12]),
    .b(\fdiv/fdiv/n9 [12]),
    .c(\fdiv/fdiv/add4_2/c12 ),
    .o({\fdiv/fdiv/add4_2/c13 ,\fdiv/rem [12]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u13  (
    .a(\fdiv/fdiv/rem1 [13]),
    .b(\fdiv/fdiv/n9 [13]),
    .c(\fdiv/fdiv/add4_2/c13 ),
    .o({\fdiv/fdiv/add4_2/c14 ,\fdiv/rem [13]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u14  (
    .a(\fdiv/fdiv/rem1 [14]),
    .b(\fdiv/fdiv/n9 [14]),
    .c(\fdiv/fdiv/add4_2/c14 ),
    .o({\fdiv/fdiv/add4_2/c15 ,\fdiv/rem [14]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u15  (
    .a(\fdiv/fdiv/rem1 [15]),
    .b(\fdiv/fdiv/n9 [15]),
    .c(\fdiv/fdiv/add4_2/c15 ),
    .o({\fdiv/fdiv/add4_2/c16 ,\fdiv/rem [15]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u16  (
    .a(\fdiv/fdiv/rem1 [16]),
    .b(\fdiv/fdiv/n9 [16]),
    .c(\fdiv/fdiv/add4_2/c16 ),
    .o({\fdiv/fdiv/add4_2/c17 ,\fdiv/rem [16]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u17  (
    .a(\fdiv/fdiv/rem1 [17]),
    .b(\fdiv/fdiv/n9 [17]),
    .c(\fdiv/fdiv/add4_2/c17 ),
    .o({\fdiv/fdiv/add4_2/c18 ,\fdiv/rem [17]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u18  (
    .a(\fdiv/fdiv/rem1 [18]),
    .b(\fdiv/fdiv/n9 [18]),
    .c(\fdiv/fdiv/add4_2/c18 ),
    .o({\fdiv/fdiv/add4_2/c19 ,\fdiv/rem [18]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u19  (
    .a(\fdiv/fdiv/rem1 [19]),
    .b(\fdiv/fdiv/n9 [19]),
    .c(\fdiv/fdiv/add4_2/c19 ),
    .o({\fdiv/fdiv/add4_2/c20 ,\fdiv/rem [19]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u2  (
    .a(\fdiv/fdiv/rem1 [2]),
    .b(\fdiv/fdiv/n9 [2]),
    .c(\fdiv/fdiv/add4_2/c2 ),
    .o({\fdiv/fdiv/add4_2/c3 ,\fdiv/rem [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u20  (
    .a(\fdiv/fdiv/rem1 [20]),
    .b(\fdiv/fdiv/n9 [20]),
    .c(\fdiv/fdiv/add4_2/c20 ),
    .o({\fdiv/fdiv/add4_2/c21 ,\fdiv/rem [20]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u21  (
    .a(\fdiv/fdiv/rem1 [21]),
    .b(\fdiv/fdiv/n9 [21]),
    .c(\fdiv/fdiv/add4_2/c21 ),
    .o({\fdiv/fdiv/add4_2/c22 ,\fdiv/rem [21]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u22  (
    .a(\fdiv/fdiv/rem1 [22]),
    .b(\fdiv/fdiv/n9 [22]),
    .c(\fdiv/fdiv/add4_2/c22 ),
    .o({\fdiv/fdiv/add4_2/c23 ,\fdiv/rem [22]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u23  (
    .a(\fdiv/fdiv/rem1 [23]),
    .b(\fdiv/fdiv/n9 [23]),
    .c(\fdiv/fdiv/add4_2/c23 ),
    .o({\fdiv/fdiv/add4_2/c24 ,\fdiv/rem [23]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u24  (
    .a(\fdiv/fdiv/rem1 [24]),
    .b(\fdiv/fdiv/n9 [24]),
    .c(\fdiv/fdiv/add4_2/c24 ),
    .o({\fdiv/fdiv/add4_2/c25 ,\fdiv/rem [24]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u25  (
    .a(\fdiv/fdiv/rem1 [25]),
    .b(\fdiv/quo [1]),
    .c(\fdiv/fdiv/add4_2/c25 ),
    .o({open_n28,\fdiv/rem [25]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u3  (
    .a(\fdiv/fdiv/rem1 [3]),
    .b(\fdiv/fdiv/n9 [3]),
    .c(\fdiv/fdiv/add4_2/c3 ),
    .o({\fdiv/fdiv/add4_2/c4 ,\fdiv/rem [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u4  (
    .a(\fdiv/fdiv/rem1 [4]),
    .b(\fdiv/fdiv/n9 [4]),
    .c(\fdiv/fdiv/add4_2/c4 ),
    .o({\fdiv/fdiv/add4_2/c5 ,\fdiv/rem [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u5  (
    .a(\fdiv/fdiv/rem1 [5]),
    .b(\fdiv/fdiv/n9 [5]),
    .c(\fdiv/fdiv/add4_2/c5 ),
    .o({\fdiv/fdiv/add4_2/c6 ,\fdiv/rem [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u6  (
    .a(\fdiv/fdiv/rem1 [6]),
    .b(\fdiv/fdiv/n9 [6]),
    .c(\fdiv/fdiv/add4_2/c6 ),
    .o({\fdiv/fdiv/add4_2/c7 ,\fdiv/rem [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u7  (
    .a(\fdiv/fdiv/rem1 [7]),
    .b(\fdiv/fdiv/n9 [7]),
    .c(\fdiv/fdiv/add4_2/c7 ),
    .o({\fdiv/fdiv/add4_2/c8 ,\fdiv/rem [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u8  (
    .a(\fdiv/fdiv/rem1 [8]),
    .b(\fdiv/fdiv/n9 [8]),
    .c(\fdiv/fdiv/add4_2/c8 ),
    .o({\fdiv/fdiv/add4_2/c9 ,\fdiv/rem [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fdiv/fdiv/add4_2/u9  (
    .a(\fdiv/fdiv/rem1 [9]),
    .b(\fdiv/fdiv/n9 [9]),
    .c(\fdiv/fdiv/add4_2/c9 ),
    .o({\fdiv/fdiv/add4_2/c10 ,\fdiv/rem [9]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \fdiv/fdiv/add4_2/ucin  (
    .a(\fdiv/quo [1]),
    .o({\fdiv/fdiv/add4_2/c0 ,open_n31}));
  reg_sr_as_w1 \fdiv/reg0_b0  (
    .clk(clk),
    .d(sglb_r[5]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [0]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b1  (
    .clk(clk),
    .d(sglb_r[6]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [1]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b10  (
    .clk(clk),
    .d(sglb_r[15]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [10]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b11  (
    .clk(clk),
    .d(sglb_r[16]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [11]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b12  (
    .clk(clk),
    .d(sglb_r[17]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [12]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b13  (
    .clk(clk),
    .d(sglb_r[18]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [13]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b14  (
    .clk(clk),
    .d(sglb_r[19]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [14]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b15  (
    .clk(clk),
    .d(sglb_r[20]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [15]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b16  (
    .clk(clk),
    .d(sglb_r[21]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [16]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b17  (
    .clk(clk),
    .d(sglb_r[22]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [17]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b18  (
    .clk(clk),
    .d(sglb_r[23]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [18]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b19  (
    .clk(clk),
    .d(sglb_r[24]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [19]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b2  (
    .clk(clk),
    .d(sglb_r[7]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [2]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b20  (
    .clk(clk),
    .d(sglb_r[25]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [20]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b21  (
    .clk(clk),
    .d(sglb_r[26]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [21]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b22  (
    .clk(clk),
    .d(sglb_r[27]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [22]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b23  (
    .clk(clk),
    .d(sglb_r[28]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [23]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b24  (
    .clk(clk),
    .d(sglb_r[29]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [24]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b3  (
    .clk(clk),
    .d(sglb_r[8]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [3]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b4  (
    .clk(clk),
    .d(sglb_r[9]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [4]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b5  (
    .clk(clk),
    .d(sglb_r[10]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [5]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b6  (
    .clk(clk),
    .d(sglb_r[11]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [6]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b7  (
    .clk(clk),
    .d(sglb_r[12]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [7]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b8  (
    .clk(clk),
    .d(sglb_r[13]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [8]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg0_b9  (
    .clk(clk),
    .d(sglb_r[14]),
    .en(~\fctl/n164 ),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/dso_r [9]));  // rtl/sglfpu.v(431)
  reg_sr_as_w1 \fdiv/reg1_b0  (
    .clk(clk),
    .d(\fdiv/quo [0]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [0]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b1  (
    .clk(clk),
    .d(\fdiv/quo [1]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [1]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b10  (
    .clk(clk),
    .d(\fdiv/fquo [5]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [10]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b11  (
    .clk(clk),
    .d(\fdiv/fquo [6]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [11]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b12  (
    .clk(clk),
    .d(\fdiv/fquo [7]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [12]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b13  (
    .clk(clk),
    .d(\fdiv/fquo [8]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [13]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b14  (
    .clk(clk),
    .d(\fdiv/fquo [9]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [14]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b15  (
    .clk(clk),
    .d(\fdiv/fquo [10]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [15]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b16  (
    .clk(clk),
    .d(\fdiv/fquo [11]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [16]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b17  (
    .clk(clk),
    .d(\fdiv/fquo [12]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [17]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b18  (
    .clk(clk),
    .d(\fdiv/fquo [13]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [18]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b19  (
    .clk(clk),
    .d(\fdiv/fquo [14]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [19]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b2  (
    .clk(clk),
    .d(\fdiv/quo [2]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [2]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b3  (
    .clk(clk),
    .d(\fdiv/quo [3]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [3]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b4  (
    .clk(clk),
    .d(\fdiv/quo [4]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [4]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b5  (
    .clk(clk),
    .d(\fdiv/fquo [0]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [5]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b6  (
    .clk(clk),
    .d(\fdiv/fquo [1]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [6]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b7  (
    .clk(clk),
    .d(\fdiv/fquo [2]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [7]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b8  (
    .clk(clk),
    .d(\fdiv/fquo [3]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [8]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg1_b9  (
    .clk(clk),
    .d(\fdiv/fquo [4]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/fquo [9]));  // rtl/sglfpu.v(443)
  reg_sr_as_w1 \fdiv/reg2_b23  (
    .clk(clk),
    .d(\fdiv/n9 [18]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [23]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b24  (
    .clk(clk),
    .d(\fdiv/rem [0]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [24]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b25  (
    .clk(clk),
    .d(\fdiv/rem [1]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [25]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b26  (
    .clk(clk),
    .d(\fdiv/rem [2]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [26]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b27  (
    .clk(clk),
    .d(\fdiv/rem [3]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [27]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b28  (
    .clk(clk),
    .d(\fdiv/rem [4]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [28]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b29  (
    .clk(clk),
    .d(\fdiv/rem [5]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [29]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b30  (
    .clk(clk),
    .d(\fdiv/rem [6]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [30]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b31  (
    .clk(clk),
    .d(\fdiv/rem [7]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [31]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b32  (
    .clk(clk),
    .d(\fdiv/rem [8]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [32]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b33  (
    .clk(clk),
    .d(\fdiv/rem [9]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [33]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b34  (
    .clk(clk),
    .d(\fdiv/rem [10]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [34]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b35  (
    .clk(clk),
    .d(\fdiv/rem [11]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [35]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b36  (
    .clk(clk),
    .d(\fdiv/rem [12]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [36]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b37  (
    .clk(clk),
    .d(\fdiv/rem [13]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [37]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b38  (
    .clk(clk),
    .d(\fdiv/rem [14]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [38]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b39  (
    .clk(clk),
    .d(\fdiv/rem [15]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [39]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b40  (
    .clk(clk),
    .d(\fdiv/rem [16]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [40]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b41  (
    .clk(clk),
    .d(\fdiv/rem [17]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [41]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b42  (
    .clk(clk),
    .d(\fdiv/rem [18]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [42]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b43  (
    .clk(clk),
    .d(\fdiv/rem [19]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [43]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b44  (
    .clk(clk),
    .d(\fdiv/rem [20]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [44]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b45  (
    .clk(clk),
    .d(\fdiv/rem [21]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [45]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b46  (
    .clk(clk),
    .d(\fdiv/rem [22]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [46]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b47  (
    .clk(clk),
    .d(\fdiv/rem [23]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [47]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b48  (
    .clk(clk),
    .d(\fdiv/rem [24]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [48]));  // rtl/sglfpu.v(420)
  reg_sr_as_w1 \fdiv/reg2_b49  (
    .clk(clk),
    .d(\fdiv/rem [25]),
    .en(fctl_dsft_enb),
    .reset(~rst_n),
    .set(1'b0),
    .q(\fdiv/den_r [49]));  // rtl/sglfpu.v(420)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub0/u0  (
    .a(sgla_e[0]),
    .b(sglb_e[0]),
    .c(\fdiv/sub0/c0 ),
    .o({\fdiv/sub0/c1 ,\fdiv/n18 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub0/u1  (
    .a(sgla_e[1]),
    .b(sglb_e[1]),
    .c(\fdiv/sub0/c1 ),
    .o({\fdiv/sub0/c2 ,\fdiv/n18 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub0/u2  (
    .a(sgla_e[2]),
    .b(sglb_e[2]),
    .c(\fdiv/sub0/c2 ),
    .o({\fdiv/sub0/c3 ,\fdiv/n18 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub0/u3  (
    .a(sgla_e[3]),
    .b(sglb_e[3]),
    .c(\fdiv/sub0/c3 ),
    .o({\fdiv/sub0/c4 ,\fdiv/n18 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub0/u4  (
    .a(sgla_e[4]),
    .b(sglb_e[4]),
    .c(\fdiv/sub0/c4 ),
    .o({\fdiv/sub0/c5 ,\fdiv/n18 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub0/u5  (
    .a(sgla_e[5]),
    .b(sglb_e[5]),
    .c(\fdiv/sub0/c5 ),
    .o({\fdiv/sub0/c6 ,\fdiv/n18 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub0/u6  (
    .a(sgla_e[6]),
    .b(sglb_e[6]),
    .c(\fdiv/sub0/c6 ),
    .o({\fdiv/sub0/c7 ,\fdiv/n18 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub0/u7  (
    .a(sgla_e[7]),
    .b(sglb_e[7]),
    .c(\fdiv/sub0/c7 ),
    .o({\fdiv/sub0/c8 ,\fdiv/n18 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub0/u8  (
    .a(sgla_e[8]),
    .b(sglb_e[8]),
    .c(\fdiv/sub0/c8 ),
    .o({open_n32,\fdiv/n18 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \fdiv/sub0/ucin  (
    .a(1'b0),
    .o({\fdiv/sub0/c0 ,open_n35}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub1/u0  (
    .a(\fdiv/n18 [0]),
    .b(\fdiv/n19 ),
    .c(\fdiv/sub1/c0 ),
    .o({\fdiv/sub1/c1 ,sglc_r_fdiv[32]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub1/u1  (
    .a(\fdiv/n18 [1]),
    .b(1'b0),
    .c(\fdiv/sub1/c1 ),
    .o({\fdiv/sub1/c2 ,sglc_r_fdiv[33]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub1/u2  (
    .a(\fdiv/n18 [2]),
    .b(1'b0),
    .c(\fdiv/sub1/c2 ),
    .o({\fdiv/sub1/c3 ,sglc_r_fdiv[34]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub1/u3  (
    .a(\fdiv/n18 [3]),
    .b(1'b0),
    .c(\fdiv/sub1/c3 ),
    .o({\fdiv/sub1/c4 ,sglc_r_fdiv[35]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub1/u4  (
    .a(\fdiv/n18 [4]),
    .b(1'b0),
    .c(\fdiv/sub1/c4 ),
    .o({\fdiv/sub1/c5 ,sglc_r_fdiv[36]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub1/u5  (
    .a(\fdiv/n18 [5]),
    .b(1'b0),
    .c(\fdiv/sub1/c5 ),
    .o({\fdiv/sub1/c6 ,sglc_r_fdiv[37]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub1/u6  (
    .a(\fdiv/n18 [6]),
    .b(1'b0),
    .c(\fdiv/sub1/c6 ),
    .o({\fdiv/sub1/c7 ,sglc_r_fdiv[38]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub1/u7  (
    .a(\fdiv/n18 [7]),
    .b(1'b0),
    .c(\fdiv/sub1/c7 ),
    .o({\fdiv/sub1/c8 ,sglc_r_fdiv[39]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \fdiv/sub1/u8  (
    .a(\fdiv/n18 [8]),
    .b(1'b0),
    .c(\fdiv/sub1/c8 ),
    .o({open_n36,sglc_r_fdiv[40]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \fdiv/sub1/ucin  (
    .a(1'b0),
    .o({\fdiv/sub1/c0 ,open_n39}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fmul/add0_fmul/add1/u0  (
    .a(sgla_e[0]),
    .b(sglb_e[0]),
    .c(\fmul/add0_fmul/add1/c0 ),
    .o({\fmul/add0_fmul/add1/c1 ,sglc_r_fmul[32]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fmul/add0_fmul/add1/u1  (
    .a(sgla_e[1]),
    .b(sglb_e[1]),
    .c(\fmul/add0_fmul/add1/c1 ),
    .o({\fmul/add0_fmul/add1/c2 ,sglc_r_fmul[33]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fmul/add0_fmul/add1/u2  (
    .a(sgla_e[2]),
    .b(sglb_e[2]),
    .c(\fmul/add0_fmul/add1/c2 ),
    .o({\fmul/add0_fmul/add1/c3 ,sglc_r_fmul[34]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fmul/add0_fmul/add1/u3  (
    .a(sgla_e[3]),
    .b(sglb_e[3]),
    .c(\fmul/add0_fmul/add1/c3 ),
    .o({\fmul/add0_fmul/add1/c4 ,sglc_r_fmul[35]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fmul/add0_fmul/add1/u4  (
    .a(sgla_e[4]),
    .b(sglb_e[4]),
    .c(\fmul/add0_fmul/add1/c4 ),
    .o({\fmul/add0_fmul/add1/c5 ,sglc_r_fmul[36]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fmul/add0_fmul/add1/u5  (
    .a(sgla_e[5]),
    .b(sglb_e[5]),
    .c(\fmul/add0_fmul/add1/c5 ),
    .o({\fmul/add0_fmul/add1/c6 ,sglc_r_fmul[37]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fmul/add0_fmul/add1/u6  (
    .a(sgla_e[6]),
    .b(sglb_e[6]),
    .c(\fmul/add0_fmul/add1/c6 ),
    .o({\fmul/add0_fmul/add1/c7 ,sglc_r_fmul[38]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fmul/add0_fmul/add1/u7  (
    .a(sgla_e[7]),
    .b(sglb_e[7]),
    .c(\fmul/add0_fmul/add1/c7 ),
    .o({\fmul/add0_fmul/add1/c8 ,sglc_r_fmul[39]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \fmul/add0_fmul/add1/u8  (
    .a(sgla_e[8]),
    .b(sglb_e[8]),
    .c(\fmul/add0_fmul/add1/c8 ),
    .o({open_n40,sglc_r_fmul[40]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \fmul/add0_fmul/add1/ucin  (
    .a(sfpu_dsp_c[47]),
    .o({\fmul/add0_fmul/add1/c0 ,open_n43}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u0  (
    .a(\norm/sglc_e [0]),
    .b(1'b1),
    .c(\norm/add0/c0 ),
    .o({\norm/add0/c1 ,\norm/n4 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u1  (
    .a(\norm/sglc_e [1]),
    .b(1'b1),
    .c(\norm/add0/c1 ),
    .o({\norm/add0/c2 ,\norm/n4 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u2  (
    .a(\norm/sglc_e [2]),
    .b(1'b0),
    .c(\norm/add0/c2 ),
    .o({\norm/add0/c3 ,\norm/n4 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u3  (
    .a(\norm/sglc_e [3]),
    .b(1'b0),
    .c(\norm/add0/c3 ),
    .o({\norm/add0/c4 ,\norm/n4 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u4  (
    .a(\norm/sglc_e [4]),
    .b(1'b0),
    .c(\norm/add0/c4 ),
    .o({\norm/add0/c5 ,\norm/n4 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u5  (
    .a(\norm/sglc_e [5]),
    .b(1'b0),
    .c(\norm/add0/c5 ),
    .o({\norm/add0/c6 ,\norm/n4 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u6  (
    .a(\norm/sglc_e [6]),
    .b(1'b0),
    .c(\norm/add0/c6 ),
    .o({\norm/add0/c7 ,\norm/n4 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u7  (
    .a(\norm/sglc_e [7]),
    .b(1'b0),
    .c(\norm/add0/c7 ),
    .o({\norm/add0/c8 ,\norm/n4 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add0/u8  (
    .a(\norm/sglc_e [8]),
    .b(1'b0),
    .c(\norm/add0/c8 ),
    .o({open_n44,\norm/n4 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \norm/add0/ucin  (
    .a(1'b0),
    .o({\norm/add0/c0 ,open_n47}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add1/u0  (
    .a(\norm/sglc_e [1]),
    .b(1'b1),
    .c(\norm/add1/c0 ),
    .o({\norm/add1/c1 ,\norm/n5 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add1/u1  (
    .a(\norm/sglc_e [2]),
    .b(1'b0),
    .c(\norm/add1/c1 ),
    .o({\norm/add1/c2 ,\norm/n5 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add1/u2  (
    .a(\norm/sglc_e [3]),
    .b(1'b0),
    .c(\norm/add1/c2 ),
    .o({\norm/add1/c3 ,\norm/n5 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add1/u3  (
    .a(\norm/sglc_e [4]),
    .b(1'b0),
    .c(\norm/add1/c3 ),
    .o({\norm/add1/c4 ,\norm/n5 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add1/u4  (
    .a(\norm/sglc_e [5]),
    .b(1'b0),
    .c(\norm/add1/c4 ),
    .o({\norm/add1/c5 ,\norm/n5 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add1/u5  (
    .a(\norm/sglc_e [6]),
    .b(1'b0),
    .c(\norm/add1/c5 ),
    .o({\norm/add1/c6 ,\norm/n5 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add1/u6  (
    .a(\norm/sglc_e [7]),
    .b(1'b0),
    .c(\norm/add1/c6 ),
    .o({\norm/add1/c7 ,\norm/n5 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add1/u7  (
    .a(\norm/sglc_e [8]),
    .b(1'b0),
    .c(\norm/add1/c7 ),
    .o({open_n48,\norm/n5 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \norm/add1/ucin  (
    .a(1'b0),
    .o({\norm/add1/c0 ,open_n51}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u0  (
    .a(\norm/sglc_e [0]),
    .b(1'b1),
    .c(\norm/add2/c0 ),
    .o({\norm/add2/c1 ,\norm/n6 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u1  (
    .a(\norm/sglc_e [1]),
    .b(1'b0),
    .c(\norm/add2/c1 ),
    .o({\norm/add2/c2 ,\norm/n6 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u2  (
    .a(\norm/sglc_e [2]),
    .b(1'b0),
    .c(\norm/add2/c2 ),
    .o({\norm/add2/c3 ,\norm/n6 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u3  (
    .a(\norm/sglc_e [3]),
    .b(1'b0),
    .c(\norm/add2/c3 ),
    .o({\norm/add2/c4 ,\norm/n6 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u4  (
    .a(\norm/sglc_e [4]),
    .b(1'b0),
    .c(\norm/add2/c4 ),
    .o({\norm/add2/c5 ,\norm/n6 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u5  (
    .a(\norm/sglc_e [5]),
    .b(1'b0),
    .c(\norm/add2/c5 ),
    .o({\norm/add2/c6 ,\norm/n6 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u6  (
    .a(\norm/sglc_e [6]),
    .b(1'b0),
    .c(\norm/add2/c6 ),
    .o({\norm/add2/c7 ,\norm/n6 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u7  (
    .a(\norm/sglc_e [7]),
    .b(1'b0),
    .c(\norm/add2/c7 ),
    .o({\norm/add2/c8 ,\norm/n6 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add2/u8  (
    .a(\norm/sglc_e [8]),
    .b(1'b0),
    .c(\norm/add2/c8 ),
    .o({open_n52,\norm/n6 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \norm/add2/ucin  (
    .a(1'b0),
    .o({\norm/add2/c0 ,open_n55}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add3/u0  (
    .a(\norm/sglc_e [0]),
    .b(1'b1),
    .c(\norm/add3/c0 ),
    .o({\norm/add3/c1 ,\norm/n60 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add3/u1  (
    .a(\norm/sglc_e [1]),
    .b(1'b1),
    .c(\norm/add3/c1 ),
    .o({\norm/add3/c2 ,\norm/n60 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add3/u2  (
    .a(\norm/sglc_e [2]),
    .b(1'b1),
    .c(\norm/add3/c2 ),
    .o({\norm/add3/c3 ,\norm/n60 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add3/u3  (
    .a(\norm/sglc_e [3]),
    .b(1'b1),
    .c(\norm/add3/c3 ),
    .o({\norm/add3/c4 ,\norm/n60 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add3/u4  (
    .a(\norm/sglc_e [4]),
    .b(1'b1),
    .c(\norm/add3/c4 ),
    .o({\norm/add3/c5 ,\norm/n60 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add3/u5  (
    .a(\norm/sglc_e [5]),
    .b(1'b1),
    .c(\norm/add3/c5 ),
    .o({\norm/add3/c6 ,\norm/n60 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add3/u6  (
    .a(\norm/sglc_e [6]),
    .b(1'b1),
    .c(\norm/add3/c6 ),
    .o({\norm/add3/c7 ,\norm/n60 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add3/u7  (
    .a(\norm/sglc_e [7]),
    .b(1'b0),
    .c(\norm/add3/c7 ),
    .o({open_n56,\norm/n60 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \norm/add3/ucin  (
    .a(1'b0),
    .o({\norm/add3/c0 ,open_n59}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add4/u0  (
    .a(\norm/sglc_r [32]),
    .b(1'b1),
    .c(\norm/add4/c0 ),
    .o({\norm/add4/c1 ,\norm/n61 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add4/u1  (
    .a(\norm/sglc_r [33]),
    .b(1'b1),
    .c(\norm/add4/c1 ),
    .o({\norm/add4/c2 ,\norm/n61 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add4/u2  (
    .a(\norm/sglc_r [34]),
    .b(1'b1),
    .c(\norm/add4/c2 ),
    .o({\norm/add4/c3 ,\norm/n61 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add4/u3  (
    .a(\norm/sglc_r [35]),
    .b(1'b1),
    .c(\norm/add4/c3 ),
    .o({\norm/add4/c4 ,\norm/n61 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add4/u4  (
    .a(\norm/sglc_r [36]),
    .b(1'b1),
    .c(\norm/add4/c4 ),
    .o({\norm/add4/c5 ,\norm/n61 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add4/u5  (
    .a(\norm/sglc_r [37]),
    .b(1'b1),
    .c(\norm/add4/c5 ),
    .o({\norm/add4/c6 ,\norm/n61 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add4/u6  (
    .a(\norm/sglc_r [38]),
    .b(1'b1),
    .c(\norm/add4/c6 ),
    .o({\norm/add4/c7 ,\norm/n61 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \norm/add4/u7  (
    .a(\norm/sglc_r [39]),
    .b(1'b0),
    .c(\norm/add4/c7 ),
    .o({open_n60,\norm/n61 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \norm/add4/ucin  (
    .a(1'b0),
    .o({\norm/add4/c0 ,open_n63}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_0  (
    .a(1'b1),
    .b(\norm/sglc_e [0]),
    .c(\norm/lt0_c0 ),
    .o({\norm/lt0_c1 ,open_n64}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_1  (
    .a(1'b1),
    .b(\norm/sglc_e [1]),
    .c(\norm/lt0_c1 ),
    .o({\norm/lt0_c2 ,open_n65}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_2  (
    .a(1'b1),
    .b(\norm/sglc_e [2]),
    .c(\norm/lt0_c2 ),
    .o({\norm/lt0_c3 ,open_n66}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_3  (
    .a(1'b1),
    .b(\norm/sglc_e [3]),
    .c(\norm/lt0_c3 ),
    .o({\norm/lt0_c4 ,open_n67}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_4  (
    .a(1'b1),
    .b(\norm/sglc_e [4]),
    .c(\norm/lt0_c4 ),
    .o({\norm/lt0_c5 ,open_n68}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_5  (
    .a(1'b1),
    .b(\norm/sglc_e [5]),
    .c(\norm/lt0_c5 ),
    .o({\norm/lt0_c6 ,open_n69}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_6  (
    .a(1'b1),
    .b(\norm/sglc_e [6]),
    .c(\norm/lt0_c6 ),
    .o({\norm/lt0_c7 ,open_n70}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_7  (
    .a(1'b0),
    .b(\norm/sglc_e [7]),
    .c(\norm/lt0_c7 ),
    .o({\norm/lt0_c8 ,open_n71}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_8  (
    .a(\norm/sglc_e [8]),
    .b(1'b0),
    .c(\norm/lt0_c8 ),
    .o({\norm/lt0_c9 ,open_n72}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \norm/lt0_cin  (
    .a(1'b0),
    .o({\norm/lt0_c0 ,open_n75}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt0_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\norm/lt0_c9 ),
    .o({open_n76,\norm/ovfl }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_0  (
    .a(\norm/sglc_e [0]),
    .b(1'b0),
    .c(\norm/lt1_c0 ),
    .o({\norm/lt1_c1 ,open_n77}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_1  (
    .a(\norm/sglc_e [1]),
    .b(1'b1),
    .c(\norm/lt1_c1 ),
    .o({\norm/lt1_c2 ,open_n78}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_2  (
    .a(\norm/sglc_e [2]),
    .b(1'b0),
    .c(\norm/lt1_c2 ),
    .o({\norm/lt1_c3 ,open_n79}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_3  (
    .a(\norm/sglc_e [3]),
    .b(1'b0),
    .c(\norm/lt1_c3 ),
    .o({\norm/lt1_c4 ,open_n80}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_4  (
    .a(\norm/sglc_e [4]),
    .b(1'b0),
    .c(\norm/lt1_c4 ),
    .o({\norm/lt1_c5 ,open_n81}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_5  (
    .a(\norm/sglc_e [5]),
    .b(1'b0),
    .c(\norm/lt1_c5 ),
    .o({\norm/lt1_c6 ,open_n82}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_6  (
    .a(\norm/sglc_e [6]),
    .b(1'b0),
    .c(\norm/lt1_c6 ),
    .o({\norm/lt1_c7 ,open_n83}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_7  (
    .a(\norm/sglc_e [7]),
    .b(1'b1),
    .c(\norm/lt1_c7 ),
    .o({\norm/lt1_c8 ,open_n84}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_8  (
    .a(1'b1),
    .b(\norm/sglc_e [8]),
    .c(\norm/lt1_c8 ),
    .o({\norm/lt1_c9 ,open_n85}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \norm/lt1_cin  (
    .a(1'b0),
    .o({\norm/lt1_c0 ,open_n88}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \norm/lt1_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\norm/lt1_c9 ),
    .o({open_n89,\norm/udfl }));
  reg_sr_as_w1 \norm/reg0_b0  (
    .clk(clk),
    .d(\norm/n52 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_e [0]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg0_b1  (
    .clk(clk),
    .d(\norm/n52 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_e [1]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg0_b2  (
    .clk(clk),
    .d(\norm/n52 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_e [2]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg0_b3  (
    .clk(clk),
    .d(\norm/n52 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_e [3]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg0_b4  (
    .clk(clk),
    .d(\norm/n52 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_e [4]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg0_b5  (
    .clk(clk),
    .d(\norm/n52 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_e [5]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg0_b6  (
    .clk(clk),
    .d(\norm/n52 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_e [6]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg0_b7  (
    .clk(clk),
    .d(\norm/n52 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_e [7]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg0_b8  (
    .clk(clk),
    .d(\norm/n52 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_e [8]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b0  (
    .clk(clk),
    .d(\norm/n53 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [0]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b1  (
    .clk(clk),
    .d(\norm/n53 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [1]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b10  (
    .clk(clk),
    .d(\norm/n53 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [10]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b11  (
    .clk(clk),
    .d(\norm/n53 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [11]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b12  (
    .clk(clk),
    .d(\norm/n53 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [12]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b13  (
    .clk(clk),
    .d(\norm/n53 [13]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [13]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b14  (
    .clk(clk),
    .d(\norm/n53 [14]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [14]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b15  (
    .clk(clk),
    .d(\norm/n53 [15]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [15]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b16  (
    .clk(clk),
    .d(\norm/n53 [16]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [16]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b17  (
    .clk(clk),
    .d(\norm/n53 [17]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [17]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b18  (
    .clk(clk),
    .d(\norm/n53 [18]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [18]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b19  (
    .clk(clk),
    .d(\norm/n53 [19]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [19]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b2  (
    .clk(clk),
    .d(\norm/n53 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [2]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b20  (
    .clk(clk),
    .d(\norm/n53 [20]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [20]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b21  (
    .clk(clk),
    .d(\norm/n53 [21]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [21]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b22  (
    .clk(clk),
    .d(\norm/n53 [22]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [22]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b23  (
    .clk(clk),
    .d(\norm/n53 [23]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [23]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b24  (
    .clk(clk),
    .d(\norm/n53 [24]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [24]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b25  (
    .clk(clk),
    .d(\norm/n53 [25]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [25]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b26  (
    .clk(clk),
    .d(\norm/n53 [26]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [26]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b27  (
    .clk(clk),
    .d(\norm/n53 [27]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [27]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b28  (
    .clk(clk),
    .d(\norm/n53 [28]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [28]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b29  (
    .clk(clk),
    .d(\norm/n53 [29]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [29]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b3  (
    .clk(clk),
    .d(\norm/n53 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [3]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b30  (
    .clk(clk),
    .d(\norm/n53 [30]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [30]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b31  (
    .clk(clk),
    .d(\norm/n53 [31]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [31]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b4  (
    .clk(clk),
    .d(\norm/n53 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [4]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b5  (
    .clk(clk),
    .d(\norm/n53 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [5]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b6  (
    .clk(clk),
    .d(\norm/n53 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [6]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b7  (
    .clk(clk),
    .d(\norm/n53 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [7]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b8  (
    .clk(clk),
    .d(\norm/n53 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [8]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg1_b9  (
    .clk(clk),
    .d(\norm/n53 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_f [9]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg2_b0  (
    .clk(clk),
    .d(\norm/sglc_r [41]),
    .en(fctl_load_c),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_i [41]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg2_b1  (
    .clk(clk),
    .d(\norm/sglc_r [42]),
    .en(fctl_load_c),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_i [42]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg2_b2  (
    .clk(clk),
    .d(\norm/sglc_r [43]),
    .en(fctl_load_c),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_i [43]));  // rtl/sglfpu.v(2013)
  reg_sr_as_w1 \norm/reg2_b3  (
    .clk(clk),
    .d(\norm/sglc_r [44]),
    .en(fctl_load_c),
    .reset(~rst_n),
    .set(1'b0),
    .q(\norm/sglc_i [44]));  // rtl/sglfpu.v(2013)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub0/u0  (
    .a(\norm/sglc_e [4]),
    .b(1'b1),
    .c(\norm/sub0/c0 ),
    .o({\norm/sub0/c1 ,n0[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub0/u1  (
    .a(\norm/sglc_e [5]),
    .b(1'b0),
    .c(\norm/sub0/c1 ),
    .o({\norm/sub0/c2 ,n0[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub0/u2  (
    .a(\norm/sglc_e [6]),
    .b(1'b0),
    .c(\norm/sub0/c2 ),
    .o({\norm/sub0/c3 ,n0[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub0/u3  (
    .a(\norm/sglc_e [7]),
    .b(1'b0),
    .c(\norm/sub0/c3 ),
    .o({\norm/sub0/c4 ,n0[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub0/u4  (
    .a(\norm/sglc_e [8]),
    .b(1'b0),
    .c(\norm/sub0/c4 ),
    .o({open_n90,n0[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub0/ucin  (
    .a(1'b0),
    .o({\norm/sub0/c0 ,open_n93}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub1/u0  (
    .a(\norm/sglc_e [1]),
    .b(1'b1),
    .c(\norm/sub1/c0 ),
    .o({\norm/sub1/c1 ,n1[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub1/u1  (
    .a(\norm/sglc_e [2]),
    .b(1'b1),
    .c(\norm/sub1/c1 ),
    .o({\norm/sub1/c2 ,n1[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub1/u2  (
    .a(\norm/sglc_e [3]),
    .b(1'b1),
    .c(\norm/sub1/c2 ),
    .o({\norm/sub1/c3 ,n1[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub1/u3  (
    .a(\norm/sglc_e [4]),
    .b(1'b0),
    .c(\norm/sub1/c3 ),
    .o({\norm/sub1/c4 ,n1[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub1/u4  (
    .a(\norm/sglc_e [5]),
    .b(1'b0),
    .c(\norm/sub1/c4 ),
    .o({\norm/sub1/c5 ,n1[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub1/u5  (
    .a(\norm/sglc_e [6]),
    .b(1'b0),
    .c(\norm/sub1/c5 ),
    .o({\norm/sub1/c6 ,n1[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub1/u6  (
    .a(\norm/sglc_e [7]),
    .b(1'b0),
    .c(\norm/sub1/c6 ),
    .o({\norm/sub1/c7 ,n1[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub1/u7  (
    .a(\norm/sglc_e [8]),
    .b(1'b0),
    .c(\norm/sub1/c7 ),
    .o({open_n94,n1[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub1/ucin  (
    .a(1'b0),
    .o({\norm/sub1/c0 ,open_n97}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub2/u0  (
    .a(\norm/sglc_e [2]),
    .b(1'b1),
    .c(\norm/sub2/c0 ),
    .o({\norm/sub2/c1 ,n2[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub2/u1  (
    .a(\norm/sglc_e [3]),
    .b(1'b1),
    .c(\norm/sub2/c1 ),
    .o({\norm/sub2/c2 ,n2[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub2/u2  (
    .a(\norm/sglc_e [4]),
    .b(1'b0),
    .c(\norm/sub2/c2 ),
    .o({\norm/sub2/c3 ,n2[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub2/u3  (
    .a(\norm/sglc_e [5]),
    .b(1'b0),
    .c(\norm/sub2/c3 ),
    .o({\norm/sub2/c4 ,n2[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub2/u4  (
    .a(\norm/sglc_e [6]),
    .b(1'b0),
    .c(\norm/sub2/c4 ),
    .o({\norm/sub2/c5 ,n2[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub2/u5  (
    .a(\norm/sglc_e [7]),
    .b(1'b0),
    .c(\norm/sub2/c5 ),
    .o({\norm/sub2/c6 ,n2[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub2/u6  (
    .a(\norm/sglc_e [8]),
    .b(1'b0),
    .c(\norm/sub2/c6 ),
    .o({open_n98,n2[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub2/ucin  (
    .a(1'b0),
    .o({\norm/sub2/c0 ,open_n101}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub3/u0  (
    .a(\norm/sglc_e [1]),
    .b(1'b1),
    .c(\norm/sub3/c0 ),
    .o({\norm/sub3/c1 ,n3[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub3/u1  (
    .a(\norm/sglc_e [2]),
    .b(1'b0),
    .c(\norm/sub3/c1 ),
    .o({\norm/sub3/c2 ,n3[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub3/u2  (
    .a(\norm/sglc_e [3]),
    .b(1'b1),
    .c(\norm/sub3/c2 ),
    .o({\norm/sub3/c3 ,n3[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub3/u3  (
    .a(\norm/sglc_e [4]),
    .b(1'b0),
    .c(\norm/sub3/c3 ),
    .o({\norm/sub3/c4 ,n3[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub3/u4  (
    .a(\norm/sglc_e [5]),
    .b(1'b0),
    .c(\norm/sub3/c4 ),
    .o({\norm/sub3/c5 ,n3[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub3/u5  (
    .a(\norm/sglc_e [6]),
    .b(1'b0),
    .c(\norm/sub3/c5 ),
    .o({\norm/sub3/c6 ,n3[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub3/u6  (
    .a(\norm/sglc_e [7]),
    .b(1'b0),
    .c(\norm/sub3/c6 ),
    .o({\norm/sub3/c7 ,n3[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub3/u7  (
    .a(\norm/sglc_e [8]),
    .b(1'b0),
    .c(\norm/sub3/c7 ),
    .o({open_n102,n3[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub3/ucin  (
    .a(1'b0),
    .o({\norm/sub3/c0 ,open_n105}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub4/u0  (
    .a(\norm/sglc_e [3]),
    .b(1'b1),
    .c(\norm/sub4/c0 ),
    .o({\norm/sub4/c1 ,n4[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub4/u1  (
    .a(\norm/sglc_e [4]),
    .b(1'b0),
    .c(\norm/sub4/c1 ),
    .o({\norm/sub4/c2 ,n4[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub4/u2  (
    .a(\norm/sglc_e [5]),
    .b(1'b0),
    .c(\norm/sub4/c2 ),
    .o({\norm/sub4/c3 ,n4[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub4/u3  (
    .a(\norm/sglc_e [6]),
    .b(1'b0),
    .c(\norm/sub4/c3 ),
    .o({\norm/sub4/c4 ,n4[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub4/u4  (
    .a(\norm/sglc_e [7]),
    .b(1'b0),
    .c(\norm/sub4/c4 ),
    .o({\norm/sub4/c5 ,n4[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub4/u5  (
    .a(\norm/sglc_e [8]),
    .b(1'b0),
    .c(\norm/sub4/c5 ),
    .o({open_n106,n4[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub4/ucin  (
    .a(1'b0),
    .o({\norm/sub4/c0 ,open_n109}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u0  (
    .a(\norm/sglc_e [1]),
    .b(1'b1),
    .c(\norm/sub5/c0 ),
    .o({\norm/sub5/c1 ,n5[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u1  (
    .a(\norm/sglc_e [2]),
    .b(1'b1),
    .c(\norm/sub5/c1 ),
    .o({\norm/sub5/c2 ,n5[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u2  (
    .a(\norm/sglc_e [3]),
    .b(1'b0),
    .c(\norm/sub5/c2 ),
    .o({\norm/sub5/c3 ,n5[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u3  (
    .a(\norm/sglc_e [4]),
    .b(1'b0),
    .c(\norm/sub5/c3 ),
    .o({\norm/sub5/c4 ,n5[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u4  (
    .a(\norm/sglc_e [5]),
    .b(1'b0),
    .c(\norm/sub5/c4 ),
    .o({\norm/sub5/c5 ,n5[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u5  (
    .a(\norm/sglc_e [6]),
    .b(1'b0),
    .c(\norm/sub5/c5 ),
    .o({\norm/sub5/c6 ,n5[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u6  (
    .a(\norm/sglc_e [7]),
    .b(1'b0),
    .c(\norm/sub5/c6 ),
    .o({\norm/sub5/c7 ,n5[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub5/u7  (
    .a(\norm/sglc_e [8]),
    .b(1'b0),
    .c(\norm/sub5/c7 ),
    .o({open_n110,n5[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub5/ucin  (
    .a(1'b0),
    .o({\norm/sub5/c0 ,open_n113}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub6/u0  (
    .a(\norm/sglc_e [2]),
    .b(1'b1),
    .c(\norm/sub6/c0 ),
    .o({\norm/sub6/c1 ,n6[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub6/u1  (
    .a(\norm/sglc_e [3]),
    .b(1'b0),
    .c(\norm/sub6/c1 ),
    .o({\norm/sub6/c2 ,n6[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub6/u2  (
    .a(\norm/sglc_e [4]),
    .b(1'b0),
    .c(\norm/sub6/c2 ),
    .o({\norm/sub6/c3 ,n6[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub6/u3  (
    .a(\norm/sglc_e [5]),
    .b(1'b0),
    .c(\norm/sub6/c3 ),
    .o({\norm/sub6/c4 ,n6[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub6/u4  (
    .a(\norm/sglc_e [6]),
    .b(1'b0),
    .c(\norm/sub6/c4 ),
    .o({\norm/sub6/c5 ,n6[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub6/u5  (
    .a(\norm/sglc_e [7]),
    .b(1'b0),
    .c(\norm/sub6/c5 ),
    .o({\norm/sub6/c6 ,n6[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub6/u6  (
    .a(\norm/sglc_e [8]),
    .b(1'b0),
    .c(\norm/sub6/c6 ),
    .o({open_n114,n6[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub6/ucin  (
    .a(1'b0),
    .o({\norm/sub6/c0 ,open_n117}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub7/u0  (
    .a(\norm/sglc_e [1]),
    .b(1'b1),
    .c(\norm/sub7/c0 ),
    .o({\norm/sub7/c1 ,n7[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub7/u1  (
    .a(\norm/sglc_e [2]),
    .b(1'b0),
    .c(\norm/sub7/c1 ),
    .o({\norm/sub7/c2 ,n7[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub7/u2  (
    .a(\norm/sglc_e [3]),
    .b(1'b0),
    .c(\norm/sub7/c2 ),
    .o({\norm/sub7/c3 ,n7[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub7/u3  (
    .a(\norm/sglc_e [4]),
    .b(1'b0),
    .c(\norm/sub7/c3 ),
    .o({\norm/sub7/c4 ,n7[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub7/u4  (
    .a(\norm/sglc_e [5]),
    .b(1'b0),
    .c(\norm/sub7/c4 ),
    .o({\norm/sub7/c5 ,n7[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub7/u5  (
    .a(\norm/sglc_e [6]),
    .b(1'b0),
    .c(\norm/sub7/c5 ),
    .o({\norm/sub7/c6 ,n7[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub7/u6  (
    .a(\norm/sglc_e [7]),
    .b(1'b0),
    .c(\norm/sub7/c6 ),
    .o({\norm/sub7/c7 ,n7[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub7/u7  (
    .a(\norm/sglc_e [8]),
    .b(1'b0),
    .c(\norm/sub7/c7 ),
    .o({open_n118,n7[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub7/ucin  (
    .a(1'b0),
    .o({\norm/sub7/c0 ,open_n121}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub8/u0  (
    .a(\norm/sglc_e [0]),
    .b(1'b1),
    .c(\norm/sub8/c0 ),
    .o({\norm/sub8/c1 ,\norm/n24 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub8/u1  (
    .a(\norm/sglc_e [1]),
    .b(1'b0),
    .c(\norm/sub8/c1 ),
    .o({\norm/sub8/c2 ,\norm/n24 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub8/u2  (
    .a(\norm/sglc_e [2]),
    .b(1'b0),
    .c(\norm/sub8/c2 ),
    .o({\norm/sub8/c3 ,\norm/n24 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub8/u3  (
    .a(\norm/sglc_e [3]),
    .b(1'b0),
    .c(\norm/sub8/c3 ),
    .o({\norm/sub8/c4 ,\norm/n24 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub8/u4  (
    .a(\norm/sglc_e [4]),
    .b(1'b0),
    .c(\norm/sub8/c4 ),
    .o({\norm/sub8/c5 ,\norm/n24 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub8/u5  (
    .a(\norm/sglc_e [5]),
    .b(1'b0),
    .c(\norm/sub8/c5 ),
    .o({\norm/sub8/c6 ,\norm/n24 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub8/u6  (
    .a(\norm/sglc_e [6]),
    .b(1'b0),
    .c(\norm/sub8/c6 ),
    .o({\norm/sub8/c7 ,\norm/n24 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub8/u7  (
    .a(\norm/sglc_e [7]),
    .b(1'b0),
    .c(\norm/sub8/c7 ),
    .o({\norm/sub8/c8 ,\norm/n24 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \norm/sub8/u8  (
    .a(\norm/sglc_e [8]),
    .b(1'b0),
    .c(\norm/sub8/c8 ),
    .o({open_n122,\norm/n24 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \norm/sub8/ucin  (
    .a(1'b0),
    .o({\norm/sub8/c0 ,open_n125}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add0/u0  (
    .a(sgla_e[0]),
    .b(\sgla/sgla_e_dif [0]),
    .c(\sgla/add0/c0 ),
    .o({\sgla/add0/c1 ,\sgla/n11 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add0/u1  (
    .a(sgla_e[1]),
    .b(\sgla/sgla_e_dif [1]),
    .c(\sgla/add0/c1 ),
    .o({\sgla/add0/c2 ,\sgla/n11 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add0/u2  (
    .a(sgla_e[2]),
    .b(\sgla/sgla_e_dif [2]),
    .c(\sgla/add0/c2 ),
    .o({\sgla/add0/c3 ,\sgla/n11 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add0/u3  (
    .a(sgla_e[3]),
    .b(\sgla/sgla_e_dif [3]),
    .c(\sgla/add0/c3 ),
    .o({\sgla/add0/c4 ,\sgla/n11 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add0/u4  (
    .a(sgla_e[4]),
    .b(\sgla/sgla_e_dif [4]),
    .c(\sgla/add0/c4 ),
    .o({\sgla/add0/c5 ,\sgla/n11 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add0/u5  (
    .a(sgla_e[5]),
    .b(\sgla/sgla_e_dif [5]),
    .c(\sgla/add0/c5 ),
    .o({\sgla/add0/c6 ,\sgla/n11 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add0/u6  (
    .a(sgla_e[6]),
    .b(\sgla/sgla_e_dif [6]),
    .c(\sgla/add0/c6 ),
    .o({\sgla/add0/c7 ,\sgla/n11 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add0/u7  (
    .a(sgla_e[7]),
    .b(\sgla/sgla_e_dif [7]),
    .c(\sgla/add0/c7 ),
    .o({\sgla/add0/c8 ,\sgla/n11 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add0/u8  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/add0/c8 ),
    .o({open_n126,\sgla/n11 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \sgla/add0/ucin  (
    .a(1'b0),
    .o({\sgla/add0/c0 ,open_n129}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add1/u0  (
    .a(sgla_e[4]),
    .b(1'b1),
    .c(\sgla/add1/c0 ),
    .o({\sgla/add1/c1 ,\sgla/n15 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add1/u1  (
    .a(sgla_e[5]),
    .b(1'b0),
    .c(\sgla/add1/c1 ),
    .o({\sgla/add1/c2 ,\sgla/n15 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add1/u2  (
    .a(sgla_e[6]),
    .b(1'b0),
    .c(\sgla/add1/c2 ),
    .o({\sgla/add1/c3 ,\sgla/n15 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add1/u3  (
    .a(sgla_e[7]),
    .b(1'b0),
    .c(\sgla/add1/c3 ),
    .o({\sgla/add1/c4 ,\sgla/n15 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add1/u4  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/add1/c4 ),
    .o({open_n130,\sgla/n15 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \sgla/add1/ucin  (
    .a(1'b0),
    .o({\sgla/add1/c0 ,open_n133}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add2/u0  (
    .a(sgla_e[3]),
    .b(1'b1),
    .c(\sgla/add2/c0 ),
    .o({\sgla/add2/c1 ,\sgla/n20 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add2/u1  (
    .a(sgla_e[4]),
    .b(1'b0),
    .c(\sgla/add2/c1 ),
    .o({\sgla/add2/c2 ,\sgla/n20 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add2/u2  (
    .a(sgla_e[5]),
    .b(1'b0),
    .c(\sgla/add2/c2 ),
    .o({\sgla/add2/c3 ,\sgla/n20 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add2/u3  (
    .a(sgla_e[6]),
    .b(1'b0),
    .c(\sgla/add2/c3 ),
    .o({\sgla/add2/c4 ,\sgla/n20 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add2/u4  (
    .a(sgla_e[7]),
    .b(1'b0),
    .c(\sgla/add2/c4 ),
    .o({\sgla/add2/c5 ,\sgla/n20 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add2/u5  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/add2/c5 ),
    .o({open_n134,\sgla/n20 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \sgla/add2/ucin  (
    .a(1'b0),
    .o({\sgla/add2/c0 ,open_n137}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add3/u0  (
    .a(sgla_e[2]),
    .b(1'b1),
    .c(\sgla/add3/c0 ),
    .o({\sgla/add3/c1 ,\sgla/n28 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add3/u1  (
    .a(sgla_e[3]),
    .b(1'b0),
    .c(\sgla/add3/c1 ),
    .o({\sgla/add3/c2 ,\sgla/n28 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add3/u2  (
    .a(sgla_e[4]),
    .b(1'b0),
    .c(\sgla/add3/c2 ),
    .o({\sgla/add3/c3 ,\sgla/n28 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add3/u3  (
    .a(sgla_e[5]),
    .b(1'b0),
    .c(\sgla/add3/c3 ),
    .o({\sgla/add3/c4 ,\sgla/n28 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add3/u4  (
    .a(sgla_e[6]),
    .b(1'b0),
    .c(\sgla/add3/c4 ),
    .o({\sgla/add3/c5 ,\sgla/n28 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add3/u5  (
    .a(sgla_e[7]),
    .b(1'b0),
    .c(\sgla/add3/c5 ),
    .o({\sgla/add3/c6 ,\sgla/n28 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add3/u6  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/add3/c6 ),
    .o({open_n138,\sgla/n28 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \sgla/add3/ucin  (
    .a(1'b0),
    .o({\sgla/add3/c0 ,open_n141}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add4/u0  (
    .a(sgla_e[1]),
    .b(1'b1),
    .c(\sgla/add4/c0 ),
    .o({\sgla/add4/c1 ,\sgla/n33 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add4/u1  (
    .a(sgla_e[2]),
    .b(1'b0),
    .c(\sgla/add4/c1 ),
    .o({\sgla/add4/c2 ,\sgla/n33 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add4/u2  (
    .a(sgla_e[3]),
    .b(1'b0),
    .c(\sgla/add4/c2 ),
    .o({\sgla/add4/c3 ,\sgla/n33 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add4/u3  (
    .a(sgla_e[4]),
    .b(1'b0),
    .c(\sgla/add4/c3 ),
    .o({\sgla/add4/c4 ,\sgla/n33 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add4/u4  (
    .a(sgla_e[5]),
    .b(1'b0),
    .c(\sgla/add4/c4 ),
    .o({\sgla/add4/c5 ,\sgla/n33 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add4/u5  (
    .a(sgla_e[6]),
    .b(1'b0),
    .c(\sgla/add4/c5 ),
    .o({\sgla/add4/c6 ,\sgla/n33 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add4/u6  (
    .a(sgla_e[7]),
    .b(1'b0),
    .c(\sgla/add4/c6 ),
    .o({\sgla/add4/c7 ,\sgla/n33 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add4/u7  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/add4/c7 ),
    .o({open_n142,\sgla/n33 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \sgla/add4/ucin  (
    .a(1'b0),
    .o({\sgla/add4/c0 ,open_n145}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add5/u0  (
    .a(sgla_e[0]),
    .b(1'b1),
    .c(\sgla/add5/c0 ),
    .o({\sgla/add5/c1 ,\sgla/n39 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add5/u1  (
    .a(sgla_e[1]),
    .b(1'b0),
    .c(\sgla/add5/c1 ),
    .o({\sgla/add5/c2 ,\sgla/n39 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add5/u2  (
    .a(sgla_e[2]),
    .b(1'b0),
    .c(\sgla/add5/c2 ),
    .o({\sgla/add5/c3 ,\sgla/n39 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add5/u3  (
    .a(sgla_e[3]),
    .b(1'b0),
    .c(\sgla/add5/c3 ),
    .o({\sgla/add5/c4 ,\sgla/n39 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add5/u4  (
    .a(sgla_e[4]),
    .b(1'b0),
    .c(\sgla/add5/c4 ),
    .o({\sgla/add5/c5 ,\sgla/n39 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add5/u5  (
    .a(sgla_e[5]),
    .b(1'b0),
    .c(\sgla/add5/c5 ),
    .o({\sgla/add5/c6 ,\sgla/n39 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add5/u6  (
    .a(sgla_e[6]),
    .b(1'b0),
    .c(\sgla/add5/c6 ),
    .o({\sgla/add5/c7 ,\sgla/n39 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add5/u7  (
    .a(sgla_e[7]),
    .b(1'b0),
    .c(\sgla/add5/c7 ),
    .o({\sgla/add5/c8 ,\sgla/n39 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sgla/add5/u8  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/add5/c8 ),
    .o({open_n146,\sgla/n39 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \sgla/add5/ucin  (
    .a(1'b0),
    .o({\sgla/add5/c0 ,open_n149}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt0_0  (
    .a(\sgla/sgla_e_dif [0]),
    .b(1'b0),
    .c(\sgla/lt0_c0 ),
    .o({\sgla/lt0_c1 ,open_n150}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt0_1  (
    .a(\sgla/sgla_e_dif [1]),
    .b(1'b0),
    .c(\sgla/lt0_c1 ),
    .o({\sgla/lt0_c2 ,open_n151}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt0_2  (
    .a(\sgla/sgla_e_dif [2]),
    .b(1'b0),
    .c(\sgla/lt0_c2 ),
    .o({\sgla/lt0_c3 ,open_n152}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt0_3  (
    .a(\sgla/sgla_e_dif [3]),
    .b(1'b0),
    .c(\sgla/lt0_c3 ),
    .o({\sgla/lt0_c4 ,open_n153}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt0_4  (
    .a(\sgla/sgla_e_dif [4]),
    .b(1'b0),
    .c(\sgla/lt0_c4 ),
    .o({\sgla/lt0_c5 ,open_n154}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt0_5  (
    .a(\sgla/sgla_e_dif [5]),
    .b(1'b0),
    .c(\sgla/lt0_c5 ),
    .o({\sgla/lt0_c6 ,open_n155}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt0_6  (
    .a(\sgla/sgla_e_dif [6]),
    .b(1'b0),
    .c(\sgla/lt0_c6 ),
    .o({\sgla/lt0_c7 ,open_n156}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt0_7  (
    .a(\sgla/sgla_e_dif [7]),
    .b(1'b0),
    .c(\sgla/lt0_c7 ),
    .o({\sgla/lt0_c8 ,open_n157}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt0_8  (
    .a(1'b0),
    .b(\sgla/sgla_e_dif [8]),
    .c(\sgla/lt0_c8 ),
    .o({\sgla/lt0_c9 ,open_n158}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \sgla/lt0_cin  (
    .a(1'b1),
    .o({\sgla/lt0_c0 ,open_n161}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt0_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\sgla/lt0_c9 ),
    .o({open_n162,\sgla/sgla_rsft_fin }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt1_0  (
    .a(\sgla/sgla_e_difl [0]),
    .b(1'b0),
    .c(\sgla/lt1_c0 ),
    .o({\sgla/lt1_c1 ,open_n163}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt1_1  (
    .a(\sgla/sgla_e_difl [1]),
    .b(1'b0),
    .c(\sgla/lt1_c1 ),
    .o({\sgla/lt1_c2 ,open_n164}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt1_2  (
    .a(\sgla/sgla_e_difl [2]),
    .b(1'b0),
    .c(\sgla/lt1_c2 ),
    .o({\sgla/lt1_c3 ,open_n165}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt1_3  (
    .a(\sgla/sgla_e_difl [3]),
    .b(1'b0),
    .c(\sgla/lt1_c3 ),
    .o({\sgla/lt1_c4 ,open_n166}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt1_4  (
    .a(\sgla/sgla_e_difl [4]),
    .b(1'b0),
    .c(\sgla/lt1_c4 ),
    .o({\sgla/lt1_c5 ,open_n167}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt1_5  (
    .a(\sgla/sgla_e_difl [5]),
    .b(1'b0),
    .c(\sgla/lt1_c5 ),
    .o({\sgla/lt1_c6 ,open_n168}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt1_6  (
    .a(\sgla/sgla_e_difl [6]),
    .b(1'b0),
    .c(\sgla/lt1_c6 ),
    .o({\sgla/lt1_c7 ,open_n169}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt1_7  (
    .a(\sgla/sgla_e_difl [7]),
    .b(1'b0),
    .c(\sgla/lt1_c7 ),
    .o({\sgla/lt1_c8 ,open_n170}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt1_8  (
    .a(1'b0),
    .b(\sgla/sgla_e_difl [8]),
    .c(\sgla/lt1_c8 ),
    .o({\sgla/lt1_c9 ,open_n171}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \sgla/lt1_cin  (
    .a(1'b1),
    .o({\sgla/lt1_c0 ,open_n174}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt1_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\sgla/lt1_c9 ),
    .o({open_n175,\sgla/sgla_lsft_fin }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt2_0  (
    .a(1'b1),
    .b(sgla_e[0]),
    .c(\sgla/lt2_c0 ),
    .o({\sgla/lt2_c1 ,open_n176}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt2_1  (
    .a(1'b1),
    .b(sgla_e[1]),
    .c(\sgla/lt2_c1 ),
    .o({\sgla/lt2_c2 ,open_n177}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt2_2  (
    .a(1'b1),
    .b(sgla_e[2]),
    .c(\sgla/lt2_c2 ),
    .o({\sgla/lt2_c3 ,open_n178}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt2_3  (
    .a(1'b0),
    .b(sgla_e[3]),
    .c(\sgla/lt2_c3 ),
    .o({\sgla/lt2_c4 ,open_n179}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt2_4  (
    .a(1'b1),
    .b(sgla_e[4]),
    .c(\sgla/lt2_c4 ),
    .o({\sgla/lt2_c5 ,open_n180}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt2_5  (
    .a(1'b0),
    .b(sgla_e[5]),
    .c(\sgla/lt2_c5 ),
    .o({\sgla/lt2_c6 ,open_n181}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt2_6  (
    .a(1'b0),
    .b(sgla_e[6]),
    .c(\sgla/lt2_c6 ),
    .o({\sgla/lt2_c7 ,open_n182}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt2_7  (
    .a(1'b0),
    .b(sgla_e[7]),
    .c(\sgla/lt2_c7 ),
    .o({\sgla/lt2_c8 ,open_n183}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt2_8  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/lt2_c8 ),
    .o({\sgla/lt2_c9 ,open_n184}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \sgla/lt2_cin  (
    .a(1'b1),
    .o({\sgla/lt2_c0 ,open_n187}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt2_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\sgla/lt2_c9 ),
    .o({open_n188,\sgla/n184 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt3_0  (
    .a(sgla_e[0]),
    .b(1'b0),
    .c(\sgla/lt3_c0 ),
    .o({\sgla/lt3_c1 ,open_n189}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt3_1  (
    .a(sgla_e[1]),
    .b(1'b0),
    .c(\sgla/lt3_c1 ),
    .o({\sgla/lt3_c2 ,open_n190}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt3_2  (
    .a(sgla_e[2]),
    .b(1'b0),
    .c(\sgla/lt3_c2 ),
    .o({\sgla/lt3_c3 ,open_n191}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt3_3  (
    .a(sgla_e[3]),
    .b(1'b0),
    .c(\sgla/lt3_c3 ),
    .o({\sgla/lt3_c4 ,open_n192}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt3_4  (
    .a(sgla_e[4]),
    .b(1'b0),
    .c(\sgla/lt3_c4 ),
    .o({\sgla/lt3_c5 ,open_n193}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt3_5  (
    .a(sgla_e[5]),
    .b(1'b0),
    .c(\sgla/lt3_c5 ),
    .o({\sgla/lt3_c6 ,open_n194}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt3_6  (
    .a(sgla_e[6]),
    .b(1'b0),
    .c(\sgla/lt3_c6 ),
    .o({\sgla/lt3_c7 ,open_n195}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt3_7  (
    .a(sgla_e[7]),
    .b(1'b0),
    .c(\sgla/lt3_c7 ),
    .o({\sgla/lt3_c8 ,open_n196}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt3_8  (
    .a(1'b0),
    .b(sgla_e[8]),
    .c(\sgla/lt3_c8 ),
    .o({\sgla/lt3_c9 ,open_n197}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \sgla/lt3_cin  (
    .a(1'b0),
    .o({\sgla/lt3_c0 ,open_n200}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt3_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\sgla/lt3_c9 ),
    .o({open_n201,\sgla/n186 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt4_2_0  (
    .a(1'b0),
    .b(sgla_e[0]),
    .c(\sgla/lt4_2_c0 ),
    .o({\sgla/lt4_2_c1 ,open_n202}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt4_2_1  (
    .a(1'b0),
    .b(sgla_e[1]),
    .c(\sgla/lt4_2_c1 ),
    .o({\sgla/lt4_2_c2 ,open_n203}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt4_2_2  (
    .a(1'b0),
    .b(sgla_e[2]),
    .c(\sgla/lt4_2_c2 ),
    .o({\sgla/lt4_2_c3 ,open_n204}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt4_2_3  (
    .a(1'b0),
    .b(sgla_e[3]),
    .c(\sgla/lt4_2_c3 ),
    .o({\sgla/lt4_2_c4 ,open_n205}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt4_2_4  (
    .a(1'b0),
    .b(sgla_e[4]),
    .c(\sgla/lt4_2_c4 ),
    .o({\sgla/lt4_2_c5 ,open_n206}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt4_2_5  (
    .a(1'b0),
    .b(sgla_e[5]),
    .c(\sgla/lt4_2_c5 ),
    .o({\sgla/lt4_2_c6 ,open_n207}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt4_2_6  (
    .a(1'b0),
    .b(sgla_e[6]),
    .c(\sgla/lt4_2_c6 ),
    .o({\sgla/lt4_2_c7 ,open_n208}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt4_2_7  (
    .a(1'b0),
    .b(sgla_e[7]),
    .c(\sgla/lt4_2_c7 ),
    .o({\sgla/lt4_2_c8 ,open_n209}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt4_2_8  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/lt4_2_c8 ),
    .o({\sgla/lt4_2_c9 ,open_n210}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \sgla/lt4_2_cin  (
    .a(1'b1),
    .o({\sgla/lt4_2_c0 ,open_n213}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt4_2_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\sgla/lt4_2_c9 ),
    .o({open_n214,\sgla/n187 }));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt5_0  (
    .a(sgla_e[0]),
    .b(1'b1),
    .c(\sgla/lt5_c0 ),
    .o({\sgla/lt5_c1 ,open_n215}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt5_1  (
    .a(sgla_e[1]),
    .b(1'b1),
    .c(\sgla/lt5_c1 ),
    .o({\sgla/lt5_c2 ,open_n216}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt5_2  (
    .a(sgla_e[2]),
    .b(1'b1),
    .c(\sgla/lt5_c2 ),
    .o({\sgla/lt5_c3 ,open_n217}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt5_3  (
    .a(sgla_e[3]),
    .b(1'b0),
    .c(\sgla/lt5_c3 ),
    .o({\sgla/lt5_c4 ,open_n218}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt5_4  (
    .a(sgla_e[4]),
    .b(1'b1),
    .c(\sgla/lt5_c4 ),
    .o({\sgla/lt5_c5 ,open_n219}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt5_5  (
    .a(sgla_e[5]),
    .b(1'b0),
    .c(\sgla/lt5_c5 ),
    .o({\sgla/lt5_c6 ,open_n220}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt5_6  (
    .a(sgla_e[6]),
    .b(1'b0),
    .c(\sgla/lt5_c6 ),
    .o({\sgla/lt5_c7 ,open_n221}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt5_7  (
    .a(sgla_e[7]),
    .b(1'b0),
    .c(\sgla/lt5_c7 ),
    .o({\sgla/lt5_c8 ,open_n222}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt5_8  (
    .a(1'b0),
    .b(sgla_e[8]),
    .c(\sgla/lt5_c8 ),
    .o({\sgla/lt5_c9 ,open_n223}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \sgla/lt5_cin  (
    .a(1'b0),
    .o({\sgla/lt5_c0 ,open_n226}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sgla/lt5_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\sgla/lt5_c9 ),
    .o({open_n227,\sgla/n188 }));
  reg_sr_as_w1 \sgla/reg0_b0  (
    .clk(clk),
    .d(\sgla/n84 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_e[0]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg0_b1  (
    .clk(clk),
    .d(\sgla/n84 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_e[1]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg0_b2  (
    .clk(clk),
    .d(\sgla/n84 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_e[2]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg0_b3  (
    .clk(clk),
    .d(\sgla/n84 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_e[3]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg0_b4  (
    .clk(clk),
    .d(\sgla/n84 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_e[4]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg0_b5  (
    .clk(clk),
    .d(\sgla/n84 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_e[5]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg0_b6  (
    .clk(clk),
    .d(\sgla/n84 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_e[6]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg0_b7  (
    .clk(clk),
    .d(\sgla/n84 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_e[7]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg0_b8  (
    .clk(clk),
    .d(\sgla/n84 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_e[8]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b0  (
    .clk(clk),
    .d(\sgla/n80 [0]),
    .en(1'b1),
    .reset(~\sgla/mux30_b0_sel_is_2_o ),
    .set(1'b0),
    .q(sgla_r[0]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b1  (
    .clk(clk),
    .d(\sgla/n80 [1]),
    .en(1'b1),
    .reset(~\sgla/mux30_b0_sel_is_2_o ),
    .set(1'b0),
    .q(sgla_r[1]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b10  (
    .clk(clk),
    .d(\sgla/n85 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[10]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b11  (
    .clk(clk),
    .d(\sgla/n85 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[11]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b12  (
    .clk(clk),
    .d(\sgla/n85 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[12]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b13  (
    .clk(clk),
    .d(\sgla/n85 [13]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[13]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b14  (
    .clk(clk),
    .d(\sgla/n85 [14]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[14]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b15  (
    .clk(clk),
    .d(\sgla/n85 [15]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[15]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b16  (
    .clk(clk),
    .d(\sgla/n85 [16]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[16]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b17  (
    .clk(clk),
    .d(\sgla/n85 [17]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[17]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b18  (
    .clk(clk),
    .d(\sgla/n85 [18]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[18]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b19  (
    .clk(clk),
    .d(\sgla/n85 [19]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[19]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b2  (
    .clk(clk),
    .d(\sgla/n80 [2]),
    .en(1'b1),
    .reset(~\sgla/mux30_b0_sel_is_2_o ),
    .set(1'b0),
    .q(sgla_r[2]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b20  (
    .clk(clk),
    .d(\sgla/n85 [20]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[20]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b21  (
    .clk(clk),
    .d(\sgla/n85 [21]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[21]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b22  (
    .clk(clk),
    .d(\sgla/n85 [22]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[22]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b23  (
    .clk(clk),
    .d(\sgla/n85 [23]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[23]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b24  (
    .clk(clk),
    .d(\sgla/n85 [24]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[24]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b25  (
    .clk(clk),
    .d(\sgla/n85 [25]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[25]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b26  (
    .clk(clk),
    .d(\sgla/n85 [26]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[26]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b27  (
    .clk(clk),
    .d(\sgla/n85 [27]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[27]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b28  (
    .clk(clk),
    .d(\sgla/n85 [28]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[28]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b29  (
    .clk(clk),
    .d(\sgla/n74 [29]),
    .en(1'b1),
    .reset(~\sgla/mux30_b29_sel_is_2_o ),
    .set(1'b0),
    .q(sgla_r[29]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b3  (
    .clk(clk),
    .d(\sgla/n80 [3]),
    .en(1'b1),
    .reset(~\sgla/mux30_b0_sel_is_2_o ),
    .set(1'b0),
    .q(sgla_r[3]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b30  (
    .clk(clk),
    .d(\sgla/n72 [30]),
    .en(1'b1),
    .reset(~\sgla/mux30_b30_sel_is_2_o ),
    .set(1'b0),
    .q(sgla_r[30]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b31  (
    .clk(clk),
    .d(\sgla/n68 [31]),
    .en(1'b1),
    .reset(~\sgla/mux30_b31_sel_is_2_o ),
    .set(1'b0),
    .q(sgla_r[31]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b4  (
    .clk(clk),
    .d(\sgla/n80 [4]),
    .en(1'b1),
    .reset(~\sgla/mux30_b0_sel_is_2_o ),
    .set(1'b0),
    .q(sgla_r[4]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b5  (
    .clk(clk),
    .d(\sgla/n85 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[5]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b6  (
    .clk(clk),
    .d(\sgla/n85 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[6]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b7  (
    .clk(clk),
    .d(\sgla/n85 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[7]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b8  (
    .clk(clk),
    .d(\sgla/n85 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[8]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg1_b9  (
    .clk(clk),
    .d(\sgla/n85 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[9]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg2_b0  (
    .clk(clk),
    .d(ccmd[0]),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/ccmd_f [0]));  // rtl/sglfpu.v(1205)
  reg_sr_as_w1 \sgla/reg2_b1  (
    .clk(clk),
    .d(ccmd[1]),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/ccmd_f [1]));  // rtl/sglfpu.v(1205)
  reg_sr_as_w1 \sgla/reg2_b2  (
    .clk(clk),
    .d(ccmd[2]),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/ccmd_f [2]));  // rtl/sglfpu.v(1205)
  reg_sr_as_w1 \sgla/reg2_b3  (
    .clk(clk),
    .d(ccmd[3]),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/ccmd_f [3]));  // rtl/sglfpu.v(1205)
  reg_sr_as_w1 \sgla/reg2_b4  (
    .clk(clk),
    .d(ccmd[4]),
    .en(crdy),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/ccmd_f [4]));  // rtl/sglfpu.v(1205)
  reg_sr_as_w1 \sgla/reg3_b0  (
    .clk(clk),
    .d(abus[0]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [0]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b1  (
    .clk(clk),
    .d(abus[1]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [1]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b10  (
    .clk(clk),
    .d(abus[10]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [10]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b11  (
    .clk(clk),
    .d(abus[11]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [11]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b12  (
    .clk(clk),
    .d(abus[12]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [12]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b13  (
    .clk(clk),
    .d(abus[13]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [13]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b14  (
    .clk(clk),
    .d(abus[14]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [14]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b15  (
    .clk(clk),
    .d(abus[15]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [15]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b16  (
    .clk(clk),
    .d(abus[16]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [16]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b17  (
    .clk(clk),
    .d(abus[17]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [17]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b18  (
    .clk(clk),
    .d(abus[18]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [18]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b19  (
    .clk(clk),
    .d(abus[19]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [19]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b2  (
    .clk(clk),
    .d(abus[2]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [2]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b20  (
    .clk(clk),
    .d(abus[20]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [20]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b21  (
    .clk(clk),
    .d(abus[21]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [21]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b22  (
    .clk(clk),
    .d(abus[22]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [22]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b23  (
    .clk(clk),
    .d(abus[23]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [23]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b24  (
    .clk(clk),
    .d(abus[24]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [24]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b25  (
    .clk(clk),
    .d(abus[25]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [25]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b26  (
    .clk(clk),
    .d(abus[26]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [26]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b27  (
    .clk(clk),
    .d(abus[27]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [27]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b28  (
    .clk(clk),
    .d(abus[28]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [28]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b29  (
    .clk(clk),
    .d(abus[29]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [29]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b3  (
    .clk(clk),
    .d(abus[3]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [3]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b30  (
    .clk(clk),
    .d(abus[30]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [30]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b31  (
    .clk(clk),
    .d(abus[31]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(sgla_r[41]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b4  (
    .clk(clk),
    .d(abus[4]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [4]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b5  (
    .clk(clk),
    .d(abus[5]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [5]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b6  (
    .clk(clk),
    .d(abus[6]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [6]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b7  (
    .clk(clk),
    .d(abus[7]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [7]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b8  (
    .clk(clk),
    .d(abus[8]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [8]));  // rtl/sglfpu.v(1175)
  reg_sr_as_w1 \sgla/reg3_b9  (
    .clk(clk),
    .d(abus[9]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sgla/sgla_i [9]));  // rtl/sglfpu.v(1175)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub0/u0  (
    .a(abus[23]),
    .b(1'b1),
    .c(\sgla/sub0/c0 ),
    .o({\sgla/sub0/c1 ,\sgla/n2 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub0/u1  (
    .a(abus[24]),
    .b(1'b1),
    .c(\sgla/sub0/c1 ),
    .o({\sgla/sub0/c2 ,\sgla/n2 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub0/u2  (
    .a(abus[25]),
    .b(1'b1),
    .c(\sgla/sub0/c2 ),
    .o({\sgla/sub0/c3 ,\sgla/n2 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub0/u3  (
    .a(abus[26]),
    .b(1'b1),
    .c(\sgla/sub0/c3 ),
    .o({\sgla/sub0/c4 ,\sgla/n2 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub0/u4  (
    .a(abus[27]),
    .b(1'b1),
    .c(\sgla/sub0/c4 ),
    .o({\sgla/sub0/c5 ,\sgla/n2 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub0/u5  (
    .a(abus[28]),
    .b(1'b1),
    .c(\sgla/sub0/c5 ),
    .o({\sgla/sub0/c6 ,\sgla/n2 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub0/u6  (
    .a(abus[29]),
    .b(1'b1),
    .c(\sgla/sub0/c6 ),
    .o({\sgla/sub0/c7 ,\sgla/n2 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub0/u7  (
    .a(abus[30]),
    .b(1'b0),
    .c(\sgla/sub0/c7 ),
    .o({\sgla/sub0/c8 ,\sgla/n2 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \sgla/sub0/ucin  (
    .a(1'b0),
    .o({\sgla/sub0/c0 ,open_n230}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub0/ucout  (
    .c(\sgla/sub0/c8 ),
    .o({open_n233,\sgla/n2 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub1/u0  (
    .a(sgla_e[0]),
    .b(\sgla/sgla_e_difl [0]),
    .c(\sgla/sub1/c0 ),
    .o({\sgla/sub1/c1 ,\sgla/n48 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub1/u1  (
    .a(sgla_e[1]),
    .b(\sgla/sgla_e_difl [1]),
    .c(\sgla/sub1/c1 ),
    .o({\sgla/sub1/c2 ,\sgla/n48 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub1/u2  (
    .a(sgla_e[2]),
    .b(\sgla/sgla_e_difl [2]),
    .c(\sgla/sub1/c2 ),
    .o({\sgla/sub1/c3 ,\sgla/n48 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub1/u3  (
    .a(sgla_e[3]),
    .b(\sgla/sgla_e_difl [3]),
    .c(\sgla/sub1/c3 ),
    .o({\sgla/sub1/c4 ,\sgla/n48 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub1/u4  (
    .a(sgla_e[4]),
    .b(\sgla/sgla_e_difl [4]),
    .c(\sgla/sub1/c4 ),
    .o({\sgla/sub1/c5 ,\sgla/n48 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub1/u5  (
    .a(sgla_e[5]),
    .b(\sgla/sgla_e_difl [5]),
    .c(\sgla/sub1/c5 ),
    .o({\sgla/sub1/c6 ,\sgla/n48 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub1/u6  (
    .a(sgla_e[6]),
    .b(\sgla/sgla_e_difl [6]),
    .c(\sgla/sub1/c6 ),
    .o({\sgla/sub1/c7 ,\sgla/n48 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub1/u7  (
    .a(sgla_e[7]),
    .b(\sgla/sgla_e_difl [7]),
    .c(\sgla/sub1/c7 ),
    .o({\sgla/sub1/c8 ,\sgla/n48 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub1/u8  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/sub1/c8 ),
    .o({open_n234,\sgla/n48 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \sgla/sub1/ucin  (
    .a(1'b0),
    .o({\sgla/sub1/c0 ,open_n237}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub2/u0  (
    .a(sgla_e[4]),
    .b(1'b1),
    .c(\sgla/sub2/c0 ),
    .o({\sgla/sub2/c1 ,n8[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub2/u1  (
    .a(sgla_e[5]),
    .b(1'b0),
    .c(\sgla/sub2/c1 ),
    .o({\sgla/sub2/c2 ,n8[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub2/u2  (
    .a(sgla_e[6]),
    .b(1'b0),
    .c(\sgla/sub2/c2 ),
    .o({\sgla/sub2/c3 ,n8[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub2/u3  (
    .a(sgla_e[7]),
    .b(1'b0),
    .c(\sgla/sub2/c3 ),
    .o({\sgla/sub2/c4 ,n8[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub2/u4  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/sub2/c4 ),
    .o({open_n238,n8[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \sgla/sub2/ucin  (
    .a(1'b0),
    .o({\sgla/sub2/c0 ,open_n241}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub3/u0  (
    .a(sgla_e[3]),
    .b(1'b1),
    .c(\sgla/sub3/c0 ),
    .o({\sgla/sub3/c1 ,n9[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub3/u1  (
    .a(sgla_e[4]),
    .b(1'b0),
    .c(\sgla/sub3/c1 ),
    .o({\sgla/sub3/c2 ,n9[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub3/u2  (
    .a(sgla_e[5]),
    .b(1'b0),
    .c(\sgla/sub3/c2 ),
    .o({\sgla/sub3/c3 ,n9[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub3/u3  (
    .a(sgla_e[6]),
    .b(1'b0),
    .c(\sgla/sub3/c3 ),
    .o({\sgla/sub3/c4 ,n9[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub3/u4  (
    .a(sgla_e[7]),
    .b(1'b0),
    .c(\sgla/sub3/c4 ),
    .o({\sgla/sub3/c5 ,n9[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub3/u5  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/sub3/c5 ),
    .o({open_n242,n9[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \sgla/sub3/ucin  (
    .a(1'b0),
    .o({\sgla/sub3/c0 ,open_n245}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub4/u0  (
    .a(sgla_e[2]),
    .b(1'b1),
    .c(\sgla/sub4/c0 ),
    .o({\sgla/sub4/c1 ,n10[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub4/u1  (
    .a(sgla_e[3]),
    .b(1'b0),
    .c(\sgla/sub4/c1 ),
    .o({\sgla/sub4/c2 ,n10[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub4/u2  (
    .a(sgla_e[4]),
    .b(1'b0),
    .c(\sgla/sub4/c2 ),
    .o({\sgla/sub4/c3 ,n10[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub4/u3  (
    .a(sgla_e[5]),
    .b(1'b0),
    .c(\sgla/sub4/c3 ),
    .o({\sgla/sub4/c4 ,n10[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub4/u4  (
    .a(sgla_e[6]),
    .b(1'b0),
    .c(\sgla/sub4/c4 ),
    .o({\sgla/sub4/c5 ,n10[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub4/u5  (
    .a(sgla_e[7]),
    .b(1'b0),
    .c(\sgla/sub4/c5 ),
    .o({\sgla/sub4/c6 ,n10[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub4/u6  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/sub4/c6 ),
    .o({open_n246,n10[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \sgla/sub4/ucin  (
    .a(1'b0),
    .o({\sgla/sub4/c0 ,open_n249}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub5/u0  (
    .a(sgla_e[1]),
    .b(1'b1),
    .c(\sgla/sub5/c0 ),
    .o({\sgla/sub5/c1 ,n11[0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub5/u1  (
    .a(sgla_e[2]),
    .b(1'b0),
    .c(\sgla/sub5/c1 ),
    .o({\sgla/sub5/c2 ,n11[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub5/u2  (
    .a(sgla_e[3]),
    .b(1'b0),
    .c(\sgla/sub5/c2 ),
    .o({\sgla/sub5/c3 ,n11[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub5/u3  (
    .a(sgla_e[4]),
    .b(1'b0),
    .c(\sgla/sub5/c3 ),
    .o({\sgla/sub5/c4 ,n11[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub5/u4  (
    .a(sgla_e[5]),
    .b(1'b0),
    .c(\sgla/sub5/c4 ),
    .o({\sgla/sub5/c5 ,n11[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub5/u5  (
    .a(sgla_e[6]),
    .b(1'b0),
    .c(\sgla/sub5/c5 ),
    .o({\sgla/sub5/c6 ,n11[5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub5/u6  (
    .a(sgla_e[7]),
    .b(1'b0),
    .c(\sgla/sub5/c6 ),
    .o({\sgla/sub5/c7 ,n11[6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub5/u7  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/sub5/c7 ),
    .o({open_n250,n11[7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \sgla/sub5/ucin  (
    .a(1'b0),
    .o({\sgla/sub5/c0 ,open_n253}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub6/u0  (
    .a(sgla_e[0]),
    .b(1'b1),
    .c(\sgla/sub6/c0 ),
    .o({\sgla/sub6/c1 ,\sgla/n58 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub6/u1  (
    .a(sgla_e[1]),
    .b(1'b0),
    .c(\sgla/sub6/c1 ),
    .o({\sgla/sub6/c2 ,\sgla/n58 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub6/u2  (
    .a(sgla_e[2]),
    .b(1'b0),
    .c(\sgla/sub6/c2 ),
    .o({\sgla/sub6/c3 ,\sgla/n58 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub6/u3  (
    .a(sgla_e[3]),
    .b(1'b0),
    .c(\sgla/sub6/c3 ),
    .o({\sgla/sub6/c4 ,\sgla/n58 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub6/u4  (
    .a(sgla_e[4]),
    .b(1'b0),
    .c(\sgla/sub6/c4 ),
    .o({\sgla/sub6/c5 ,\sgla/n58 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub6/u5  (
    .a(sgla_e[5]),
    .b(1'b0),
    .c(\sgla/sub6/c5 ),
    .o({\sgla/sub6/c6 ,\sgla/n58 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub6/u6  (
    .a(sgla_e[6]),
    .b(1'b0),
    .c(\sgla/sub6/c6 ),
    .o({\sgla/sub6/c7 ,\sgla/n58 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub6/u7  (
    .a(sgla_e[7]),
    .b(1'b0),
    .c(\sgla/sub6/c7 ),
    .o({\sgla/sub6/c8 ,\sgla/n58 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub6/u8  (
    .a(sgla_e[8]),
    .b(1'b0),
    .c(\sgla/sub6/c8 ),
    .o({open_n254,\sgla/n58 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \sgla/sub6/ucin  (
    .a(1'b0),
    .o({\sgla/sub6/c0 ,open_n257}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub7/u0  (
    .a(\sgla/sglb_et [0]),
    .b(sgla_e[0]),
    .c(\sgla/sub7/c0 ),
    .o({\sgla/sub7/c1 ,\sgla/sgla_e_dif [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub7/u1  (
    .a(\sgla/sglb_et [1]),
    .b(sgla_e[1]),
    .c(\sgla/sub7/c1 ),
    .o({\sgla/sub7/c2 ,\sgla/sgla_e_dif [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub7/u2  (
    .a(\sgla/sglb_et [2]),
    .b(sgla_e[2]),
    .c(\sgla/sub7/c2 ),
    .o({\sgla/sub7/c3 ,\sgla/sgla_e_dif [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub7/u3  (
    .a(\sgla/sglb_et [3]),
    .b(sgla_e[3]),
    .c(\sgla/sub7/c3 ),
    .o({\sgla/sub7/c4 ,\sgla/sgla_e_dif [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub7/u4  (
    .a(\sgla/sglb_et [4]),
    .b(sgla_e[4]),
    .c(\sgla/sub7/c4 ),
    .o({\sgla/sub7/c5 ,\sgla/sgla_e_dif [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub7/u5  (
    .a(\sgla/sglb_et [5]),
    .b(sgla_e[5]),
    .c(\sgla/sub7/c5 ),
    .o({\sgla/sub7/c6 ,\sgla/sgla_e_dif [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub7/u6  (
    .a(\sgla/sglb_et [6]),
    .b(sgla_e[6]),
    .c(\sgla/sub7/c6 ),
    .o({\sgla/sub7/c7 ,\sgla/sgla_e_dif [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub7/u7  (
    .a(\sgla/sglb_et [7]),
    .b(sgla_e[7]),
    .c(\sgla/sub7/c7 ),
    .o({\sgla/sub7/c8 ,\sgla/sgla_e_dif [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub7/u8  (
    .a(\sgla/sglb_et [8]),
    .b(sgla_e[8]),
    .c(\sgla/sub7/c8 ),
    .o({open_n258,\sgla/sgla_e_dif [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \sgla/sub7/ucin  (
    .a(1'b0),
    .o({\sgla/sub7/c0 ,open_n261}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub8/u0  (
    .a(sgla_e[0]),
    .b(\sgla/sglb_et [0]),
    .c(\sgla/sub8/c0 ),
    .o({\sgla/sub8/c1 ,\sgla/sgla_e_difl [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub8/u1  (
    .a(sgla_e[1]),
    .b(\sgla/sglb_et [1]),
    .c(\sgla/sub8/c1 ),
    .o({\sgla/sub8/c2 ,\sgla/sgla_e_difl [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub8/u2  (
    .a(sgla_e[2]),
    .b(\sgla/sglb_et [2]),
    .c(\sgla/sub8/c2 ),
    .o({\sgla/sub8/c3 ,\sgla/sgla_e_difl [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub8/u3  (
    .a(sgla_e[3]),
    .b(\sgla/sglb_et [3]),
    .c(\sgla/sub8/c3 ),
    .o({\sgla/sub8/c4 ,\sgla/sgla_e_difl [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub8/u4  (
    .a(sgla_e[4]),
    .b(\sgla/sglb_et [4]),
    .c(\sgla/sub8/c4 ),
    .o({\sgla/sub8/c5 ,\sgla/sgla_e_difl [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub8/u5  (
    .a(sgla_e[5]),
    .b(\sgla/sglb_et [5]),
    .c(\sgla/sub8/c5 ),
    .o({\sgla/sub8/c6 ,\sgla/sgla_e_difl [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub8/u6  (
    .a(sgla_e[6]),
    .b(\sgla/sglb_et [6]),
    .c(\sgla/sub8/c6 ),
    .o({\sgla/sub8/c7 ,\sgla/sgla_e_difl [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub8/u7  (
    .a(sgla_e[7]),
    .b(\sgla/sglb_et [7]),
    .c(\sgla/sub8/c7 ),
    .o({\sgla/sub8/c8 ,\sgla/sgla_e_difl [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub8/u8  (
    .a(sgla_e[8]),
    .b(\sgla/sglb_et [8]),
    .c(\sgla/sub8/c8 ),
    .o({open_n262,\sgla/sgla_e_difl [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \sgla/sub8/ucin  (
    .a(1'b0),
    .o({\sgla/sub8/c0 ,open_n265}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub9/u0  (
    .a(1'b1),
    .b(sgla_e[0]),
    .c(\sgla/sub9/c0 ),
    .o({\sgla/sub9/c1 ,\sgla/n190 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub9/u1  (
    .a(1'b1),
    .b(sgla_e[1]),
    .c(\sgla/sub9/c1 ),
    .o({\sgla/sub9/c2 ,\sgla/n190 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub9/u2  (
    .a(1'b1),
    .b(sgla_e[2]),
    .c(\sgla/sub9/c2 ),
    .o({\sgla/sub9/c3 ,\sgla/n190 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub9/u3  (
    .a(1'b0),
    .b(sgla_e[3]),
    .c(\sgla/sub9/c3 ),
    .o({\sgla/sub9/c4 ,\sgla/n190 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub9/u4  (
    .a(1'b1),
    .b(sgla_e[4]),
    .c(\sgla/sub9/c4 ),
    .o({\sgla/sub9/c5 ,\sgla/n190 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub9/u5  (
    .a(1'b0),
    .b(sgla_e[5]),
    .c(\sgla/sub9/c5 ),
    .o({\sgla/sub9/c6 ,\sgla/n190 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub9/u6  (
    .a(1'b0),
    .b(sgla_e[6]),
    .c(\sgla/sub9/c6 ),
    .o({\sgla/sub9/c7 ,\sgla/n190 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub9/u7  (
    .a(1'b0),
    .b(sgla_e[7]),
    .c(\sgla/sub9/c7 ),
    .o({\sgla/sub9/c8 ,\sgla/n190 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sgla/sub9/u8  (
    .a(1'b0),
    .b(sgla_e[8]),
    .c(\sgla/sub9/c8 ),
    .o({open_n266,\sgla/n190 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \sgla/sub9/ucin  (
    .a(1'b0),
    .o({\sgla/sub9/c0 ,open_n269}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add0/u0  (
    .a(sglb_e[0]),
    .b(\fdiv/n18 [0]),
    .c(\sglb/add0/c0 ),
    .o({\sglb/add0/c1 ,\sglb/n11 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add0/u1  (
    .a(sglb_e[1]),
    .b(\fdiv/n18 [1]),
    .c(\sglb/add0/c1 ),
    .o({\sglb/add0/c2 ,\sglb/n11 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add0/u2  (
    .a(sglb_e[2]),
    .b(\fdiv/n18 [2]),
    .c(\sglb/add0/c2 ),
    .o({\sglb/add0/c3 ,\sglb/n11 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add0/u3  (
    .a(sglb_e[3]),
    .b(\fdiv/n18 [3]),
    .c(\sglb/add0/c3 ),
    .o({\sglb/add0/c4 ,\sglb/n11 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add0/u4  (
    .a(sglb_e[4]),
    .b(\fdiv/n18 [4]),
    .c(\sglb/add0/c4 ),
    .o({\sglb/add0/c5 ,\sglb/n11 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add0/u5  (
    .a(sglb_e[5]),
    .b(\fdiv/n18 [5]),
    .c(\sglb/add0/c5 ),
    .o({\sglb/add0/c6 ,\sglb/n11 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add0/u6  (
    .a(sglb_e[6]),
    .b(\fdiv/n18 [6]),
    .c(\sglb/add0/c6 ),
    .o({\sglb/add0/c7 ,\sglb/n11 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add0/u7  (
    .a(sglb_e[7]),
    .b(\fdiv/n18 [7]),
    .c(\sglb/add0/c7 ),
    .o({\sglb/add0/c8 ,\sglb/n11 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add0/u8  (
    .a(sglb_e[8]),
    .b(1'b0),
    .c(\sglb/add0/c8 ),
    .o({open_n270,\sglb/n11 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \sglb/add0/ucin  (
    .a(1'b0),
    .o({\sglb/add0/c0 ,open_n273}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add1/u0  (
    .a(sglb_e[4]),
    .b(1'b1),
    .c(\sglb/add1/c0 ),
    .o({\sglb/add1/c1 ,\sglb/n20 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add1/u1  (
    .a(sglb_e[5]),
    .b(1'b0),
    .c(\sglb/add1/c1 ),
    .o({\sglb/add1/c2 ,\sglb/n20 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add1/u2  (
    .a(sglb_e[6]),
    .b(1'b0),
    .c(\sglb/add1/c2 ),
    .o({\sglb/add1/c3 ,\sglb/n20 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add1/u3  (
    .a(sglb_e[7]),
    .b(1'b0),
    .c(\sglb/add1/c3 ),
    .o({\sglb/add1/c4 ,\sglb/n20 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add1/u4  (
    .a(sglb_e[8]),
    .b(1'b0),
    .c(\sglb/add1/c4 ),
    .o({open_n274,\sglb/n20 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \sglb/add1/ucin  (
    .a(1'b0),
    .o({\sglb/add1/c0 ,open_n277}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add2/u0  (
    .a(sglb_e[3]),
    .b(1'b1),
    .c(\sglb/add2/c0 ),
    .o({\sglb/add2/c1 ,\sglb/n45 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add2/u1  (
    .a(sglb_e[4]),
    .b(1'b0),
    .c(\sglb/add2/c1 ),
    .o({\sglb/add2/c2 ,\sglb/n45 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add2/u2  (
    .a(sglb_e[5]),
    .b(1'b0),
    .c(\sglb/add2/c2 ),
    .o({\sglb/add2/c3 ,\sglb/n45 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add2/u3  (
    .a(sglb_e[6]),
    .b(1'b0),
    .c(\sglb/add2/c3 ),
    .o({\sglb/add2/c4 ,\sglb/n45 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add2/u4  (
    .a(sglb_e[7]),
    .b(1'b0),
    .c(\sglb/add2/c4 ),
    .o({\sglb/add2/c5 ,\sglb/n45 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add2/u5  (
    .a(sglb_e[8]),
    .b(1'b0),
    .c(\sglb/add2/c5 ),
    .o({open_n278,\sglb/n45 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \sglb/add2/ucin  (
    .a(1'b0),
    .o({\sglb/add2/c0 ,open_n281}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add3/u0  (
    .a(sglb_e[2]),
    .b(1'b1),
    .c(\sglb/add3/c0 ),
    .o({\sglb/add3/c1 ,\sglb/n62 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add3/u1  (
    .a(sglb_e[3]),
    .b(1'b0),
    .c(\sglb/add3/c1 ),
    .o({\sglb/add3/c2 ,\sglb/n62 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add3/u2  (
    .a(sglb_e[4]),
    .b(1'b0),
    .c(\sglb/add3/c2 ),
    .o({\sglb/add3/c3 ,\sglb/n62 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add3/u3  (
    .a(sglb_e[5]),
    .b(1'b0),
    .c(\sglb/add3/c3 ),
    .o({\sglb/add3/c4 ,\sglb/n62 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add3/u4  (
    .a(sglb_e[6]),
    .b(1'b0),
    .c(\sglb/add3/c4 ),
    .o({\sglb/add3/c5 ,\sglb/n62 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add3/u5  (
    .a(sglb_e[7]),
    .b(1'b0),
    .c(\sglb/add3/c5 ),
    .o({\sglb/add3/c6 ,\sglb/n62 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add3/u6  (
    .a(sglb_e[8]),
    .b(1'b0),
    .c(\sglb/add3/c6 ),
    .o({open_n282,\sglb/n62 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \sglb/add3/ucin  (
    .a(1'b0),
    .o({\sglb/add3/c0 ,open_n285}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add4/u0  (
    .a(sglb_e[1]),
    .b(1'b1),
    .c(\sglb/add4/c0 ),
    .o({\sglb/add4/c1 ,\sglb/n75 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add4/u1  (
    .a(sglb_e[2]),
    .b(1'b0),
    .c(\sglb/add4/c1 ),
    .o({\sglb/add4/c2 ,\sglb/n75 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add4/u2  (
    .a(sglb_e[3]),
    .b(1'b0),
    .c(\sglb/add4/c2 ),
    .o({\sglb/add4/c3 ,\sglb/n75 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add4/u3  (
    .a(sglb_e[4]),
    .b(1'b0),
    .c(\sglb/add4/c3 ),
    .o({\sglb/add4/c4 ,\sglb/n75 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add4/u4  (
    .a(sglb_e[5]),
    .b(1'b0),
    .c(\sglb/add4/c4 ),
    .o({\sglb/add4/c5 ,\sglb/n75 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add4/u5  (
    .a(sglb_e[6]),
    .b(1'b0),
    .c(\sglb/add4/c5 ),
    .o({\sglb/add4/c6 ,\sglb/n75 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add4/u6  (
    .a(sglb_e[7]),
    .b(1'b0),
    .c(\sglb/add4/c6 ),
    .o({\sglb/add4/c7 ,\sglb/n75 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add4/u7  (
    .a(sglb_e[8]),
    .b(1'b0),
    .c(\sglb/add4/c7 ),
    .o({open_n286,\sglb/n75 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \sglb/add4/ucin  (
    .a(1'b0),
    .o({\sglb/add4/c0 ,open_n289}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add5/u0  (
    .a(sglb_e[0]),
    .b(1'b1),
    .c(\sglb/add5/c0 ),
    .o({\sglb/add5/c1 ,\sglb/n86 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add5/u1  (
    .a(sglb_e[1]),
    .b(1'b0),
    .c(\sglb/add5/c1 ),
    .o({\sglb/add5/c2 ,\sglb/n86 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add5/u2  (
    .a(sglb_e[2]),
    .b(1'b0),
    .c(\sglb/add5/c2 ),
    .o({\sglb/add5/c3 ,\sglb/n86 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add5/u3  (
    .a(sglb_e[3]),
    .b(1'b0),
    .c(\sglb/add5/c3 ),
    .o({\sglb/add5/c4 ,\sglb/n86 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add5/u4  (
    .a(sglb_e[4]),
    .b(1'b0),
    .c(\sglb/add5/c4 ),
    .o({\sglb/add5/c5 ,\sglb/n86 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add5/u5  (
    .a(sglb_e[5]),
    .b(1'b0),
    .c(\sglb/add5/c5 ),
    .o({\sglb/add5/c6 ,\sglb/n86 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add5/u6  (
    .a(sglb_e[6]),
    .b(1'b0),
    .c(\sglb/add5/c6 ),
    .o({\sglb/add5/c7 ,\sglb/n86 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add5/u7  (
    .a(sglb_e[7]),
    .b(1'b0),
    .c(\sglb/add5/c7 ),
    .o({\sglb/add5/c8 ,\sglb/n86 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \sglb/add5/u8  (
    .a(sglb_e[8]),
    .b(1'b0),
    .c(\sglb/add5/c8 ),
    .o({open_n290,\sglb/n86 [8]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \sglb/add5/ucin  (
    .a(1'b0),
    .o({\sglb/add5/c0 ,open_n293}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sglb/lt0_0  (
    .a(\fdiv/n18 [0]),
    .b(1'b0),
    .c(\sglb/lt0_c0 ),
    .o({\sglb/lt0_c1 ,open_n294}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sglb/lt0_1  (
    .a(\fdiv/n18 [1]),
    .b(1'b0),
    .c(\sglb/lt0_c1 ),
    .o({\sglb/lt0_c2 ,open_n295}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sglb/lt0_2  (
    .a(\fdiv/n18 [2]),
    .b(1'b0),
    .c(\sglb/lt0_c2 ),
    .o({\sglb/lt0_c3 ,open_n296}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sglb/lt0_3  (
    .a(\fdiv/n18 [3]),
    .b(1'b0),
    .c(\sglb/lt0_c3 ),
    .o({\sglb/lt0_c4 ,open_n297}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sglb/lt0_4  (
    .a(\fdiv/n18 [4]),
    .b(1'b0),
    .c(\sglb/lt0_c4 ),
    .o({\sglb/lt0_c5 ,open_n298}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sglb/lt0_5  (
    .a(\fdiv/n18 [5]),
    .b(1'b0),
    .c(\sglb/lt0_c5 ),
    .o({\sglb/lt0_c6 ,open_n299}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sglb/lt0_6  (
    .a(\fdiv/n18 [6]),
    .b(1'b0),
    .c(\sglb/lt0_c6 ),
    .o({\sglb/lt0_c7 ,open_n300}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sglb/lt0_7  (
    .a(\fdiv/n18 [7]),
    .b(1'b0),
    .c(\sglb/lt0_c7 ),
    .o({\sglb/lt0_c8 ,open_n301}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sglb/lt0_8  (
    .a(1'b0),
    .b(\fdiv/n18 [8]),
    .c(\sglb/lt0_c8 ),
    .o({\sglb/lt0_c9 ,open_n302}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    \sglb/lt0_cin  (
    .a(1'b1),
    .o({\sglb/lt0_c0 ,open_n305}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    \sglb/lt0_cout  (
    .a(1'b0),
    .b(1'b1),
    .c(\sglb/lt0_c9 ),
    .o({open_n306,\sglb/n111 }));
  reg_sr_as_w1 \sglb/reg0_b0  (
    .clk(clk),
    .d(\sglb/n102 [0]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_e[0]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg0_b1  (
    .clk(clk),
    .d(\sglb/n102 [1]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_e[1]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg0_b2  (
    .clk(clk),
    .d(\sglb/n102 [2]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_e[2]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg0_b3  (
    .clk(clk),
    .d(\sglb/n102 [3]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_e[3]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg0_b4  (
    .clk(clk),
    .d(\sglb/n102 [4]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_e[4]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg0_b5  (
    .clk(clk),
    .d(\sglb/n102 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_e[5]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg0_b6  (
    .clk(clk),
    .d(\sglb/n102 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_e[6]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg0_b7  (
    .clk(clk),
    .d(\sglb/n102 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_e[7]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg0_b8  (
    .clk(clk),
    .d(\sglb/n102 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_e[8]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b0  (
    .clk(clk),
    .d(\sglb/n98 [0]),
    .en(1'b1),
    .reset(~\sglb/mux18_b0_sel_is_2_o ),
    .set(1'b0),
    .q(sglb_r[0]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b1  (
    .clk(clk),
    .d(\sglb/n98 [1]),
    .en(1'b1),
    .reset(~\sglb/mux18_b0_sel_is_2_o ),
    .set(1'b0),
    .q(sglb_r[1]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b10  (
    .clk(clk),
    .d(\sglb/n103 [10]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[10]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b11  (
    .clk(clk),
    .d(\sglb/n103 [11]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[11]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b12  (
    .clk(clk),
    .d(\sglb/n103 [12]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[12]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b13  (
    .clk(clk),
    .d(\sglb/n103 [13]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[13]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b14  (
    .clk(clk),
    .d(\sglb/n103 [14]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[14]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b15  (
    .clk(clk),
    .d(\sglb/n103 [15]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[15]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b16  (
    .clk(clk),
    .d(\sglb/n103 [16]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[16]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b17  (
    .clk(clk),
    .d(\sglb/n103 [17]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[17]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b18  (
    .clk(clk),
    .d(\sglb/n103 [18]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[18]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b19  (
    .clk(clk),
    .d(\sglb/n103 [19]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[19]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b2  (
    .clk(clk),
    .d(\sglb/n98 [2]),
    .en(1'b1),
    .reset(~\sglb/mux18_b0_sel_is_2_o ),
    .set(1'b0),
    .q(sglb_r[2]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b20  (
    .clk(clk),
    .d(\sglb/n103 [20]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[20]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b21  (
    .clk(clk),
    .d(\sglb/n103 [21]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[21]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b22  (
    .clk(clk),
    .d(\sglb/n103 [22]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[22]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b23  (
    .clk(clk),
    .d(\sglb/n103 [23]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[23]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b24  (
    .clk(clk),
    .d(\sglb/n103 [24]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[24]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b25  (
    .clk(clk),
    .d(\sglb/n103 [25]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[25]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b26  (
    .clk(clk),
    .d(\sglb/n103 [26]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[26]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b27  (
    .clk(clk),
    .d(\sglb/n103 [27]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[27]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b28  (
    .clk(clk),
    .d(\sglb/n103 [28]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[28]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b29  (
    .clk(clk),
    .d(\sglb/n92 [29]),
    .en(1'b1),
    .reset(~\sglb/mux18_b29_sel_is_2_o ),
    .set(1'b0),
    .q(sglb_r[29]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b3  (
    .clk(clk),
    .d(\sglb/n98 [3]),
    .en(1'b1),
    .reset(~\sglb/mux18_b0_sel_is_2_o ),
    .set(1'b0),
    .q(sglb_r[3]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b4  (
    .clk(clk),
    .d(\sglb/n98 [4]),
    .en(1'b1),
    .reset(~\sglb/mux18_b0_sel_is_2_o ),
    .set(1'b0),
    .q(sglb_r[4]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b5  (
    .clk(clk),
    .d(\sglb/n103 [5]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[5]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b6  (
    .clk(clk),
    .d(\sglb/n103 [6]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[6]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b7  (
    .clk(clk),
    .d(\sglb/n103 [7]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[7]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b8  (
    .clk(clk),
    .d(\sglb/n103 [8]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[8]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg1_b9  (
    .clk(clk),
    .d(\sglb/n103 [9]),
    .en(1'b1),
    .reset(~rst_n),
    .set(1'b0),
    .q(sglb_r[9]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b0  (
    .clk(clk),
    .d(bbus[0]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [0]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b1  (
    .clk(clk),
    .d(bbus[1]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [1]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b10  (
    .clk(clk),
    .d(bbus[10]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [10]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b11  (
    .clk(clk),
    .d(bbus[11]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [11]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b12  (
    .clk(clk),
    .d(bbus[12]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [12]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b13  (
    .clk(clk),
    .d(bbus[13]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [13]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b14  (
    .clk(clk),
    .d(bbus[14]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [14]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b15  (
    .clk(clk),
    .d(bbus[15]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [15]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b16  (
    .clk(clk),
    .d(bbus[16]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [16]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b17  (
    .clk(clk),
    .d(bbus[17]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [17]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b18  (
    .clk(clk),
    .d(bbus[18]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [18]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b19  (
    .clk(clk),
    .d(bbus[19]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [19]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b2  (
    .clk(clk),
    .d(bbus[2]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [2]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b20  (
    .clk(clk),
    .d(bbus[20]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [20]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b21  (
    .clk(clk),
    .d(bbus[21]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [21]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b22  (
    .clk(clk),
    .d(bbus[22]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [22]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b23  (
    .clk(clk),
    .d(bbus[23]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [23]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b24  (
    .clk(clk),
    .d(bbus[24]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [24]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b25  (
    .clk(clk),
    .d(bbus[25]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [25]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b26  (
    .clk(clk),
    .d(bbus[26]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [26]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b27  (
    .clk(clk),
    .d(bbus[27]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [27]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b28  (
    .clk(clk),
    .d(bbus[28]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [28]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b29  (
    .clk(clk),
    .d(bbus[29]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [29]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b3  (
    .clk(clk),
    .d(bbus[3]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [3]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b30  (
    .clk(clk),
    .d(bbus[30]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [30]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b31  (
    .clk(clk),
    .d(bbus[31]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [31]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b4  (
    .clk(clk),
    .d(bbus[4]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [4]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b5  (
    .clk(clk),
    .d(bbus[5]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [5]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b6  (
    .clk(clk),
    .d(bbus[6]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [6]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b7  (
    .clk(clk),
    .d(bbus[7]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [7]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b8  (
    .clk(clk),
    .d(bbus[8]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [8]));  // rtl/sglfpu.v(1598)
  reg_sr_as_w1 \sglb/reg2_b9  (
    .clk(clk),
    .d(bbus[9]),
    .en(fctl_load_a),
    .reset(~rst_n),
    .set(1'b0),
    .q(\sglb/sglb_i [9]));  // rtl/sglfpu.v(1598)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sglb/sub0/u0  (
    .a(bbus[23]),
    .b(1'b1),
    .c(\sglb/sub0/c0 ),
    .o({\sglb/sub0/c1 ,\sglb/n1 [0]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sglb/sub0/u1  (
    .a(bbus[24]),
    .b(1'b1),
    .c(\sglb/sub0/c1 ),
    .o({\sglb/sub0/c2 ,\sglb/n1 [1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sglb/sub0/u2  (
    .a(bbus[25]),
    .b(1'b1),
    .c(\sglb/sub0/c2 ),
    .o({\sglb/sub0/c3 ,\sglb/n1 [2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sglb/sub0/u3  (
    .a(bbus[26]),
    .b(1'b1),
    .c(\sglb/sub0/c3 ),
    .o({\sglb/sub0/c4 ,\sglb/n1 [3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sglb/sub0/u4  (
    .a(bbus[27]),
    .b(1'b1),
    .c(\sglb/sub0/c4 ),
    .o({\sglb/sub0/c5 ,\sglb/n1 [4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sglb/sub0/u5  (
    .a(bbus[28]),
    .b(1'b1),
    .c(\sglb/sub0/c5 ),
    .o({\sglb/sub0/c6 ,\sglb/n1 [5]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sglb/sub0/u6  (
    .a(bbus[29]),
    .b(1'b1),
    .c(\sglb/sub0/c6 ),
    .o({\sglb/sub0/c7 ,\sglb/n1 [6]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sglb/sub0/u7  (
    .a(bbus[30]),
    .b(1'b0),
    .c(\sglb/sub0/c7 ),
    .o({\sglb/sub0/c8 ,\sglb/n1 [7]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    \sglb/sub0/ucin  (
    .a(1'b0),
    .o({\sglb/sub0/c0 ,open_n309}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    \sglb/sub0/ucout  (
    .c(\sglb/sub0/c8 ),
    .o({open_n312,\sglb/n1 [8]}));

endmodule 

