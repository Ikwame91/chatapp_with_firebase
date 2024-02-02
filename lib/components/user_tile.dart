import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.text, this.onTap});
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Expanded(
          flex: 1,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.black38,
                  size: 40,
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).colorScheme.primary),
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          text,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
