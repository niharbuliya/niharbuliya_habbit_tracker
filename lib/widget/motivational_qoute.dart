import 'package:flutter/material.dart';
import 'package:niharbuliya_habbit_tracker/widget/api_service.dart';

class MotivationalQuote extends StatelessWidget {
  const MotivationalQuote({super.key});

  Future<void> fetchAndDisplayQuote(BuildContext context) async {
    try {
      final randomQuote = await ApiService().fetchRandomQuote();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(randomQuote['author']),
            content: Text(randomQuote['quote']),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching quote: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () => fetchAndDisplayQuote(context),
          child: const Text('Daily Quote'),
        ),
      ),
    );
  }
}
