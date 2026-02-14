import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data Grouped by Date
    final List<Map<String, dynamic>> todayNotifications = [
      {
        'type': 'icon',
        'icon': Icons.check_circle_outline,
        'title': 'New Update Available!',
        'description': 'Update Caffely and get a better coffee experience!',
        'time': '09:40 AM',
        'isUnread': true,
      },
      {
        'type': 'image',
        'image':
            'assets/images/coffee_cup.png', // Placeholder, will fallback or use icon
        'title': "Your order 'Classic Brew' is ready to be picked up!",
        'description': '', // Sometimes description is part of title or empty?
        // Actually the design has description. I'll use placeholders.
        'time': '08:20 AM',
        'isUnread': true,
      },
    ];

    final List<Map<String, dynamic>> yesterdayNotifications = [
      {
        'type': 'icon',
        'icon': Icons.shield_outlined,
        'title': 'Enable 2-Factor Authentication',
        'description':
            'Use 2-factor authentication for multiple layers of security on your account.',
        'time': '14:45 PM',
        'isUnread': false,
      },
      {
        'type': 'image',
        'image': 'assets/images/coffee_go.png',
        'title':
            "Your order 'Minty Fresh Brew' is being delivered to your place!",
        'description': '',
        'time': '09:58 AM',
        'isUnread': false,
      },
    ];

    final List<Map<String, dynamic>> olderNotifications = [
      {
        'type': 'icon',
        'icon': Icons.credit_card,
        'title': 'Multiple Payment Updates!',
        'description': 'Now you can add a credit card for coffee payments.',
        'time': '16:34 PM',
        'isUnread': false,
      },
      {
        'type': 'icon',
        'icon': Icons.local_offer_outlined,
        'title': 'Christmas & New Year Offer!',
        'description':
            'Limited time promo to order your favorite coffee on special Christmas and New Year\'s days.',
        'time': '12:00 PM',
        'isUnread': false,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Notification",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ), // Removed horizontal padding from container to allow section headers to align, but content needs padding.
        // Actually, looking at design, "Today" label is aligned with content.
        children: [
          _buildSectionHeader("Today"),
          ...todayNotifications.map((n) => _buildNotificationItem(n)),
          const SizedBox(height: 16),
          _buildSectionHeader("Yesterday"),
          ...yesterdayNotifications.map((n) => _buildNotificationItem(n)),
          const SizedBox(height: 16),
          _buildSectionHeader("Dec 20, 2023"),
          ...olderNotifications.map((n) => _buildNotificationItem(n)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> data) {
    const Color primaryGreen = Color(0xFF00B14F);

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon or Image
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: data['type'] == 'image'
                    ? const Icon(
                        Icons.local_cafe,
                        color: Colors.brown,
                      ) // Fallback for now as we don't have assets
                    : Icon(data['icon'], color: primaryGreen, size: 24),
              ),
            ),
            const SizedBox(width: 16),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  if (data['description'] != '') ...[
                    const SizedBox(height: 4),
                    Text(
                      data['description'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    data['time'],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
            // Actions
            Column(
              children: [
                if (data['isUnread'] == true) ...[
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: primaryGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ), // Spacing to align chevron somewhat centered or just below
                ],
                const SizedBox(height: 4),
              ],
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
