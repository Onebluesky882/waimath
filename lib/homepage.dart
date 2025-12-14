import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          FilledButton(
            onPressed: () {
              context.go('/login');
            },
            child: const Text('Filled'),
          ),
        ],
      ),
    );
  }
}
