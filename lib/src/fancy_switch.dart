import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable animated switch widget with optional images and color transitions.
///
/// The [FancySwitch] widget provides a smooth and interactive toggle UI component,
/// useful for themes or custom toggles.
///
/// Example usage:
/// ```dart
/// FancySwitch(
///   initialValue: true,
///   onChanged: (value) {
///     print("Switch is now: $value");
///   },
/// )
/// ```
class FancySwitch extends StatefulWidget {
  /// Whether the switch is initially turned on.
  final bool initialValue;

  /// Path to the image displayed when the switch is turned on.
  ///
  /// Default: `"assets/images/day.png"`
  final String onImagePath;

  /// Path to the image displayed when the switch is turned off.
  ///
  /// Default: `"assets/images/night.png"`
  final String offImagePath;

  /// Diameter of the circular thumb.
  final double thumbSize;

  /// Height of the switch container.
  final double height;

  /// Width of the switch container.
  final double width;

  /// The background color when the switch is in the "enabled" state
  /// (used when image is not present).
  final Color enableColor;

  /// The background color when the switch is in the "disabled" state
  /// (used when image is not present).
  final Color disableColor;

  /// Callback triggered when the switch is toggled.
  final ValueChanged<bool>? onChanged;

  /// Creates a [FancySwitch] widget.
  ///
  /// The [onChanged] callback provides the updated boolean value.
  const FancySwitch({
    super.key,
    this.initialValue = false,
    this.onImagePath = "assets/images/day.png",
    this.offImagePath = "assets/images/night.png",
    this.thumbSize = 35,
    this.height = 50,
    this.width = 100,
    this.enableColor = Colors.green,
    this.disableColor = Colors.grey,
    this.onChanged,
  });

  @override
  State<FancySwitch> createState() => _FancySwitchState();
}

class _FancySwitchState extends State<FancySwitch> with SingleTickerProviderStateMixin {
  late bool _isOn;
  bool _hasOnImage = true;
  bool _hasOffImage = true;

  @override
  void initState() {
    super.initState();
    _isOn = widget.initialValue;
    _checkAssets();
  }

  /// Checks if the provided image assets exist before using them.
  Future<void> _checkAssets() async {
    final onExists = await assetExists(widget.onImagePath);
    final offExists = await assetExists(widget.offImagePath);
    if (mounted) {
      setState(() {
        _hasOnImage = onExists;
        _hasOffImage = offExists;
      });
    }
  }

  /// Toggles the switch state and invokes the [onChanged] callback if available.
  void _toggleSwitch() {
    setState(() {
      _isOn = !_isOn;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(_isOn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool useImage = _isOn ? _hasOnImage : _hasOffImage;
    final DecorationImage? bgImage = useImage
        ? DecorationImage(
            image: AssetImage(
              _isOn ? widget.onImagePath : widget.offImagePath,
            ),
            fit: BoxFit.cover,
          )
        : null;

    return GestureDetector(
      onTap: _toggleSwitch,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: bgImage == null ? (_isOn ? widget.enableColor : widget.disableColor) : null,
          image: bgImage,
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              alignment: _isOn ? Alignment.centerLeft : Alignment.centerRight,
              curve: Curves.easeInOut,
              child: Container(
                width: widget.thumbSize,
                height: widget.thumbSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isOn ? Colors.yellow : Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Checks if an asset exists at the given [assetPath].
///
/// Returns `true` if the asset can be loaded, otherwise `false`.
Future<bool> assetExists(String assetPath) async {
  try {
    await rootBundle.load(assetPath);
    return true;
  } catch (e) {
    debugPrint('Asset not found: $assetPath');
    return false;
  }
}
