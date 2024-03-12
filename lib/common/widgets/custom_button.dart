import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  final String name;
  final VoidCallback callback;
  const CustomButton({Key? key, required this.name, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: callback, 
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(name),
    );
  }
}