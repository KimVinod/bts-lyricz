import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  final String imageAsset;
  final Widget widget;
  final String? name;

  const CustomCard({
    super.key,
    required this.imageAsset,
    required this.widget,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () => onTap(context),
      child: Column(
        children: <Widget>[
          Material(
            elevation: 3,
            shadowColor: Theme.of(context).colorScheme.shadow,
            borderRadius: BorderRadius.circular(12),
            child: Ink(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(image: AssetImage(imageAsset), fit: BoxFit.fill),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => onTap(context),
              ),
            ),
          ),
          if (name != null) ...[
            const SizedBox(height: 6),
            SizedBox(
              height: 20,
              width: 170,
              child: FittedBox(
                child: Text(
                  name!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void onTap(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
