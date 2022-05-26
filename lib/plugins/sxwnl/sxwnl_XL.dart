import 'sxwnl_LunarHelper.dart';
import 'sxwnl_LunarInfoListT.dart';
import 'sxwnl_ZB.dart';
import 'sxwnl_tool.dart';

/// 星历类
class XL {
//  #region 私有数组成员定义(注: 初始转换时为公共字段, 已改写)

  /// 地球黄经数据,最大误差0.25"
  static List<List<double>> EL = [
    //以下是地球黄经数据,最大误差0.25"
    [
      //EL0
      33416565, 4.6692568, 6283.07584999,
      348943, 4.626102, 12566.1517, 34971, 2.74412, 5753.38488, 34176, 2.82887,
      3.52312, 31359, 3.62767, 77713.77147,
      26762, 4.41808, 7860.41939, 23427, 6.13516, 3930.2097, 13243, 0.74246,
      11506.76977, 12732, 2.0371, 529.69097,
      11992, 1.10963, 1577.34354, 9903, 5.2327, 5884.9268, 9019, 2.0451,
      26.2983, 8572, 3.5085, 398.149,
      7798, 1.1788, 5223.6939, 7531, 2.5334, 5507.5532, 5053, 4.5829,
      18849.2275, 4924, 4.2051, 775.5226,
      3567, 2.9195, 0.0673, 3171, 5.849, 11790.6291, 2841, 1.8987, 796.298,
      2710, 0.3149, 10977.0788,
      2428, 0.3448, 5486.7778, 2062, 4.8065, 2544.3144, 2054, 1.8695, 5573.1428,
      2023, 2.4577, 6069.7768,
      1555, 0.8331, 213.2991, 1322, 3.4112, 2942.4634, 1262, 1.083, 20.7754,
      1151, 0.6454, 0.9803,
      1029, 0.636, 4694.003, 1019, 0.9757, 15720.8388, 1017, 4.2668, 7.1135,
      992, 6.21, 2146.165,
      976, 0.681, 155.42, 858, 5.983, 161000.686, 851, 1.299, 6275.962, 847,
      3.671, 71430.696,
      796, 1.808, 17260.155, 788, 3.037, 12036.461, 747, 1.755, 5088.629, 739,
      3.503, 3154.687,
      735, 4.679, 801.821, 696, 0.833, 9437.763, 624, 3.978, 8827.39, 611,
      1.818, 7084.897,
      570, 2.784, 6286.599, 561, 4.387, 14143.495, 556, 3.47, 6279.553, 520,
      0.189, 12139.554,
      516, 1.333, 1748.016, 511, 0.283, 5856.478, 490, 0.487, 1194.447, 410,
      5.368, 8429.241,
      409, 2.399, 19651.048, 392, 6.168, 10447.388, 368, 6.041, 10213.286, 366,
      2.57, 1059.382,
      360, 1.709, 2352.866, 356, 1.776, 6812.767, 333, 0.593, 17789.846, 304,
      0.443, 83996.847,
      300, 2.74, 1349.867, 254, 3.165, 4690.48, 247, 0.215, 3.59, 237, 0.485,
      8031.092,
      236, 2.065, 3340.612, 228, 5.222, 4705.732, 219, 5.556, 553.569, 214,
      1.426, 16730.464,
      211, 4.148, 951.718, 203, 0.371, 283.859, 199, 5.222, 12168.003, 199,
      5.775, 6309.374,
      191, 3.822, 23581.258, 189, 5.386, 149854.4, 179, 2.215, 13367.973, 175,
      4.561, 135.065,
      162, 5.988, 11769.854, 151, 4.196, 6256.778, 144, 4.193, 242.729, 143,
      3.724, 38.028,
      140, 4.401, 6681.225, 136, 1.889, 7632.943, 125, 1.131, 5.523, 121, 2.622,
      955.6,
      120, 1.004, 632.784, 113, 0.177, 4164.312, 108, 0.327, 103.093, 105,
      0.939, 11926.254,
      105, 5.359, 1592.596, 103, 6.2, 6438.496, 100, 6.029, 5746.271, 98, 1,
      11371.7,
      98, 5.24, 27511.47, 94, 2.62, 5760.5, 92, 0.48, 522.58, 92, 4.57, 4292.33,
      90, 5.34, 6386.17, 86, 4.17, 7058.6, 84, 3.3, 7234.79, 84, 4.54, 25132.3,
      81, 6.11, 4732.03, 81, 6.27, 426.6, 80, 5.82, 28.45, 79, 1, 5643.18,
      78, 2.96, 23013.54, 77, 3.12, 7238.68, 76, 3.97, 11499.66, 73, 4.39,
      316.39,
      73, 0.61, 11513.88, 72, 4, 74.78, 71, 0.32, 263.08, 68, 5.91, 90955.55,
      66, 3.66, 17298.18, 65, 5.79, 18073.7, 63, 4.72, 6836.65, 62, 1.46,
      233141.31,
      61, 1.07, 19804.83, 60, 3.32, 6283.01, 60, 2.88, 6283.14, 55, 2.45,
      12352.85
    ],
    [
      //EL1
      2060589, 2.6782346, 6283.07585, 43034, 2.63513, 12566.1517, 4253, 1.5905,
      3.5231, 1193, 5.7956, 26.2983,
      1090, 2.9662, 1577.3435, 935, 2.592, 18849.228, 721, 1.138, 529.691, 678,
      1.875, 398.149,
      673, 4.409, 5507.553, 590, 2.888, 5223.694, 560, 2.175, 155.42, 454,
      0.398, 796.298,
      364, 0.466, 775.523, 290, 2.647, 7.114, 208, 5.341, 0.98, 191, 1.846,
      5486.778,
      185, 4.969, 213.299, 173, 2.991, 6275.962, 162, 0.032, 2544.314, 158,
      1.43, 2146.165,
      146, 1.205, 10977.079, 125, 2.834, 1748.016, 119, 3.258, 5088.629, 118,
      5.274, 1194.447,
      115, 2.075, 4694.003, 106, 0.766, 553.569, 100, 1.303, 6286.599, 97, 4.24,
      1349.87,
      95, 2.7, 242.73, 86, 5.64, 951.72, 76, 5.3, 2352.87, 64, 2.65, 9437.76,
      61, 4.67, 4690.48, 58, 1.77, 1059.38, 53, 0.91, 3154.69, 52, 5.66,
      71430.7,
      52, 1.85, 801.82, 50, 1.42, 6438.5, 43, 0.24, 6812.77, 43, 0.77, 10447.39,
      41, 5.24, 7084.9, 37, 2, 8031.09, 36, 2.43, 14143.5, 35, 4.8, 6279.55,
      34, 0.89, 12036.46, 34, 3.86, 1592.6, 33, 3.4, 7632.94, 32, 0.62, 8429.24,
      32, 3.19, 4705.73, 30, 6.07, 4292.33, 30, 1.43, 5746.27, 29, 2.32, 20.36,
      27, 0.93, 5760.5, 27, 4.8, 7234.79, 25, 6.22, 6836.65, 23, 5, 17789.85,
      23, 5.67, 11499.66, 21, 5.2, 11513.88, 21, 3.96, 10213.29, 21, 2.27,
      522.58,
      21, 2.22, 5856.48, 21, 2.55, 25132.3, 20, 0.91, 6256.78, 19, 0.53,
      3340.61,
      19, 4.74, 83996.85, 18, 1.47, 4164.31, 18, 3.02, 5.52, 18, 3.03, 5753.38,
      16, 4.64, 3.29, 16, 6.12, 5216.58, 16, 3.08, 6681.22, 15, 4.2, 13367.97,
      14, 1.19, 3894.18, 14, 3.09, 135.07, 14, 4.25, 426.6, 13, 5.77, 6040.35,
      13, 3.09, 5643.18, 13, 2.09, 6290.19, 13, 3.08, 11926.25, 12, 3.45, 536.8
    ],
    [
      //EL2
      87198, 1.0721, 6283.07585, 3091, 0.8673, 12566.1517, 273, 0.053, 3.523,
      163, 5.188, 26.298,
      158, 3.685, 155.42, 95, 0.76, 18849.23, 89, 2.06, 77713.77, 70, 0.83,
      775.52,
      51, 4.66, 1577.34, 41, 1.03, 7.11, 38, 3.44, 5573.14, 35, 5.14, 796.3,
      32, 6.05, 5507.55, 30, 1.19, 242.73, 29, 6.12, 529.69, 27, 0.31, 398.15,
      25, 2.28, 553.57, 24, 4.38, 5223.69, 21, 3.75, 0.98, 17, 0.9, 951.72,
      15, 5.76, 1349.87, 14, 4.36, 1748.02, 13, 3.72, 1194.45, 13, 2.95, 6438.5,
      12, 2.97, 2146.17, 11, 1.27, 161000.69, 10, 0.6, 3154.69, 10, 5.99,
      6286.6,
      9, 4.8, 5088.63, 9, 5.23, 7084.9, 8, 3.31, 213.3, 8, 3.42, 5486.78,
      7, 6.19, 4690.48, 7, 3.43, 4694, 6, 1.6, 2544.31, 6, 1.98, 801.82,
      6, 2.48, 10977.08, 5, 1.44, 6836.65, 5, 2.34, 1592.6, 5, 1.31, 4292.33,
      5, 3.81, 149854.4, 4, 0.04, 7234.79, 4, 4.94, 7632.94, 4, 1.57, 71430.7,
      4, 3.17, 6309.37, 3, 0.99, 6040.35, 3, 0.67, 1059.38, 3, 3.18, 2352.87,
      3, 3.55, 8031.09, 3, 1.92, 10447.39, 3, 2.52, 6127.66, 3, 4.42, 9437.76,
      3, 2.71, 3894.18, 3, 0.67, 25132.3, 3, 5.27, 6812.77, 3, 0.55, 6279.55
    ],
    [
      2892,
      5.8438,
      6283.0758,
      168,
      5.488,
      12566.152,
      30,
      5.2,
      155.42,
      13,
      4.72,
      3.52,
      7,
      5.3,
      18849.23,
      6,
      5.97,
      242.73,
      4,
      3.79,
      553.57,
      1,
      4.3,
      6286.6,
      1,
      0.91,
      6127.66
    ], //EL3
    [77, 4.13, 6283.08, 8, 3.84, 12566.15, 4, 0.42, 155.42], //EL4
    [2, 2.77, 6283.08, 1, 2.01, 155.42] //EL5
  ];

  /// <summary>
  /// 地球黄纬数据,误差0.2"
  /// </summary>
  static List<List<double>> EB = [
    //地球黄纬数据,误差0.2"
    [
      2796,
      3.1987,
      84334.6616,
      1016,
      5.4225,
      5507.5532,
      804,
      3.88,
      5223.694,
      438,
      3.704,
      2352.866,
      319,
      4,
      1577.344,
      227,
      3.985,
      1047.747
    ], //EB0
    [90, 3.9, 5507.55, 62, 1.73, 5223.69], //EB1
    [17, 1.63, 84334.66] //EB2
  ];

  /// <summary>
  /// 地球向径数据,误差0.00001AU
  /// </summary>
  static List<List<double>> ER = [
    //地球向径数据,误差0.00001AU
    [
      //ER0
      1000139888, 0, 0, 16706996, 3.09846351, 6283.07584999,
      139560, 3.055246, 12566.1517, 30837, 5.19847, 77713.77147,
      16285, 1.17388, 5753.38488, 15756, 2.84685, 7860.41939,
      9248, 5.4529, 11506.7698, 5424, 4.5641, 3930.2097,
      4721, 3.661, 5884.9268, 3460, 0.9637, 5507.5532,
      3288, 5.8998, 5223.6939, 3068, 0.2987, 5573.1428,
      2432, 4.2735, 11790.6291, 2118, 5.8471, 1577.3435,
      1858, 5.0219, 10977.0788, 1748, 3.0119, 18849.2275
    ],
    [
      1030186,
      1.1074897,
      6283.07585,
      17212,
      1.06442,
      12566.1517,
      7022,
      3.1416,
      0
    ], //ER1
    [
      43594,
      5.78455,
      6283.07585,
      1236,
      5.5793,
      12566.1517,
      123,
      3.142,
      0,
      88,
      3.63,
      77713.77
    ], //ER2
    [1446, 4.2732, 6283.0758, 67, 3.92, 12566.15], //ER3
    [39, 2.56, 6283.08, 3, 2.27, 12566.15], //ER4
    [1, 1.22, 6283.08] //ER5
  ];

  /// <summary>
  /// 以下是月球黄经周期项及泊松项,精度3角秒,平均误差0.5角秒
  /// 各坐标均是余弦项,各列单位:角秒,1,1,1e-4,1e-8,1e-8
  /// </summary>
  static List<List<double>> ML = [
    [
      //ML0
      22639.59, 0.784758, 8328.6914246, 1.52292, 25.07, -0.1236, 4586.44,
      0.18740, 7214.0628654, -2.1848, -18.86, 0.083,
      2369.91, 2.54295, 15542.754290, -0.6618, 6.2, -0.041, 769.03, 3.1403,
      16657.382849, 3.046, 50.1, -0.25,
      666.42, 1.5277, 628.301955, -0.027, 0.1, -0.01, 411.60, 4.8266,
      16866.932315, -1.280, -1.1, -0.01,
      211.66, 4.1150, -1114.62856, -3.708, -44, 0.21, 205.44, 0.2305,
      6585.76091, -2.158, -19, 0.09,
      191.96, 4.8985, 23871.44571, 0.861, 31, -0.16, 164.73, 2.5861,
      14914.45233, -0.635, 6, -0.04,
      147.32, 5.4553, -7700.38947, -1.550, -25, 0.12, 124.99, 0.4861,
      7771.37714, -0.331, 3, -0.02,
      109.38, 3.8832, 8956.99338, 1.496, 25, -0.1, 55.18, 5.570, -1324.17803,
      0.62, 7, 0,
      45.10, 0.899, 25195.62374, 0.24, 24, -0.1, 39.53, 3.812, -8538.24089,
      2.80, 26, -0.1,
      38.43, 4.301, 22756.81716, -2.85, -13, 0, 36.12, 5.496, 24986.07427, 4.57,
      75, -0.4,
      30.77, 1.946, 14428.1257, -4.37, -38, 0.2, 28.40, 3.286, 7842.3648, -2.21,
      -19, 0.1,
      24.36, 5.641, 16171.0562, -0.69, 6, 0, 18.58, 4.414, -557.3143, -1.85,
      -22, 0.1,
      17.95, 3.585, 8399.6791, -0.36, 3, 0, 14.53, 4.942, 23243.1438, 0.89, 31,
      -0.2,
      14.38, 0.971, 32200.1371, 2.38, 56, -0.3, 14.25, 5.764, -2.3012, 1.52, 25,
      -0.1,
      13.90, 0.374, 31085.5086, -1.32, 12, -0.1, 13.19, 1.759, -9443.3200,
      -5.23, -69, 0.3,
      9.68, 3.100, -16029.0809, -3.1, -50, 0, 9.37, 0.30, 24080.9952, -3.5, -20,
      0,
      8.61, 4.16, -1742.9305, -3.7, -44, 0, 8.45, 2.84, 16100.0686, 1.2, 28, 0,
      8.05, 2.63, 14286.1504, -0.6, 6, 0, 7.63, 6.24, 17285.6848, 3.0, 50, 0,
      7.45, 1.48, 1256.6039, -0.1, 0, 0, 7.37, 0.27, 5957.4590, -2.1, -19, 0,
      7.06, 5.67, 33.7570, -0.3, -4, 0, 6.38, 4.78, 7004.5134, 2.1, 32, 0,
      5.74, 2.66, 32409.6866, -1.9, 5, 0, 4.37, 4.34, 22128.5152, -2.8, -13, 0,
      4.00, 3.25, 33524.3152, 1.8, 49, 0, 3.21, 2.24, 14985.4400, -2.5, -16, 0,
      2.91, 1.71, 24499.748, 0.8, 31, 0, 2.73, 1.99, 13799.824, -4.3, -38, 0,
      2.57, 5.41, -7072.088, -1.6, -25, 0, 2.52, 3.24, 8470.667, -2.2, -19, 0,
      2.49, 4.07, -486.327, -3.7, -44, 0, 2.15, 5.61, -1952.480, 0.6, 7, 0,
      1.98, 2.73, 39414.200, 0.2, 37, 0, 1.93, 1.57, 33314.766, 6.1, 100, 0,
      1.87, 0.42, 30457.207, -1.3, 12, 0, 1.75, 2.06, -8886.006, -3.4, -47, 0,
      1.44, 2.39, -695.876, 0.6, 7, 0, 1.37, 3.03, -209.549, 4.3, 51, 0,
      1.26, 5.94, 16728.371, 1.2, 28, 0, 1.22, 6.17, 6656.749, -4.0, -41, 0,
      1.19, 5.87, 6099.434, -5.9, -63, 0, 1.18, 1.01, 31571.835, 2.4, 56, 0,
      1.16, 3.84, 9585.295, 1.5, 25, 0, 1.14, 5.64, 8364.740, -2.2, -19, 0,
      1.08, 1.23, 70.988, -1.9, -22, 0, 1.06, 3.33, 40528.829, 3.9, 81, 0,
      0.99, 5.01, 40738.378, 0, 30, 0, 0.95, 5.7, -17772.011, -7, -94, 0,
      0.88, 0.3, -0.352, 0, 0, 0, 0.82, 3.0, 393.021, 0, 0, 0,
      0.79, 1.8, 8326.390, 3, 50, 0, 0.75, 5.0, 22614.842, 1, 31, 0,
      0.74, 2.9, 8330.993, 0, 0, 0, 0.67, 0.7, -24357.772, -5, -75, 0,
      0.64, 1.3, 8393.126, -2, -19, 0, 0.64, 5.9, 575.338, 0, 0, 0,
      0.64, 1.1, 23385.119, -3, -13, 0, 0.58, 5.2, 24428.760, 3, 53, 0,
      0.58, 3.5, -9095.555, 1, 0, 0, 0.57, 6.1, 29970.880, -5, -32, 0,
      0.56, 3.0, 0.329, 2, 25, 0, 0.56, 4.0, -17981.561, -2, -43, 0,
      0.56, 0.5, 7143.075, 0, 0, 0, 0.55, 2.3, 25614.376, 5, 75, 0,
      0.54, 4.2, 15752.304, -5, -45, 0, 0.49, 3.3, -8294.934, -2, -29, 0,
      0.49, 1.7, 8362.448, 1, 21, 0, 0.48, 1.8, -10071.622, -5, -69, 0,
      0.45, 0.9, 15333.205, 4, 57, 0, 0.45, 2.1, 8311.771, -2, -19, 0,
      0.43, 0.3, 23452.693, -3, -20, 0, 0.42, 4.9, 33733.865, -3, 0, 0,
      0.41, 1.6, 17495.234, -1, 0, 0, 0.40, 1.5, 23314.131, -1, 9, 0,
      0.39, 2.1, 38299.571, -4, -6, 0, 0.38, 2.7, 31781.385, -2, 5, 0,
      0.37, 4.8, 6376.211, 2, 32, 0, 0.36, 3.9, 16833.175, -1, 0, 0,
      0.36, 5.0, 15056.428, -4, -38, 0, 0.35, 5.2, -8257.704, -3, 0, 0,
      0.34, 4.2, 157.734, 0, 0, 0, 0.34, 2.7, 13657.848, -1, 0, 0,
      0.33, 5.6, 41853.007, 3, 74, 0, 0.32, 5.9, -39.815, 0, 0, 0,
      0.31, 4.4, 21500.21, -3, 0, 0, 0.30, 1.3, 786.04, 0, 0, 0,
      0.30, 5.3, -24567.32, 0, 0, 0, 0.30, 1.0, 5889.88, -2, 0, 0,
      0.29, 4.2, -2371.23, -4, 0, 0, 0.29, 3.7, 21642.19, -7, -57, 0,
      0.29, 4.1, 32828.44, 2, 56, 0, 0.29, 3.5, 31713.81, -1, 0, 0,
      0.29, 5.4, -33.78, 0, 0, 0, 0.28, 6.0, -16.92, -4, 0, 0,
      0.28, 2.8, 38785.90, 0, 0, 0, 0.27, 5.3, 15613.74, -3, 0, 0,
      0.26, 4.0, 25823.93, 0, 0, 0, 0.25, 0.6, 24638.31, -2, 0, 0,
      0.25, 1.3, 6447.20, 0, 0, 0, 0.25, 0.9, 141.98, -4, 0, 0,
      0.25, 0.3, 5329.16, -2, 0, 0, 0.25, 0.1, 36.05, -4, 0, 0,
      0.23, 2.3, 14357.14, -2, 0, 0, 0.23, 5.2, 2.63, 0, 0, 0,
      0.22, 5.1, 47742.89, 2, 63, 0, 0.21, 2.1, 6638.72, -2, 0, 0,
      0.20, 4.4, 39623.75, -4, 0, 0, 0.19, 2.1, 588.49, 0, 0, 0,
      0.19, 3.1, -15400.78, -3, -50, 0, 0.19, 5.6, 16799.36, -1, 0, 0,
      0.18, 3.9, 1150.68, 0, 0, 0, 0.18, 1.6, 7178.01, 2, 0, 0,
      0.18, 2.6, 8328.34, 2, 0, 0, 0.18, 2.1, 8329.04, 2, 0, 0,
      0.18, 3.2, -9652.87, -1, 0, 0, 0.18, 1.7, -8815.02, -5, -69, 0,
      0.18, 5.7, 550.76, 0, 0, 0, 0.17, 2.1, 31295.06, -6, 0, 0,
      0.17, 1.2, 7211.76, -1, 0, 0, 0.16, 4.5, 14967.42, -1, 0, 0,
      0.16, 3.6, 15540.45, 1, 0, 0, 0.16, 4.2, 522.37, 0, 0, 0,
      0.16, 4.6, 15545.06, -2, 0, 0, 0.16, 0.5, 6428.02, -2, 0, 0,
      0.16, 2.0, 13171.52, -4, 0, 0, 0.16, 2.3, 7216.36, -4, 0, 0,
      0.15, 5.6, 7935.67, 2, 0, 0, 0.15, 0.5, 29828.90, -1, 0, 0,
      0.15, 1.2, -0.71, 0, 0, 0, 0.15, 1.4, 23942.43, -1, 0, 0,
      0.14, 2.8, 7753.35, 2, 0, 0, 0.14, 2.1, 7213.71, -2, 0, 0,
      0.14, 1.4, 7214.42, -2, 0, 0, 0.14, 4.5, -1185.62, -2, 0, 0,
      0.14, 3.0, 8000.10, -2, 0, 0, 0.13, 2.8, 14756.71, -1, 0, 0,
      0.13, 5.0, 6821.04, -2, 0, 0, 0.13, 6.0, -17214.70, -5, -72, 0,
      0.13, 5.3, 8721.71, 2, 0, 0, 0.13, 4.5, 46628.26, -2, 0, 0,
      0.13, 5.9, 7149.63, 2, 0, 0, 0.12, 1.1, 49067.07, 1, 55, 0,
      0.12, 2.9, 15471.77, 1, 0, 0
    ],
    [
      //ML1
      1.677, 4.669, 628.30196, -0.03, 0, 0, 0.516, 3.372, 6585.7609, -2.16, -19,
      0.1,
      0.414, 5.728, 14914.4523, -0.64, 6, 0, 0.371, 3.969, 7700.3895, 1.55, 25,
      0,
      0.276, 0.74, 8956.9934, 1.5, 25, 0, 0.246, 4.23, -2.3012, 1.5, 25, 0,
      0.071, 0.14, 7842.365, -2.2, -19, 0, 0.061, 2.50, 16171.056, -0.7, 6, 0,
      0.045, 0.44, 8399.679, -0.4, 0, 0, 0.040, 5.77, 14286.150, -0.6, 6, 0,
      0.037, 4.63, 1256.604, -0.1, 0, 0, 0.037, 3.42, 5957.459, -2.1, -19, 0,
      0.036, 1.80, 23243.144, 0.9, 31, 0, 0.024, 0, 16029.081, 3, 50, 0,
      0.022, 1.0, -1742.931, -4, -44, 0, 0.019, 3.1, 17285.685, 3, 50, 0,
      0.017, 1.3, 0.329, 2, 25, 0, 0.014, 0.3, 8326.390, 3, 50, 0,
      0.013, 4.0, 7072.088, 2, 25, 0, 0.013, 4.4, 8330.993, 0, 0, 0,
      0.013, 0.1, 8470.667, -2, -19, 0, 0.011, 1.2, 22128.515, -3, 0, 0,
      0.011, 2.5, 15542.754, -1, 0, 0, 0.008, 0.2, 7214.06, -2, 0, 0,
      0.007, 4.9, 24499.75, 1, 0, 0, 0.007, 5.1, 13799.82, -4, 0, 0,
      0.006, 0.9, -486.33, -4, 0, 0, 0.006, 0.7, 9585.30, 1, 0, 0,
      0.006, 4.1, 8328.34, 2, 0, 0, 0.006, 0.6, 8329.04, 2, 0, 0,
      0.005, 2.5, -1952.48, 1, 0, 0, 0.005, 2.9, -0.71, 0, 0, 0,
      0.005, 3.6, 30457.21, -1, 0, 0
    ],
    [
      //ML2
      0.0049, 4.67, 628.3020, 0, 0, 0, 0.0023, 2.67, -2.301, 1.5, 25, 0,
      0.0015, 3.37, 6585.761, -2.2, -19, 0, 0.0012, 5.73, 14914.452, -0.6, 6, 0,
      0.0011, 3.97, 7700.389, 2, 25, 0, 0.0008, 0.7, 8956.993, 1, 25, 0
    ]
  ];

  /// <summary>
  /// 月球黄纬数据(?)
  /// </summary>
  static List<List<double>> MB = [
    //精度3角秒
    [
      //MB0
      18461.24, 0.057109, 8433.4661575, -0.64006, -0.53, -0.0029, 1010.17,
      2.41266, 16762.157582, 0.883, 24.5, -0.13,
      999.69, 5.44004, -104.774733, 2.163, 25.6, -0.12, 623.65, 0.9150,
      7109.288132, -0.022, 6.7, -0.04,
      199.48, 1.8153, 15647.52902, -2.825, -19, 0.08, 166.57, 4.8427,
      -1219.40329, -1.545, -18, 0.09,
      117.26, 4.1709, 23976.22045, -1.302, 6, -0.04, 61.91, 4.768, 25090.84901,
      2.41, 50, -0.3,
      33.36, 3.271, 15437.97956, 1.50, 32, -0.2, 31.76, 1.512, 8223.91669, 3.69,
      51, -0.2,
      29.58, 0.958, 6480.9862, 0, 7, 0, 15.57, 2.487, -9548.0947, -3.07, -43,
      0.2,
      15.12, 0.243, 32304.9119, 0.22, 31, -0.2, 12.09, 4.014, 7737.5901, -0.05,
      7, 0,
      8.87, 1.86, 15019.2271, -2.8, -19, 0, 8.05, 5.38, 8399.7091, -0.3, 3, 0,
      7.96, 4.21, 23347.9185, -1.3, 6, 0, 7.43, 4.89, -1847.7052, -1.5, -18, 0,
      6.73, 3.83, -16133.8556, -0.9, -24, 0, 6.58, 2.67, 14323.3510, -2.2, -12,
      0,
      6.46, 3.16, 9061.7681, -0.7, 0, 0, 6.30, 0.17, 25300.3985, -1.9, -2, 0,
      5.63, 0.80, 733.0767, -2.2, -26, 0, 5.37, 2.11, 16204.8433, -1.0, 3, 0,
      5.31, 5.51, 17390.4595, 0.9, 25, 0, 5.08, 2.26, 523.5272, 2.1, 26, 0,
      4.84, 6.18, -7805.1642, 0.6, 1, 0, 4.81, 5.14, -662.0890, 0.3, 4, 0,
      3.98, 0.84, 33419.5404, 3.9, 75, 0, 3.67, 5.03, 22652.0424, -0.7, 13, 0,
      3.00, 5.93, 31190.283, -3.5, -13, 0, 2.80, 2.18, -16971.707, 3.4, 27, 0,
      2.41, 3.57, 22861.592, -5.0, -38, 0, 2.19, 3.94, -9757.644, 1.3, 8, 0,
      2.15, 5.63, 23766.671, 3.0, 57, 0, 1.77, 3.31, 14809.678, 1.5, 32, 0,
      1.62, 2.60, 7318.838, -4.3, -44, 0, 1.58, 3.87, 16552.608, 5.2, 76, 0,
      1.52, 2.60, 40633.603, 1.7, 56, 0, 1.52, 0.13, -17876.786, -4.6, -68, 0,
      1.51, 3.93, 8399.685, -0.3, 0, 0, 1.32, 4.91, 16275.831, -2.9, -19, 0,
      1.26, 0.99, 24604.522, -1.3, 6, 0, 1.19, 2.00, 39518.975, -2.0, 12, 0,
      1.13, 0.29, 31676.610, 0.2, 31, 0, 1.09, 1.00, 5852.684, 0, 7, 0,
      1.02, 2.53, 33629.090, 0, 23, 0, 0.82, 0.1, 16066.282, 1, 32, 0,
      0.80, 2.0, -33.787, 0, 0, 0, 0.80, 5.2, 16833.145, -1, 0, 0,
      0.79, 1.5, -24462.547, -2, -50, 0, 0.79, 1.7, -591.101, -2, -18, 0,
      0.67, 4.5, 24533.535, 1, 28, 0, 0.65, 2.5, -10176.397, -3, -43, 0,
      0.64, 1.6, 25719.151, 2, 50, 0, 0.63, 0.3, 5994.660, -4, -37, 0,
      0.63, 2.1, 8435.767, -2, -26, 0, 0.63, 1.1, 8431.165, 1, 25, 0,
      0.60, 2.7, 13695.049, -2, -12, 0, 0.59, 1.2, 7666.602, 2, 29, 0,
      0.47, 1.1, 30980.734, 1, 38, 0, 0.46, 0.1, -71.018, 2, 22, 0,
      0.43, 2.8, -8990.780, -1, -21, 0, 0.42, 1.5, 16728.401, 1, 28, 0,
      0.41, 5.1, 22023.740, -1, 13, 0, 0.38, 4.3, 22719.617, -1, 6, 0,
      0.35, 3.0, 14880.665, 0, 10, 0, 0.34, 6.0, 30561.981, -3, 0, 0,
      0.33, 1.6, -18086.336, 0, 0, 0, 0.33, 1.0, 8467.223, -1, 0, 0,
      0.31, 1.9, 14390.93, -3, 0, 0, 0.31, 4.6, 8852.22, 4, 51, 0,
      0.31, 0.6, 6551.97, -2, 0, 0, 0.30, 4.7, -7595.61, -4, -51, 0,
      0.30, 1.9, 7143.05, 0, 0, 0, 0.29, 3.2, -1428.95, 3, 0, 0,
      0.27, 4.9, -2476.01, -1, 0, 0, 0.26, 3.2, 41748.23, 5, 100, 0,
      0.25, 3.4, -1009.85, -6, -70, 0, 0.24, 1.9, 32514.46, -4, 0, 0,
      0.24, 3.3, 32933.21, 0, 0, 0, 0.21, 3.6, 22233.29, -5, 0, 0,
      0.21, 4.4, 47847.67, 0, 0, 0, 0.21, 3.9, 23418.91, -3, 0, 0,
      0.17, 5.8, 14951.65, -2, 0, 0, 0.16, 2.0, 38890.67, -2, 0, 0
    ],
    [
      //MB1
      0.074, 4.10, 6480.986, 0, 7, 0, 0.030, 0.9, 7737.590, 0, 7, 0,
      0.022, 5.0, 15019.227, -3, -19, 0, 0.020, 1.1, 23347.918, -1, 6, 0,
      0.019, 1.7, -1847.705, -2, -18, 0, 0.017, 5.6, 16133.856, 1, 24, 0,
      0.016, 0, 9061.768, -1, 0, 0, 0.014, 3.9, 733.077, -2, -26, 0,
      0.013, 2.4, 17390.460, 1, 25, 0, 0.013, 5.6, 8399.685, 0, 0, 0,
      0.013, 0.9, -523.527, -2, -26, 0, 0.012, 3.2, 7805.164, -1, 0, 0,
      0.011, 3.7, 8435.767, -2, 0, 0, 0.011, 5.9, 8431.165, 1, 0, 0
    ]
  ];

  /// <summary>
  /// 月球向径数据(?)
  /// </summary>
  static List<List<double>> MR = [
    //精度3千米
    [
      //MR0
      385000.5, 0, 0, 0, 0, 0,
      20905.4, 5.497147, 8328.6914246, 1.52292, 25.07, -0.1236, 3699.1, 4.89979,
      7214.062865, -2.1848, -18.9, 0.083,
      2956.0, 0.97216, 15542.754290, -0.6618, 6.2, -0.041, 569.9, 1.5695,
      16657.382849, 3.046, 50, -0.25,
      246.2, 5.6858, -1114.62856, -3.708, -44, 0.21, 204.6, 1.0153, 14914.45233,
      -0.635, 6, -0.04,
      170.7, 3.3277, 23871.44571, 0.86, 31, -0.2, 152.1, 4.943, 6585.76091,
      -2.16, -19, 0.1,
      129.6, 0.743, -7700.38947, -1.55, -25, 0.1, 108.7, 5.198, 7771.37714,
      -0.33, 3, 0,
      104.8, 2.312, 8956.99338, 1.50, 25, -0.1, 79.7, 5.383, -8538.24089, 2.80,
      26, -0.1,
      48.9, 6.240, 628.3020, -0.03, 0, 0, 34.8, 2.730, 22756.8172, -2.85, -13,
      0,
      30.8, 4.071, 16171.0562, -0.69, 6, 0, 24.2, 1.715, 7842.3648, -2.21, -19,
      0.1,
      23.2, 3.925, 24986.0743, 4.57, 75, -0.4, 21.6, 0.375, 14428.1257, -4.37,
      -38, 0.2,
      16.7, 2.014, 8399.6791, -0.4, 3, 0, 14.4, 3.33, -9443.3200, -5.2, -69, 0,
      12.8, 3.37, 23243.1438, 0.9, 31, 0, 11.6, 5.09, 31085.5086, -1.3, 12, 0,
      10.4, 5.68, 32200.1371, 2.4, 56, 0, 10.3, 0.86, -1324.1780, 0.6, 7, 0,
      10.1, 5.73, -1742.9305, -3.7, -44, 0, 9.9, 1.06, 14286.1504, -0.6, 6, 0,
      8.8, 4.79, -9652.8694, -0.9, -18, 0, 8.4, 5.98, -557.3143, -1.9, -22, 0,
      7.0, 4.67, -16029.0809, -3.1, -50, 0, 6.3, 1.27, 16100.0686, 1.2, 28, 0,
      5.8, 4.67, 17285.6848, 3.0, 50, 0, 5.0, 4.99, 5957.459, -2.1, -19, 0,
      4.4, 4.60, -209.549, 4.3, 51, 0, 4.1, 3.21, 7004.513, 2.1, 32, 0,
      4.0, 2.77, 22128.515, -2.8, -13, 0, 3.3, 0.67, 14985.440, -2.5, -16, 0,
      3.1, 0.11, 16866.932, -1.3, 0, 0, 2.6, 0.14, 24499.748, 0.8, 31, 0,
      2.4, 1.67, 8470.667, -2.2, -19, 0, 2.1, 0.70, -7072.088, -1.6, -25, 0,
      1.9, 0.42, 13799.824, -4.3, -38, 0, 1.7, 3.63, -8886.006, -3, -47, 0,
      1.6, 5.1, 30457.207, -1, 12, 0, 1.4, 1.2, 39414.200, 0, 37, 0,
      1.4, 6.2, 23314.131, -1, 9, 0, 1.2, 2.3, 9585.295, 1, 25, 0,
      1.1, 6.3, 33314.766, 6, 100, 0, 1.1, 6.2, 1256.604, 0, 0, 0,
      1.1, 4.1, 8364.740, -2, -19, 0, 0.9, 4.4, 16728.371, 1, 28, 0,
      0.9, 4.6, 6656.749, -4, -41, 0, 0.9, 2.8, 70.988, -2, -22, 0,
      0.8, 5.7, 31571.835, 2, 56, 0, 0.8, 5.1, -9095.555, 1, 0, 0,
      0.8, 1.0, -17772.011, -7, -94, 0, 0.8, 2.7, 15752.304, -5, -45, 0,
      0.7, 0.3, 8326.390, 3, 50, 0, 0.7, 1.3, 8330.993, 0, 0, 0,
      0.7, 1.8, 40528.829, 4, 81, 0, 0.7, 3.4, 22614.842, 1, 31, 0,
      0.7, 0.9, -1952.480, 1, 7, 0, 0.6, 6.0, 8393.126, -2, -19, 0,
      0.6, 5.0, 24080.995, -3, -20, 0, 0.6, 5.8, 23385.119, -3, 0, 0,
      0.5, 4.3, 6099.43, -6, -63, 0, 0.5, 1.8, 14218.58, 0, 0, 0,
      0.5, 5.2, 7143.08, 0, 0, 0, 0.5, 3.4, -10071.62, -5, -69, 0,
      0.5, 2.4, -17981.56, -2, 0, 0, 0.5, 4.9, -8294.93, -2, 0, 0,
      0.5, 0.2, 8362.45, 1, 0, 0, 0.4, 4.5, 29970.88, -5, 0, 0,
      0.4, 2.3, -24357.77, -5, -75, 0, 0.4, 1.1, 13657.85, -1, 0, 0,
      0.4, 0.5, 8311.77, -2, 0, 0, 0.4, 3.6, 24428.76, 3, 53, 0,
      0.4, 0.7, 25614.38, 5, 75, 0, 0.3, 5.8, -2371.23, -4, 0, 0,
      0.3, 0.9, 9166.54, -3, 0, 0, 0.3, 0.4, -8257.70, -3, 0, 0,
      0.3, 4.8, -10281.17, -1, 0, 0, 0.3, 5.8, 5889.88, -2, 0, 0,
      0.3, 0.6, 38299.57, -4, 0, 0, 0.3, 5.6, 15333.20, 4, 57, 0,
      0.3, 2.8, 21500.21, -3, 0, 0, 0.3, 0.7, 14357.14, -2, 0, 0
    ],
    [
      //MR1
      0.514, 4.16, 14914.4523, -0.6, 6, 0, 0.382, 1.80, 6585.7609, -2.2, -19, 0,
      0.327, 2.40, 7700.3895, 1.5, 25, 0, 0.264, 5.45, 8956.9934, 1.5, 25, 0,
      0.123, 3.10, 628.302, 0, 0, 0, 0.078, 0.93, 16171.056, -0.7, 6, 0,
      0.061, 4.86, 7842.365, -2.2, -19, 0, 0.050, 4.2, 14286.150, -1, 6, 0,
      0.042, 5.2, 8399.679, 0, 0, 0, 0.032, 0.2, 23243.144, 1, 31, 0,
      0.025, 2.6, -1742.931, -4, -44, 0, 0.025, 1.8, 5957.459, -2, -19, 0,
      0.018, 4.8, 16029.081, 3, 50, 0, 0.014, 1.5, 17285.68, 3, 50, 0,
      0.014, 1.0, 15542.75, -1, 0, 0, 0.013, 5.0, 8326.39, 3, 50, 0,
      0.012, 4.8, 8470.67, -2, 0, 0, 0.012, 2.8, 8330.99, 0, 0, 0,
      0.011, 2.4, 7072.09, 2, 0, 0, 0.010, 5.9, 22128.52, -3, 0, 0
    ],
    [
      //MR2
      0.0015, 4.2, 14914.452, -1, 6, 0, 0.0011, 1.8, 6585.761, -2, -19, 0,
      0.0009, 2.4, 7700.389, 2, 25, 0, 0.0008, 5.5, 8956.993, 1, 25, 0
    ]
  ];

//  #endregion

//  #region 星历函数(日月球面坐标计算)

  /// <summary>
  /// 计算E_L0或E_L1或E_L2等
  /// </summary>
  /// <param name="ob"></param>
  /// <param name="t"></param>
  /// <param name="n"></param>
  /// <returns></returns>
  static double Enn(List<List<double>> ob, double t, double n) {
    int i, j;
    List<double> F;
    double N, v = 0, tn = 1, c;
    if (ob == XL.EL) {
      double t2 = t * t, t3 = t2 * t, t4 = t3 * t, t5 = t4 * t; //千年数的各次方
      v += 1753469512 +
          6283319653318 * t +
          529674 * t2 +
          432 * t3 -
          1124 * t4 -
          9 * t5 +
          630 * Math.Cos(6 + 3 * t); //地球平黄经(已拟合DE406)
    }
    n *= 3;
    if (n < 0) n = ob[0].length.toDouble();
    for (i = 0; i < ob.length; i++) // C#: 注释循环变量中步长计算的后半语句:   , tn *= t)
    {
      F = ob[i];
      N = Math.Floor2Double(n * F.length / ob[0].length + 0.5);
      if (i != 0) N += 3;
      if (N >= F.length) N = F.length.toDouble();
      j = 0;
      c = 0;
      for (; j < N; j += 3) c += F[j] * Math.Cos(F[j + 1] + t * F[j + 2]);
      // v += c * tn;     // C#: 注释此句并改写如下
      v += c * tn * Math.Pow(t, i.toDouble());
    }
    return v / 1000000000;
  }

  /// <summary>
  /// 返回地球坐标,t为世纪数
  /// </summary>
  /// <param name="t"></param>
  /// <param name="re"></param>
  /// <param name="n1"></param>
  /// <param name="n2"></param>
  /// <param name="n3"></param>
  static void E_coord(
      double t, List<double> re, double n1, double n2, double n3) {
    t /= 10;
    re[0] = XL.Enn(XL.EL, t, n1);
    re[1] = XL.Enn(XL.EB, t, n2);
    re[2] = XL.Enn(XL.ER, t, n3);
  }

  /// <summary>
  /// 地球经度计算,返回Date分点黄经,传入世纪数、取项数
  /// </summary>
  /// <param name="t"></param>
  /// <param name="n"></param>
  /// <returns></returns>
  static double E_Lon(double t, double n) {
    return XL.Enn(XL.EL, t / 10, n);
  }

  /// <summary>
  /// 计算ML0或ML1或ML2
  /// </summary>
  /// <param name="ob"></param>
  /// <param name="t"></param>
  /// <param name="n"></param>
  /// <returns></returns>
  static double Mnn(List<List<double>> ob, double t, double n) {
    int i, j;
    List<double> F;
    double N, v = 0, tn = 1, c;
    double t2 = t * t, t3 = t2 * t, t4 = t3 * t, t5 = t4 * t, tx = t - 10;
    if (ob == XL.ML) {
      v += (3.81034409 +
              8399.684730072 * t -
              3.319e-05 * t2 +
              3.11e-08 * t3 -
              2.033e-10 * t4) *
          LunarHelper.rad; //月球平黄经(弧度)
      v += 5028.792262 * t +
          1.1124406 * t2 +
          0.00007699 * t3 -
          0.000023479 * t4 -
          0.0000000178 * t5; //岁差(角秒)
      if (tx > 0)
        v += -0.866 +
            1.43 * tx +
            0.054 * tx * tx; // 对公元3000年至公元5000年的拟合,最大误差小于10角秒
    }
    //t2 /= 1e4; t3 /= 1e8; t4 /= 1e8;    // C#: 此处的计算可能会导致数据精度过低, 故注释, 在下面引用的地方进行修改
    n *= 6;
    if (n < 0) n = ob[0].length.toDouble();
    for (i = 0; i < ob.length; i++) // C#: 注释循环变量中步长计算的后半语句:   , tn *= t)
    {
      F = ob[i];
      N = Math.Floor2Double(n * F.length / ob[0].length + 0.5);
      if (i != 0) N += 6;
      if (N >= F.length) N = F.length.toDouble();
      j = 0;
      c = 0;
      for (; j < N; j += 6) {
        // c += F[j] * Math.Cos(F[j + 1] + t * F[j + 2] + t2 * F[j + 3] + t3 * F[j + 4] + t4 * F[j + 5]);  // C#: 原语句, 因可能导致数据精度过低, 故修改如下
        c += F[j] *
            Math.Cos(F[j + 1] +
                t * F[j + 2] +
                t2 * F[j + 3] / 1e4 +
                t3 * F[j + 4] / 1e8 +
                t4 * F[j + 5] / 1e8); // C#: 新语句

      }
      // v += c * tn;     // C#: 注释此句并改写如下
      v += c * tn * Math.Pow(t, i.toDouble());
    }
    if (ob != XL.MR) v /= LunarHelper.rad;
    return v;
  }

  /// <summary>
  /// 返回月球坐标,n1,n2,n3为各坐标所取的项数
  /// </summary>
  /// <param name="t"></param>
  /// <param name="re"></param>
  /// <param name="n1"></param>
  /// <param name="n2"></param>
  /// <param name="n3"></param>
  static void M_coord(
      double t, List<double> re, double n1, double n2, double n3) {
    re[0] = XL.Mnn(XL.ML, t, n1);
    re[1] = XL.Mnn(XL.MB, t, n2);
    re[2] = XL.Mnn(XL.MR, t, n3);
  }

  /// <summary>
  /// 返回月球坐标,n1,n2,n3为各坐标所取的项数
  /// </summary>
  /// <param name="t"></param>
  /// <param name="re"></param>
  /// <param name="n1"></param>
  /// <param name="n2"></param>
  /// <param name="n3"></param>
  static void M_coord_5(double t, LunarInfoListT<double> re, double n1,
      double n2, double n3) // C#: 新扩展出来的方法
  {
    re[0] = XL.Mnn(XL.ML, t, n1);
    re[1] = XL.Mnn(XL.MB, t, n2);
    re[2] = XL.Mnn(XL.MR, t, n3);
  }

  /// <summary>
  /// 月球经度计算,返回Date分点黄经,传入世纪数,n是项数比例
  /// </summary>
  /// <param name="t"></param>
  /// <param name="n"></param>
  /// <returns></returns>
  static double M_Lon(double t, double n) {
    return XL.Mnn(XL.ML, t, n);
  }

  /// <summary>
  /// 地球速度,t是世纪数,误差小于万分3
  /// </summary>
  /// <param name="t"></param>
  /// <returns></returns>
  static double E_v(double t) {
    double f = 628.307585 * t;
    return 628.332 +
        21 * Math.Sin(1.527 + f) +
        0.44 * Math.Sin(1.48 + f * 2) +
        0.129 * Math.Sin(5.82 + f) * t +
        0.00055 * Math.Sin(4.21 + f) * t * t;
  }

  /// <summary>
  /// 月球速度计算,传入世经数
  /// </summary>
  /// <param name="t"></param>
  /// <returns></returns>
  static double M_v(double t) {
    double v = 8399.71 -
        914 * Math.Sin(0.7848 + 8328.691425 * t + 0.0001523 * t * t); //误差小于5%
    v -= 179 * Math.Sin(2.543 + 15542.7543 * t) //误差小于0.3%
        +
        160 * Math.Sin(0.1874 + 7214.0629 * t) +
        62 * Math.Sin(3.14 + 16657.3828 * t) +
        34 * Math.Sin(4.827 + 16866.9323 * t) +
        22 * Math.Sin(4.9 + 23871.4457 * t) +
        12 * Math.Sin(2.59 + 14914.4523 * t) +
        7 * Math.Sin(0.23 + 6585.7609 * t) +
        5 * Math.Sin(0.9 + 25195.624 * t) +
        5 * Math.Sin(2.32 - 7700.3895 * t) +
        5 * Math.Sin(3.88 + 8956.9934 * t) +
        5 * Math.Sin(0.49 + 7771.3771 * t);
    return v;
  }

  /// <summary>
  /// 月日视黄经的差值
  /// </summary>
  /// <param name="t"></param>
  /// <param name="Mn"></param>
  /// <param name="Sn"></param>
  /// <returns></returns>
  static double MS_aLon(double t, double Mn, double Sn) {
    return XL.M_Lon(t, Mn) +
        ZB.gxc_moonLon(t) -
        (XL.E_Lon(t, Sn) + ZB.gxc_sunLon(t) + Math.PI);
  }

  /// <summary>
  /// 太阳视黄经
  /// </summary>
  /// <param name="t"></param>
  /// <param name="n"></param>
  /// <returns></returns>
  static double S_aLon(double t, double n) {
    return XL.E_Lon(t, n) +
        ZB.nutationLon(t) +
        ZB.gxc_sunLon(t) +
        Math.PI; //注意，这里的章动计算很耗时
  }

  /// <summary>
  /// 已知地球真黄经求时间
  /// </summary>
  /// <param name="W"></param>
  /// <returns></returns>
  static double E_Lon_t(double W) {
    double t, v = 628.3319653318;
    t = (W - 1.75347) / v;
    v = XL.E_v(t); //v的精度0.03%，详见原文
    t += (W - XL.E_Lon(t, 10)) / v;
    v = XL.E_v(t); //再算一次v有助于提高精度,不算也可以
    t += (W - XL.E_Lon(t, -1)) / v;
    return t;
  }

  /// <summary>
  /// 已知真月球黄经求时间
  /// </summary>
  /// <param name="W"></param>
  /// <returns></returns>
  static double M_Lon_t(double W) {
    double t, v = 8399.70911033384;
    t = (W - 3.81034) / v;
    t += (W - XL.M_Lon(t, 3)) / v;
    v = XL.M_v(t); //v的精度0.5%，详见原文
    t += (W - XL.M_Lon(t, 20)) / v;
    t += (W - XL.M_Lon(t, -1)) / v;
    return t;
  }

  /// <summary>
  /// 已知月日视黄经差求时间
  /// </summary>
  /// <param name="W"></param>
  /// <returns></returns>
  static double MS_aLon_t(double W) {
    double t, v = 7771.37714500204;
    t = (W + 1.08472) / v;
    t += (W - XL.MS_aLon(t, 3, 3)) / v;
    v = XL.M_v(t) - XL.E_v(t); //v的精度0.5%，详见原文
    t += (W - XL.MS_aLon(t, 20, 10)) / v;
    t += (W - XL.MS_aLon(t, -1, 60)) / v;
    return t;
  }

  /// <summary>
  /// 已知太阳视黄经反求时间
  /// </summary>
  /// <param name="W"></param>
  /// <returns></returns>
  static double S_aLon_t(double W) {
    double t, v = 628.3319653318;
    t = (W - 1.75347 - Math.PI) / v;
    v = XL.E_v(t); //v的精度0.03%，详见原文
    t += (W - XL.S_aLon(t, 10)) / v;
    v = XL.E_v(t); //再算一次v有助于提高精度,不算也可以
    t += (W - XL.S_aLon(t, -1)) / v;
    return t;
  }

  /// <summary>
  /// 已知月日视黄经差求时间,高速低精度,误差不超过600秒
  /// </summary>
  /// <param name="W"></param>
  /// <returns></returns>
  static double MS_aLon_t2(double W) {
    double t, v = 7771.37714500204;
    t = (W + 1.08472) / v;
    double L, t2 = t * t;
    t -= (-0.00003309 * t2 +
            0.10976 * Math.Cos(0.784758 + 8328.6914246 * t + 0.000152292 * t2) +
            0.02224 * Math.Cos(0.18740 + 7214.0628654 * t - 0.00021848 * t2) -
            0.03342 * Math.Cos(4.669257 + 628.307585 * t)) /
        v;
    L = XL.M_Lon(t, 20) -
        (4.8950632 +
            628.3319653318 * t +
            0.000005297 * t * t +
            0.0334166 * Math.Cos(4.669257 + 628.307585 * t) +
            0.0002061 * Math.Cos(2.67823 + 628.307585 * t) * t +
            0.000349 * Math.Cos(4.6261 + 1256.61517 * t) -
            20.5 / LunarHelper.rad);
    v = 7771.38 -
        914 * Math.Sin(0.7848 + 8328.691425 * t + 0.0001523 * t * t) -
        179 * Math.Sin(2.543 + 15542.7543 * t) -
        160 * Math.Sin(0.1874 + 7214.0629 * t);
    t += (W - L) / v;
    return t;
  }

  /// <summary>
  /// 已知太阳视黄经反求时间,高速低精度,最大误差不超过600秒
  /// </summary>
  /// <param name="W"></param>
  /// <returns></returns>
  static double S_aLon_t2(double W) {
    double t, v = 628.3319653318;
    t = (W - 1.75347 - Math.PI) / v;
    t -= (0.000005297 * t * t +
            0.0334166 * Math.Cos(4.669257 + 628.307585 * t) +
            0.0002061 * Math.Cos(2.67823 + 628.307585 * t) * t) /
        v;
    t += (W -
            XL.E_Lon(t, 8) -
            Math.PI +
            (20.5 + 17.2 * Math.Sin(2.1824 - 33.75705 * t)) / LunarHelper.rad) /
        v;
    return t;
  }

  /// <summary>
  /// 月亮被照亮部分的比例
  /// </summary>
  /// <param name="t"></param>
  /// <returns></returns>
  static double moonIll(double t) {
    double t2 = t * t, t3 = t2 * t, t4 = t3 * t;
    double D, M, m, a, dm = Math.PI / 180;
    D = 297.8502042 +
        445267.1115168 * t -
        0.0016300 * t2 +
        t3 / 545868 -
        t4 / 113065000; //日月距角
    M = 357.5291092 +
        35999.0502909 * t -
        0.0001536 * t2 +
        t3 / 24490000; //太阳平近点
    m = 134.9634114 +
        477198.8676313 * t +
        0.0089970 * t2 +
        t3 / 69699 -
        t4 / 14712000; //月亮平近点
    D *= dm;
    M *= dm;
    m *= dm;
    a = Math.PI -
        D +
        (-6.289 * Math.Sin(m) +
                2.100 * Math.Sin(M) -
                1.274 * Math.Sin(D * 2 - m) -
                0.658 * Math.Sin(D * 2) -
                0.214 * Math.Sin(m * 2) -
                0.110 * Math.Sin(D)) *
            dm;
    return (1 + Math.Cos(a)) / 2;
  }

  /// <summary>
  /// 转入地平纬度及地月质心距离,返回站心视半径(角秒)
  /// </summary>
  /// <param name="r"></param>
  /// <param name="h"></param>
  /// <returns></returns>
  static double moonRad(double r, double h) {
    return 358473400 / r * (1 + Math.Sin(h) * LunarHelper.cs_rEar / r);
  }

  /// <summary>
  /// 时差计算(高精度)
  /// </summary>
  /// <param name="t"></param>
  /// <returns></returns>
  static double shiCha(double t) {
    double t2 = t * t, t3 = t2 * t, t4 = t3 * t, t5 = t4 * t;
    double L = (1753469512 +
                628331965331.8 * t +
                5296.74 * t2 +
                0.432 * t3 -
                0.1124 * t4 -
                0.00009 * t5 +
                630 * Math.Cos(6 + 0.3 * t)) /
            1000000000 +
        Math.PI -
        20.5 / LunarHelper.rad;

    double E, dE, dL;
    var z = List<double>.filled(2, 0.0); // C#: 待定(?)
    dL = -17.2 * Math.Sin(2.1824 - 33.75705 * t) / LunarHelper.rad; //黄经章
    dE = 9.2 * Math.Cos(2.1824 - 33.75705 * t) / LunarHelper.rad; //交角章
    E = ZB.hcjj(t) + dE; //真黄赤交角

    //地球坐标
    z[0] = XL.E_Lon(t, 50) + Math.PI + ZB.gxc_sunLon(t) + dL;
    z[1] = -(2796 * Math.Cos(3.1987 + 8433.46616 * t) +
            1016 * Math.Cos(5.4225 + 550.75532 * t) +
            804 * Math.Cos(3.88 + 522.3694 * t)) /
        1000000000;

    ZB.llrConv(z, E); //z太阳地心赤道坐标
    z[0] -= dL * Math.Cos(E);

    L = LunarHelper.rad2mrad(L - z[0]);
    if (L > Math.PI) L -= LunarHelper.pi2;
    return L / LunarHelper.pi2; //单位是周(天)
  }

  /// <summary>
  /// 时差计算(低精度),误差约在1秒以内
  /// </summary>
  /// <param name="t"></param>
  /// <returns></returns>
  static double shiCha2(double t) {
    double L =
        (1753469512 + 628331965331.8 * t + 5296.74 * t * t) / 1000000000 +
            Math.PI;
    var z = List<double>.filled(2, 0.0); // C#: 待定(?)
    double E = (84381.4088 - 46.836051 * t) / LunarHelper.rad;
    z[0] = XL.E_Lon(t, 5) + Math.PI;
    z[1] = 0; // 地球坐标
    ZB.llrConv(z, E); // z太阳地心赤道坐标
    L = LunarHelper.rad2mrad(L - z[0]);
    if (L > Math.PI) L -= LunarHelper.pi2;
    return L / LunarHelper.pi2; // 单位是周(天)
  }

//  #endregion

}
//}
