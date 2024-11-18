

import 'package:audioplayers/audioplayers.dart';

final AudioPlayer _audioPlayer = AudioPlayer();

Future<void> done() async {
  await _audioPlayer.play(AssetSource('sounds/done.mp3'));
  _audioPlayer.setVolume(.5);
}

Future<void> delete() async {
  await _audioPlayer.play(AssetSource('sounds/delete.mp3'));
  _audioPlayer.setVolume(1);
}

Future<void> archive() async {
  await _audioPlayer.play(AssetSource('sounds/archive.mp3'));
  _audioPlayer.setVolume(1);

}
Future<void> click() async {
  await _audioPlayer.play(AssetSource('sounds/bubble.mp3'));
  _audioPlayer.setVolume(.5);
}

Future<void> reopen() async {
  await _audioPlayer.play(AssetSource('sounds/reopen.mp3'));
  _audioPlayer.setVolume(.5);
}