import 'package:bts_lyricz/main.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    super.key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  });

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SearchBar(
        controller: controller,
        hintText: widget.hintText,
        hintStyle: WidgetStatePropertyAll(TextStyle(fontSize: 15)),
        //surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
        autoFocus: true,
        trailing: widget.text.isNotEmpty ? [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              controller.clear();
              widget.onChanged('');
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ] : [],
        backgroundColor: BTSLyricsApp.of(context).isMaterialYou ? WidgetStateProperty.all(Theme.of(context).colorScheme.inversePrimary) : WidgetStateProperty.all(Theme.of(context).colorScheme.tertiaryContainer),
        onChanged: widget.onChanged,
      ),
    );
  }
}