import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const CustomTimePicker({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late int _selectedHour;
  late int _selectedMinute;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.initialTime.hour;
    _selectedMinute = widget.initialTime.minute;
    _hourController = FixedExtentScrollController(initialItem: _selectedHour);
    _minuteController = FixedExtentScrollController(
      initialItem: _selectedMinute,
    );
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  void _onHourChanged(int index) {
    setState(() {
      _selectedHour = index;
    });
    HapticFeedback.selectionClick();
    widget.onTimeChanged(
      TimeOfDay(hour: _selectedHour, minute: _selectedMinute),
    );
  }

  void _onMinuteChanged(int index) {
    setState(() {
      _selectedMinute = index;
    });
    HapticFeedback.selectionClick();
    widget.onTimeChanged(
      TimeOfDay(hour: _selectedHour, minute: _selectedMinute),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // Height of the picker
      child: Stack(
        children: [
          // Center Highlight Overlay
          Center(
            child: Container(
              height: 50, // Fixed extent height matches itemExtent
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50, // Light background strip
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          // Colon in the center
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text(
                ":",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // Wheels
          Row(
            children: [
              // Hours Wheel
              Expanded(
                child: _buildWheel(
                  controller: _hourController,
                  itemCount: 24,
                  selectedItem: _selectedHour,
                  onChanged: _onHourChanged,
                  formatLabel: (index) => index.toString().padLeft(2, '0'),
                ),
              ),
              // Minutes Wheel
              Expanded(
                child: _buildWheel(
                  controller: _minuteController,
                  itemCount: 60,
                  selectedItem: _selectedMinute,
                  onChanged: _onMinuteChanged,
                  formatLabel: (index) => index.toString().padLeft(2, '0'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWheel({
    required FixedExtentScrollController controller,
    required int itemCount,
    required int selectedItem,
    required ValueChanged<int> onChanged,
    required String Function(int) formatLabel,
  }) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: 50, // Height of each item
      perspective: 0.005, // Cylindrical effect
      diameterRatio: 1.2,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: onChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: itemCount,
        builder: (context, index) {
          final isSelected = index == selectedItem;
          return Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: isSelected ? 24 : 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.black : Colors.grey.shade400,
              ),
              child: Text(formatLabel(index)),
            ),
          );
        },
      ),
    );
  }
}
