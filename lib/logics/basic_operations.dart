import 'package:calculator/screens_pages/home_page.dart';

List<String> listFromString(String input) {
  RegExp regex = RegExp(r'([+\-\*\/]|\d+\.\d+|\d+)');
  List<String> result =
      regex.allMatches(input).map((match) => match.group(0)!).toList();
  if (result[0] == "-") {
    result[0] = "-${result[1]}";
    result.removeAt(1);
  }
  return result;
}

String calculateResult(List<String> list) {
  for (int i = 0; i < list.length; i++) {
    if (list[i] == '*' || list[i] == '/') {
      double left = double.parse(list[i - 1].toString());
      double right = double.parse(list[i + 1].toString());
      double result;
      if (list[i] == '*') {
        result = left * right;
      } else {
        result = left / right;
      }
      list[i - 1] = result.toString();
      list.removeRange(i, i + 2);
      i--;
    }
  }
  for (int i = 0; i < list.length; i++) {
    if (list[i] == '+' || list[i] == '-') {
      double left = double.parse(list[i - 1].toString());
      double right = double.parse(list[i + 1].toString());
      double result;
      if (list[i] == '+') {
        result = left + right;
      } else {
        result = left - right;
      }
      list[i - 1] = result.toString();
      list.removeRange(i, i + 2);
      i--;
    }
  }
  return list[0].toString();
}

String calculationFunction(String input) {
  String temp = calculateResult(listFromString(input));
  streamController.add(temp);
  return temp;
}
