import 'package:similarity/math.dart';
import 'package:similarity/string.dart';
import 'package:test/test.dart';

void main() {
  test("dLSimilarity", () {
    String str1 = "kitten";
    String str2 = "sitting";
    int distance1 = dLDistance(str1.codeUnits, str2.codeUnits);
    expect(3, distance1);
    double similarity1 = dLStringSimilarity(str1, str2);
    expect(0.5714285714285714, similarity1);

    String str3 = "OpenAI";
    String str4 = "OpenAI";
    int distance2 = dLDistance(str3.codeUnits, str4.codeUnits);
    expect(0, distance2);
    double similarity2 = dLStringSimilarity(str3, str4);
    expect(1, similarity2);

    String str5 = "Saturday";
    String str6 = "Sunday";
    int distance3 = dLDistance(str5.codeUnits, str6.codeUnits);
    expect(3, distance3);
    double similarity3 = dLStringSimilarity(str5, str6);
    expect(0.625, similarity3);

    String str7 = "CA";
    String str8 = "ABC";
    int distance4 = dLDistance(str7.codeUnits, str8.codeUnits);
    expect(2, distance4);
    double similarity4 = dLStringSimilarity(str7, str8);
    expect(0.33333333333333337, similarity4);
  });

  test("osaSimilarity", () {
    String str1 = "kitten";
    String str2 = "sitting";
    int distance1 = osaDistance(str1.codeUnits, str2.codeUnits);
    expect(3, distance1);
    double similarity1 = osaStringSimilarity(str1, str2);
    expect(0.5714285714285714, similarity1);

    String str3 = "OpenAI";
    String str4 = "OpenAI";
    int distance2 = osaDistance(str3.codeUnits, str4.codeUnits);
    expect(0, distance2);
    double similarity2 = dLStringSimilarity(str3, str4);
    expect(1, similarity2);

    String str5 = "Saturday";
    String str6 = "Sunday";
    int distance3 = osaDistance(str5.codeUnits, str6.codeUnits);
    expect(3, distance3);
    double similarity3 = osaStringSimilarity(str5, str6);
    expect(0.625, similarity3);

    String str7 = "CA";
    String str8 = "ABC";
    int distance4 = osaDistance(str7.codeUnits, str8.codeUnits);
    expect(3, distance4);
    double similarity4 = osaStringSimilarity(str7, str8);
    expect(0.0, similarity4);
  });
}
