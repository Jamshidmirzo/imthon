import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TadbirItem extends StatefulWidget {
  const TadbirItem({super.key});

  @override
  State<TadbirItem> createState() => _TadbirItemState();
}

class _TadbirItemState extends State<TadbirItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.amber,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 35,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "12\nMay",
                        style:
                            TextStyle(fontFamily: "lato", color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.heart_circle_fill,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Satellite mega festival for\ndesigners",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
