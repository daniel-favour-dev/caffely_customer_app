import 'package:flutter/material.dart';

class NearbyShopsScreen extends StatelessWidget {
  const NearbyShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00B14F);

    final List<Map<String, String>> shops = [
      {'name': 'Caffely Astoria Aromas', 'distance': '1.2 km', 'rating': '4.8'},
      {
        'name': 'Caffely West Village Wake-Up',
        'distance': '1.5 km',
        'rating': '4.6',
      },
      {
        'name': 'Caffely Upper East Espresso',
        'distance': '2.0 km',
        'rating': '4.4',
      },
      {
        'name': 'Caffely Manhattan Morning',
        'distance': '2.3 km',
        'rating': '4.5',
      },
      {'name': 'Caffely Wall Street', 'distance': '2.8 km', 'rating': '4.7'},
      {'name': 'Caffely Queens', 'distance': '3.1 km', 'rating': '4.8'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Nearby Shop",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 24,
          childAspectRatio: 0.7,
        ),
        itemCount: shops.length,
        itemBuilder: (context, index) {
          final shop = shops[index];
          return _buildGridShopCard(shop, primaryGreen);
        },
      ),
    );
  }

  Widget _buildGridShopCard(Map<String, String> shop, Color primaryGreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Container
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(Icons.store, size: 50, color: Colors.grey),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          shop['rating']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Title
        Text(
          shop['name']!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black,
            height: 1.2,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        // Distance
        Row(
          children: [
            Icon(Icons.location_on, size: 14, color: primaryGreen),
            const SizedBox(width: 4),
            Text(
              shop['distance']!,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    );
  }
}
