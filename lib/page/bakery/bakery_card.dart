import 'package:flutter/material.dart';

class BakeryCard extends StatefulWidget {
  const BakeryCard({Key? key}) : super(key: key);

  @override
  State<BakeryCard> createState() => _BakeryCardState();
}

class _BakeryCardState extends State<BakeryCard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration(seconds: 1), (){
    //   Navigator.of(context).pop();
    // });
  }

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
