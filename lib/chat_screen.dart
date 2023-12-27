import 'package:flutter/material.dart';
import 'package:Campus_Companion/models/chat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:linkable/linkable.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  String botURL = 'https://above-rationally-lionfish.ngrok-free.app/chatbot';
  List<Chat> messages = [
    Chat(message: 'Hello, Welcome', isBot: true),
    Chat(message: 'What do you want to know?', isBot: true),
  ];
  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(botURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_message': message}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['response'];
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  void addMessage(String message) async {
    setState(() {
      messages.add(Chat(message: message, isBot: false));
    });

    try {
      final botResponse = await sendMessage(message);
      setState(() {
        messages.add(Chat(message: botResponse, isBot: true));
      });
    } catch (e) {
      setState(() {
        messages.add(Chat(message: 'Error: $e', isBot: true));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Companion'),
      ),
      body: Center(
        child: Column(
          children: [
            if (messages.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: messages[index].isBot
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: messages[index].isBot
                              ? const Color.fromARGB(255, 197, 234, 237)
                              : const Color.fromARGB(255, 198, 241, 203),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Linkable(
                          text: messages[index].message,
                        ),
                      ),
                    );
                  },
                ),
              ),
            const Divider(height: 1),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Ask me something...',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_controller.text.trim().isNotEmpty) {
                          addMessage(_controller.text);
                          _controller.clear();
                        }
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
