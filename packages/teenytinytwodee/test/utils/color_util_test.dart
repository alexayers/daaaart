import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/utils/color_utils.dart';
import 'package:test/test.dart';

void main() {
  group('ColorUtils', () {
    test('RGB to Hex conversion', () {
      expect(rbgToHex(255, 0, 0), '#ff0000');
      expect(rbgToHex(0, 255, 0), '#00ff00');
      expect(rbgToHex(0, 0, 255), '#0000ff');
      expect(rbgToHex(128, 128, 128), '#808080');
    });

    test('Hex to Color conversion', () {
      expect(hexToColor('#ff0000'), Color(red: 255, green: 0, blue: 0));
      expect(hexToColor('#00ff00'), Color(red: 0, green: 255, blue: 0));
      expect(hexToColor('#0000ff'), Color(red: 0, green: 0, blue: 255));
      expect(hexToColor('#808080'), Color(red: 128, green: 128, blue: 128));
    });
  });
}
