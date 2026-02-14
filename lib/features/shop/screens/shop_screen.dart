import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  bool isAllSelected = true;

  final List<Map<String, dynamic>> shops = [
    {
      'name': 'Caffely Astoria Aromas',
      'distance': '1.2 km',
      'location': '350 5th Ave, New York, NY 1...',
      'rating': 4.8,
      'reviews': '2.4k',
    },
    {
      'name': 'Caffely West Village Wak..',
      'distance': '1.5 km',
      'location': '285 Fulton St, New York, NY...',
      'rating': 4.6,
      'reviews': '1.9k',
    },
    {
      'name': 'Caffely Upper East Espres..',
      'distance': '1.8 km',
      'location': '45 Rockefeller Plaza, New Y...',
      'rating': 4.7,
      'reviews': '2.2k',
    },
    {
      'name': 'Caffely Manhattan Morni..',
      'distance': '2.3 km',
      'location': '89 E 42nd St, New York, NY...',
      'rating': 4.5,
      'reviews': '1.7k',
    },
    {
      'name': 'Caffely Wall Street Beans',
      'distance': '2.5 km',
      'location': '200 Eastern Pkwy, Brooklyn...',
      'rating': 4.7,
      'reviews': '2.0k',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00B14F);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png', width: 24, height: 24),
        ),
        title: const Text(
          "Shop",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black, size: 28),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Location Selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black54,
                  size: 22,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Your location",
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
                const Spacer(),
                const Text(
                  "New York",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down, color: primaryGreen),
              ],
            ),
          ),

          // Toggle Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isAllSelected = true),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isAllSelected
                              ? primaryGreen
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "All",
                          style: TextStyle(
                            color: isAllSelected
                                ? Colors.white
                                : Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isAllSelected = false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: !isAllSelected
                              ? primaryGreen
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Favorites",
                          style: TextStyle(
                            color: !isAllSelected
                                ? Colors.white
                                : Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Shop List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: shops.length,
              separatorBuilder: (context, index) => const Divider(height: 32),
              itemBuilder: (context, index) {
                final shop = shops[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shop Image Placeholder
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(Icons.store, color: Colors.grey, size: 32),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Shop Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shop['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: primaryGreen,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${shop['distance']} | ${shop['location']}",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              ...List.generate(5, (i) {
                                return Icon(
                                  Icons.star,
                                  size: 14,
                                  color: i < (shop['rating'] as double).floor()
                                      ? Colors.amber
                                      : Colors.grey.shade300,
                                );
                              }),
                              const SizedBox(width: 4),
                              Text(
                                "${shop['rating']} (${shop['reviews']} reviews)",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Arrow Icon
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
