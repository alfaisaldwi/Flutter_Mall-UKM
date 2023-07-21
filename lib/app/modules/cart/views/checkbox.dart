import 'package:flutter/material.dart';

class CheckboxTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CheckboxTile({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
