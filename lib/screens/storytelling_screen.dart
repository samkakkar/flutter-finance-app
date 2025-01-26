import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StorytellingScreen extends StatefulWidget {
  const StorytellingScreen({Key? key}) : super(key: key);

  @override
  State<StorytellingScreen> createState() => _StorytellingScreenState();
}

class _StorytellingScreenState extends State<StorytellingScreen> {
  final List<Map<String, dynamic>> _posts = []; // List to store posts
  final TextEditingController _textController = TextEditingController(); // Controller for text input
  String? _imageUrl;

  void _addPost() {
    // Ensure either text or image is provided before adding a post
    if (_textController.text.isNotEmpty || _imageUrl != null) {
      setState(() {
        _posts.insert(0, {
          "text": _textController.text, // Store the entered text
          "image": _imageUrl,           // Store the optional image
          "timestamp": DateTime.now(),  // Store the timestamp
        });
        // Clear the input fields after posting
        _textController.clear();
        _imageUrl = null;
      });
    } else {
      // Show a Snackbar if no content is entered
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter some text or add an image to post."),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _addImage() {
    // Example placeholder for image logic
    setState(() {
      _imageUrl =
      "https://via.placeholder.com/150"; // Replace this with your image picker logic
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Storytelling for Empowerment",
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _PostInputField(
            textController: _textController,
            onAddImage: _addImage,
            onPost: _addPost,
          ),
          const Divider(),
          Expanded(
            child: _posts.isEmpty
                ? Center(
              child: Text(
                "No posts yet. Share your first story!",
                style: GoogleFonts.nunito(fontSize: 16),
              ),
            )
                : ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return _PostCard(
                  text: post["text"],
                  image: post["image"],
                  timestamp: post["timestamp"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PostInputField extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onAddImage;
  final VoidCallback onPost;

  const _PostInputField({
    Key? key,
    required this.textController,
    required this.onAddImage,
    required this.onPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          TextField(
            controller: textController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "What's on your mind?",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: onAddImage,
                icon: const Icon(Icons.image),
                label: const Text("Add Image"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: onPost,
                child: const Text("Post"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final String? text;
  final String? image;
  final DateTime timestamp;

  const _PostCard({
    Key? key,
    required this.text,
    required this.image,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (text != null && text!.isNotEmpty)
              Text(
                text!,
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            if (image != null) const SizedBox(height: 8),
            if (image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  image!,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 8),
            Text(
              "${timestamp.hour}:${timestamp.minute} • ${timestamp.day}/${timestamp.month}/${timestamp.year}",
              style: GoogleFonts.nunito(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
