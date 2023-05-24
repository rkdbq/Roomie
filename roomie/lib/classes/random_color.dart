import 'dart:math';
import 'dart:ui';

Color randomColor() {
  var r = Random().nextInt(255);
  var g = Random().nextInt(255);
  var b = Random().nextInt(255);
  return Color.fromRGBO(r, g, b, 1);
}
