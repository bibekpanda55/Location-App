import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/api.dart';
import 'package:flutter_application_1/components/button_style.dart';
import 'package:flutter_application_1/components/custom_input_decorator.dart';
import 'package:flutter_application_1/screens/location_screen.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'package:location/location.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login-screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(width: 2, color: Colors.black),
  );
  final Location location = Location();
  bool _serviceEnabled = false;
  late PermissionStatus _permissionGranted;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((value) async {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          Navigator.of(context).pop();
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          Navigator.of(context).pop();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(0xff6C63FF);
    return Scaffold(
        body: SafeArea(
      minimum: EdgeInsets.all(20),
      child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  validator: (val) => val!.isEmpty ? 'Cannot be empty!' : null,
                  decoration:
                      CustomInputDecorator.getStandardInputDecoration(context)
                          .copyWith(
                    hintText: 'Email',
                  )),
              TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _password,
                  validator: (val) => val!.isEmpty ? 'Cannot be empty!' : null,
                  decoration:
                      CustomInputDecorator.getStandardInputDecoration(context)
                          .copyWith(
                    hintText: 'Password',
                  )),
              ElevatedButton(
                  style: StyleButton.getStandardButtonStyle(
                      context, ButtonType.Raised),
                  onPressed: () async {
                    //final mobile = _phone.text.trim().toString();
                    final email = _email.text.trim().toString();
                    final fstate = formKey.currentState;
                    if (fstate!.validate()) {
                      try {
                        userLogin(email, _password.text.trim().toString())
                            .then((value) async {
                          //print(sp.getString('access_token'));
                          Navigator.of(context)
                              .pushReplacementNamed(LocationScreen.routeName);
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('One or more fields are empty!')));
                    }
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400])),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.routeName);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: color,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ]
                .map(
              (e) => Column(
                children: [e, SizedBox(height: 20)],
              ),
            )
                .fold([],
                    (previousValue, element) => previousValue..add(element)),
          )),
    ));
  }
}
