import 'package:bts_lyrics_app/utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final String text;
  final Function onTap;
  const CustomButton({
    super.key, required this.text, required this.onTap, this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {},
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 3,
        color: Colors.transparent,
        shadowColor: Colors.purple.shade700,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Container(
                width: width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: appCardColor,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Text(
                    text,
                    style: GoogleFonts.openSans(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => onTap(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}