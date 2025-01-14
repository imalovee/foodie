import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton ({super.key, required this.buttonText, required this.onpressed, required this.buttonColor});

  final String buttonText;
  final void Function() onpressed;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          minimumSize: Size(MediaQuery.of(context).size.width*0.9, 50)
        ),
        child: Text(buttonText, style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700
        ),));
  }
}
