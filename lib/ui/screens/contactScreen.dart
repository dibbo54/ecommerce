import 'package:ecommerce/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Contact'),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //   shape: BoxShape.circle,
              //   border: Border.all(
              //     color: primaryColor,
              //     width: 4.0,
              //   ),
              // ),
              child: Image.asset('assets/images/logo.png'),
              // child: const CircleAvatar(
              //   radius: 100,
              //   backgroundImage: AssetImage(
              //     'assets/images/logo.png',
              //   ),
              // ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Crafty Bay',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'craftybay@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              '+8801317734711',
              style: TextStyle(
                fontSize: 16,
                color: primaryColor,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: const [
                Icon(
                  Icons.location_on,
                  color: primaryColor,
                ),
                SizedBox(width: 8.0),
                Text(
                  '123 Main Street, City, Country',
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
