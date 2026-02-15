import 'package:flutter/material.dart';

class DeliveryServiceSelectionScreen extends StatefulWidget {
  const DeliveryServiceSelectionScreen({super.key});

  @override
  State<DeliveryServiceSelectionScreen> createState() =>
      _DeliveryServiceSelectionScreenState();
}

class _DeliveryServiceSelectionScreenState
    extends State<DeliveryServiceSelectionScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _services = [
    {
      "name": "DoorDash Drive",
      "price": "\$1.00",
      "image": "assets/logos/doordash.png", // Need placeholder or icon
      "color": Colors.red,
    },
    {
      "name": "Chowbus",
      "price": "\$1.50",
      "image": "assets/logos/chowbus.png",
      "color": Colors.pink,
    },
    {
      "name": "Rapidus",
      "price": "\$0.80",
      "image": "assets/logos/rapidus.png",
      "color": Colors.black,
    },
    {
      "name": "Roadie",
      "price": "\$1.00",
      "image": "assets/logos/roadie.png",
      "color": Colors.teal,
    },
    {
      "name": "Zifty",
      "price": "\$1.25",
      "image": "assets/logos/zifty.png",
      "color": Colors.greenAccent,
    },
    {
      "name": "Caviar",
      "price": "\$1.00",
      "image": "assets/logos/caviar.png",
      "color": Colors.orange,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Choose Delivery Service",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: _services.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final service = _services[index];
                final isSelected = _selectedIndex == index;

                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: isSelected
                            ? primaryGreen
                            : const Color(0xFFEEEEEE),
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        if (!isSelected)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Icon/Logo Placeholder
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: service['color'],
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.delivery_dining,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Name & Price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              service['price'],
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (isSelected)
                          const Icon(
                            Icons.check,
                            color: primaryGreen,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
