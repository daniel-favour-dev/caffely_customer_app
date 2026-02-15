import 'package:flutter/material.dart';

class ShopReviewsScreen extends StatefulWidget {
  const ShopReviewsScreen({super.key});

  @override
  State<ShopReviewsScreen> createState() => _ShopReviewsScreenState();
}

class _ShopReviewsScreenState extends State<ShopReviewsScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ["Sort by", "5", "4", "3", "2", "1"];

  final List<Map<String, dynamic>> _reviews = [
    {
      "name": "Augustina Midgett",
      "date": "5 days ago",
      "rating": 5.0,
      "review":
          "I absolutely love the cozy ambiance and friendly staff at this coffee shop. The 'Berry Bliss' coffee is my favorite! Perfect spot to unwind and enjoy a cup of happiness.",
    },
    {
      "name": "Tanner Stafford",
      "date": "2 days ago",
      "rating": 4.5,
      "review":
          "Great coffee selection! I tried the 'Turquoise Cup - Ocean Breeze Iced Coffee,' and it was refreshing. Service was quick and efficient too.",
    },
    {
      "name": "Krishna Barbe",
      "date": "3 days ago",
      "rating": 5.0,
      "review":
          "Best coffee in town! The 'Gray Cup - Smoky Espresso' is a bold and flavorful pick-me-up. Can't start my day without it.",
    },
    {
      "name": "Rodolfo Goode",
      "date": "6 days ago",
      "rating": 4.0,
      "review": "A very nice spot, decent coffee.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00B14F);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Rating & Reviews",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Rating Summary Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Average Rating
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "4.8",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(5, (index) {
                        if (index < 4) {
                          return const Icon(
                            Icons.star_rounded,
                            color: Colors.orange,
                            size: 20,
                          );
                        } else {
                          return const Icon(
                            Icons.star_half_rounded,
                            color: Colors.orange,
                            size: 20,
                          );
                        }
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "(2.4k reviews)",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                // Vertical Divider
                Container(width: 1, height: 100, color: Colors.grey.shade200),
                const SizedBox(width: 24),
                // Rating Bars
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildRatingBar(5, 0.85),
                      const SizedBox(height: 6),
                      _buildRatingBar(4, 0.65),
                      const SizedBox(height: 6),
                      _buildRatingBar(3, 0.15),
                      const SizedBox(height: 6),
                      _buildRatingBar(2, 0.20),
                      const SizedBox(height: 6),
                      _buildRatingBar(1, 0.05),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: Color(0xFFEEEEEE)),
            const SizedBox(height: 24),
            // Filter Chips
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilterIndex == index;
                  final label = _filters[index];
                  final isStarFilter = int.tryParse(label) != null;
                  final isSort = index == 0;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilterIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryGreen : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? primaryGreen
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSort)
                            Icon(
                              Icons.swap_vert,
                              size: 18,
                              color: isSelected ? Colors.white : primaryGreen,
                            ),
                          if (isStarFilter)
                            Icon(
                              Icons.star_border_rounded,
                              size: 18,
                              color: isSelected ? Colors.white : primaryGreen,
                            ),
                          if (isSort || isStarFilter) const SizedBox(width: 6),
                          Text(
                            label,
                            style: TextStyle(
                              color: isSelected ? Colors.white : primaryGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // Reviews List
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _reviews.length,
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) {
                final review = _reviews[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          // Placeholder user image
                          backgroundImage: AssetImage(
                            'assets/images/user1.png',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                review['date'],
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.orange,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${review['rating']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.more_horiz,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      review['review'],
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        height: 1.5,
                        fontSize: 14,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar(int stars, double value) {
    return Row(
      children: [
        SizedBox(
          width: 12,
          child: Text(
            "$stars",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: value,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF00B14F),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
