import 'package:flutter/material.dart';

void main() {
  runApp(const TrafficLightApp());
}

class TrafficLightApp extends StatelessWidget {
  const TrafficLightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traffic Light Simulator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFF4F4F4),
      ),
      home: const TrafficLightScreen(),
    );
  }
}

enum LightState { red, green }

class TrafficLightScreen extends StatefulWidget {
  const TrafficLightScreen({super.key});

  @override
  State<TrafficLightScreen> createState() => _TrafficLightScreenState();
}

class _TrafficLightScreenState extends State<TrafficLightScreen> {
  LightState _current = LightState.red;
  bool _isYellow = false;
  bool _buttonDisabled = false;

  // Returns the color for each bulb
  Color _redColor() {
    if (_isYellow) return const Color(0xFF444444);
    return _current == LightState.red ? Colors.red : const Color(0xFF444444);
  }

  Color _yellowColor() {
    return _isYellow ? Colors.yellow : const Color(0xFF444444);
  }

  Color _greenColor() {
    if (_isYellow) return const Color(0xFF444444);
    return _current == LightState.green
        ? const Color(0xFF00FF00)
        : const Color(0xFF444444);
  }

  void _switchLight() {
    setState(() => _buttonDisabled = true);

    // Flash yellow first
    setState(() => _isYellow = true);

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _isYellow = false;
        _current =
            _current == LightState.red ? LightState.green : LightState.red;
        _buttonDisabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Traffic light housing
            Container(
              width: 120,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF222222),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _Bulb(color: _redColor()),
                  _Bulb(color: _yellowColor()),
                  _Bulb(color: _greenColor()),
                ],
              ),
            ),
            const SizedBox(height: 25),
            // Switch button
            ElevatedButton(
              onPressed: _buttonDisabled ? null : _switchLight,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
                disabledBackgroundColor: const Color(0xFFAAAAAA),
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.white.withOpacity(0.6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(fontSize: 16),
                elevation: 0,
              ),
              child: const Text('Switch Traffic Light'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bulb extends StatelessWidget {
  final Color color;
  const _Bulb({required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 70,
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
