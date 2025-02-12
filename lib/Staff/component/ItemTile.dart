import 'package:flutter/material.dart';

class ItemListTile extends StatelessWidget {
  final String items;
  final void Function()? onTap;

  const ItemListTile({
    super.key,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Row(
            children: [
              Icon(
                Icons.store,
                color: Colors.blue[900],
              ),
              const SizedBox(width: 12),
              Text(
                items,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,)
              )
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
