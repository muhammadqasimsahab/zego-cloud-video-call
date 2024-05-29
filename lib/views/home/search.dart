import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search For a user')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Enter username"),
              onChanged: (val) {
                username = val;
                setState(() {});
              },
            ),
          ),
          if (username != null)
            if (username!.length > 3)
              FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .where('username')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data?.docs.isEmpty ?? false) {
                        return const Text('No User Found !');
                      }
                      return SizedBox(
                        height: 300,
                        child: ListView.builder(
                            itemCount: snapshot.data?.docs.length ?? 0,
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = snapshot.data!.docs[index];
                              return ListTile(
                                title: Text(doc['username']),
                                trailing: FutureBuilder<DocumentSnapshot>(
                                    future: doc.reference
                                        .collection('followers')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data?.exists ?? false) {
                                          return ElevatedButton(
                                            onPressed: () async {
                                              await doc.reference
                                                  .collection('followers')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .set({
                                                'time': DateTime.now(),
                                              });
                                              setState(() {});
                                            },
                                            child: const Text('Un Follow'),
                                          );
                                        }
                                        return ElevatedButton(
                                          onPressed: () async {
                                            await doc.reference
                                                .collection('followers')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .set({
                                              'time': DateTime.now(),
                                            });
                                            setState(() {});
                                          },
                                          child: const Text('Follow'),
                                        );
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    }),
                              );
                            }),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
        ],
      ),
    );
  }
}
