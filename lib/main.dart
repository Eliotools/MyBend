import 'package:flutter/widgets.dart';
import 'package:mybend/src/app.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(
      'en_US', null); // You can change 'en_US' to your desired locale
  
  runApp(const App());
}
