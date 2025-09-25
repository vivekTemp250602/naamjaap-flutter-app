import 'package:naamjaap/utils/constants.dart';

class MantraInfoService {
  // The data is now a map where each mantra has its own map of translations.
  static final Map<String, Map<String, String>> _mantraDescriptions = {
    AppConstants.hareKrishna: {
      'en':
          "The Hare Krishna Maha Mantra is a revered Vaishnava mantra from the Kali-Santarana Upanishad. It is a heartfelt call to the divine energies of Lord Krishna and Lord Rama, seeking to engage the chanter in devotional service (bhakti). Chanting this mantra is believed to purify the consciousness and bring one closer to spiritual realization.",
      'hi':
          "हरे कृष्ण महामंत्र काली-संतारण उपनिषद का एक प्रतिष्ठित वैष्णव मंत्र है। यह भगवान कृष्ण और भगवान राम की दिव्य ऊर्जाओं का हार्दिक आह्वान है, जो जपने वाले को भक्ति सेवा में संलग्न करने का प्रयास करता है। माना जाता है कि इस मंत्र का जाप चेतना को शुद्ध करता है और व्यक्ति को आध्यात्मिक अनुभूति के करीब लाता है।",
      'sa':
          "हरे कृष्ण महामन्त्रः कलिसन्तरणोपनिषदः एकः सम्मानितः वैष्णवमन्त्रः अस्ति। अयं भगवतः कृष्णस्य भगवतः रामस्य च दिव्यशक्तीनां हार्दिकं आह्वानम् अस्ति, यत् भक्तसेवायां जप्तारं नियोक्तुं प्रयतते। अस्य मन्त्रस्य जपेन चेतना शुद्धा भवति, व्यक्तिः च आध्यात्मिकसाक्षात्कारस्य समीपं गच्छति इति विश्वासः।",
    },
    AppConstants.radhaRadha: {
      'en':
          "This is a devotional chant that glorifies Radharani, the divine consort of Lord Krishna and the embodiment of pure, selfless love. Chanting 'Radha Radha' is a practice of immersing oneself in the blissful energy of divine love and devotion.",
      'hi':
          "यह एक भक्तिपूर्ण जाप है जो भगवान कृष्ण की दिव्य संगिनी और शुद्ध, निस्वार्थ प्रेम की प्रतिमूर्ति राधारानी की महिमा का गुणगान करता है। 'राधा राधा' का जाप दिव्य प्रेम और भक्ति की आनंदमयी ऊर्जा में डूबने का एक अभ्यास है।",
      'sa':
          "अयं भक्तिजपः भगवतः कृष्णस्य दिव्यायाः पत्न्याः, शुद्धस्य निःस्वार्थप्रेमस्य मूर्तरूपायाः राधारानीदेव्याः महिमानं करोति। 'राधा राधा' इति जपनं दिव्यप्रेमभक्त्योः आनन्दमय्यां ऊर्जायां निमज्जनस्य अभ्यासः अस्ति।",
    },
    AppConstants.ramRam: {
      'en':
          "The name of Lord Rama is considered a powerful and sacred mantra. Chanting 'Ram Ram' is a simple yet profound practice of japa that is believed to bestow peace, righteousness (dharma), and protection upon the devotee.",
      'hi':
          "भगवान राम का नाम एक शक्तिशाली और पवित्र मंत्र माना जाता है। 'राम राम' का जाप एक सरल लेकिन गहरा अभ्यास है, जिसके बारे में माना जाता है कि यह भक्त को शांति, धर्म और सुरक्षा प्रदान करता है।",
      'sa':
          "भगवतः रामस्य नाम एकं शक्तिशाली पवित्रं मन्त्रं मन्यते। 'राम राम' इति जपनं जस्य एकः सरलः गहनः च अभ्यासः अस्ति, यः भक्ताय शान्तिं, धर्मं, रक्षणं च ददाति इति विश्वासः।",
    },
  };

  static Map<String, String> getDescription(String mantraName) {
    return _mantraDescriptions[mantraName] ??
        {
          'en': "Information for this mantra is not yet available.",
          'hi': "इस मंत्र के लिए जानकारी अभी उपलब्ध नहीं है।",
          'sa': "अस्य मन्त्रस्य कृते सूचना अद्यापि न उपलभ्यते।",
        };
  }
}
