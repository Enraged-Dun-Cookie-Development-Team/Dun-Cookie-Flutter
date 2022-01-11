import 'package:flutter/material.dart';

class BakeryCard extends StatelessWidget {
  const BakeryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Text(
              "2022-01-01 16:00:00",
              style: TextStyle(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Text("?");
              },
              itemCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}
