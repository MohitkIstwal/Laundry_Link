import 'package:flutter/material.dart';

class StoreTile extends StatelessWidget {
  final String storeName;
  final void Function()? onTap;

  const StoreTile({
    super.key,
    required this.storeName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
         decoration: BoxDecoration(
           color: Colors.grey[200],
           borderRadius: BorderRadius.circular(12),
         ),
         margin: const EdgeInsets.all(10),
         padding: const EdgeInsets.all(12),
         child: Row(
           children: [
             Icon(
               Icons.store,
               color: Colors.blue[900],
             ),
             const SizedBox(width: 12),
             Text(
               storeName,
               style: const TextStyle(
                 color: Colors.black,
                 fontWeight: FontWeight.bold,
               ),
             ),
           ],
         ),
      ),
    );
  }
}
