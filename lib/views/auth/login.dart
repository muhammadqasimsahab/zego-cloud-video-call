import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:zegowith_asif/views/auth/signup.dart';
import 'package:zegowith_asif/views/home/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LogIn")),
      body: Form(
        key: key,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Email"),
              validator: ValidationBuilder().email().maxLength(50).build(),
              onChanged: (value) {
                email = value;
              },
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Password"),
              validator: ValidationBuilder().maxLength(15).maxLength(6).build(),
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
                height: 40,
                child: ElevatedButton(
                    onPressed: () async {
                      if (key.currentState?.validate() ?? false) {
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email!, password: password!);
                       if(mounted){
                         Navigator.of(context).pushReplacement(
                             MaterialPageRoute(
                                 builder: (context) => const HomePage()));
                       }
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: const Text('Login'))),
            InkWell(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SignUp()));
              },
              child: const Text('Create an Account'),
            )
          ],
        ),
      ),
    );
  }
}
