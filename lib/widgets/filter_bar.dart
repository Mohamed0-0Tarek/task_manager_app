import 'package:flutter/material.dart';
import 'package:task_manager_app/utils/enums.dart';

class FilterBar extends StatefulWidget {
  final PriorityValues? selectedPriority;
  final Function (PriorityValues?)onChange;
  const FilterBar({
    super.key,
    required this.selectedPriority,
    required this.onChange,
  });

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  Widget filterRadioButton(PriorityValues? priority, String text) {
    return InkWell(
      onTap: () {
        widget.onChange(priority);
      },
      child: Container(
        decoration: BoxDecoration(
          color: (widget.selectedPriority == priority)
              ? Colors.amberAccent
              : Colors.transparent,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsetsGeometry.directional(
            start: 20,
            end: 20,
            top: 8,
            bottom: 8,
          ),
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 5, color: Color.fromARGB(133, 100, 75, 225)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterRadioButton(null, "All"),
            filterRadioButton(PriorityValues.high, "High"),
            filterRadioButton(PriorityValues.medium, "Medium"),
            filterRadioButton(PriorityValues.low, "Low"),
          ],
        ),
      ),
    );
  }
}
