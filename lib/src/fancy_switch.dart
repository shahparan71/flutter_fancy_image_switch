import 'package:flutter/material.dart';

class FancySwitch extends StatefulWidget {
  final bool initialValue;
  final String on_image_path;
  final String off_image_path;
  final double thumb_size;
  final double height;
  final double width;
  final ValueChanged<bool>? onChanged;

  const FancySwitch({
    Key? key,
    this.initialValue = false,
    this.on_image_path = "assets/images/day.png",
    this.off_image_path = "assets/images/night.png",
    this.thumb_size = 35,
    this.height = 50,
    this.width = 100,
    this.onChanged,
  }) : super(key: key);

  @override
  State<FancySwitch> createState() => _FancySwitchState();
}

class _FancySwitchState extends State<FancySwitch> with SingleTickerProviderStateMixin {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.initialValue;
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
    return GestureDetector(
      onTap: _toggleSwitch,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          image: DecorationImage(
            image: AssetImage(_isOn ? '${widget.on_image_path}' : '${widget.off_image_path}'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Stars or clouds background layer could go here
            AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              alignment: _isOn ? Alignment.centerLeft : Alignment.centerRight,
              curve: Curves.easeInOut,
              child: Container(
                width: widget.thumb_size,
                height: widget.thumb_size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isOn ? Colors.yellow : Colors.white,
                  boxShadow: [
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