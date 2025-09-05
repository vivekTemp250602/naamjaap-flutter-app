import 'package:flutter/material.dart';

class ShareCard extends StatelessWidget {
  final String name;
  final int totalJapps;

  const ShareCard({super.key, required this.name, required this.totalJapps});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepOrange.shade200,
            Colors.amber.shade100,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/app_logo.png',
            height: 80,
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            'has completed',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '$totalJapps chants!',
            style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'on the NaamJaap App',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
