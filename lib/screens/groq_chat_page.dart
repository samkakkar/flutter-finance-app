import 'package:flutter/material.dart';
import '../services/groq_service.dart'; // Ensure the correct import path

class GroqChatPage extends StatefulWidget {
  const GroqChatPage({Key? key}) : super(key: key);

  @override
  _GroqChatPageState createState() => _GroqChatPageState();
}

class _GroqChatPageState extends State<GroqChatPage> {
  final GroqService _groqService = GroqService();
  final TextEditingController _chatController = TextEditingController();
  List<Map<String, String>> chatMessages = [];
  bool isLoadingResponse = false;

  void sendMessage() async {
    final userMessage = _chatController.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      chatMessages.add({"sender": "user", "message": userMessage});
      isLoadingResponse = true;
    });

    _chatController.clear();

    // Correct method call
    final botResponse = await _groqService.getChatResponse(userMessage);

    setState(() {
      chatMessages.add({"sender": "bot", "message": botResponse ?? "No response available."});
      isLoadingResponse = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Groq Chat"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                final isUser = message["sender"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      message["message"] ?? "",
                      style: TextStyle(color: isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          if (isLoadingResponse) const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: const InputDecoration(hintText: "Type a message"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
