import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/groq_service.dart';
import '../data/models/transaction.dart';
import '../data/models/wallet.dart';
import 'visa_friendly_saving_plans.dart';
import 'bootcamp_screen.dart';
import 'storytelling_screen.dart';
import 'support_small_business_screen.dart';
import 'financial_buddy_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dropdown options
  final List<String> dropdownOptions = [
    'Saving',
    'Financial Independence Bootcamp',
    'Story Feed',
    'Small Business',
    'Mentor Matching',
  ];

  // AI Lakshmi Chat state
  bool isChatOpen = false;
  final TextEditingController _chatController = TextEditingController();
  final GroqService _groqService = GroqService();
  List<Map<String, String>> chatMessages = [];
  bool isLoadingResponse = false;

  // Footer quotes
  final List<String> quotes = [
    "Empower your dreams: Financial independence is freedom!",
    "Every rupee saved is a step closer to independence.",
    "Your money, your rules, your future.",
    "Financial independence begins with small steps.",
    "Invest in yourself: You're worth it.",
  ];
  int currentQuoteIndex = 0;

  // Timer for cycling quotes
  Timer? _quoteTimer;

  @override
  void initState() {
    super.initState();
    _startQuoteTimer();
  }

  @override
  void dispose() {
    _quoteTimer?.cancel();
    super.dispose();
  }

  // Start the timer for cycling quotes
  void _startQuoteTimer() {
    _quoteTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        currentQuoteIndex = (currentQuoteIndex + 1) % quotes.length;
      });
    });
  }

  // Toggle AI Lakshmi Chat visibility
  void toggleChat() {
    setState(() {
      isChatOpen = !isChatOpen;
    });
  }

  // Navigate based on dropdown selection
  void navigateToOption(String selectedOption) {
    switch (selectedOption) {
      case 'Saving':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SavingsApp()),
        );
        break;
      case 'Financial Independence Bootcamp':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BootcampScreen()),
        );
        break;
      case 'Story Feed':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StorytellingScreen()),
        );
        break;
      case 'Small Business':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SupportSmallBusinessScreen()),
        );
        break;
      case 'Mentor Matching':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FinancialBuddyScreen()),
        );
        break;
      default:
        print("Unknown option selected: $selectedOption");
        break;
    }
  }

  // Send message to AI Lakshmi
  void sendMessage() async {
    final userMessage = _chatController.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      chatMessages.add({"sender": "user", "message": userMessage});
      isLoadingResponse = true;
    });

    _chatController.clear();

    // Get the response from GroqService
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
        backgroundColor: Colors.red,
        elevation: 0,
        title: Text(
          "Invest Sakhi",
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu, color: Colors.white),
          onSelected: navigateToOption,
          itemBuilder: (context) {
            return dropdownOptions.map((String option) {
              return PopupMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleChat,
        backgroundColor: Colors.red,
        child: const Icon(Icons.message, color: Colors.white),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    // Welcome Text
                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 8, bottom: 16),
                      child: Text(
                        "Hi, Mala",
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // Last Transactions Section
                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Last Transactions",
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "See All",
                            style: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Transactions List
                    Container(
                      height: 190,
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            height: 190,
                            width: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x04000000),
                                  spreadRadius: 10,
                                  blurRadius: 10,
                                  offset: Offset(0.0, 8.0),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 16,
                                  top: 16,
                                  child: Image.asset(
                                    transactions[index].icon,
                                    height: 18,
                                    width: 18,
                                    color: transactions[index].iconColor,
                                  ),
                                ),
                                Positioned(
                                  top: 16,
                                  right: 16,
                                  child: Text(
                                    transactions[index].inOrOut,
                                    style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: transactions[index].iconColor,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 64,
                                  left: 16,
                                  child: Text(
                                    transactions[index].balance,
                                    style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: transactions[index].iconColor,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  top: 106,
                                  child: Text(
                                    transactions[index].description,
                                    style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  bottom: 48,
                                  child: Text(
                                    transactions[index].recipient,
                                    style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  bottom: 22,
                                  child: Text(
                                    transactions[index].date,
                                    style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 14,
                                  bottom: 16,
                                  child: Image.asset(
                                    transactions[index].type,
                                    width: 33,
                                    height: 33,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Send Money Section
                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
                      child: Text(
                        "Send Money",
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // Wallets List
                    Container(
                      height: 300,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        itemCount: wallets.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x04000000),
                                  spreadRadius: 10,
                                  blurRadius: 10,
                                  offset: Offset(0.0, 8.0),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 12),
                                    Container(
                                      height: 44,
                                      width: 44,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Image.asset(wallets[index].logo),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          wallets[index].name,
                                          style: GoogleFonts.nunito(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          wallets[index].wallet,
                                          style: GoogleFonts.nunito(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      wallets[index].number,
                                      style: GoogleFonts.nunito(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Footer Section: Cycling Quotes
              Container(
                width: double.infinity,
                color: Colors.red[50],
                padding: const EdgeInsets.all(16),
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Text(
                    quotes[currentQuoteIndex],
                    key: ValueKey(currentQuoteIndex),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // AI Lakshmi Chat Popup
          if (isChatOpen)
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "AI Lakshmi",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: toggleChat,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: chatMessages.length,
                        itemBuilder: (context, index) {
                          final chat = chatMessages[index];
                          final isUser = chat["sender"] == "user";
                          return Align(
                            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: isUser ? Colors.red : Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                chat["message"]!,
                                style: TextStyle(
                                  color: isUser ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (isLoadingResponse)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _chatController,
                              decoration: const InputDecoration(
                                hintText: "Type your message...",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: isLoadingResponse ? null : sendMessage,
                            child: const Text("Send"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
