import 'dart:convert';
import 'package:intl/intl.dart';

final formater = NumberFormat("#.##0,00");

List<T> stringToList<T>(String input) =>
    input != null ? (json.decode(input) as List<dynamic>).cast<T>() : [];

Map<String, dynamic> stringToMap(String input) => json.decode(input);

String formatMoney(String money) => money
    .replaceAll('\$', "R\$ ")
    .replaceAll('.', 'p')
    .replaceAll(',', '.')
    .replaceAll('p', ',');

double currencyStringToDouble(String money) => double.parse(
      money
          .replaceAll('R', "")
          .replaceAll('\$', '')
          .replaceAll('.', '')
          .replaceAll('+', '')
          .replaceAll('-', '')
          .replaceAll(' ', '')
          .replaceAll(',', '.'),
    );

String doubleToCurrencyString(double money) =>
    "R\$ " + formatMoney(money.toStringAsFixed(2));

String moneyFormatted(String value, int count) {
  final numberFormat = NumberFormat("#,###.00");

  value = value.replaceAll('\$', '');
  return 'R\$ ' + numberFormat.format(double.parse(value) * count);
}

String getVerboseDate(DateTime date) {
  final List<String> months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];

  return '${date.day} de ${months[date.month - 1]} de ${date.year}';
}

bool isValidEmail(String email) {
  final Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);

  return (!regex.hasMatch(email)) ? false : true;
}
