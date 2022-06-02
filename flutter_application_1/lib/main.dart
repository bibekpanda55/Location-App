import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/list_widget._screen.dart';
import 'package:flutter_application_1/screens/location_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/pie_widget.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'package:flutter_application_1/screens/test_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sp;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, fontFamily: 'LexendDeca'),
      initialRoute: PieWidget.routeName,
      routes: {
        PieWidget.routeName: (_) => PieWidget(),
        ListWidgetScreen.routeName: (_) => ListWidgetScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        LocationScreen.routeName: (_) => LocationScreen(),
        TestWidget.routeName: (_) => TestWidget()
      },
    );
  }
}
