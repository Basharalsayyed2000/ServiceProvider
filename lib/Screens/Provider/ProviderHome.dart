import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProviderHome extends StatefulWidget {
  static String id='ProviderHome';
  @override
  _ProviderHomeState createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome in provider page'),
      ),
    );
  }
}