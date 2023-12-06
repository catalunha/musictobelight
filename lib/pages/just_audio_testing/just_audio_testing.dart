import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class JustAudioTesting extends StatefulWidget {
  final AudioPlayer justAudio;
  const JustAudioTesting({
    Key? key,
    required this.justAudio,
  }) : super(key: key);

  @override
  State<JustAudioTesting> createState() => _JustAudioTestingState();
}

class _JustAudioTestingState extends State<JustAudioTesting> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
