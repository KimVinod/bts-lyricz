import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCardWithTitle extends StatelessWidget {
  final String imageAsset, name;
  final Widget widget;
  const CustomCardWithTitle({super.key, required this.imageAsset, required this.widget, required this.name});

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
          const SizedBox(height: 6),
          SizedBox(
            height: 20,
            width: 150,
            child: FittedBox(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}