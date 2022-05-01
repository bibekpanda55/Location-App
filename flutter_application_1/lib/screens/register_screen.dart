import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/api.dart';
import 'package:flutter_application_1/components/button_style.dart';
import 'package:flutter_application_1/components/custom_input_decorator.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:location/location.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/register-screen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final name = TextEditingController(),
      mail = TextEditingController(),
      pass = TextEditingController(),
      cpass = TextEditingController();
  final Location location = Location();

  late LocationData _locationData;
  final formKey = GlobalKey<FormState>();
  final outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(width: 2, color: Colors.black),
  );
  String nameText = '', emailText = '', passText = '', cPassText = '';

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((value) async {
      _locationData = await location.getLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(0xff6C63FF);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          minimum: EdgeInsets.all(20),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: name,
                    decoration:
                        CustomInputDecorator.getStandardInputDecoration(context)
                            .copyWith(
                                prefixIcon: Icon(Icons.person),
                                enabledBorder: outlineInputBorder,
                                // focusedBorder: outlineInputBorder,
                                hintText: 'First Name',
                                enabled: true
                                //border: InputBorder.none
                                ),
                    validator: (val) =>
                        val!.trim().isEmpty ? 'cannot be empty' : null,
                    onSaved: (val) => nameText = val!.trim().toString(),
                  ),
                  TextFormField(
                    controller: mail,
                    decoration:
                        CustomInputDecorator.getStandardInputDecoration(context)
                            .copyWith(
                                prefixIcon: Icon(Icons.mail),
                                //border: InputBorder.none,
                                enabledBorder: outlineInputBorder,
                                // focusedBorder: outlineInputBorder,
                                hintText: 'Email',
                                enabled: true),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) =>
                        val!.trim().isEmpty ? 'cannot be empty' : null,
                    onSaved: (val) => emailText = val!.trim().toString(),
                  ),
                  TextFormField(
                    controller: pass,
                    decoration:
                        CustomInputDecorator.getStandardInputDecoration(context)
                            .copyWith(
                                prefixIcon: Icon(Icons.mail),
                                //border: InputBorder.none,
                                enabledBorder: outlineInputBorder,
                                // focusedBorder: outlineInputBorder,
                                hintText: 'Password',
                                enabled: true),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) =>
                        val!.trim().isEmpty ? 'cannot be empty' : null,
                    onSaved: (val) => passText = val!.trim().toString(),
                  ),
                  TextFormField(
                    controller: cpass,
                    decoration:
                        CustomInputDecorator.getStandardInputDecoration(context)
                            .copyWith(
                                prefixIcon: Icon(Icons.mail),
                                //border: InputBorder.none,
                                enabledBorder: outlineInputBorder,
                                // focusedBorder: outlineInputBorder,
                                hintText: 'Confirm Password',
                                enabled: true),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) =>
                        val!.trim().isEmpty ? 'cannot be empty' : null,
                    onSaved: (val) => cPassText = val!.trim().toString(),
                  ),
                  ElevatedButton(
                      style: StyleButton.getStandardButtonStyle(
                          context, ButtonType.Raised),
                      onPressed: () async {
                        final fstate = formKey.currentState;
                        if (fstate!.validate()) {
                          fstate.save();
                          try {
                            await userRegister(UserClass(
                                    name: nameText,
                                    email: emailText,
                                    password: passText,
                                    passwordConfirmation: cPassText,
                                    userLattitude:
                                        _locationData.latitude.toString(),
                                    userLongitude:
                                        _locationData.longitude.toString()))
                                .then((value) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                    SnackBar(content: Text(value.message)));
                              Navigator.of(context).pop();
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content:
                                    Text('One or more fields are empty!')));
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('Already have an account?',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              color: color,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ))
                  ]),
                ]
                    .map(
                  (e) => Column(
                    children: [e, SizedBox(height: 20)],
                  ),
                )
                    .fold(
                        [],
                        (previousValue, element) =>
                            previousValue..add(element)),
              ))),
    );
  }
}
