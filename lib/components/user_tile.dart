import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.text, this.onTap});
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          padding: const EdgeInsets.all(25),
          child: Row(
            children: [
              const Icon(Icons.person),
              const SizedBox(
                width: 18,
              ),
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
}
