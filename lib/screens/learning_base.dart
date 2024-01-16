import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LearningBasePage extends StatelessWidget {
  const LearningBasePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Learning Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This is the AR Learning Page',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Open the AR link
                const url = 'https://arloopa.page.link/MViinvCcx8gj12Am6';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: const Text('Open AR Feature'),
            ),
          ],
        ),
      ),
    );
  }
}
