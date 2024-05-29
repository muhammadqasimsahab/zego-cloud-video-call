import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import '../home/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //TODO: ensure that the username is unique before registering
  String? username;
  String? email;
  String? password;

  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SiginUp"),
      ),
      body: Form(
        key: key,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "username"),
              validator: ValidationBuilder().maxLength(10).build(),
              onChanged: (value) {
                username = value;
              },
            ),
            const SizedBox(
              height: 12,
            ),
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
                          UserCredential usercred = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email!, password: password!);
                          if (usercred.user != null) {
                            var data = {
                              'username': username,
                              'email': email,
                              'created_at': DateTime.now()
                            };
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(usercred.user!.uid)
                                .set(data);
                          }
                          if (mounted) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: const Text('SignUp')))
          ],
        ),
      ),
    );
  }
}
