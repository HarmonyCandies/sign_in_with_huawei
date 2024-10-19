import 'package:flutter/material.dart';
import 'dart:async';

import 'package:sign_in_with_huawei/sign_in_with_huawei.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> loginWithHuaweiId() async {
    final response = await SignInWithHuawei.instance.authById(
      forceLogin: true,
      state: "any state",
      nonce: "any nonce",
      idTokenAlg: IdTokenSignAlgorithm.PS256,
    );
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: loginWithHuaweiId,
            child: const Text('Login With Huawei ID'),
          ),
        ),
      ),
    );
  }
}
