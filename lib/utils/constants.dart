class AppConstants {
  // Mantra Names - Used for display and as keys for SharedPreferences
  static const String hareKrishna = 'Hare Krishna';
  static const String radhaRadha = 'Radha Radha';
  static const String ramRam = 'Ram Ram';
  static const String omNamahShivay = 'Om Namah Shivay';

  // List of all mantras for easy mapping in the UI
  static const List<String> mantras = [
    hareKrishna,
    radhaRadha,
    ramRam,
    omNamahShivay,
  ];

  // Map of mantra names to their audio file paths
  static const Map<String, String> mantraAudioPaths = {
    hareKrishna: 'assets/audio/hare_krishna.mp3',
    radhaRadha: 'assets/audio/radha_radha.mp3',
    ramRam: 'assets/audio/ram_ram.mp3',
    omNamahShivay: 'assets/audio/om_namah_shivay.mp3',
  };

  // Map of mantra names to their background image paths
  static const Map<String, String> mantraImagePaths = {
    hareKrishna: 'assets/images/hare_krishna.png',
    radhaRadha: 'assets/images/radha_radha.png',
    ramRam: 'assets/images/ram_ram.png',
    omNamahShivay: 'assets/images/om_namah_shivay.png',
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
