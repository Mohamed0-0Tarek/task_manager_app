import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

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
            Container(
              decoration: BoxDecoration(
                color: Colors.amberAccent,
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
                child: Text("all"),
              ),
            ),
            Container(
              decoration: BoxDecoration(
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
                child: Text("high"),
              ),
            ),
            Container(
              decoration: BoxDecoration(
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
                child: Text("medium"),
              ),
            ),
            Container(
              decoration: BoxDecoration(
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
                child: Text("low"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
