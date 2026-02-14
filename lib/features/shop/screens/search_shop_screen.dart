import 'package:flutter/material.dart';

class SearchShopScreen extends StatefulWidget {
  const SearchShopScreen({super.key});

  @override
  State<SearchShopScreen> createState() => _SearchShopScreenState();
}

class _SearchShopScreenState extends State<SearchShopScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showResults = false;

  final List<String> _recentSearches = [
    'Caffely Central Park',
    'Caffely Times Square',
    'Caffely Brooklyn Blend',
    'Caffely Broadway Brews',
    'Caffely SoHo Sips',
    'Caffely Chelsea Chai',
    'Caffely Wall Street Beans',
  ];

  final List<Map<String, dynamic>> _searchResults = [
    {
      'name': 'Caffely Astoria Aromas',
      'distance': '1.2 km',
      'location': '350 5th Ave, New York, NY 1...',
      'rating': 4.8,
      'reviews': '2.4k',
    },
    {
      'name': 'Caffely Astoria Whiffs',
      'distance': '3.6 km',
      'location': '4 Pennsylvania Plaza, New...',
      'rating': 4.6,
      'reviews': '2.2k',
    },
    {
      'name': 'Caffely Astoria Grains',
      'distance': '3.8 km',
      'location': 'Central Park West & 79th S...',
      'rating': 4.9,
      'reviews': '1.9k',
    },
    {
      'name': 'Caffely Astoria Brews',
      'distance': '3.9 km',
      'location': 'Chinatown, New York, NY 1...',
      'rating': 4.5,
      'reviews': '1.6k',
    },
    {
      'name': 'Caffely Astoria Quencher',
      'distance': '4.2 km',
      'location': '2300 Southern Blvd, Bronx...',
      'rating': 4.6,
      'reviews': '1.3k',
    },
    {
      'name': 'Caffely Astoria Brewsters',
      'distance': '4.3 km',
      'location': '1260 6th Ave, New York, NY...',
      'rating': 4.8,
      'reviews': '1.8k',
    },
  ];

  void _onSearch(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _showResults = true;
      });
    } else {
      setState(() {
        _showResults = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00B14F);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: _searchController.text.isNotEmpty && !_showResults
                ? Border.all(color: primaryGreen, width: 1)
                : null,
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearch,
            onSubmitted: (value) => _onSearch(value),
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.grey.shade400),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 18,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        _onSearch("");
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        titleSpacing: 0,
        actions: const [SizedBox(width: 20)],
      ),
      body: _showResults ? _buildSearchResults() : _buildRecentSearches(),
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Searches",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20, color: Colors.black54),
                onPressed: () {
                  setState(() {
                    _recentSearches.clear();
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _recentSearches.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                title: Text(
                  _recentSearches[index],
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _recentSearches.removeAt(index);
                    });
                  },
                ),
                onTap: () {
                  _searchController.text = _recentSearches[index];
                  _onSearch(_recentSearches[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    const Color primaryGreen = Color(0xFF00B14F);
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: _searchResults.length,
      separatorBuilder: (context, index) => const Divider(height: 32),
      itemBuilder: (context, index) {
        final shop = _searchResults[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
    );
  }
}
