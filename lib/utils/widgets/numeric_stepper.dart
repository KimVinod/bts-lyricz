import 'package:bts_lyricz/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NumericStepper extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const NumericStepper({
    super.key,
    this.initialValue = 16,
    this.minValue = 10,
    this.maxValue = 25,
    required this.onChanged,
  });

  @override
  State<NumericStepper> createState() => _NumericStepperState();
}

class _NumericStepperState extends State<NumericStepper> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  void _updateValue(int newValue) {
    if (newValue >= widget.minValue && newValue <= widget.maxValue) {
      setState(() {
        _currentValue = newValue;
      });
      widget.onChanged(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: StadiumBorder(),
      elevation: 3,
      shadowColor: Theme.of(context).colorScheme.shadow,
      child: Container(
        width: 160,
        decoration: ShapeDecoration(
          color: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.tertiaryContainer,
          shape: StadiumBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Decrement Button
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: _currentValue > widget.minValue
                  ? () => _updateValue(_currentValue - 1)
                  : null,
            ),

            // Static Read-Only
            Text(
              '$_currentValue',
              style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),

            // Increment Button
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _currentValue < widget.maxValue
                  ? () => _updateValue(_currentValue + 1)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
