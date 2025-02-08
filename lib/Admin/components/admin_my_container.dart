import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final String text;
  final String text2;

  const MyContainer({
    super.key,
    required this.text,
    required this.text2
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$text : $text2",
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                )
            )
          ],
        ),
      ),
    );
  }
}
