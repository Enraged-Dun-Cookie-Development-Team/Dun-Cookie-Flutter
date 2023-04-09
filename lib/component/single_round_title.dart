import 'package:flutter/material.dart';

class SingleRoundTitle extends StatelessWidget {
  final String title;
  const SingleRoundTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.orangeAccent),
      ),
    );
  }
}
