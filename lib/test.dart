import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ButtonSoundExample extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    await _audioPlayer.play(AssetSource('sounds/archive.mp3'));
    // _audioPlayer.setVolume(.3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Button Sound Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _playSound();
          },
          child: Text('Click Me'),
        ),
      ),
    );
  }
}
