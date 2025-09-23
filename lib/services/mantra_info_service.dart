import 'package:naamjaap/utils/constants.dart';

class MantraInfoService {
  static final Map<String, String> _mantraDescriptions = {
    AppConstants.hareKrishna:
        "The Hare Krishna Maha Mantra is a revered Vaishnava mantra from the Kali-Santarana Upanishad. It is a heartfelt call to the divine energies of Lord Krishna and Lord Rama, seeking to engage the chanter in devotional service (bhakti). Chanting this mantra is believed to purify the consciousness and bring one closer to spiritual realization.",
    AppConstants.radhaRadha:
        "This is a devotional chant that glorifies Radharani, the divine consort of Lord Krishna and the embodiment of pure, selfless love. Chanting 'Radha Radha' is a practice of immersing oneself in the blissful energy of divine love and devotion.",
    AppConstants.ramRam:
        "The name of Lord Rama is considered a powerful and sacred mantra. Chanting 'Ram Ram' is a simple yet profound practice of japa that is believed to bestow peace, righteousness (dharma), and protection upon the devotee.",
  };

  static String getDescription(String mantraName) {
    return _mantraDescriptions[mantraName] ??
        "Information for this mantra is not yet available.";
  }
}
