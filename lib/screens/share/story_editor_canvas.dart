import 'dart:io';
import 'package:bts_lyricz/main.dart';
import 'package:bts_lyricz/services/settings_service.dart';
import 'package:bts_lyricz/utils/ui_constants.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image/image.dart' as img;

Future<Uint8List> cropImageBytes(Uint8List rawBytes) async {
  return await compute(_cropTask, rawBytes);
}

// Background Task
Uint8List _cropTask(Uint8List bytes) {
  final img.Image? original = img.decodePng(bytes);
  if (original == null) return bytes;

  const int cropPx = 2;

  final img.Image cropped = img.copyCrop(
      original,
      x: cropPx,
      y: cropPx,
      width: original.width - (cropPx * 2),
      height: original.height - (cropPx * 2)
  );

  return Uint8List.fromList(img.encodePng(cropped));
}

class StoryEditorCanvas extends StatefulWidget {
  final List<String> lines;
  final String songTitle;
  final String artistName;
  final ImageProvider albumArt;
  final List<Color> extractedColors;
  final GenerationMode mode;
  final VoidCallback onBack;

  const StoryEditorCanvas({
    super.key,
    required this.lines,
    required this.songTitle,
    required this.artistName,
    required this.albumArt,
    required this.extractedColors,
    required this.mode,
    required this.onBack,
  });

  @override
  State<StoryEditorCanvas> createState() => StoryEditorCanvasState();
}

class StoryEditorCanvasState extends State<StoryEditorCanvas> {
  final ScreenshotController _screenshotController = ScreenshotController();
  late Color _currentColor;
  bool _showHintBorder = false;
  bool _enableBackground = true;
  bool _showLogo = true;
  bool _lightText = false;
  bool _isLoading = false;
  double _userScale = 0.9;
  double _baseScale = 0.9;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.extractedColors.isNotEmpty
        ? widget.extractedColors.first
        : const Color(0xFF5D9BA8);
    _lightText = !(_currentColor.computeLuminance() > 0.4);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SettingsService.openShareLyricsWalkthrough(context);
    });
  }

  Future<void> _openColorPicker() async {
    final Color newColor = await showColorPickerDialog(
      context,
      _currentColor,
      wheelSquarePadding: 8,
      enableTonalPalette: true,
      enableShadesSelection: true,
      pickersEnabled: <ColorPickerType, bool>{
        ColorPickerType.both : true,
        ColorPickerType.primary: false,
        ColorPickerType.accent: false,
        ColorPickerType.bw : false,
        ColorPickerType.custom : true,
        ColorPickerType.wheel : true,
      },
    );

    setState(() {
      _currentColor = newColor;
      _lightText = !(_currentColor.computeLuminance() > 0.4);
    });
  }

  Future<void> _shareImage() async {
    setState(() {
      _showHintBorder = false;
      _isLoading = true;
    });
    const double captureRatio = 3.0; // Hardcoded 3.0 for standard 1080p width

    // final double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    // final double captureRatio = pixelRatio > 2.0 ? 2.0 : pixelRatio * 1.5;

    try {
      final Uint8List? imageBytes = await _screenshotController.capture(pixelRatio: captureRatio);

      if (imageBytes != null) {
        final Uint8List cleanBytes = await cropImageBytes(imageBytes);
        final directory = await getTemporaryDirectory();
        final imagePath = await File('${directory.path}/bangtan_lyricz_card.png').create();
        await imagePath.writeAsBytes(cleanBytes);

        if(!mounted) return;
        final box = context.findRenderObject() as RenderBox?;

        await SharePlus.instance.share(ShareParams(
          sharePositionOrigin: box != null ? box.localToGlobal(Offset.zero) & box.size : null,
          files: [XFile(imagePath.path)],
        ));
      }
    } catch (e) {
      debugPrint("Share failed: $e");
      if (mounted) showCustomToastError("Something went wrong");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isBackgroundDark = _enableBackground
        ? _currentColor.computeLuminance() < 0.4
        : Theme.brightnessOf(context) == Brightness.dark;

    final Color foregroundColor = isBackgroundDark ? Colors.white : Colors.black;
    final Color textColor = _lightText ? Colors.white : Colors.black;

    return Scaffold(
      body: Stack(
        children: [
          // LAYER 1: Background Canvas
          Positioned.fill(
            child: Container(
                color: _enableBackground
                    ? _currentColor
                    : BTSLyricsApp.of(context).isMaterialYou ? Theme.of(context).colorScheme.surfaceContainerLow : Theme.of(context).scaffoldBackgroundColor
            ),
          ),

          // LAYER 2: The Content (Centered)
          Positioned.fill(
            child: GestureDetector(
              onScaleStart: _enableBackground
                  ? (details) => _baseScale = _userScale
                  : null,
              onScaleEnd: (v) => setState(() => _showHintBorder = false),
              onScaleUpdate: _enableBackground
                  ? (details) {
                setState(() {
                  // Clamp scale between 0.5x (half size) and 1.5x (big)
                  _userScale = (_baseScale * details.scale).clamp(0.5, 1.1);
                  _showHintBorder = true;
                });
              }
                  : null,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    // Add padding to "push" the scrolling area up
                    // Top: 80 (approx Header height)
                    // Bottom: 160 (approx Footer height + buffer)
                    padding: const EdgeInsets.only(top: 80, left: 0, right: 0, bottom: 160),
                    child: Screenshot(
                      controller: _screenshotController,
                      child: _buildCardPreview(textColor, foregroundColor),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // LAYER 3: Top Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: foregroundColor,
                      onPressed: widget.onBack,
                    ),
                    const Spacer(),

                    IconButton(
                      tooltip: "Text Color",
                      icon: Icon(_lightText ? Icons.format_color_text : Icons.format_color_text_outlined),
                      color: foregroundColor,
                      onPressed: () => setState(() => _lightText = !_lightText),
                    ),

                    IconButton(
                      tooltip: _showLogo ? "Hide logo" : "Show logo",
                      icon: Icon(_showLogo ? Icons.verified : Icons.verified_outlined),
                      color: foregroundColor,
                      onPressed: () => setState(() => _showLogo = !_showLogo),
                    ),

                    IconButton(
                      tooltip: _enableBackground ? "Card mode" : "Story mode",
                      icon: Icon(_enableBackground ? Icons.aspect_ratio_rounded : Icons.crop_free_rounded),
                      color: foregroundColor,
                      onPressed: () {
                        setState(() {
                          _enableBackground = !_enableBackground;
                          if(_enableBackground) _userScale = 0.9;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // LAYER 4: Bottom Controls (Palette + Share)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Color Palette
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _openColorPicker,
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const SweepGradient(
                                  colors: [Colors.red, Colors.yellow, Colors.green, Colors.blue, Colors.purple, Colors.red],
                                ),
                                border: Border.all(color: Colors.white30, width: 3),
                                boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 4)],
                              ),
                              child: const Icon(Icons.colorize, color: Colors.white, size: 20),
                            ),
                          ),
                          ...widget.extractedColors.toSet().map((c) => _colorOption(c)),
                          _colorOption(const Color(0xFF282828)),
                          _colorOption(const Color(0xFF191414)),
                          _colorOption(Colors.white, isBorder: true),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Share Button (Floating Style)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                            elevation: 3,
                          ),
                          onPressed: _isLoading ? () {} : _shareImage,
                          icon: _isLoading
                              ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 3, color: Theme.of(context).colorScheme.onPrimaryContainer))
                              : const Icon(Icons.share),
                          label: Text(_isLoading ? "Saving..." : "Share", style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorOption(Color color, {bool isBorder = false}) {
    final isSelected = _currentColor == color;

    return GestureDetector(
      onTap: () => setState(() {
        _currentColor = color;
        _lightText = !(_currentColor.computeLuminance() > 0.4);
      }),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: 45,
        height: 45,
        alignment: Alignment.center,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isSelected ? 40 : 36, // Animate size inside the fixed box
          height: isSelected ? 40 : 36,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: isBorder || isSelected ? Border.all(color: Colors.white60, width: isSelected ? 3 : 1) : null,
            boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
        ),
      ),
    );
  }

  Widget _buildCardPreview(Color textColor, Color foregroundColor) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double baseWidth = screenWidth > 500 ? 350 : screenWidth * 0.85;

    final bool showLyricsLayout = widget.mode == GenerationMode.lyrics && widget.lines.isNotEmpty;

    // Inner Content
    Widget cardContent = Padding(
      padding: const EdgeInsets.all(28),
      child: showLyricsLayout
          ? _buildLyricsLayout(textColor)
          : _buildSongLayout(textColor),
    );

    if (_enableBackground) {
      // --- STORY MODE (9:16) ---
      return Container(
        width: baseWidth,
        height: baseWidth * (16 / 9),
        decoration: BoxDecoration(
          color: _currentColor,
          borderRadius: _showHintBorder ? BorderRadius.circular(24) : null,
          border: _showHintBorder ? Border.all(color: foregroundColor.withValues(alpha: 0.5)) : null,
        ),
        child: Transform.scale(
          scale: _userScale,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: baseWidth,
                decoration: BoxDecoration(
                  color: _currentColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 5))],
                ),
                child: cardContent,
              ),
            ),
          ),
        ),
      );
    } else {
      // --- CARD MODE ---
      return Container(
        width: baseWidth,
        decoration: BoxDecoration(
          color: _currentColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: const Offset(0, 4))],
          border: Border.all(color: _currentColor, width: 3.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: cardContent,
        ),
      );
    }
  }

  Widget _buildLyricsLayout(Color textColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image(image: widget.albumArt, width: 45, height: 45, fit: BoxFit.fill),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.songTitle,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12, color: textColor, letterSpacing: 0),
                  ),
                  Text(
                    widget.artistName,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 11, color: textColor, letterSpacing: 0),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
        ...widget.lines.map((line) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            line,
            maxLines: 4,
            overflow: TextOverflow.fade,
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.bold, color: textColor, height: 1.2, letterSpacing: 0
            ),
          ),
        )),
        const SizedBox(height: 24),
        if (_showLogo) _buildFooter(textColor),
      ],
    );
  }

  Widget _buildSongLayout(Color textColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(image: widget.albumArt, fit: BoxFit.fill),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          widget.songTitle,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 21, color: textColor, letterSpacing: 0),
        ),
        const SizedBox(height: 4),
        Text(
          widget.artistName,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: textColor.withValues(alpha: 0.8), letterSpacing: 0),
        ),
        const SizedBox(height: 30),
        if (_showLogo) _buildFooter(textColor),
      ],
    );
  }

  Widget _buildFooter(Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(4), child: Image.asset("images/app-icon-v3.png", height: 24)),
        const SizedBox(width: 8),
        Text("Bangtan Lyricz", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: textColor, fontSize: 11, letterSpacing: 0)),
      ],
    );
  }
}