import 'package:bts_lyricz/main.dart';
import 'package:bts_lyricz/screens/share/story_editor_canvas.dart';
import 'package:bts_lyricz/services/firebase_service.dart';
import 'package:bts_lyricz/utils/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

class SongLyricsGenerator extends StatefulWidget {
  final String songTitle;
  final String artistName;
  final ImageProvider albumArt;
  final String lyrics;
  final GenerationMode mode;

  const SongLyricsGenerator({
    super.key,
    required this.songTitle,
    required this.artistName,
    required this.albumArt,
    required this.lyrics,
    this.mode = GenerationMode.lyrics,
  });

  @override
  State<SongLyricsGenerator> createState() => _SongLyricsGeneratorState();
}

class _SongLyricsGeneratorState extends State<SongLyricsGenerator> {
  late int _currentStep;
  late List<String> _allLines;
  final Set<int> _selectedLineIndices = {};
  List<Color> _extractedColors = [];
  bool _isLoadingColors = true;

  @override
  void initState() {
    super.initState();
    _currentStep = widget.mode == GenerationMode.song ? 1 : 0;
    _allLines = widget.lyrics.split('\n').where((line) => line.trim().isNotEmpty).toList();
    _extractColors();
  }

  Future<void> _extractColors() async {
    try {
      final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
        widget.albumArt,
        size: const Size(100, 100),
      ).timeout(const Duration(seconds: 3));

      if (!mounted) return;

      setState(() {
        _extractedColors = [
          generator.vibrantColor?.color,
          generator.lightVibrantColor?.color,
          generator.darkVibrantColor?.color,
          generator.dominantColor?.color,
          generator.mutedColor?.color,
          generator.lightMutedColor?.color,
          generator.darkMutedColor?.color,
        ].whereType<Color>().toList();
        _isLoadingColors = false;
      });
    } catch (e, s) {
      FirebaseService.logCustomError(e, s, "SongLyricsGeneratorState - _extractColors");
      if (mounted) setState(() => _isLoadingColors = false);
    }
  }

  void _handleBackAttempt() {
    if (widget.mode == GenerationMode.song) {
      _showDiscardDialog();
      return;
    }
    if (_currentStep == 0) {
      _showDiscardDialog();
    } else {
      _showEditorExitOptions();
    }
  }

  void _showEditorExitOptions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Discard edits?", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text("Change lyrics"),
              onTap: () {
                Navigator.pop(ctx);
                setState(() => _currentStep = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text("Discard"),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Keep editing", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDiscardDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Discard edits?"),
        content: const Text("You will lose your current changes."),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("No", style: GoogleFonts.openSans(fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: Text("Yes", style: GoogleFonts.openSans(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedLineIndices.contains(index)) {
        _selectedLineIndices.remove(index);
      } else {
        if (_selectedLineIndices.length < 5) {
          _selectedLineIndices.add(index);
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 3),
              content: Text("Maximum 5 lines are allowed.", style: GoogleFonts.openSans(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w500)),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // If Step 1 (Editor)
    if (_currentStep == 1) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          _handleBackAttempt();
        },
        child: _isLoadingColors
            ? SizedBox()
            : _buildEditor(),
      );
    }

    // Step 0: Selection Screen
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _handleBackAttempt();
      },
      child: Scaffold(
        backgroundColor: BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.surfaceContainerLow : Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: "Back",
            onPressed: _handleBackAttempt,
          ),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select Lyrics",
                style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(width: 12),
              const Chip(label: Text("BETA", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), labelPadding: EdgeInsets.zero, padding: EdgeInsets.symmetric(vertical: 0, horizontal: 14), shape: StadiumBorder())
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => setState(() => _currentStep = 1),
              child: Text("Next", style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 15)),
            )
          ],
        ),
        body: _isLoadingColors
            ? SizedBox()
            : _buildSelector(),
      ),
    );
  }

  Widget _buildSelector() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _allLines.length,
      itemBuilder: (context, index) {
        final isSelected = _selectedLineIndices.contains(index);
        return GestureDetector(
          onTap: () => _toggleSelection(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.secondaryContainer : Theme.brightnessOf(context) == Brightness.light ? Theme.of(context).colorScheme.tertiaryContainer : Theme.of(context).colorScheme.surfaceContainerHighest
                  : BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0) : Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.black38 : Colors.white30),
            ),
            child: Text(
              _allLines[index],
              style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditor() {
    List<String> finalLines = [];
    if (widget.mode == GenerationMode.lyrics) {
      final sortedIndices = _selectedLineIndices.toList()..sort();
      finalLines = sortedIndices.map((i) => _allLines[i]).toList();
    }

    return StoryEditorCanvas(
      lines: finalLines,
      songTitle: widget.songTitle,
      artistName: widget.artistName,
      albumArt: widget.albumArt,
      extractedColors: _extractedColors,
      mode: widget.mode,
      onBack: _handleBackAttempt,
    );
  }
}