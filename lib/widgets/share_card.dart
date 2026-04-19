import 'package:flutter/material.dart';

class ShareCard extends StatelessWidget {
  final String name;
  final int totalJapps;

  const ShareCard({super.key, required this.name, required this.totalJapps});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350, // Fixed width for consistent sharing
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8C00), Color(0xFFFF5E62)], // Saffron Sunset
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Mandala (Subtle)
          const Positioned(
            right: -50,
            top: -50,
            child: Opacity(
              opacity: 0.1,
              child:
                  Icon(Icons.wb_sunny_rounded, size: 200, color: Colors.white),
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.verified_rounded,
                      color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "SPIRITUAL MILESTONE",
                    style: TextStyle(
                      color: Colors.white.withAlpha(220),
                      fontSize: 12,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. User Info
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: Colors.white.withAlpha(130), width: 2),
                ),
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.deepOrange, size: 35),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // 3. The Big Number
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withAlpha(60)),
                ),
                child: Column(
                  children: [
                    const Text(
                      "COMPLETED",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$totalJapps',
                      style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.0,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            )
                          ]),
                    ),
                    const Text(
                      "DIVINE MANTRAS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 4. Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/app_logo_simple.webp',
                    height: 24,
                    color: Colors.white, // Tint logo white if possible
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Naam Jaap",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
