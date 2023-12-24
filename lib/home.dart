import 'package:flutter/material.dart';
import 'package:Campus_Companion/chat_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void startBot() {
    setState(() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const ChatScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/CCLogo.png'),
            Text(
              'Campus Companion',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                onPressed: startBot,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Lets Chat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
