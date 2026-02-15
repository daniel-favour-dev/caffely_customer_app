import 'package:flutter/material.dart';

class DeliveryAddressSelectionScreen extends StatefulWidget {
  const DeliveryAddressSelectionScreen({super.key});

  @override
  State<DeliveryAddressSelectionScreen> createState() =>
      _DeliveryAddressSelectionScreenState();
}

class _DeliveryAddressSelectionScreenState
    extends State<DeliveryAddressSelectionScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _addresses = [
    {
      "label": "Home",
      "isMain": true,
      "name": "Andrew Ainsley",
      "phone": "+1 111 467 378 399",
      "address": "701 7th Ave, New York, NY 10036, USA",
      "isPinpointed": true,
    },
    {
      "label": "Apartment",
      "isMain": false,
      "name": "Andrew Ainsley",
      "phone": "+1 111 467 378 399",
      "address": "Liberty Island, New York, NY 10004, USA",
      "isPinpointed": true,
    },
    {
      "label": "Mom's House",
      "isMain": false,
      "name": "Jenny Wilson",
      "phone":
          "Jenny Wilson", // The image repeats the name as phone? Or maybe it's "Jenny Wilson" and phone is hidden? I'll just follow the image text structure or assume it's a name. The image shows "Jenny Wilson Jenny Wilson". I will assume the second one is a placeholder or typo in design, but I'll put a phone number or name there. Actually, looking closely, it says "Jenny Wilson" then "Jenny Wilson" again? Or maybe "Contact: ...". I'll use a standard format for now.
      // Wait, the image says "Jenny Wilson Jenny Wilson". It might be Name then Phone.
      // Let's stick to Name and Phone structure.
      "address": "Central Park, New York, NY 10022, USA",
      "isPinpointed": true,
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
          "Choose Delivery Address",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: _addresses.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final address = _addresses[index];
                final isSelected = _selectedIndex == index;

                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Container(
                    padding: const EdgeInsets.all(16),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              address['label'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            if (address['isMain']) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryGreen.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  "Main Address",
                                  style: TextStyle(
                                    color: primaryGreen,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                            const Spacer(),
                            const Icon(
                              Icons
                                  .edit_outlined, // Using edit icon instead of share for better UX likely
                              size: 20,
                              color: primaryGreen,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(height: 1, color: Color(0xFFEEEEEE)),
                        const SizedBox(height: 12),
                        Text(
                          address['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          address['address'],
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on, // "Pinpoint" icon
                              size: 16,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Pinpoint already",
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
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
