import 'package:flutter/material.dart';

class SizeGuideView extends StatefulWidget {
  const SizeGuideView({super.key});

  @override
  State<SizeGuideView> createState() => _SizeGuideViewState();
}

class _SizeGuideViewState extends State<SizeGuideView> {
  bool _isShowCentimetersSize = false;

  void updateSizes() {
    setState(() {
      _isShowCentimetersSize = !_isShowCentimetersSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

    );
  }
}