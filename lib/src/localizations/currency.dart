import 'package:intl/intl.dart';

// void currency(context) {
//   Locale locale = Localizations.localeOf(context);
//   var format =
//       NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
//   print("CURRENCY SYMBOL ${format.currencySymbol}"); // N
//   print("CURRENCY NAME ${format.currencyName}"); // NGN
// }

NumberFormat nairaFormat = NumberFormat.simpleCurrency(
  locale: 'en_NG',
  // Platform.localeName, ₦
  name: 'N',
  decimalDigits: 0,
);
