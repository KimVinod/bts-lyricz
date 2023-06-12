import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class CustomCardWithoutTitle extends StatelessWidget {
  final String imageAsset;
  final Widget widget;
  const CustomCardWithoutTitle({super.key, required this.imageAsset, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Material(
              elevation: 3,
              shadowColor: Colors.purple.shade700,
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                width: 150,
                height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(image: AssetImage(imageAsset), fit: BoxFit.fill)
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => widget)),
                ),
              )),
        ],
      ),
    );
  }
}