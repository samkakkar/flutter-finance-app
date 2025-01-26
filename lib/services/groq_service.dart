import 'dart:convert';
import 'package:http/http.dart' as http;

class GroqService {
  final String _baseUrl = "https://api.groq.ai/v1/chat/completions";
  final String _apiKey = "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";

  // Predefined prompts for the chatbot
  final Map<String, String> predefinedQuestions = {
    "hello": "Hi there! How can I assist you today?",
    "give me financial advice":
    "Here’s some advice: Start budgeting your expenses, set financial goals, and save at least 20% of your income regularly.",
    "how do I start investing?":
    "Start by understanding your financial goals. Consider mutual funds, index funds, or stocks, and diversify your investments to reduce risk.",
    "what is financial independence?":
    "Financial independence is when your passive income exceeds your living expenses, allowing you to live without depending on a paycheck.",
    "tell me a motivational quote":
    "Empower your dreams: Financial independence is freedom!",
    "can you help me with my small business idea": "Yes, ofcourse!",
  };

  Future<String?> getChatResponse(String userMessage) async {
    // Check for predefined responses
    final lowerMessage = userMessage.toLowerCase();
    if (predefinedQuestions.containsKey(lowerMessage)) {
      return predefinedQuestions[lowerMessage]; // Return predefined response
    }

    // Otherwise, send the message to Groq API
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_apiKey",
        },
        body: jsonEncode({
          "messages": [
            {"role": "system", "content": "You are a helpful financial assistant."},
            {"role": "user", "content": userMessage},
          ],
          "model": "llama-3.3-70b-versatile",
          "temperature": 0.5,
          "max_completion_tokens": 1024,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["choices"][0]["message"]["content"];
      } else {
        print("Groq API Error: ${response.statusCode}");
        print("Response Body: ${response.body}");
        return "Sorry, I couldn’t process your request. Try again later.";
      }
    } catch (e) {
      print("Error calling Groq API: $e");
      return "An error occurred while connecting to the chatbot.";
    }
  }
}
