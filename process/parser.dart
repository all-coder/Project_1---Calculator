import 'dart:math';
import 'package:petitparser/petitparser.dart';

class ParseExpressions{
  Parser buildParser() {
  final builder = ExpressionBuilder();
  builder.group()
    ..primitive((pattern('+-').optional() &
            digit().plus() &
            (char('.') & digit().plus()).optional() &
            (pattern('eE') & pattern('+-').optional() & digit().plus())
                .optional())
        .flatten('number expected')
        .trim()
        .map(num.tryParse))
    ..wrapper(
        char('(').trim(), char(')').trim(), (left, value, right) => value);
  builder.group()..prefix(char('-').trim(), (op, a) => -a);
  builder.group()..right(char('^').trim(), (a, op, b) => pow(a, b));
  builder.group()
    ..left(char('*').trim(), (a, op, b) => a * b)
    ..left(char('/').trim(), (a, op, b) => a / b);
  builder.group()
    ..left(char('+').trim(), (a, op, b) => a + b)
    ..left(char('-').trim(), (a, op, b) => a - b);
  return builder.build().end();
}

double calcString(String text) {
  final parser = buildParser();
  final input = text;
  final result = parser.parse(input);
  if (result is Success)
    return result.value.toDouble();
  else
    return -1;
}
}