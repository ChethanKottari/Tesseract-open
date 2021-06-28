import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final bool dark;

  const ButtonWidget({this.text, this.onClicked, this.dark});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
          shape: StadiumBorder(),
          onPrimary: Colors.white,
          padding: EdgeInsets.all(10)),
      onPressed: onClicked,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            )),
      ),
    );
  }
}
