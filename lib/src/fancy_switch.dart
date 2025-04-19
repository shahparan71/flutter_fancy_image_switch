import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FancySwitch extends StatefulWidget {
  final bool initialValue;
  final String onImagePath;
  final String offImagePath;
  final double thumbSize;
  final double height;
  final double width;
  final Color enableColor;
  final Color disableColor;
  final ValueChanged<bool>? onChanged;

  const FancySwitch({
    Key? key,
    this.initialValue = false,
    this.onImagePath = "assets/images/day.png",
    this.offImagePath = "assets/images/night.png",
    this.thumbSize = 35,
    this.height = 50,
    this.width = 100,
    this.enableColor = Colors.green,
    this.disableColor = Colors.grey,
    this.onChanged,
  }) : super(key: key);

  @override
  State<FancySwitch> createState() => _FancySwitchState();
}

class _FancySwitchState extends State<FancySwitch>
    with SingleTickerProviderStateMixin {
  late bool _isOn;
  bool _hasOnImage = true;
  bool _hasOffImage = true;

  @override
  void initState() {
    super.initState();
    _isOn = widget.initialValue;
    _checkAssets();
  }

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
          color: bgImage == null
              ? (_isOn ? widget.enableColor : widget.disableColor)
              : null,
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

Future<bool> assetExists(String assetPath) async {
  try {
    await rootBundle.load(assetPath);
    return true;
  } catch (e) {
    debugPrint('Asset not found: $assetPath');
    return false;
  }
}
