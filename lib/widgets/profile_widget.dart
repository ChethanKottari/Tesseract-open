import 'package:flutter/material.dart';

import 'build_circle.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isedit;

  const ProfileWidget({
    this.imagePath,
    this.onClicked,
    this.isedit,
  });

  @override
  Widget build(BuildContext context) {
    final color = Colors.indigo;
    return Center(
      child: Stack(
        children: [
          BuildImage(),
          Positioned(bottom: 0, right: 4, child: BuildEditIcon(color)),
        ],
      ),
    );
  }

  Widget BuildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: onClicked,
          ),
        ),
      ),
    );
  }

  Widget BuildEditIcon(Color color) {
    return BuildCircle(
      all: 5,
      color: Colors.white,
      child: BuildCircle(
        color: color,
        all: 8,
        child: Icon(
          isedit ? Icons.add_a_photo : Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
