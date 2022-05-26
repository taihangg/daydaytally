// import 'package:gbk2utf8/gbk2utf8.dart';
// import 'package:charset/charset.dart';
// import 'package:charset_converter/charset_converter.dart';
import 'package:enough_convert/enough_convert.dart';
import 'package:http/http.dart' as http;

class GetCityByIP {
  static Future<List<String>?> get() async {
    String url;
    url = "http://whois.pconline.com.cn/ipJson.jsp";

    print(url);

    http.Response response;
    try {
      response = await http.get(Uri.parse(url));
    } catch (e) {
      print("从网络获取数据失败: $e");
      return null;
    }

    // Utf16Encoder encoder = utf16.encoder as Utf16Encoder;
    // String body = (await CharsetConverter.decode("gbk", response.bodyBytes))!;
    String body = GbkCodec().decode(response.bodyBytes);

    // String body = gbk.decode(response.bodyBytes);
//    print(body);

    // "pro": "重庆市",
    RegExp proRE = RegExp(r'"pro": ?"([^"]+)",');
    final proMatch = proRE.firstMatch(body);
    if ((null == proMatch) || (1 != proMatch.groupCount)) {
      return null;
    }
    final String pro = proMatch.group(1)!;

    // "city": "重庆市",
    RegExp cityRE = RegExp(r'"city": ?"([^"]+)",');
    final cityMatch = cityRE.firstMatch(body);
    if ((null == cityMatch) || (1 != cityMatch.groupCount)) {
      return null;
    }
    final String city = cityMatch.group(1)!;

    return [pro, city];
  }
}
