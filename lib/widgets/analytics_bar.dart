import 'package:flutter/material.dart';

class AnalyticsBar extends StatelessWidget {
  const AnalyticsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 5, color: Color.fromARGB(133, 100, 75, 225)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment(0, 0),

                    child: Text(
                      "Done : 5",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    alignment: Alignment(0, 0),
                    child: Text(
                      "Remains : 5",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "10",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight(20),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
      //Analytics Bar
    );
  }
}
