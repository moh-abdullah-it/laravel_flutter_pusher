import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    setUpServices();
  }

  void setUpServices() {
    var options = PusherOptions(
      host: 'socket.code-link.com',
      port: 6001,
      encrypted: true,
    );

    LaravelFlutterPusher pusher = LaravelFlutterPusher(
        '25bea58d-98eb-4c2c-9436-5d9912fb737f', options, enableLogging: true,
        onConnectionStateChange: (state) {
      log('state ${state.currentState}');
    });
    pusher.subscribe('test').bind('App\\Events\\TestEvent',
        (event) => log('event =>' + event.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
