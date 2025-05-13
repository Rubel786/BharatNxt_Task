import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class MiddleContainer extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  MiddleContainer({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      top: 40,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
        ),
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            suffixIcon: const Icon(Icons.search, color: Colors.grey),
            hintText: 'Enter Product name',
            hintStyle: TextStyle(
              color: Colors.brown,
              fontFamily: "Mulish",
              fontSize: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
