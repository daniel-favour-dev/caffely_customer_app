import 'package:flutter/material.dart';

class PaymentMethodSelectionScreen extends StatefulWidget {
  const PaymentMethodSelectionScreen({super.key});

  @override
  State<PaymentMethodSelectionScreen> createState() =>
      _PaymentMethodSelectionScreenState();
}

class _PaymentMethodSelectionScreenState
    extends State<PaymentMethodSelectionScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      "name": "My Wallet",
      "balance": "\$948.50",
      "icon": Icons.account_balance_wallet,
      "color": Color(0xFF00B14F),
      "isWallet": true,
    },
    {
      "name": "PayPal",
      "icon": Icons.payment, // Placeholder for PayPal
      "color": Colors.blue,
      "isWallet": false,
    },
    {
      "name": "Google Pay",
      "icon": Icons.g_mobiledata, // Placeholder for Google Pay
      "color": Colors.transparent, // Uses generic icon
      "isWallet": false,
    },
    {
      "name": "Apple Pay",
      "icon": Icons.apple,
      "color": Colors.black,
      "isWallet": false,
    },
    {
      "name": ".... .... .... 4679",
      "icon": Icons.credit_card, // Mastercard
      "color": Colors.orange,
      "isWallet": false,
      "brand": "Mastercard",
    },
    {
      "name": ".... .... .... 5567",
      "icon": Icons.credit_card, // Visa
      "color": Colors.blue.shade900,
      "isWallet": false,
      "brand": "VISA",
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
          "Choose Payment Method",
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
              itemCount: _paymentMethods.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final method = _paymentMethods[index];
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
                        // Icon
                        Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          child: method['isWallet'] == true
                              ? Icon(
                                  method['icon'],
                                  color: method['color'],
                                  size: 28,
                                )
                              : method['brand'] != null
                              ? Icon(
                                  method['icon'],
                                  color: method['color'],
                                  size: 28,
                                )
                              : Icon(
                                  method['icon'],
                                  color: method['color'] == Colors.transparent
                                      ? Colors.black
                                      : method['color'],
                                  size: 28,
                                ),
                        ),
                        const SizedBox(width: 16),
                        // Name & Balance
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                method['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              if (method['balance'] != null)
                                Text(
                                  method['balance'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryGreen,
                                    fontSize: 16,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // Checkmark if selected
                        if (isSelected) ...[
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.check,
                            color: primaryGreen,
                            size: 24,
                          ),
                        ],
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
