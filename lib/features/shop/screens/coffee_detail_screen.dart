import 'package:flutter/material.dart';
import '../../../../common/widgets/share_bottom_sheet.dart';
import '../../orders/screens/checkout_screen.dart';

class CoffeeDetailScreen extends StatefulWidget {
  final String productName;
  final String price;

  const CoffeeDetailScreen({
    super.key,
    required this.productName,
    required this.price,
  });

  @override
  State<CoffeeDetailScreen> createState() => _CoffeeDetailScreenState();
}

class _CoffeeDetailScreenState extends State<CoffeeDetailScreen> {
  int _quantity = 1;
  String _selectedTemp = "Hot";
  String _selectedSize = "Medium";

  // Options
  final List<Map<String, dynamic>> _tempOptions = [
    {"label": "Hot", "icon": Icons.coffee},
    {"label": "Iced", "icon": Icons.local_drink},
  ];

  final List<Map<String, dynamic>> _sizeOptions = [
    {"label": "Tall", "price": "Free", "icon": Icons.local_cafe},
    {"label": "Grande", "price": "+ 0.50", "icon": Icons.local_cafe},
    {"label": "Venti", "price": "+ 1.00", "icon": Icons.local_cafe},
  ];

  // Customization Options
  String? _selectedMilk;
  String? _selectedSyrup;
  String? _selectedTopping;

  final List<Map<String, String>> _milkOptions = [
    {"name": "Whole Milk", "price": "+ \$1.00"},
    {"name": "Skim Milk", "price": "+ \$0.50"},
    {"name": "Soy Milk", "price": "+ \$0.50"},
    {"name": "Almond Milk", "price": "+ \$0.50"},
  ];

  final List<Map<String, String>> _syrupOptions = [
    {"name": "Aren", "price": "+ \$1.00"},
    {"name": "Caramel", "price": "+ \$1.00"},
    {"name": "Hazelnut", "price": "+ \$1.00"},
    {"name": "Pandan", "price": "+ \$1.00"},
    {"name": "Irish", "price": "+ \$1.00"},
  ];

  final List<Map<String, String>> _toppingOptions = [
    {"name": "Cinnamon", "price": "+ \$0.50"},
    {"name": "Nutmeg", "price": "+ \$0.50"},
    {"name": "Cocoa Powder", "price": "+ \$0.50"},
    {"name": "Crumble", "price": "+ \$0.50"},
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00B14F);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) => const ShareBottomSheet(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coffee Image
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Icon(Icons.coffee, size: 120, color: Colors.brown),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title & Quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "\$${widget.price}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      // Quantity Selector
                      // Quantity Selector
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryGreen),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              iconSize: 18,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (_quantity > 1) {
                                  setState(() => _quantity--);
                                }
                              },
                              icon: const Icon(Icons.remove),
                              color: primaryGreen,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "$_quantity",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryGreen),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              iconSize: 18,
                              padding: EdgeInsets.zero,
                              onPressed: () => setState(() => _quantity++),
                              icon: const Icon(Icons.add),
                              color: primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Divider(),

                  // Available in (Hot/Iced)
                  const Text(
                    "Available in",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: _tempOptions.map((temp) {
                      final isSelected = _selectedTemp == temp['label'];
                      return Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedTemp = temp['label']),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? primaryGreen.withOpacity(0.1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? primaryGreen
                                    : Colors.grey.shade300,
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  temp['icon'],
                                  color: isSelected
                                      ? primaryGreen
                                      : Colors.black,
                                  size: 28,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  temp['label'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? primaryGreen
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Size
                  const Text(
                    "Size",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: _sizeOptions.map((size) {
                      final isSelected = _selectedSize == size['label'];
                      return Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedSize = size['label']),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? primaryGreen.withOpacity(0.1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? primaryGreen
                                    : Colors.grey.shade300,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  size['icon'],
                                  color: isSelected
                                      ? primaryGreen
                                      : Colors.grey,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  size['label'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? primaryGreen
                                        : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  size['price'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  const Divider(),

                  // Customizations List
                  CustomizationSection(
                    title: "Milk (Optional)",
                    options: _milkOptions,
                    selectedValue: _selectedMilk,
                    onSelect: (val) {
                      setState(() => _selectedMilk = val);
                    },
                  ),
                  CustomizationSection(
                    title: "Syrup (Optional)",
                    options: _syrupOptions,
                    selectedValue: _selectedSyrup,
                    onSelect: (val) {
                      setState(() => _selectedSyrup = val);
                    },
                  ),
                  CustomizationSection(
                    title: "Topping (Optional)",
                    options: _toppingOptions,
                    selectedValue: _selectedTopping,
                    onSelect: (val) {
                      setState(() => _selectedTopping = val);
                    },
                  ),

                  // Notes
                  const Text(
                    "Notes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Example: No added cream",
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 100), // Space for bottom bar
                ],
              ),
            ),
          ),
          // Bottom Bar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total price", style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 4),
                    Text(
                      "\$6.00",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckoutScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Add to Basket",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomizationSection extends StatefulWidget {
  final String title;
  final List<Map<String, String>> options;
  final String? selectedValue;
  final Function(String?) onSelect;

  const CustomizationSection({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onSelect,
  });

  @override
  State<CustomizationSection> createState() => _CustomizationSectionState();
}

class _CustomizationSectionState extends State<CustomizationSection> {
  bool _isExpanded = true;
  final Color primaryGreen = const Color(0xFF00B14F);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Max 1",
                    style: TextStyle(
                      color: primaryGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: primaryGreen,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: 12),
          ...widget.options.map((option) {
            final isSelected = widget.selectedValue == option['name'];
            return GestureDetector(
              onTap: () => widget.onSelect(isSelected ? null : option['name']),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.transparent)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        option['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      option['price']!,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: isSelected ? primaryGreen : Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
        const SizedBox(height: 24),
      ],
    );
  }
}
