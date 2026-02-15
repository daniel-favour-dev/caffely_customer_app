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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Rating Summary
            Row(
              children: [
                Column(
                  children: [
                    const Text(
                      "4.8",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(5, (index) {
                        return const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "(2.4k reviews)",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                // Progress Bars
                Expanded(
                  child: Column(
                    children: [
                      _buildRatingBar(5, 0.9),
                      _buildRatingBar(4, 0.7),
                      _buildRatingBar(3, 0.1),
                      _buildRatingBar(2, 0.1),
                      _buildRatingBar(1, 0.05),
                    ],
                  ),
                ),
              ],
            ),
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
                  // If it's a number, append a star icon
                  final isStarFilter = int.tryParse(label) != null;

                  return ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (index == 0)
                          const Icon(Icons.sort, size: 16, color: Colors.black),
                        if (index == 0) const SizedBox(width: 4),
                        if (isStarFilter)
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                        if (isStarFilter) const SizedBox(width: 4),
                        Text(
                          label,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilterIndex = index;
                      });
                    },
                    selectedColor: primaryGreen,
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: isSelected ? primaryGreen : Colors.grey.shade300,
                      ),
                    ),
                    showCheckmark: false,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
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
                          backgroundImage: AssetImage(
                            'assets/images/user1.png',
                          ), // Placeholder
                          backgroundColor: Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              review['date'],
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            for (int i = 0; i < 5; i++)
                              Icon(
                                i < (review['rating'] as double).ceil()
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 16,
                                color: Colors.amber,
                              ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.more_vert,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      review['review'],
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        height: 1.5,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(
            width: 12,
            child: Text(
              "$stars",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.grey.shade200,
                color: const Color(0xFF00B14F),
                minHeight: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
