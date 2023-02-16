/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : K-2015.06-SP5-1
// Date      : Wed Feb 15 19:16:24 2023
/////////////////////////////////////////////////////////////


module r_fifo ( clk, resetn, soft_reset, write_enb, read_enb, lfd_state, 
        data_in, full, empty, data_out );
  input [7:0] data_in;
  output [7:0] data_out;
  input clk, resetn, soft_reset, write_enb, read_enb, lfd_state;
  output full, empty;
  wire   lfd_temp, N32, \fifo_mem[15][8] , \fifo_mem[15][7] ,
         \fifo_mem[15][6] , \fifo_mem[15][5] , \fifo_mem[15][4] ,
         \fifo_mem[15][3] , \fifo_mem[15][2] , \fifo_mem[15][1] ,
         \fifo_mem[15][0] , \fifo_mem[14][8] , \fifo_mem[14][7] ,
         \fifo_mem[14][6] , \fifo_mem[14][5] , \fifo_mem[14][4] ,
         \fifo_mem[14][3] , \fifo_mem[14][2] , \fifo_mem[14][1] ,
         \fifo_mem[14][0] , \fifo_mem[13][8] , \fifo_mem[13][7] ,
         \fifo_mem[13][6] , \fifo_mem[13][5] , \fifo_mem[13][4] ,
         \fifo_mem[13][3] , \fifo_mem[13][2] , \fifo_mem[13][1] ,
         \fifo_mem[13][0] , \fifo_mem[12][8] , \fifo_mem[12][7] ,
         \fifo_mem[12][6] , \fifo_mem[12][5] , \fifo_mem[12][4] ,
         \fifo_mem[12][3] , \fifo_mem[12][2] , \fifo_mem[12][1] ,
         \fifo_mem[12][0] , \fifo_mem[11][8] , \fifo_mem[11][7] ,
         \fifo_mem[11][6] , \fifo_mem[11][5] , \fifo_mem[11][4] ,
         \fifo_mem[11][3] , \fifo_mem[11][2] , \fifo_mem[11][1] ,
         \fifo_mem[11][0] , \fifo_mem[10][8] , \fifo_mem[10][7] ,
         \fifo_mem[10][6] , \fifo_mem[10][5] , \fifo_mem[10][4] ,
         \fifo_mem[10][3] , \fifo_mem[10][2] , \fifo_mem[10][1] ,
         \fifo_mem[10][0] , \fifo_mem[9][8] , \fifo_mem[9][7] ,
         \fifo_mem[9][6] , \fifo_mem[9][5] , \fifo_mem[9][4] ,
         \fifo_mem[9][3] , \fifo_mem[9][2] , \fifo_mem[9][1] ,
         \fifo_mem[9][0] , \fifo_mem[8][8] , \fifo_mem[8][7] ,
         \fifo_mem[8][6] , \fifo_mem[8][5] , \fifo_mem[8][4] ,
         \fifo_mem[8][3] , \fifo_mem[8][2] , \fifo_mem[8][1] ,
         \fifo_mem[8][0] , \fifo_mem[7][8] , \fifo_mem[7][7] ,
         \fifo_mem[7][6] , \fifo_mem[7][5] , \fifo_mem[7][4] ,
         \fifo_mem[7][3] , \fifo_mem[7][2] , \fifo_mem[7][1] ,
         \fifo_mem[7][0] , \fifo_mem[6][8] , \fifo_mem[6][7] ,
         \fifo_mem[6][6] , \fifo_mem[6][5] , \fifo_mem[6][4] ,
         \fifo_mem[6][3] , \fifo_mem[6][2] , \fifo_mem[6][1] ,
         \fifo_mem[6][0] , \fifo_mem[5][8] , \fifo_mem[5][7] ,
         \fifo_mem[5][6] , \fifo_mem[5][5] , \fifo_mem[5][4] ,
         \fifo_mem[5][3] , \fifo_mem[5][2] , \fifo_mem[5][1] ,
         \fifo_mem[5][0] , \fifo_mem[4][8] , \fifo_mem[4][7] ,
         \fifo_mem[4][6] , \fifo_mem[4][5] , \fifo_mem[4][4] ,
         \fifo_mem[4][3] , \fifo_mem[4][2] , \fifo_mem[4][1] ,
         \fifo_mem[4][0] , \fifo_mem[3][8] , \fifo_mem[3][7] ,
         \fifo_mem[3][6] , \fifo_mem[3][5] , \fifo_mem[3][4] ,
         \fifo_mem[3][3] , \fifo_mem[3][2] , \fifo_mem[3][1] ,
         \fifo_mem[3][0] , \fifo_mem[2][8] , \fifo_mem[2][7] ,
         \fifo_mem[2][6] , \fifo_mem[2][5] , \fifo_mem[2][4] ,
         \fifo_mem[2][3] , \fifo_mem[2][2] , \fifo_mem[2][1] ,
         \fifo_mem[2][0] , \fifo_mem[1][8] , \fifo_mem[1][7] ,
         \fifo_mem[1][6] , \fifo_mem[1][5] , \fifo_mem[1][4] ,
         \fifo_mem[1][3] , \fifo_mem[1][2] , \fifo_mem[1][1] ,
         \fifo_mem[1][0] , \fifo_mem[0][8] , \fifo_mem[0][7] ,
         \fifo_mem[0][6] , \fifo_mem[0][5] , \fifo_mem[0][4] ,
         \fifo_mem[0][3] , \fifo_mem[0][2] , \fifo_mem[0][1] ,
         \fifo_mem[0][0] , N156, N159, N162, N165, N168, N171, N174, N175,
         N177, n2, n353, n354, n355, n356, n357, n358, n359, n360, n361, n363,
         n364, n365, n366, n367, n368, n369, n370, n371, n372, n373, n374,
         n375, n376, n377, n378, n379, n380, n381, n382, n383, n384, n385,
         n386, n387, n388, n389, n390, n391, n392, n393, n394, n395, n396,
         n397, n398, n399, n400, n401, n402, n403, n404, n405, n406, n407,
         n408, n409, n410, n411, n412, n413, n414, n415, n416, n417, n418,
         n419, n420, n421, n422, n423, n424, n425, n426, n427, n428, n429,
         n430, n431, n432, n433, n434, n435, n436, n437, n438, n439, n440,
         n441, n442, n443, n444, n445, n446, n447, n448, n449, n450, n451,
         n452, n453, n454, n455, n456, n457, n458, n459, n460, n461, n462,
         n463, n464, n465, n466, n467, n468, n469, n470, n471, n472, n473,
         n474, n475, n476, n477, n478, n479, n480, n481, n482, n483, n484,
         n485, n486, n487, n488, n489, n490, n491, n492, n493, n494, n495,
         n496, n497, n498, n499, n500, n501, n502, n503, n504, n505, n506,
         n507, n508, n509, n510, n511, n512, n513, n514, n515, n516, n517,
         n518, n519, n520, n521, n522, n523, n524, n525, n526, n527, n528,
         n529, n530, n531, n532, n533, n534, n535, n536, n537, n538, n539,
         n540, n541, n542, n543, n544, n545, n546, n547, n548, n549, n550,
         n551, n552, n553, n554, n555, n556, n557, n558, n559, n560, n561,
         n562, n563, n564, n565, n566, n567, n568, n569, n570, n571, n572,
         n573, n574, n575, n576, n577, n578, n579, n580, n581, n582, n583,
         n584, n585, n586, n587, n588, n589, n590, n591, n592, n593, n594,
         n595, n596, n597, n598, n599, n600, n601, n602, n603, n604, n605,
         n606, n607, n608, n609, n610, n611, n612, n613, n614, n615, n616,
         n617, n618, n619, n620, n621, n622, n623, n624, n625, n626, n627,
         n628, n629, n630, n631, n632, n633, n634, n635, n636, n637, n638,
         n639, n640, n641, n642, n643, n644, n645, n646, n647, n648, n649,
         n650, n651, n652, n653, n654, n655, n656, n657, n658, n659, n660,
         n661, n662, n663, n664, n665, n666, n667, n668, n669, n670, n671,
         n672, n673, n674, n675, n676, n677, n678, n679, n680, n681, n682,
         n683, n684, n685, n686, n687, n688, n689, n690, n691, n692, n693,
         n694, n695, n696, n697, n698, n699, n700, n701, n702, n703, n704,
         n705, n706, n707, n708, n709, n710, n711, n712, n713, n714, n715,
         n716, n717, n718, n719, n720, n721, n722, n723, n724, n725, n726,
         n727, n728, n729, n730, n731, n732, n733, n734, n735, n736, n737,
         n738, n739, n740, n741, n742, n743, n744, n745, n746, n747, n748,
         n749, n750, n751, n752, n753, n754, n755, n756, n757, n758, n759,
         n760, n761, n762, n763, n764, n765, n766, n767, n768, n769, n770,
         n771, n772, n773, n774, n775, n776, n777, n778, n779, n780, n781,
         n782, n783, n784, n785, n786, n787, n788, n789, n790, n791, n792,
         n793, n794, n795, n796, n797, n798, n799, n800, n801, n802, n803,
         n804, n805, n806, n807, n808, n809, n810, n811, n812, n813, n814,
         n815, n816, n817, n818, n819, n820, n821, n822, n823, n824, n825,
         n826, n827, n828, n829, n830, n831, n832, n833, n834, n835, n836,
         n837, n838, n839, n840, n841, n842, n843, n844, n845, n846, n847,
         n848, n849, n850, n851, n852, n853, n854, n855, n856, n857, n858,
         n859, n860, n861, n862, n863, n864, n865, n866, n867, n868, n869,
         n870, n871, n872, n873, n874, n875, n876, n877, n878, n879, n880,
         n881, n882;
  wire   [4:0] write_ptr;
  wire   [6:0] packet_len_count;
  wire   [4:0] read_ptr;
  tri   [7:0] data_out;

  CFD1QXL lfd_temp_reg ( .D(N32), .CP(clk), .Q(lfd_temp) );
  CFD1QXL \fifo_mem_reg[0][0]  ( .D(n512), .CP(clk), .Q(\fifo_mem[0][0] ) );
  CFD1QXL \fifo_mem_reg[2][0]  ( .D(n494), .CP(clk), .Q(\fifo_mem[2][0] ) );
  CFD1QXL \fifo_mem_reg[4][0]  ( .D(n476), .CP(clk), .Q(\fifo_mem[4][0] ) );
  CFD1QXL \fifo_mem_reg[6][0]  ( .D(n458), .CP(clk), .Q(\fifo_mem[6][0] ) );
  CFD1QXL \fifo_mem_reg[8][0]  ( .D(n440), .CP(clk), .Q(\fifo_mem[8][0] ) );
  CFD1QXL \fifo_mem_reg[10][0]  ( .D(n422), .CP(clk), .Q(\fifo_mem[10][0] ) );
  CFD1QXL \fifo_mem_reg[12][0]  ( .D(n404), .CP(clk), .Q(\fifo_mem[12][0] ) );
  CFD1QXL \fifo_mem_reg[14][0]  ( .D(n386), .CP(clk), .Q(\fifo_mem[14][0] ) );
  CFD1QXL \fifo_mem_reg[0][7]  ( .D(n511), .CP(clk), .Q(\fifo_mem[0][7] ) );
  CFD1QXL \fifo_mem_reg[2][7]  ( .D(n493), .CP(clk), .Q(\fifo_mem[2][7] ) );
  CFD1QXL \fifo_mem_reg[4][7]  ( .D(n475), .CP(clk), .Q(\fifo_mem[4][7] ) );
  CFD1QXL \fifo_mem_reg[6][7]  ( .D(n457), .CP(clk), .Q(\fifo_mem[6][7] ) );
  CFD1QXL \fifo_mem_reg[8][7]  ( .D(n439), .CP(clk), .Q(\fifo_mem[8][7] ) );
  CFD1QXL \fifo_mem_reg[10][7]  ( .D(n421), .CP(clk), .Q(\fifo_mem[10][7] ) );
  CFD1QXL \fifo_mem_reg[12][7]  ( .D(n403), .CP(clk), .Q(\fifo_mem[12][7] ) );
  CFD1QXL \fifo_mem_reg[14][7]  ( .D(n385), .CP(clk), .Q(\fifo_mem[14][7] ) );
  CFD1QXL \fifo_mem_reg[0][6]  ( .D(n510), .CP(clk), .Q(\fifo_mem[0][6] ) );
  CFD1QXL \fifo_mem_reg[2][6]  ( .D(n492), .CP(clk), .Q(\fifo_mem[2][6] ) );
  CFD1QXL \fifo_mem_reg[4][6]  ( .D(n474), .CP(clk), .Q(\fifo_mem[4][6] ) );
  CFD1QXL \fifo_mem_reg[6][6]  ( .D(n456), .CP(clk), .Q(\fifo_mem[6][6] ) );
  CFD1QXL \fifo_mem_reg[8][6]  ( .D(n438), .CP(clk), .Q(\fifo_mem[8][6] ) );
  CFD1QXL \fifo_mem_reg[10][6]  ( .D(n420), .CP(clk), .Q(\fifo_mem[10][6] ) );
  CFD1QXL \fifo_mem_reg[12][6]  ( .D(n402), .CP(clk), .Q(\fifo_mem[12][6] ) );
  CFD1QXL \fifo_mem_reg[14][6]  ( .D(n384), .CP(clk), .Q(\fifo_mem[14][6] ) );
  CFD1QXL \fifo_mem_reg[0][5]  ( .D(n509), .CP(clk), .Q(\fifo_mem[0][5] ) );
  CFD1QXL \fifo_mem_reg[2][5]  ( .D(n491), .CP(clk), .Q(\fifo_mem[2][5] ) );
  CFD1QXL \fifo_mem_reg[4][5]  ( .D(n473), .CP(clk), .Q(\fifo_mem[4][5] ) );
  CFD1QXL \fifo_mem_reg[6][5]  ( .D(n455), .CP(clk), .Q(\fifo_mem[6][5] ) );
  CFD1QXL \fifo_mem_reg[8][5]  ( .D(n437), .CP(clk), .Q(\fifo_mem[8][5] ) );
  CFD1QXL \fifo_mem_reg[10][5]  ( .D(n419), .CP(clk), .Q(\fifo_mem[10][5] ) );
  CFD1QXL \fifo_mem_reg[12][5]  ( .D(n401), .CP(clk), .Q(\fifo_mem[12][5] ) );
  CFD1QXL \fifo_mem_reg[14][5]  ( .D(n383), .CP(clk), .Q(\fifo_mem[14][5] ) );
  CFD1QXL \fifo_mem_reg[0][4]  ( .D(n508), .CP(clk), .Q(\fifo_mem[0][4] ) );
  CFD1QXL \fifo_mem_reg[2][4]  ( .D(n490), .CP(clk), .Q(\fifo_mem[2][4] ) );
  CFD1QXL \fifo_mem_reg[4][4]  ( .D(n472), .CP(clk), .Q(\fifo_mem[4][4] ) );
  CFD1QXL \fifo_mem_reg[6][4]  ( .D(n454), .CP(clk), .Q(\fifo_mem[6][4] ) );
  CFD1QXL \fifo_mem_reg[8][4]  ( .D(n436), .CP(clk), .Q(\fifo_mem[8][4] ) );
  CFD1QXL \fifo_mem_reg[10][4]  ( .D(n418), .CP(clk), .Q(\fifo_mem[10][4] ) );
  CFD1QXL \fifo_mem_reg[12][4]  ( .D(n400), .CP(clk), .Q(\fifo_mem[12][4] ) );
  CFD1QXL \fifo_mem_reg[14][4]  ( .D(n382), .CP(clk), .Q(\fifo_mem[14][4] ) );
  CFD1QXL \fifo_mem_reg[0][3]  ( .D(n507), .CP(clk), .Q(\fifo_mem[0][3] ) );
  CFD1QXL \fifo_mem_reg[2][3]  ( .D(n489), .CP(clk), .Q(\fifo_mem[2][3] ) );
  CFD1QXL \fifo_mem_reg[4][3]  ( .D(n471), .CP(clk), .Q(\fifo_mem[4][3] ) );
  CFD1QXL \fifo_mem_reg[6][3]  ( .D(n453), .CP(clk), .Q(\fifo_mem[6][3] ) );
  CFD1QXL \fifo_mem_reg[8][3]  ( .D(n435), .CP(clk), .Q(\fifo_mem[8][3] ) );
  CFD1QXL \fifo_mem_reg[10][3]  ( .D(n417), .CP(clk), .Q(\fifo_mem[10][3] ) );
  CFD1QXL \fifo_mem_reg[12][3]  ( .D(n399), .CP(clk), .Q(\fifo_mem[12][3] ) );
  CFD1QXL \fifo_mem_reg[14][3]  ( .D(n381), .CP(clk), .Q(\fifo_mem[14][3] ) );
  CFD1QXL \fifo_mem_reg[0][2]  ( .D(n506), .CP(clk), .Q(\fifo_mem[0][2] ) );
  CFD1QXL \fifo_mem_reg[2][2]  ( .D(n488), .CP(clk), .Q(\fifo_mem[2][2] ) );
  CFD1QXL \fifo_mem_reg[4][2]  ( .D(n470), .CP(clk), .Q(\fifo_mem[4][2] ) );
  CFD1QXL \fifo_mem_reg[6][2]  ( .D(n452), .CP(clk), .Q(\fifo_mem[6][2] ) );
  CFD1QXL \fifo_mem_reg[8][2]  ( .D(n434), .CP(clk), .Q(\fifo_mem[8][2] ) );
  CFD1QXL \fifo_mem_reg[10][2]  ( .D(n416), .CP(clk), .Q(\fifo_mem[10][2] ) );
  CFD1QXL \fifo_mem_reg[12][2]  ( .D(n398), .CP(clk), .Q(\fifo_mem[12][2] ) );
  CFD1QXL \fifo_mem_reg[14][2]  ( .D(n380), .CP(clk), .Q(\fifo_mem[14][2] ) );
  CFD1QXL \fifo_mem_reg[0][1]  ( .D(n505), .CP(clk), .Q(\fifo_mem[0][1] ) );
  CFD1QXL \fifo_mem_reg[2][1]  ( .D(n487), .CP(clk), .Q(\fifo_mem[2][1] ) );
  CFD1QXL \fifo_mem_reg[4][1]  ( .D(n469), .CP(clk), .Q(\fifo_mem[4][1] ) );
  CFD1QXL \fifo_mem_reg[6][1]  ( .D(n451), .CP(clk), .Q(\fifo_mem[6][1] ) );
  CFD1QXL \fifo_mem_reg[8][1]  ( .D(n433), .CP(clk), .Q(\fifo_mem[8][1] ) );
  CFD1QXL \fifo_mem_reg[10][1]  ( .D(n415), .CP(clk), .Q(\fifo_mem[10][1] ) );
  CFD1QXL \fifo_mem_reg[12][1]  ( .D(n397), .CP(clk), .Q(\fifo_mem[12][1] ) );
  CFD1QXL \fifo_mem_reg[14][1]  ( .D(n379), .CP(clk), .Q(\fifo_mem[14][1] ) );
  CFD1QXL \fifo_mem_reg[1][0]  ( .D(n503), .CP(clk), .Q(\fifo_mem[1][0] ) );
  CFD1QXL \fifo_mem_reg[1][7]  ( .D(n502), .CP(clk), .Q(\fifo_mem[1][7] ) );
  CFD1QXL \fifo_mem_reg[1][6]  ( .D(n501), .CP(clk), .Q(\fifo_mem[1][6] ) );
  CFD1QXL \fifo_mem_reg[1][5]  ( .D(n500), .CP(clk), .Q(\fifo_mem[1][5] ) );
  CFD1QXL \fifo_mem_reg[1][4]  ( .D(n499), .CP(clk), .Q(\fifo_mem[1][4] ) );
  CFD1QXL \fifo_mem_reg[1][3]  ( .D(n498), .CP(clk), .Q(\fifo_mem[1][3] ) );
  CFD1QXL \fifo_mem_reg[1][2]  ( .D(n497), .CP(clk), .Q(\fifo_mem[1][2] ) );
  CFD1QXL \fifo_mem_reg[1][1]  ( .D(n496), .CP(clk), .Q(\fifo_mem[1][1] ) );
  CFD1QXL \fifo_mem_reg[3][0]  ( .D(n485), .CP(clk), .Q(\fifo_mem[3][0] ) );
  CFD1QXL \fifo_mem_reg[3][7]  ( .D(n484), .CP(clk), .Q(\fifo_mem[3][7] ) );
  CFD1QXL \fifo_mem_reg[3][6]  ( .D(n483), .CP(clk), .Q(\fifo_mem[3][6] ) );
  CFD1QXL \fifo_mem_reg[3][5]  ( .D(n482), .CP(clk), .Q(\fifo_mem[3][5] ) );
  CFD1QXL \fifo_mem_reg[3][4]  ( .D(n481), .CP(clk), .Q(\fifo_mem[3][4] ) );
  CFD1QXL \fifo_mem_reg[3][3]  ( .D(n480), .CP(clk), .Q(\fifo_mem[3][3] ) );
  CFD1QXL \fifo_mem_reg[3][2]  ( .D(n479), .CP(clk), .Q(\fifo_mem[3][2] ) );
  CFD1QXL \fifo_mem_reg[3][1]  ( .D(n478), .CP(clk), .Q(\fifo_mem[3][1] ) );
  CFD1QXL \fifo_mem_reg[5][0]  ( .D(n467), .CP(clk), .Q(\fifo_mem[5][0] ) );
  CFD1QXL \fifo_mem_reg[5][7]  ( .D(n466), .CP(clk), .Q(\fifo_mem[5][7] ) );
  CFD1QXL \fifo_mem_reg[5][6]  ( .D(n465), .CP(clk), .Q(\fifo_mem[5][6] ) );
  CFD1QXL \fifo_mem_reg[5][5]  ( .D(n464), .CP(clk), .Q(\fifo_mem[5][5] ) );
  CFD1QXL \fifo_mem_reg[5][4]  ( .D(n463), .CP(clk), .Q(\fifo_mem[5][4] ) );
  CFD1QXL \fifo_mem_reg[5][3]  ( .D(n462), .CP(clk), .Q(\fifo_mem[5][3] ) );
  CFD1QXL \fifo_mem_reg[5][2]  ( .D(n461), .CP(clk), .Q(\fifo_mem[5][2] ) );
  CFD1QXL \fifo_mem_reg[5][1]  ( .D(n460), .CP(clk), .Q(\fifo_mem[5][1] ) );
  CFD1QXL \fifo_mem_reg[7][0]  ( .D(n449), .CP(clk), .Q(\fifo_mem[7][0] ) );
  CFD1QXL \fifo_mem_reg[7][7]  ( .D(n448), .CP(clk), .Q(\fifo_mem[7][7] ) );
  CFD1QXL \fifo_mem_reg[7][6]  ( .D(n447), .CP(clk), .Q(\fifo_mem[7][6] ) );
  CFD1QXL \fifo_mem_reg[7][5]  ( .D(n446), .CP(clk), .Q(\fifo_mem[7][5] ) );
  CFD1QXL \fifo_mem_reg[7][4]  ( .D(n445), .CP(clk), .Q(\fifo_mem[7][4] ) );
  CFD1QXL \fifo_mem_reg[7][3]  ( .D(n444), .CP(clk), .Q(\fifo_mem[7][3] ) );
  CFD1QXL \fifo_mem_reg[7][2]  ( .D(n443), .CP(clk), .Q(\fifo_mem[7][2] ) );
  CFD1QXL \fifo_mem_reg[7][1]  ( .D(n442), .CP(clk), .Q(\fifo_mem[7][1] ) );
  CFD1QXL \fifo_mem_reg[9][0]  ( .D(n431), .CP(clk), .Q(\fifo_mem[9][0] ) );
  CFD1QXL \fifo_mem_reg[9][7]  ( .D(n430), .CP(clk), .Q(\fifo_mem[9][7] ) );
  CFD1QXL \fifo_mem_reg[9][6]  ( .D(n429), .CP(clk), .Q(\fifo_mem[9][6] ) );
  CFD1QXL \fifo_mem_reg[9][5]  ( .D(n428), .CP(clk), .Q(\fifo_mem[9][5] ) );
  CFD1QXL \fifo_mem_reg[9][4]  ( .D(n427), .CP(clk), .Q(\fifo_mem[9][4] ) );
  CFD1QXL \fifo_mem_reg[9][3]  ( .D(n426), .CP(clk), .Q(\fifo_mem[9][3] ) );
  CFD1QXL \fifo_mem_reg[9][2]  ( .D(n425), .CP(clk), .Q(\fifo_mem[9][2] ) );
  CFD1QXL \fifo_mem_reg[9][1]  ( .D(n424), .CP(clk), .Q(\fifo_mem[9][1] ) );
  CFD1QXL \fifo_mem_reg[11][0]  ( .D(n413), .CP(clk), .Q(\fifo_mem[11][0] ) );
  CFD1QXL \fifo_mem_reg[11][7]  ( .D(n412), .CP(clk), .Q(\fifo_mem[11][7] ) );
  CFD1QXL \fifo_mem_reg[11][6]  ( .D(n411), .CP(clk), .Q(\fifo_mem[11][6] ) );
  CFD1QXL \fifo_mem_reg[11][5]  ( .D(n410), .CP(clk), .Q(\fifo_mem[11][5] ) );
  CFD1QXL \fifo_mem_reg[11][4]  ( .D(n409), .CP(clk), .Q(\fifo_mem[11][4] ) );
  CFD1QXL \fifo_mem_reg[11][3]  ( .D(n408), .CP(clk), .Q(\fifo_mem[11][3] ) );
  CFD1QXL \fifo_mem_reg[11][2]  ( .D(n407), .CP(clk), .Q(\fifo_mem[11][2] ) );
  CFD1QXL \fifo_mem_reg[11][1]  ( .D(n406), .CP(clk), .Q(\fifo_mem[11][1] ) );
  CFD1QXL \fifo_mem_reg[13][0]  ( .D(n395), .CP(clk), .Q(\fifo_mem[13][0] ) );
  CFD1QXL \fifo_mem_reg[13][7]  ( .D(n394), .CP(clk), .Q(\fifo_mem[13][7] ) );
  CFD1QXL \fifo_mem_reg[13][6]  ( .D(n393), .CP(clk), .Q(\fifo_mem[13][6] ) );
  CFD1QXL \fifo_mem_reg[13][5]  ( .D(n392), .CP(clk), .Q(\fifo_mem[13][5] ) );
  CFD1QXL \fifo_mem_reg[13][4]  ( .D(n391), .CP(clk), .Q(\fifo_mem[13][4] ) );
  CFD1QXL \fifo_mem_reg[13][3]  ( .D(n390), .CP(clk), .Q(\fifo_mem[13][3] ) );
  CFD1QXL \fifo_mem_reg[13][2]  ( .D(n389), .CP(clk), .Q(\fifo_mem[13][2] ) );
  CFD1QXL \fifo_mem_reg[13][1]  ( .D(n388), .CP(clk), .Q(\fifo_mem[13][1] ) );
  CFD1QXL \fifo_mem_reg[15][0]  ( .D(n377), .CP(clk), .Q(\fifo_mem[15][0] ) );
  CFD1QXL \fifo_mem_reg[15][7]  ( .D(n376), .CP(clk), .Q(\fifo_mem[15][7] ) );
  CFD1QXL \fifo_mem_reg[15][6]  ( .D(n375), .CP(clk), .Q(\fifo_mem[15][6] ) );
  CFD1QXL \fifo_mem_reg[15][5]  ( .D(n374), .CP(clk), .Q(\fifo_mem[15][5] ) );
  CFD1QXL \fifo_mem_reg[15][4]  ( .D(n373), .CP(clk), .Q(\fifo_mem[15][4] ) );
  CFD1QXL \fifo_mem_reg[15][3]  ( .D(n372), .CP(clk), .Q(\fifo_mem[15][3] ) );
  CFD1QXL \fifo_mem_reg[15][2]  ( .D(n371), .CP(clk), .Q(\fifo_mem[15][2] ) );
  CFD1QXL \fifo_mem_reg[15][1]  ( .D(n370), .CP(clk), .Q(\fifo_mem[15][1] ) );
  CFD1QXL \fifo_mem_reg[0][8]  ( .D(n504), .CP(clk), .Q(\fifo_mem[0][8] ) );
  CFD1QXL \fifo_mem_reg[1][8]  ( .D(n495), .CP(clk), .Q(\fifo_mem[1][8] ) );
  CFD1QXL \fifo_mem_reg[2][8]  ( .D(n486), .CP(clk), .Q(\fifo_mem[2][8] ) );
  CFD1QXL \fifo_mem_reg[3][8]  ( .D(n477), .CP(clk), .Q(\fifo_mem[3][8] ) );
  CFD1QXL \fifo_mem_reg[4][8]  ( .D(n468), .CP(clk), .Q(\fifo_mem[4][8] ) );
  CFD1QXL \fifo_mem_reg[5][8]  ( .D(n459), .CP(clk), .Q(\fifo_mem[5][8] ) );
  CFD1QXL \fifo_mem_reg[6][8]  ( .D(n450), .CP(clk), .Q(\fifo_mem[6][8] ) );
  CFD1QXL \fifo_mem_reg[7][8]  ( .D(n441), .CP(clk), .Q(\fifo_mem[7][8] ) );
  CFD1QXL \fifo_mem_reg[8][8]  ( .D(n432), .CP(clk), .Q(\fifo_mem[8][8] ) );
  CFD1QXL \fifo_mem_reg[9][8]  ( .D(n423), .CP(clk), .Q(\fifo_mem[9][8] ) );
  CFD1QXL \fifo_mem_reg[10][8]  ( .D(n414), .CP(clk), .Q(\fifo_mem[10][8] ) );
  CFD1QXL \fifo_mem_reg[11][8]  ( .D(n405), .CP(clk), .Q(\fifo_mem[11][8] ) );
  CFD1QXL \fifo_mem_reg[12][8]  ( .D(n396), .CP(clk), .Q(\fifo_mem[12][8] ) );
  CFD1QXL \fifo_mem_reg[13][8]  ( .D(n387), .CP(clk), .Q(\fifo_mem[13][8] ) );
  CFD1QXL \fifo_mem_reg[14][8]  ( .D(n378), .CP(clk), .Q(\fifo_mem[14][8] ) );
  CFD1QXL \fifo_mem_reg[15][8]  ( .D(n369), .CP(clk), .Q(\fifo_mem[15][8] ) );
  CFD1QXL \packet_len_count_reg[0]  ( .D(n368), .CP(clk), .Q(
        packet_len_count[0]) );
  CFD1QXL \packet_len_count_reg[1]  ( .D(n367), .CP(clk), .Q(
        packet_len_count[1]) );
  CFD1QXL \packet_len_count_reg[2]  ( .D(n366), .CP(clk), .Q(
        packet_len_count[2]) );
  CFD1QXL \packet_len_count_reg[3]  ( .D(n365), .CP(clk), .Q(
        packet_len_count[3]) );
  CFD1QXL \packet_len_count_reg[4]  ( .D(n364), .CP(clk), .Q(
        packet_len_count[4]) );
  CFD1QXL \packet_len_count_reg[5]  ( .D(n363), .CP(clk), .Q(
        packet_len_count[5]) );
  CTSX2 \data_out_tri[0]  ( .A(N177), .E(n2), .Z(data_out[0]) );
  CTSX2 \data_out_tri[1]  ( .A(N174), .E(n2), .Z(data_out[1]) );
  CTSX2 \data_out_tri[2]  ( .A(N171), .E(n2), .Z(data_out[2]) );
  CTSX2 \data_out_tri[3]  ( .A(N168), .E(n2), .Z(data_out[3]) );
  CTSX2 \data_out_tri[4]  ( .A(N165), .E(n2), .Z(data_out[4]) );
  CTSX2 \data_out_tri[5]  ( .A(N162), .E(n2), .Z(data_out[5]) );
  CTSX2 \data_out_tri[6]  ( .A(N159), .E(n2), .Z(data_out[6]) );
  CTSX2 \data_out_tri[7]  ( .A(N156), .E(n2), .Z(data_out[7]) );
  CFD1QXL \data_out_reg[0]  ( .D(n361), .CP(clk), .Q(N177) );
  CFD1QXL \data_out_reg[7]  ( .D(n360), .CP(clk), .Q(N156) );
  CFD1QXL \data_out_reg[6]  ( .D(n359), .CP(clk), .Q(N159) );
  CFD1QXL \data_out_reg[5]  ( .D(n358), .CP(clk), .Q(N162) );
  CFD1QXL \data_out_reg[4]  ( .D(n357), .CP(clk), .Q(N165) );
  CFD1QXL \data_out_reg[3]  ( .D(n356), .CP(clk), .Q(N168) );
  CFD1QXL \data_out_reg[2]  ( .D(n355), .CP(clk), .Q(N171) );
  CFD1QXL \data_out_reg[1]  ( .D(n354), .CP(clk), .Q(N174) );
  CFD1QXL \data_out_tri_enable_reg[1]  ( .D(n353), .CP(clk), .Q(N175) );
  CFD1QXL \write_ptr_reg[4]  ( .D(n513), .CP(clk), .Q(write_ptr[4]) );
  CFD1QXL \read_ptr_reg[4]  ( .D(n517), .CP(clk), .Q(read_ptr[4]) );
  CFD1QXL \write_ptr_reg[2]  ( .D(n515), .CP(clk), .Q(write_ptr[2]) );
  CFD1QXL \write_ptr_reg[1]  ( .D(n516), .CP(clk), .Q(write_ptr[1]) );
  CFD1QXL \write_ptr_reg[3]  ( .D(n514), .CP(clk), .Q(write_ptr[3]) );
  CFD1QXL \write_ptr_reg[0]  ( .D(n522), .CP(clk), .Q(write_ptr[0]) );
  CFD1QXL \read_ptr_reg[1]  ( .D(n520), .CP(clk), .Q(read_ptr[1]) );
  CFD1QXL \read_ptr_reg[0]  ( .D(n521), .CP(clk), .Q(read_ptr[0]) );
  CFD1QXL \read_ptr_reg[2]  ( .D(n519), .CP(clk), .Q(read_ptr[2]) );
  CFD1QXL \read_ptr_reg[3]  ( .D(n518), .CP(clk), .Q(read_ptr[3]) );
  CANR1XL U513 ( .A(n851), .B(n838), .C(n849), .Z(n848) );
  CANR1XL U514 ( .A(n750), .B(n851), .C(n849), .Z(n760) );
  CANR1XL U515 ( .A(n761), .B(n851), .C(n849), .Z(n771) );
  CANR1XL U516 ( .A(n851), .B(n850), .C(n849), .Z(n870) );
  CNR3XL U517 ( .A(n551), .B(n667), .C(n563), .Z(n877) );
  CNR3XL U518 ( .A(read_ptr[2]), .B(read_ptr[1]), .C(read_ptr[0]), .Z(n653) );
  CND2XL U519 ( .A(n604), .B(n603), .Z(n364) );
  CND2XL U520 ( .A(n565), .B(n874), .Z(n366) );
  CND2XL U521 ( .A(n837), .B(\fifo_mem[13][8] ), .Z(n836) );
  CND2XL U522 ( .A(n709), .B(\fifo_mem[1][7] ), .Z(n701) );
  CND2XL U523 ( .A(n816), .B(\fifo_mem[11][7] ), .Z(n808) );
  CND2XL U524 ( .A(n782), .B(\fifo_mem[8][2] ), .Z(n779) );
  CND2XL U525 ( .A(n749), .B(\fifo_mem[5][0] ), .Z(n740) );
  CND2XL U526 ( .A(n709), .B(\fifo_mem[1][0] ), .Z(n700) );
  CND2XL U527 ( .A(n719), .B(\fifo_mem[2][4] ), .Z(n714) );
  CND2XL U528 ( .A(n816), .B(\fifo_mem[11][8] ), .Z(n815) );
  CND2XL U529 ( .A(n816), .B(\fifo_mem[11][0] ), .Z(n807) );
  CND2XL U530 ( .A(n805), .B(\fifo_mem[10][2] ), .Z(n802) );
  CND2XL U531 ( .A(n771), .B(\fifo_mem[7][6] ), .Z(n764) );
  CND2XL U532 ( .A(n795), .B(\fifo_mem[9][1] ), .Z(n793) );
  CND2XL U533 ( .A(n848), .B(\fifo_mem[14][8] ), .Z(n847) );
  CND2XL U534 ( .A(n848), .B(\fifo_mem[14][7] ), .Z(n840) );
  CND2XL U535 ( .A(n826), .B(\fifo_mem[12][8] ), .Z(n825) );
  CND2XL U536 ( .A(n698), .B(\fifo_mem[0][4] ), .Z(n693) );
  CND2XL U537 ( .A(n771), .B(\fifo_mem[7][5] ), .Z(n765) );
  CND2XL U538 ( .A(n698), .B(\fifo_mem[0][3] ), .Z(n694) );
  CND2XL U539 ( .A(n826), .B(\fifo_mem[12][7] ), .Z(n818) );
  CND2XL U540 ( .A(n709), .B(\fifo_mem[1][6] ), .Z(n702) );
  CND2XL U541 ( .A(n848), .B(\fifo_mem[14][1] ), .Z(n846) );
  CND2XL U542 ( .A(n795), .B(\fifo_mem[9][2] ), .Z(n792) );
  CND2XL U543 ( .A(n848), .B(\fifo_mem[14][4] ), .Z(n843) );
  CND2XL U544 ( .A(n870), .B(\fifo_mem[15][8] ), .Z(n868) );
  CND2XL U545 ( .A(n771), .B(\fifo_mem[7][4] ), .Z(n766) );
  CND2XL U546 ( .A(n826), .B(\fifo_mem[12][1] ), .Z(n824) );
  CND2XL U547 ( .A(n805), .B(\fifo_mem[10][7] ), .Z(n797) );
  CND2XL U548 ( .A(n826), .B(\fifo_mem[12][2] ), .Z(n823) );
  CND2XL U549 ( .A(n795), .B(\fifo_mem[9][3] ), .Z(n791) );
  CND2XL U550 ( .A(n739), .B(\fifo_mem[4][4] ), .Z(n734) );
  CND2XL U551 ( .A(n782), .B(\fifo_mem[8][7] ), .Z(n774) );
  CND2XL U552 ( .A(n805), .B(\fifo_mem[10][1] ), .Z(n803) );
  CND2XL U553 ( .A(n795), .B(\fifo_mem[9][4] ), .Z(n790) );
  CND2XL U554 ( .A(n760), .B(\fifo_mem[6][7] ), .Z(n752) );
  CND2XL U555 ( .A(n771), .B(\fifo_mem[7][3] ), .Z(n767) );
  CND2XL U556 ( .A(n826), .B(\fifo_mem[12][4] ), .Z(n821) );
  CND2XL U557 ( .A(n739), .B(\fifo_mem[4][7] ), .Z(n731) );
  CND2XL U558 ( .A(n782), .B(\fifo_mem[8][1] ), .Z(n780) );
  CND2XL U559 ( .A(n848), .B(\fifo_mem[14][2] ), .Z(n845) );
  CND2XL U560 ( .A(n719), .B(\fifo_mem[2][7] ), .Z(n711) );
  CND2XL U561 ( .A(n795), .B(\fifo_mem[9][5] ), .Z(n789) );
  CND2XL U562 ( .A(n760), .B(\fifo_mem[6][4] ), .Z(n755) );
  CND2XL U563 ( .A(n698), .B(\fifo_mem[0][7] ), .Z(n690) );
  CND2XL U564 ( .A(n771), .B(\fifo_mem[7][2] ), .Z(n768) );
  CND2XL U565 ( .A(n760), .B(\fifo_mem[6][1] ), .Z(n758) );
  CND2XL U566 ( .A(n848), .B(\fifo_mem[14][0] ), .Z(n839) );
  CND2XL U567 ( .A(n795), .B(\fifo_mem[9][6] ), .Z(n788) );
  CND2XL U568 ( .A(n826), .B(\fifo_mem[12][0] ), .Z(n817) );
  CND2XL U569 ( .A(n771), .B(\fifo_mem[7][1] ), .Z(n769) );
  CND2XL U570 ( .A(n739), .B(\fifo_mem[4][1] ), .Z(n737) );
  CND2XL U571 ( .A(n805), .B(\fifo_mem[10][0] ), .Z(n796) );
  CND2XL U572 ( .A(n576), .B(n589), .Z(n368) );
  CND2XL U573 ( .A(n795), .B(\fifo_mem[9][7] ), .Z(n787) );
  CND2XL U574 ( .A(n698), .B(\fifo_mem[0][1] ), .Z(n696) );
  CND2XL U575 ( .A(n782), .B(\fifo_mem[8][4] ), .Z(n777) );
  CND2XL U576 ( .A(n782), .B(\fifo_mem[8][0] ), .Z(n773) );
  CND2XL U577 ( .A(n795), .B(\fifo_mem[9][0] ), .Z(n786) );
  COND3XL U578 ( .A(packet_len_count[1]), .B(n589), .C(n588), .D(n587), .Z(
        n367) );
  CND2XL U579 ( .A(n805), .B(\fifo_mem[10][4] ), .Z(n800) );
  CND2XL U580 ( .A(n816), .B(\fifo_mem[11][6] ), .Z(n809) );
  CND2XL U581 ( .A(n805), .B(\fifo_mem[10][8] ), .Z(n804) );
  CND2XL U582 ( .A(n719), .B(\fifo_mem[2][1] ), .Z(n717) );
  CND2XL U583 ( .A(n771), .B(\fifo_mem[7][7] ), .Z(n763) );
  CND2XL U584 ( .A(n795), .B(\fifo_mem[9][8] ), .Z(n794) );
  CND2XL U585 ( .A(n760), .B(\fifo_mem[6][2] ), .Z(n757) );
  CND2XL U586 ( .A(n709), .B(\fifo_mem[1][5] ), .Z(n703) );
  CND2XL U587 ( .A(n782), .B(\fifo_mem[8][8] ), .Z(n781) );
  CND2XL U588 ( .A(n816), .B(\fifo_mem[11][5] ), .Z(n810) );
  CND2XL U589 ( .A(n709), .B(\fifo_mem[1][4] ), .Z(n704) );
  CND2XL U590 ( .A(n848), .B(\fifo_mem[14][5] ), .Z(n842) );
  CND2XL U591 ( .A(n771), .B(\fifo_mem[7][0] ), .Z(n762) );
  CND2XL U592 ( .A(n771), .B(\fifo_mem[7][8] ), .Z(n770) );
  CND2XL U593 ( .A(n719), .B(\fifo_mem[2][6] ), .Z(n712) );
  CND2XL U594 ( .A(n816), .B(\fifo_mem[11][4] ), .Z(n811) );
  CND2XL U595 ( .A(n739), .B(\fifo_mem[4][2] ), .Z(n736) );
  CND2XL U596 ( .A(n760), .B(\fifo_mem[6][8] ), .Z(n759) );
  CND2XL U597 ( .A(n709), .B(\fifo_mem[1][3] ), .Z(n705) );
  CND2XL U598 ( .A(n816), .B(\fifo_mem[11][3] ), .Z(n812) );
  CND2XL U599 ( .A(n749), .B(\fifo_mem[5][1] ), .Z(n747) );
  CND2XL U600 ( .A(n719), .B(\fifo_mem[2][3] ), .Z(n715) );
  CND2XL U601 ( .A(n826), .B(\fifo_mem[12][5] ), .Z(n820) );
  CND2XL U602 ( .A(n749), .B(\fifo_mem[5][8] ), .Z(n748) );
  CND2XL U603 ( .A(n739), .B(\fifo_mem[4][6] ), .Z(n732) );
  CND2XL U604 ( .A(n709), .B(\fifo_mem[1][2] ), .Z(n706) );
  CND2XL U605 ( .A(n816), .B(\fifo_mem[11][2] ), .Z(n813) );
  CND2XL U606 ( .A(n739), .B(\fifo_mem[4][8] ), .Z(n738) );
  CND2XL U607 ( .A(n749), .B(\fifo_mem[5][2] ), .Z(n746) );
  CND2XL U608 ( .A(n719), .B(\fifo_mem[2][2] ), .Z(n716) );
  CND2XL U609 ( .A(n709), .B(\fifo_mem[1][1] ), .Z(n707) );
  CND2XL U610 ( .A(n729), .B(\fifo_mem[3][8] ), .Z(n728) );
  CND2XL U611 ( .A(n760), .B(\fifo_mem[6][6] ), .Z(n753) );
  CND2XL U612 ( .A(n816), .B(\fifo_mem[11][1] ), .Z(n814) );
  CND2XL U613 ( .A(n805), .B(\fifo_mem[10][5] ), .Z(n799) );
  CND2XL U614 ( .A(n719), .B(\fifo_mem[2][8] ), .Z(n718) );
  CND2XL U615 ( .A(n749), .B(\fifo_mem[5][3] ), .Z(n745) );
  CND2XL U616 ( .A(n729), .B(\fifo_mem[3][0] ), .Z(n720) );
  CND2XL U617 ( .A(n837), .B(\fifo_mem[13][0] ), .Z(n828) );
  CND2XL U618 ( .A(n739), .B(\fifo_mem[4][3] ), .Z(n735) );
  CND2XL U619 ( .A(n709), .B(\fifo_mem[1][8] ), .Z(n708) );
  CND2XL U620 ( .A(n729), .B(\fifo_mem[3][7] ), .Z(n721) );
  CND2XL U621 ( .A(n782), .B(\fifo_mem[8][6] ), .Z(n775) );
  CND2XL U622 ( .A(n782), .B(\fifo_mem[8][5] ), .Z(n776) );
  CND2XL U623 ( .A(n837), .B(\fifo_mem[13][7] ), .Z(n829) );
  CND2XL U624 ( .A(n698), .B(\fifo_mem[0][2] ), .Z(n695) );
  CND2XL U625 ( .A(n698), .B(\fifo_mem[0][8] ), .Z(n697) );
  CND2XL U626 ( .A(n729), .B(\fifo_mem[3][6] ), .Z(n722) );
  CND2XL U627 ( .A(n805), .B(\fifo_mem[10][6] ), .Z(n798) );
  CND2XL U628 ( .A(n749), .B(\fifo_mem[5][4] ), .Z(n744) );
  CND2XL U629 ( .A(n837), .B(\fifo_mem[13][6] ), .Z(n830) );
  CND2XL U630 ( .A(n870), .B(\fifo_mem[15][1] ), .Z(n866) );
  CND2XL U631 ( .A(n760), .B(\fifo_mem[6][5] ), .Z(n754) );
  CND2XL U632 ( .A(n729), .B(\fifo_mem[3][5] ), .Z(n723) );
  CND2XL U633 ( .A(n837), .B(\fifo_mem[13][5] ), .Z(n831) );
  CND2XL U634 ( .A(n749), .B(\fifo_mem[5][5] ), .Z(n743) );
  CND2XL U635 ( .A(n870), .B(\fifo_mem[15][2] ), .Z(n864) );
  CND2XL U636 ( .A(n848), .B(\fifo_mem[14][3] ), .Z(n844) );
  CND2XL U637 ( .A(n826), .B(\fifo_mem[12][6] ), .Z(n819) );
  CND2XL U638 ( .A(n729), .B(\fifo_mem[3][4] ), .Z(n724) );
  CND2XL U639 ( .A(n760), .B(\fifo_mem[6][3] ), .Z(n756) );
  CND2XL U640 ( .A(n870), .B(\fifo_mem[15][3] ), .Z(n862) );
  CND2XL U641 ( .A(n837), .B(\fifo_mem[13][4] ), .Z(n832) );
  CND2XL U642 ( .A(n749), .B(\fifo_mem[5][6] ), .Z(n742) );
  CND2XL U643 ( .A(n870), .B(\fifo_mem[15][4] ), .Z(n860) );
  CND2XL U644 ( .A(n729), .B(\fifo_mem[3][3] ), .Z(n725) );
  CND2XL U645 ( .A(n848), .B(\fifo_mem[14][6] ), .Z(n841) );
  CND2XL U646 ( .A(n739), .B(\fifo_mem[4][5] ), .Z(n733) );
  CND2XL U647 ( .A(n837), .B(\fifo_mem[13][3] ), .Z(n833) );
  CND2XL U648 ( .A(n870), .B(\fifo_mem[15][5] ), .Z(n858) );
  CND2XL U649 ( .A(n749), .B(\fifo_mem[5][7] ), .Z(n741) );
  CND2XL U650 ( .A(n826), .B(\fifo_mem[12][3] ), .Z(n822) );
  CND2XL U651 ( .A(n729), .B(\fifo_mem[3][2] ), .Z(n726) );
  CND2XL U652 ( .A(n837), .B(\fifo_mem[13][2] ), .Z(n834) );
  CND2XL U653 ( .A(n870), .B(\fifo_mem[15][6] ), .Z(n856) );
  CND2XL U654 ( .A(n782), .B(\fifo_mem[8][3] ), .Z(n778) );
  CND2XL U655 ( .A(n698), .B(\fifo_mem[0][5] ), .Z(n692) );
  CND2XL U656 ( .A(n870), .B(\fifo_mem[15][7] ), .Z(n854) );
  CND2XL U657 ( .A(n729), .B(\fifo_mem[3][1] ), .Z(n727) );
  CND2XL U658 ( .A(n719), .B(\fifo_mem[2][5] ), .Z(n713) );
  CND2XL U659 ( .A(n837), .B(\fifo_mem[13][1] ), .Z(n835) );
  CND2XL U660 ( .A(n870), .B(\fifo_mem[15][0] ), .Z(n852) );
  CND2XL U661 ( .A(n805), .B(\fifo_mem[10][3] ), .Z(n801) );
  CND2XL U662 ( .A(n698), .B(\fifo_mem[0][6] ), .Z(n691) );
  CND2XL U663 ( .A(n698), .B(\fifo_mem[0][0] ), .Z(n689) );
  CANR2XL U664 ( .A(packet_len_count[3]), .B(n872), .C(n879), .D(n871), .Z(
        n873) );
  CND2XL U665 ( .A(n719), .B(\fifo_mem[2][0] ), .Z(n710) );
  CANR2XL U666 ( .A(packet_len_count[2]), .B(n564), .C(n663), .D(n879), .Z(
        n565) );
  CND2XL U667 ( .A(n760), .B(\fifo_mem[6][0] ), .Z(n751) );
  CND2XL U668 ( .A(n739), .B(\fifo_mem[4][0] ), .Z(n730) );
  CNR2XL U669 ( .A(n876), .B(n601), .Z(n602) );
  CND2XL U670 ( .A(n552), .B(n666), .Z(n564) );
  COND2XL U671 ( .A(n535), .B(n672), .C(n670), .D(n534), .Z(n518) );
  CND2XL U672 ( .A(n590), .B(n877), .Z(n874) );
  CND2XL U673 ( .A(n879), .B(n633), .Z(n588) );
  CNR3XL U674 ( .A(write_ptr[3]), .B(n784), .C(n699), .Z(n761) );
  CNR2X1 U675 ( .A(write_ptr[0]), .B(n783), .Z(n838) );
  CIVX1 U676 ( .A(n877), .Z(n601) );
  CND2XL U677 ( .A(n879), .B(n878), .Z(n880) );
  CANR2XL U678 ( .A(packet_len_count[0]), .B(n875), .C(n879), .D(n632), .Z(
        n576) );
  CND2XL U679 ( .A(n684), .B(n784), .Z(n664) );
  CIVXL U680 ( .A(n666), .Z(n875) );
  CND2XL U681 ( .A(n669), .B(n672), .Z(n534) );
  COND2XL U682 ( .A(n530), .B(n540), .C(n667), .D(n529), .Z(n519) );
  COND2XL U683 ( .A(n527), .B(n528), .C(n667), .D(n539), .Z(n520) );
  CIVXL U684 ( .A(n772), .Z(n699) );
  CNR2X1 U685 ( .A(n688), .B(n849), .Z(n772) );
  CNR2XL U686 ( .A(n680), .B(n688), .Z(n684) );
  CIVXL U687 ( .A(n667), .Z(n669) );
  CIVX1 U688 ( .A(n532), .Z(n671) );
  CIVX1 U689 ( .A(n607), .Z(n618) );
  CND2X1 U690 ( .A(resetn), .B(n532), .Z(n667) );
  CANR4CXL U691 ( .A(n532), .B(n2), .C(n607), .D(n680), .Z(n353) );
  CANR2XL U692 ( .A(n650), .B(\fifo_mem[3][4] ), .C(n649), .D(\fifo_mem[4][4] ), .Z(n558) );
  CANR2XL U693 ( .A(n651), .B(\fifo_mem[13][8] ), .C(n668), .D(
        \fifo_mem[15][8] ), .Z(n545) );
  CANR2XL U694 ( .A(n650), .B(\fifo_mem[11][5] ), .C(n649), .D(
        \fifo_mem[12][5] ), .Z(n646) );
  CANR2XL U695 ( .A(n653), .B(\fifo_mem[0][8] ), .C(n648), .D(\fifo_mem[2][8] ), .Z(n544) );
  CANR2XL U696 ( .A(n650), .B(\fifo_mem[11][1] ), .C(n649), .D(
        \fifo_mem[12][1] ), .Z(n622) );
  CANR2XL U697 ( .A(n650), .B(\fifo_mem[11][6] ), .C(n649), .D(
        \fifo_mem[12][6] ), .Z(n593) );
  CANR2XL U698 ( .A(n649), .B(\fifo_mem[12][8] ), .C(n652), .D(
        \fifo_mem[14][8] ), .Z(n546) );
  CANR2XL U699 ( .A(n648), .B(\fifo_mem[10][6] ), .C(n647), .D(
        \fifo_mem[9][6] ), .Z(n600) );
  CANR2XL U700 ( .A(n652), .B(\fifo_mem[14][1] ), .C(n651), .D(
        \fifo_mem[13][1] ), .Z(n621) );
  CANR2XL U701 ( .A(n652), .B(\fifo_mem[14][4] ), .C(n651), .D(
        \fifo_mem[13][4] ), .Z(n554) );
  CANR2XL U702 ( .A(n648), .B(\fifo_mem[10][2] ), .C(n647), .D(
        \fifo_mem[9][2] ), .Z(n575) );
  CANR2XL U703 ( .A(n650), .B(\fifo_mem[3][6] ), .C(n649), .D(\fifo_mem[4][6] ), .Z(n596) );
  CANR2XL U704 ( .A(n650), .B(\fifo_mem[3][5] ), .C(n649), .D(\fifo_mem[4][5] ), .Z(n656) );
  CANR2XL U705 ( .A(n652), .B(\fifo_mem[6][5] ), .C(n651), .D(\fifo_mem[5][5] ), .Z(n655) );
  CANR2XL U706 ( .A(n653), .B(\fifo_mem[8][8] ), .C(n648), .D(
        \fifo_mem[10][8] ), .Z(n548) );
  CANR2XL U707 ( .A(n648), .B(\fifo_mem[2][1] ), .C(n647), .D(\fifo_mem[1][1] ), .Z(n627) );
  CANR2XL U708 ( .A(n648), .B(\fifo_mem[2][0] ), .C(n647), .D(\fifo_mem[1][0] ), .Z(n615) );
  CANR2XL U709 ( .A(n648), .B(\fifo_mem[10][5] ), .C(n647), .D(
        \fifo_mem[9][5] ), .Z(n660) );
  CANR2XL U710 ( .A(n648), .B(\fifo_mem[10][1] ), .C(n647), .D(
        \fifo_mem[9][1] ), .Z(n629) );
  CANR2XL U711 ( .A(n648), .B(\fifo_mem[2][3] ), .C(n647), .D(\fifo_mem[1][3] ), .Z(n584) );
  CANR2XL U712 ( .A(n650), .B(\fifo_mem[11][3] ), .C(n649), .D(
        \fifo_mem[12][3] ), .Z(n579) );
  CANR2XL U713 ( .A(n650), .B(\fifo_mem[3][7] ), .C(n649), .D(\fifo_mem[4][7] ), .Z(n639) );
  CANR2XL U714 ( .A(n648), .B(\fifo_mem[2][4] ), .C(n647), .D(\fifo_mem[1][4] ), .Z(n560) );
  CANR2XL U715 ( .A(n648), .B(\fifo_mem[2][7] ), .C(n647), .D(\fifo_mem[1][7] ), .Z(n641) );
  CANR2XL U716 ( .A(n652), .B(\fifo_mem[14][3] ), .C(n651), .D(
        \fifo_mem[13][3] ), .Z(n578) );
  CANR2XL U717 ( .A(n652), .B(\fifo_mem[6][3] ), .C(n651), .D(\fifo_mem[5][3] ), .Z(n581) );
  CANR2XL U718 ( .A(n647), .B(\fifo_mem[1][8] ), .C(n650), .D(\fifo_mem[3][8] ), .Z(n543) );
  CANR2XL U719 ( .A(n652), .B(\fifo_mem[6][4] ), .C(n651), .D(\fifo_mem[5][4] ), .Z(n557) );
  CANR2XL U720 ( .A(n650), .B(\fifo_mem[11][2] ), .C(n649), .D(
        \fifo_mem[12][2] ), .Z(n568) );
  CANR2XL U721 ( .A(n648), .B(\fifo_mem[10][0] ), .C(n647), .D(
        \fifo_mem[9][0] ), .Z(n617) );
  CANR2XL U722 ( .A(n650), .B(\fifo_mem[11][4] ), .C(n649), .D(
        \fifo_mem[12][4] ), .Z(n555) );
  CANR2XL U723 ( .A(n652), .B(\fifo_mem[14][7] ), .C(n651), .D(
        \fifo_mem[13][7] ), .Z(n635) );
  CANR2XL U724 ( .A(n650), .B(\fifo_mem[3][1] ), .C(n649), .D(\fifo_mem[4][1] ), .Z(n625) );
  CANR2XL U725 ( .A(n647), .B(\fifo_mem[9][8] ), .C(n650), .D(
        \fifo_mem[11][8] ), .Z(n547) );
  CANR2XL U726 ( .A(n648), .B(\fifo_mem[10][7] ), .C(n647), .D(
        \fifo_mem[9][7] ), .Z(n643) );
  CANR2XL U727 ( .A(n652), .B(\fifo_mem[14][5] ), .C(n651), .D(
        \fifo_mem[13][5] ), .Z(n645) );
  CANR2XL U728 ( .A(n652), .B(\fifo_mem[14][2] ), .C(n651), .D(
        \fifo_mem[13][2] ), .Z(n567) );
  CANR2XL U729 ( .A(n651), .B(\fifo_mem[5][8] ), .C(n668), .D(\fifo_mem[7][8] ), .Z(n541) );
  CANR2XL U730 ( .A(n652), .B(\fifo_mem[14][6] ), .C(n651), .D(
        \fifo_mem[13][6] ), .Z(n592) );
  CANR2XL U731 ( .A(n650), .B(\fifo_mem[11][7] ), .C(n649), .D(
        \fifo_mem[12][7] ), .Z(n636) );
  CANR2XL U732 ( .A(n648), .B(\fifo_mem[10][3] ), .C(n647), .D(
        \fifo_mem[9][3] ), .Z(n586) );
  CANR2XL U733 ( .A(n648), .B(\fifo_mem[2][5] ), .C(n647), .D(\fifo_mem[1][5] ), .Z(n658) );
  CANR2XL U734 ( .A(n650), .B(\fifo_mem[11][0] ), .C(n649), .D(
        \fifo_mem[12][0] ), .Z(n610) );
  CANR2XL U735 ( .A(n650), .B(\fifo_mem[3][0] ), .C(n649), .D(\fifo_mem[4][0] ), .Z(n613) );
  CANR2XL U736 ( .A(n652), .B(\fifo_mem[6][6] ), .C(n651), .D(\fifo_mem[5][6] ), .Z(n595) );
  CANR2XL U737 ( .A(n649), .B(\fifo_mem[4][8] ), .C(n652), .D(\fifo_mem[6][8] ), .Z(n542) );
  CANR2XL U738 ( .A(n648), .B(\fifo_mem[2][2] ), .C(n647), .D(\fifo_mem[1][2] ), .Z(n573) );
  CANR2XL U739 ( .A(n648), .B(\fifo_mem[10][4] ), .C(n647), .D(
        \fifo_mem[9][4] ), .Z(n562) );
  CANR2XL U740 ( .A(n652), .B(\fifo_mem[6][0] ), .C(n651), .D(\fifo_mem[5][0] ), .Z(n612) );
  CANR2XL U741 ( .A(n650), .B(\fifo_mem[3][3] ), .C(n649), .D(\fifo_mem[4][3] ), .Z(n582) );
  CANR2XL U742 ( .A(n650), .B(\fifo_mem[3][2] ), .C(n649), .D(\fifo_mem[4][2] ), .Z(n571) );
  CANR2XL U743 ( .A(n652), .B(\fifo_mem[14][0] ), .C(n651), .D(
        \fifo_mem[13][0] ), .Z(n609) );
  CANR2XL U744 ( .A(n652), .B(\fifo_mem[6][1] ), .C(n651), .D(\fifo_mem[5][1] ), .Z(n624) );
  CANR2XL U745 ( .A(n652), .B(\fifo_mem[6][2] ), .C(n651), .D(\fifo_mem[5][2] ), .Z(n570) );
  CANR2XL U746 ( .A(n648), .B(\fifo_mem[2][6] ), .C(n647), .D(\fifo_mem[1][6] ), .Z(n598) );
  CANR2XL U747 ( .A(n652), .B(\fifo_mem[6][7] ), .C(n651), .D(\fifo_mem[5][7] ), .Z(n638) );
  CANR2XL U748 ( .A(n653), .B(\fifo_mem[0][7] ), .C(n668), .D(\fifo_mem[7][7] ), .Z(n637) );
  CANR2XL U749 ( .A(n653), .B(\fifo_mem[8][0] ), .C(n668), .D(
        \fifo_mem[15][0] ), .Z(n608) );
  CANR2XL U750 ( .A(n653), .B(\fifo_mem[0][3] ), .C(n668), .D(\fifo_mem[7][3] ), .Z(n580) );
  CANR2XL U751 ( .A(n653), .B(\fifo_mem[0][6] ), .C(n668), .D(\fifo_mem[7][6] ), .Z(n594) );
  CANR2XL U752 ( .A(n653), .B(\fifo_mem[8][7] ), .C(n668), .D(
        \fifo_mem[15][7] ), .Z(n634) );
  CANR2XL U753 ( .A(n653), .B(\fifo_mem[8][5] ), .C(n668), .D(
        \fifo_mem[15][5] ), .Z(n644) );
  CANR2XL U754 ( .A(n653), .B(\fifo_mem[0][5] ), .C(n668), .D(\fifo_mem[7][5] ), .Z(n654) );
  CANR2XL U755 ( .A(n653), .B(\fifo_mem[0][0] ), .C(n668), .D(\fifo_mem[7][0] ), .Z(n611) );
  CANR2XL U756 ( .A(n653), .B(\fifo_mem[8][1] ), .C(n668), .D(
        \fifo_mem[15][1] ), .Z(n620) );
  CANR2XL U757 ( .A(n653), .B(\fifo_mem[8][6] ), .C(n668), .D(
        \fifo_mem[15][6] ), .Z(n591) );
  CANR2XL U758 ( .A(n653), .B(\fifo_mem[0][4] ), .C(n668), .D(\fifo_mem[7][4] ), .Z(n556) );
  CANR2XL U759 ( .A(n653), .B(\fifo_mem[0][1] ), .C(n668), .D(\fifo_mem[7][1] ), .Z(n623) );
  CIVX1 U760 ( .A(n650), .Z(n529) );
  CANR2XL U761 ( .A(n653), .B(\fifo_mem[8][2] ), .C(n668), .D(
        \fifo_mem[15][2] ), .Z(n566) );
  CANR2XL U762 ( .A(n653), .B(\fifo_mem[0][2] ), .C(n668), .D(\fifo_mem[7][2] ), .Z(n569) );
  CANR2XL U763 ( .A(n653), .B(\fifo_mem[8][3] ), .C(n668), .D(
        \fifo_mem[15][3] ), .Z(n577) );
  CANR2XL U764 ( .A(n653), .B(\fifo_mem[8][4] ), .C(n668), .D(
        \fifo_mem[15][4] ), .Z(n553) );
  CND2XL U765 ( .A(read_ptr[0]), .B(n528), .Z(n539) );
  CNR2X1 U766 ( .A(write_ptr[2]), .B(n678), .Z(n806) );
  CNR2X1 U767 ( .A(write_ptr[1]), .B(n679), .Z(n827) );
  CIVX1 U768 ( .A(write_ptr[0]), .Z(n784) );
  CIVX2 U769 ( .A(N175), .Z(n2) );
  CEOX1 U770 ( .A(read_ptr[4]), .B(write_ptr[4]), .Z(n606) );
  CENX1 U771 ( .A(read_ptr[1]), .B(write_ptr[1]), .Z(n524) );
  CENX1 U772 ( .A(read_ptr[3]), .B(write_ptr[3]), .Z(n526) );
  CENX1 U773 ( .A(read_ptr[0]), .B(write_ptr[0]), .Z(n523) );
  CNR2X1 U774 ( .A(write_ptr[2]), .B(write_ptr[1]), .Z(n785) );
  CENX1 U775 ( .A(read_ptr[2]), .B(write_ptr[2]), .Z(n525) );
  CND4X1 U776 ( .A(n526), .B(n525), .C(n524), .D(n523), .Z(n605) );
  CNR2XL U777 ( .A(n606), .B(n605), .Z(empty) );
  CIVXL U778 ( .A(read_ptr[0]), .Z(n536) );
  CNR2IX1 U779 ( .B(read_enb), .A(empty), .Z(n532) );
  COND1XL U780 ( .A(n536), .B(n671), .C(resetn), .Z(n527) );
  CIVXL U781 ( .A(read_ptr[1]), .Z(n528) );
  COND11XL U782 ( .A(n528), .B(n536), .C(n671), .D(resetn), .Z(n530) );
  CIVXL U783 ( .A(read_ptr[2]), .Z(n540) );
  CND2XL U784 ( .A(read_ptr[1]), .B(read_ptr[0]), .Z(n533) );
  CNR2X1 U785 ( .A(read_ptr[2]), .B(n533), .Z(n650) );
  CNR3XL U786 ( .A(packet_len_count[0]), .B(packet_len_count[2]), .C(
        packet_len_count[1]), .Z(n590) );
  CNR2X1 U787 ( .A(packet_len_count[4]), .B(packet_len_count[3]), .Z(n531) );
  CND2X1 U788 ( .A(n590), .B(n531), .Z(n876) );
  CNR2X1 U789 ( .A(packet_len_count[5]), .B(n876), .Z(n551) );
  CNR2XL U790 ( .A(n551), .B(soft_reset), .Z(n607) );
  CIVXL U791 ( .A(resetn), .Z(n680) );
  CNR2X1 U792 ( .A(n540), .B(n533), .Z(n668) );
  CIVX2 U793 ( .A(n668), .Z(n670) );
  COND1XL U794 ( .A(n671), .B(n670), .C(resetn), .Z(n535) );
  CIVXL U795 ( .A(read_ptr[3]), .Z(n672) );
  CND2XL U796 ( .A(read_ptr[1]), .B(n536), .Z(n538) );
  CNR2X1 U797 ( .A(read_ptr[2]), .B(n538), .Z(n648) );
  CNR2X1 U798 ( .A(read_ptr[2]), .B(n539), .Z(n647) );
  CND2XL U799 ( .A(read_ptr[2]), .B(n536), .Z(n537) );
  CNR2X1 U800 ( .A(read_ptr[1]), .B(n537), .Z(n649) );
  CNR2X1 U801 ( .A(n540), .B(n538), .Z(n652) );
  CNR2X1 U802 ( .A(n540), .B(n539), .Z(n651) );
  CAN4X1 U803 ( .A(n544), .B(n543), .C(n542), .D(n541), .Z(n550) );
  CAN4X1 U804 ( .A(n548), .B(n547), .C(n546), .D(n545), .Z(n549) );
  CMXI2X1 U805 ( .A0(n550), .A1(n549), .S(read_ptr[3]), .Z(n563) );
  COND1XL U806 ( .A(packet_len_count[0]), .B(packet_len_count[1]), .C(n877), 
        .Z(n552) );
  CND2XL U807 ( .A(resetn), .B(n671), .Z(n666) );
  CAN4X1 U808 ( .A(read_ptr[3]), .B(n555), .C(n554), .D(n553), .Z(n561) );
  CAN4X1 U809 ( .A(n558), .B(n557), .C(n556), .D(n672), .Z(n559) );
  CANR2X1 U810 ( .A(n562), .B(n561), .C(n560), .D(n559), .Z(n663) );
  CNR2IX1 U811 ( .B(n563), .A(n667), .Z(n879) );
  CAN4X1 U812 ( .A(read_ptr[3]), .B(n568), .C(n567), .D(n566), .Z(n574) );
  CAN4X1 U813 ( .A(n571), .B(n570), .C(n569), .D(n672), .Z(n572) );
  CANR2X1 U814 ( .A(n575), .B(n574), .C(n573), .D(n572), .Z(n632) );
  COR2X1 U815 ( .A(packet_len_count[0]), .B(n601), .Z(n589) );
  CAN4X1 U816 ( .A(read_ptr[3]), .B(n579), .C(n578), .D(n577), .Z(n585) );
  CAN4X1 U817 ( .A(n582), .B(n581), .C(n580), .D(n672), .Z(n583) );
  CANR2X1 U818 ( .A(n586), .B(n585), .C(n584), .D(n583), .Z(n633) );
  COND4CXL U819 ( .A(packet_len_count[0]), .B(n877), .C(n875), .D(
        packet_len_count[1]), .Z(n587) );
  COND1XL U820 ( .A(n590), .B(n601), .C(n666), .Z(n872) );
  COND4CXL U821 ( .A(packet_len_count[3]), .B(n877), .C(n872), .D(
        packet_len_count[4]), .Z(n604) );
  CAN4X1 U822 ( .A(read_ptr[3]), .B(n593), .C(n592), .D(n591), .Z(n599) );
  CAN4X1 U823 ( .A(n596), .B(n595), .C(n594), .D(n672), .Z(n597) );
  CANR2X1 U824 ( .A(n600), .B(n599), .C(n598), .D(n597), .Z(n631) );
  CANR1XL U825 ( .A(n879), .B(n631), .C(n602), .Z(n603) );
  CNR2IX1 U826 ( .B(n606), .A(n605), .Z(full) );
  CNR2X1 U827 ( .A(n667), .B(n618), .Z(n662) );
  CAN4X1 U828 ( .A(read_ptr[3]), .B(n610), .C(n609), .D(n608), .Z(n616) );
  CAN4X1 U829 ( .A(n613), .B(n612), .C(n611), .D(n672), .Z(n614) );
  CANR2X1 U830 ( .A(n617), .B(n616), .C(n615), .D(n614), .Z(n619) );
  CNR2X1 U831 ( .A(n666), .B(n618), .Z(n661) );
  CAOR2XL U832 ( .A(n662), .B(n619), .C(n661), .D(N177), .Z(n361) );
  CAN4X1 U833 ( .A(read_ptr[3]), .B(n622), .C(n621), .D(n620), .Z(n628) );
  CAN4X1 U834 ( .A(n625), .B(n624), .C(n623), .D(n672), .Z(n626) );
  CANR2X1 U835 ( .A(n629), .B(n628), .C(n627), .D(n626), .Z(n630) );
  CAOR2XL U836 ( .A(n662), .B(n630), .C(n661), .D(N174), .Z(n354) );
  CAOR2XL U837 ( .A(n631), .B(n662), .C(n661), .D(N159), .Z(n359) );
  CAOR2XL U838 ( .A(n632), .B(n662), .C(n661), .D(N171), .Z(n355) );
  CAOR2XL U839 ( .A(n633), .B(n662), .C(n661), .D(N168), .Z(n356) );
  CAN4X1 U840 ( .A(read_ptr[3]), .B(n636), .C(n635), .D(n634), .Z(n642) );
  CAN4X1 U841 ( .A(n639), .B(n638), .C(n637), .D(n672), .Z(n640) );
  CANR2X1 U842 ( .A(n643), .B(n642), .C(n641), .D(n640), .Z(n878) );
  CAOR2XL U843 ( .A(n878), .B(n662), .C(n661), .D(N156), .Z(n360) );
  CAN4X1 U844 ( .A(read_ptr[3]), .B(n646), .C(n645), .D(n644), .Z(n659) );
  CAN4X1 U845 ( .A(n656), .B(n655), .C(n654), .D(n672), .Z(n657) );
  CANR2X1 U846 ( .A(n660), .B(n659), .C(n658), .D(n657), .Z(n871) );
  CAOR2XL U847 ( .A(n871), .B(n662), .C(n661), .D(N162), .Z(n358) );
  CAOR2XL U848 ( .A(n663), .B(n662), .C(n661), .D(N165), .Z(n357) );
  CAN2XL U849 ( .A(lfd_state), .B(resetn), .Z(N32) );
  CNR2IX1 U850 ( .B(write_enb), .A(full), .Z(n681) );
  CIVX2 U851 ( .A(n681), .Z(n688) );
  CND2XL U852 ( .A(resetn), .B(n688), .Z(n665) );
  COND1XL U853 ( .A(n665), .B(n784), .C(n664), .Z(n522) );
  CMXI2XL U854 ( .A0(n667), .A1(n666), .S(read_ptr[0]), .Z(n521) );
  CND3XL U855 ( .A(read_ptr[3]), .B(n669), .C(n668), .Z(n674) );
  COND11XL U856 ( .A(n672), .B(n671), .C(n670), .D(resetn), .Z(n673) );
  CMXI2XL U857 ( .A0(n674), .A1(n673), .S(read_ptr[4]), .Z(n517) );
  CND2XL U858 ( .A(write_ptr[0]), .B(n684), .Z(n675) );
  COND1XL U859 ( .A(n784), .B(n688), .C(resetn), .Z(n677) );
  CMXI2XL U860 ( .A0(n675), .A1(n677), .S(write_ptr[1]), .Z(n516) );
  CIVXL U861 ( .A(write_ptr[2]), .Z(n679) );
  CIVXL U862 ( .A(write_ptr[1]), .Z(n678) );
  COND4CXL U863 ( .A(write_ptr[0]), .B(n806), .C(n827), .D(n684), .Z(n676) );
  COND1XL U864 ( .A(n677), .B(n679), .C(n676), .Z(n515) );
  CNR2X1 U865 ( .A(n679), .B(n678), .Z(n851) );
  CND3XL U866 ( .A(write_ptr[0]), .B(n851), .C(n684), .Z(n686) );
  CANR11XL U867 ( .A(write_ptr[0]), .B(n681), .C(n851), .D(n680), .Z(n683) );
  CND2XL U868 ( .A(write_ptr[3]), .B(n683), .Z(n682) );
  COND1XL U869 ( .A(n686), .B(write_ptr[3]), .C(n682), .Z(n514) );
  CIVXL U870 ( .A(write_ptr[3]), .Z(n687) );
  COND4CXL U871 ( .A(n684), .B(n687), .C(n683), .D(write_ptr[4]), .Z(n685) );
  COND11XL U872 ( .A(write_ptr[4]), .B(n687), .C(n686), .D(n685), .Z(n513) );
  CND2IX1 U873 ( .B(soft_reset), .A(resetn), .Z(n849) );
  CNR3XL U874 ( .A(write_ptr[3]), .B(write_ptr[0]), .C(n699), .Z(n750) );
  CANR1X1 U875 ( .A(n785), .B(n750), .C(n849), .Z(n698) );
  CND2XL U876 ( .A(n772), .B(data_in[0]), .Z(n853) );
  COND1XL U877 ( .A(n698), .B(n853), .C(n689), .Z(n512) );
  CND2XL U878 ( .A(n772), .B(data_in[7]), .Z(n855) );
  COND1XL U879 ( .A(n698), .B(n855), .C(n690), .Z(n511) );
  CND2XL U880 ( .A(n772), .B(data_in[6]), .Z(n857) );
  COND1XL U881 ( .A(n698), .B(n857), .C(n691), .Z(n510) );
  CND2XL U882 ( .A(n772), .B(data_in[5]), .Z(n859) );
  COND1XL U883 ( .A(n698), .B(n859), .C(n692), .Z(n509) );
  CND2XL U884 ( .A(n772), .B(data_in[4]), .Z(n861) );
  COND1XL U885 ( .A(n698), .B(n861), .C(n693), .Z(n508) );
  CND2XL U886 ( .A(n772), .B(data_in[3]), .Z(n863) );
  COND1XL U887 ( .A(n698), .B(n863), .C(n694), .Z(n507) );
  CND2XL U888 ( .A(n772), .B(data_in[2]), .Z(n865) );
  COND1XL U889 ( .A(n698), .B(n865), .C(n695), .Z(n506) );
  CND2XL U890 ( .A(n772), .B(data_in[1]), .Z(n867) );
  COND1XL U891 ( .A(n698), .B(n867), .C(n696), .Z(n505) );
  CND2XL U892 ( .A(n772), .B(lfd_temp), .Z(n869) );
  COND1XL U893 ( .A(n698), .B(n869), .C(n697), .Z(n504) );
  CANR1X1 U894 ( .A(n785), .B(n761), .C(n849), .Z(n709) );
  COND1XL U895 ( .A(n709), .B(n853), .C(n700), .Z(n503) );
  COND1XL U896 ( .A(n709), .B(n855), .C(n701), .Z(n502) );
  COND1XL U897 ( .A(n709), .B(n857), .C(n702), .Z(n501) );
  COND1XL U898 ( .A(n709), .B(n859), .C(n703), .Z(n500) );
  COND1XL U899 ( .A(n709), .B(n861), .C(n704), .Z(n499) );
  COND1XL U900 ( .A(n709), .B(n863), .C(n705), .Z(n498) );
  COND1XL U901 ( .A(n709), .B(n865), .C(n706), .Z(n497) );
  COND1XL U902 ( .A(n709), .B(n867), .C(n707), .Z(n496) );
  COND1XL U903 ( .A(n709), .B(n869), .C(n708), .Z(n495) );
  CANR1X1 U904 ( .A(n750), .B(n806), .C(n849), .Z(n719) );
  COND1XL U905 ( .A(n719), .B(n853), .C(n710), .Z(n494) );
  COND1XL U906 ( .A(n719), .B(n855), .C(n711), .Z(n493) );
  COND1XL U907 ( .A(n719), .B(n857), .C(n712), .Z(n492) );
  COND1XL U908 ( .A(n719), .B(n859), .C(n713), .Z(n491) );
  COND1XL U909 ( .A(n719), .B(n861), .C(n714), .Z(n490) );
  COND1XL U910 ( .A(n719), .B(n863), .C(n715), .Z(n489) );
  COND1XL U911 ( .A(n719), .B(n865), .C(n716), .Z(n488) );
  COND1XL U912 ( .A(n719), .B(n867), .C(n717), .Z(n487) );
  COND1XL U913 ( .A(n719), .B(n869), .C(n718), .Z(n486) );
  CANR1X1 U914 ( .A(n761), .B(n806), .C(n849), .Z(n729) );
  COND1XL U915 ( .A(n729), .B(n853), .C(n720), .Z(n485) );
  COND1XL U916 ( .A(n729), .B(n855), .C(n721), .Z(n484) );
  COND1XL U917 ( .A(n729), .B(n857), .C(n722), .Z(n483) );
  COND1XL U918 ( .A(n729), .B(n859), .C(n723), .Z(n482) );
  COND1XL U919 ( .A(n729), .B(n861), .C(n724), .Z(n481) );
  COND1XL U920 ( .A(n729), .B(n863), .C(n725), .Z(n480) );
  COND1XL U921 ( .A(n729), .B(n865), .C(n726), .Z(n479) );
  COND1XL U922 ( .A(n729), .B(n867), .C(n727), .Z(n478) );
  COND1XL U923 ( .A(n729), .B(n869), .C(n728), .Z(n477) );
  CANR1X1 U924 ( .A(n750), .B(n827), .C(n849), .Z(n739) );
  COND1XL U925 ( .A(n739), .B(n853), .C(n730), .Z(n476) );
  COND1XL U926 ( .A(n739), .B(n855), .C(n731), .Z(n475) );
  COND1XL U927 ( .A(n739), .B(n857), .C(n732), .Z(n474) );
  COND1XL U928 ( .A(n739), .B(n859), .C(n733), .Z(n473) );
  COND1XL U929 ( .A(n739), .B(n861), .C(n734), .Z(n472) );
  COND1XL U930 ( .A(n739), .B(n863), .C(n735), .Z(n471) );
  COND1XL U931 ( .A(n739), .B(n865), .C(n736), .Z(n470) );
  COND1XL U932 ( .A(n739), .B(n867), .C(n737), .Z(n469) );
  COND1XL U933 ( .A(n739), .B(n869), .C(n738), .Z(n468) );
  CANR1X1 U934 ( .A(n761), .B(n827), .C(n849), .Z(n749) );
  COND1XL U935 ( .A(n749), .B(n853), .C(n740), .Z(n467) );
  COND1XL U936 ( .A(n749), .B(n855), .C(n741), .Z(n466) );
  COND1XL U937 ( .A(n749), .B(n857), .C(n742), .Z(n465) );
  COND1XL U938 ( .A(n749), .B(n859), .C(n743), .Z(n464) );
  COND1XL U939 ( .A(n749), .B(n861), .C(n744), .Z(n463) );
  COND1XL U940 ( .A(n749), .B(n863), .C(n745), .Z(n462) );
  COND1XL U941 ( .A(n749), .B(n865), .C(n746), .Z(n461) );
  COND1XL U942 ( .A(n749), .B(n867), .C(n747), .Z(n460) );
  COND1XL U943 ( .A(n749), .B(n869), .C(n748), .Z(n459) );
  COND1XL U944 ( .A(n760), .B(n853), .C(n751), .Z(n458) );
  COND1XL U945 ( .A(n760), .B(n855), .C(n752), .Z(n457) );
  COND1XL U946 ( .A(n760), .B(n857), .C(n753), .Z(n456) );
  COND1XL U947 ( .A(n760), .B(n859), .C(n754), .Z(n455) );
  COND1XL U948 ( .A(n760), .B(n861), .C(n755), .Z(n454) );
  COND1XL U949 ( .A(n760), .B(n863), .C(n756), .Z(n453) );
  COND1XL U950 ( .A(n760), .B(n865), .C(n757), .Z(n452) );
  COND1XL U951 ( .A(n760), .B(n867), .C(n758), .Z(n451) );
  COND1XL U952 ( .A(n760), .B(n869), .C(n759), .Z(n450) );
  COND1XL U953 ( .A(n771), .B(n853), .C(n762), .Z(n449) );
  COND1XL U954 ( .A(n771), .B(n855), .C(n763), .Z(n448) );
  COND1XL U955 ( .A(n771), .B(n857), .C(n764), .Z(n447) );
  COND1XL U956 ( .A(n771), .B(n859), .C(n765), .Z(n446) );
  COND1XL U957 ( .A(n771), .B(n861), .C(n766), .Z(n445) );
  COND1XL U958 ( .A(n771), .B(n863), .C(n767), .Z(n444) );
  COND1XL U959 ( .A(n771), .B(n865), .C(n768), .Z(n443) );
  COND1XL U960 ( .A(n771), .B(n867), .C(n769), .Z(n442) );
  COND1XL U961 ( .A(n771), .B(n869), .C(n770), .Z(n441) );
  CND2XL U962 ( .A(write_ptr[3]), .B(n772), .Z(n783) );
  CANR1X1 U963 ( .A(n785), .B(n838), .C(n849), .Z(n782) );
  COND1XL U964 ( .A(n782), .B(n853), .C(n773), .Z(n440) );
  COND1XL U965 ( .A(n782), .B(n855), .C(n774), .Z(n439) );
  COND1XL U966 ( .A(n782), .B(n857), .C(n775), .Z(n438) );
  COND1XL U967 ( .A(n782), .B(n859), .C(n776), .Z(n437) );
  COND1XL U968 ( .A(n782), .B(n861), .C(n777), .Z(n436) );
  COND1XL U969 ( .A(n782), .B(n863), .C(n778), .Z(n435) );
  COND1XL U970 ( .A(n782), .B(n865), .C(n779), .Z(n434) );
  COND1XL U971 ( .A(n782), .B(n867), .C(n780), .Z(n433) );
  COND1XL U972 ( .A(n782), .B(n869), .C(n781), .Z(n432) );
  CNR2X1 U973 ( .A(n784), .B(n783), .Z(n850) );
  CANR1X1 U974 ( .A(n785), .B(n850), .C(n849), .Z(n795) );
  COND1XL U975 ( .A(n795), .B(n853), .C(n786), .Z(n431) );
  COND1XL U976 ( .A(n795), .B(n855), .C(n787), .Z(n430) );
  COND1XL U977 ( .A(n795), .B(n857), .C(n788), .Z(n429) );
  COND1XL U978 ( .A(n795), .B(n859), .C(n789), .Z(n428) );
  COND1XL U979 ( .A(n795), .B(n861), .C(n790), .Z(n427) );
  COND1XL U980 ( .A(n795), .B(n863), .C(n791), .Z(n426) );
  COND1XL U981 ( .A(n795), .B(n865), .C(n792), .Z(n425) );
  COND1XL U982 ( .A(n795), .B(n867), .C(n793), .Z(n424) );
  COND1XL U983 ( .A(n795), .B(n869), .C(n794), .Z(n423) );
  CANR1X1 U984 ( .A(n806), .B(n838), .C(n849), .Z(n805) );
  COND1XL U985 ( .A(n805), .B(n853), .C(n796), .Z(n422) );
  COND1XL U986 ( .A(n805), .B(n855), .C(n797), .Z(n421) );
  COND1XL U987 ( .A(n805), .B(n857), .C(n798), .Z(n420) );
  COND1XL U988 ( .A(n805), .B(n859), .C(n799), .Z(n419) );
  COND1XL U989 ( .A(n805), .B(n861), .C(n800), .Z(n418) );
  COND1XL U990 ( .A(n805), .B(n863), .C(n801), .Z(n417) );
  COND1XL U991 ( .A(n805), .B(n865), .C(n802), .Z(n416) );
  COND1XL U992 ( .A(n805), .B(n867), .C(n803), .Z(n415) );
  COND1XL U993 ( .A(n805), .B(n869), .C(n804), .Z(n414) );
  CANR1X1 U994 ( .A(n806), .B(n850), .C(n849), .Z(n816) );
  COND1XL U995 ( .A(n816), .B(n853), .C(n807), .Z(n413) );
  COND1XL U996 ( .A(n816), .B(n855), .C(n808), .Z(n412) );
  COND1XL U997 ( .A(n816), .B(n857), .C(n809), .Z(n411) );
  COND1XL U998 ( .A(n816), .B(n859), .C(n810), .Z(n410) );
  COND1XL U999 ( .A(n816), .B(n861), .C(n811), .Z(n409) );
  COND1XL U1000 ( .A(n816), .B(n863), .C(n812), .Z(n408) );
  COND1XL U1001 ( .A(n816), .B(n865), .C(n813), .Z(n407) );
  COND1XL U1002 ( .A(n816), .B(n867), .C(n814), .Z(n406) );
  COND1XL U1003 ( .A(n816), .B(n869), .C(n815), .Z(n405) );
  CANR1X1 U1004 ( .A(n827), .B(n838), .C(n849), .Z(n826) );
  COND1XL U1005 ( .A(n826), .B(n853), .C(n817), .Z(n404) );
  COND1XL U1006 ( .A(n826), .B(n855), .C(n818), .Z(n403) );
  COND1XL U1007 ( .A(n826), .B(n857), .C(n819), .Z(n402) );
  COND1XL U1008 ( .A(n826), .B(n859), .C(n820), .Z(n401) );
  COND1XL U1009 ( .A(n826), .B(n861), .C(n821), .Z(n400) );
  COND1XL U1010 ( .A(n826), .B(n863), .C(n822), .Z(n399) );
  COND1XL U1011 ( .A(n826), .B(n865), .C(n823), .Z(n398) );
  COND1XL U1012 ( .A(n826), .B(n867), .C(n824), .Z(n397) );
  COND1XL U1013 ( .A(n826), .B(n869), .C(n825), .Z(n396) );
  CANR1X1 U1014 ( .A(n827), .B(n850), .C(n849), .Z(n837) );
  COND1XL U1015 ( .A(n837), .B(n853), .C(n828), .Z(n395) );
  COND1XL U1016 ( .A(n837), .B(n855), .C(n829), .Z(n394) );
  COND1XL U1017 ( .A(n837), .B(n857), .C(n830), .Z(n393) );
  COND1XL U1018 ( .A(n837), .B(n859), .C(n831), .Z(n392) );
  COND1XL U1019 ( .A(n837), .B(n861), .C(n832), .Z(n391) );
  COND1XL U1020 ( .A(n837), .B(n863), .C(n833), .Z(n390) );
  COND1XL U1021 ( .A(n837), .B(n865), .C(n834), .Z(n389) );
  COND1XL U1022 ( .A(n837), .B(n867), .C(n835), .Z(n388) );
  COND1XL U1023 ( .A(n837), .B(n869), .C(n836), .Z(n387) );
  COND1XL U1024 ( .A(n848), .B(n853), .C(n839), .Z(n386) );
  COND1XL U1025 ( .A(n848), .B(n855), .C(n840), .Z(n385) );
  COND1XL U1026 ( .A(n848), .B(n857), .C(n841), .Z(n384) );
  COND1XL U1027 ( .A(n848), .B(n859), .C(n842), .Z(n383) );
  COND1XL U1028 ( .A(n848), .B(n861), .C(n843), .Z(n382) );
  COND1XL U1029 ( .A(n848), .B(n863), .C(n844), .Z(n381) );
  COND1XL U1030 ( .A(n848), .B(n865), .C(n845), .Z(n380) );
  COND1XL U1031 ( .A(n848), .B(n867), .C(n846), .Z(n379) );
  COND1XL U1032 ( .A(n848), .B(n869), .C(n847), .Z(n378) );
  COND1XL U1033 ( .A(n870), .B(n853), .C(n852), .Z(n377) );
  COND1XL U1034 ( .A(n870), .B(n855), .C(n854), .Z(n376) );
  COND1XL U1035 ( .A(n870), .B(n857), .C(n856), .Z(n375) );
  COND1XL U1036 ( .A(n870), .B(n859), .C(n858), .Z(n374) );
  COND1XL U1037 ( .A(n870), .B(n861), .C(n860), .Z(n373) );
  COND1XL U1038 ( .A(n870), .B(n863), .C(n862), .Z(n372) );
  COND1XL U1039 ( .A(n870), .B(n865), .C(n864), .Z(n371) );
  COND1XL U1040 ( .A(n870), .B(n867), .C(n866), .Z(n370) );
  COND1XL U1041 ( .A(n870), .B(n869), .C(n868), .Z(n369) );
  COND1XL U1042 ( .A(packet_len_count[3]), .B(n874), .C(n873), .Z(n365) );
  CANR1XL U1043 ( .A(n877), .B(n876), .C(n875), .Z(n882) );
  CIVXL U1044 ( .A(packet_len_count[5]), .Z(n881) );
  COND1XL U1045 ( .A(n882), .B(n881), .C(n880), .Z(n363) );
endmodule

