import 'package:flutter/material.dart';

class Mantra {
  final String id;
  final String name;
  final bool isCustom;
  final String? backgroundId;
  final List<String>? imagePaths;
  final String audioPath;
  final String? customAudioPath;

  Mantra(
      {required this.id,
      required this.name,
      required this.isCustom,
      this.backgroundId,
      this.imagePaths,
      this.customAudioPath,
      required this.audioPath});
}

class CustomBackground {
  final String id;
  final Widget child;
  final Widget thumbnail;

  CustomBackground(
      {required this.id, required this.child, required this.thumbnail});
}

class AppConstants {
  // Mantra Names - Used for display and as keys for SharedPreferences
  static const String hareKrishna = 'Hare Krishna';
  static const String radhaRadha = 'Radha Radha';
  static const String ramRam = 'Ram Ram';

  // List of all mantras for easy mapping in the UI
  static const List<String> mantras = [
    hareKrishna,
    radhaRadha,
    ramRam,
  ];

  // Map of mantra names to their audio file paths
  static const Map<String, String> mantraAudioPaths = {
    hareKrishna: 'assets/audio/hare_krishna.mp3',
    radhaRadha: 'assets/audio/radha_radha.mp3',
    ramRam: 'assets/audio/ram_ram.mp3',
  };

  static final List<CustomBackground> customBackgrounds = [
    _buildGradient('gradient_1', Colors.blue.shade200, Colors.blue.shade800),
    _buildGradient(
        'gradient_2', Colors.purple.shade200, Colors.purple.shade800),
    _buildGradient('gradient_3', Colors.green.shade200, Colors.green.shade800),
    _buildGradient(
        'gradient_4', Colors.orange.shade200, Colors.orange.shade800),
    _buildGradient('gradient_5', Colors.pink.shade200, Colors.pink.shade800),
    _buildImage('image_1', 'assets/images/custom_galaxy.jpeg'),
    _buildImage('image_2', 'assets/images/custom_mountain.jpeg'),
    _buildImage('image_3', 'assets/images/custom_sky.jpeg'),
    _buildImage('image_4', 'assets/images/custom_forest.jpeg'),
    _buildImage('image_5', 'assets/images/custom_temple.jpg'),
  ];

  static CustomBackground getBackgroundById(String id) {
    return customBackgrounds.firstWhere((bg) => bg.id == id,
        orElse: () => customBackgrounds.first);
  }

  // --- Helper methods for building the backgrounds ---
  static CustomBackground _buildGradient(
      String id, Color color1, Color color2) {
    final gradient = LinearGradient(
        colors: [color1, color2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight);
    return CustomBackground(
      id: id,
      child: Container(decoration: BoxDecoration(gradient: gradient)),
      thumbnail: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(gradient: gradient, shape: BoxShape.circle),
      ),
    );
  }

  static CustomBackground _buildImage(String id, String assetPath) {
    return CustomBackground(
      id: id,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(assetPath), fit: BoxFit.cover)),
      ),
      thumbnail: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image:
              DecorationImage(image: AssetImage(assetPath), fit: BoxFit.cover),
        ),
      ),
    );
  }

  // Map of mantra names to their background image paths
  static const Map<String, List<String>> mantraImagePaths = {
    hareKrishna: [
      'assets/images/hare_krishna_1.png',
      'assets/images/hare_krishna_2.png',
      'assets/images/hare_krishna_3.png',
      'assets/images/hare_krishna_4.png',
      'assets/images/hare_krishna_5.png',
    ],
    radhaRadha: [
      'assets/images/radha_radha_1.png',
      'assets/images/radha_radha_2.png',
      'assets/images/radha_radha_3.png',
      'assets/images/radha_radha_4.png',
      'assets/images/radha_radha_5.png',
    ],
    ramRam: [
      'assets/images/ram_ram_1.png',
      'assets/images/ram_ram_2.png',
      'assets/images/ram_ram_3.png',
      'assets/images/ram_ram_4.png',
      'assets/images/ram_ram_5.png',
    ],
  };

  // A default quote to show on first launch or if the server is unavailable.
  static const Map<String, String> defaultQuote = {
    'text_en':
        'It is better to live your own destiny imperfectly than to live an imitation of somebody else’s life with perfection.',
    'text_hi':
        'अपने स्वयं के भाग्य को अपूर्ण रूप से जीना किसी और के जीवन की नकल को पूर्णता के साथ जीने से बेहतर है।',
    'text_sa':
        'श्रेयान्स्वधर्मो विगुणः परधर्मात्स्वनुष्ठितात्। स्वधर्मे निधनं श्रेयः परधर्मो भयावहः।।',
    'source': 'Bhagavad Gita 3.35',
  };

  // Keys for SharedPreferences
  static const String prefsKeyMute = 'isMuted';
  static const String prefsKeyVibrationEnabled = 'isVibrationEnabled';
  static const String prefsKeySelectedMantra = 'selectedMantra';
}
