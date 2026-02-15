import 'package:flutter/material.dart';

class ShareBottomSheet extends StatelessWidget {
  const ShareBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle Bar (Optional, mock shows title directly)
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Title
          const Center(
            child: Text(
              "Share",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),

          // Recent People
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Recent people",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const SizedBox(width: 8),
                Expanded(child: Divider(color: Colors.grey.shade200)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRecentPerson(
                  "Charlotte",
                  "Hanlin",
                  Colors.orange.shade100,
                  Icons.chat,
                  Colors.green,
                ),
                _buildRecentPerson(
                  "Kristin",
                  "Watson",
                  Colors.purple.shade100,
                  Icons.facebook,
                  Colors.blue,
                ),
                _buildRecentPerson(
                  "Clinton",
                  "Mcclure",
                  Colors.blue.shade100,
                  Icons.camera_alt,
                  Colors.pink,
                ),
                _buildRecentPerson(
                  "Maryland",
                  "Winkles",
                  Colors.orange.shade100,
                  Icons.chat,
                  Colors.green,
                ),
                _buildRecentPerson(
                  "Alex",
                  "Here",
                  Colors.green.shade100,
                  Icons.send,
                  Colors.lightBlue,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Social Media
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Social media",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const SizedBox(width: 8),
                Expanded(child: Divider(color: Colors.grey.shade200)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSocialIcon("WhatsApp", Colors.green, Icons.chat),
                _buildSocialIcon(
                  "Facebook",
                  Colors.blue.shade800,
                  Icons.facebook,
                ),
                _buildSocialIcon("Instagram", Colors.pink, Icons.camera_alt),
                _buildSocialIcon("Telegram", Colors.blue, Icons.send),
                _buildSocialIcon(
                  "Twitter",
                  Colors.lightBlue,
                  Icons.featured_play_list_outlined,
                ), // Placeholder for Twitter
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildRecentPerson(
    String firstName,
    String lastName,
    Color color,
    IconData appIcon,
    Color appColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color,
                // Using first letter as placeholder for image
                child: Text(
                  firstName[0],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: appColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(appIcon, size: 10, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            firstName,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          Text(
            lastName,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String name, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
