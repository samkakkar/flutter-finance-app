import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const SavingsApp());
}

class SavingsApp extends StatelessWidget {
  const SavingsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      home: const SavingsPage(),
    );
  }
}

class SavingsPage extends StatelessWidget {
  const SavingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Savings Page"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: "Goal-Based Savings"),
            SavingsCard(
              title: "Set Financial Goals",
              description:
              "Set clear financial goals—whether it’s saving for your child’s education, starting a business, or building an emergency fund—and track your progress.",
              icon: Icons.flag_outlined,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const VisaFriendlySavingPlansScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const SectionHeader(title: "Savings Calculator"),
            SavingsCard(
              title: "Plan Your Savings",
              description:
              "Use our intuitive calculator to figure out how much you need to save each month to reach your targets.",
              icon: Icons.calculate_outlined,
              onPressed: () {
                // Add navigation or action
                print("Navigate to Savings Calculator");
              },
            ),
            const SizedBox(height: 16),
            const SectionHeader(title: "Financial Tips"),
            SavingsCard(
              title: "Practical Advice",
              description:
              "Receive practical advice on budgeting, reducing unnecessary expenses, and creating a savings habit that lasts.",
              icon: Icons.lightbulb_outline,
              onPressed: () {
                // Add navigation or action
                print("Navigate to Financial Tips");
              },
            ),
            const SizedBox(height: 16),
            const SectionHeader(title: "Mock Investing"),
            SavingsCard(
              title: "Practice Virtual Investing",
              description:
              "Simulate stock trading with virtual money to learn and practice investing in a risk-free environment.",
              icon: Icons.show_chart,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MockInvestingPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SavingsCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;

  const SavingsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.blue,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text("Learn More"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VisaFriendlySavingPlansScreen extends StatelessWidget {
  const VisaFriendlySavingPlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Visa Friendly Saving Plans",
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Details about Visa Friendly Saving Plans go here...",
          style: GoogleFonts.nunito(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}


class MockInvestingPage extends StatefulWidget {
  @override
  _MockInvestingPageState createState() => _MockInvestingPageState();
}

class _MockInvestingPageState extends State<MockInvestingPage> {
  double virtualBalance = 10000.0; // Starting virtual balance
  List<Map<String, dynamic>> portfolio = []; // Portfolio to store investments
  List<Map<String, dynamic>> transactionHistory = []; // Mock transactions
  final List<Map<String, dynamic>> stockList = [
    {"name": "Apple", "symbol": "AAPL", "price": 150.0},
    {"name": "Google", "symbol": "GOOGL", "price": 2800.0},
    {"name": "Amazon", "symbol": "AMZN", "price": 3300.0},
    {"name": "Tesla", "symbol": "TSLA", "price": 700.0},
    {"name": "Microsoft", "symbol": "MSFT", "price": 300.0},
  ]; // Mock stock data

  String searchQuery = "";

  void buyStock(String stockName, double price, int quantity) {
    setState(() {
      double totalCost = price * quantity;
      if (virtualBalance >= totalCost) {
        virtualBalance -= totalCost;

        // Check if stock already exists in portfolio
        int existingIndex =
        portfolio.indexWhere((stock) => stock["name"] == stockName);
        if (existingIndex != -1) {
          portfolio[existingIndex]["quantity"] += quantity;
        } else {
          portfolio.add({"name": stockName, "price": price, "quantity": quantity});
        }

        transactionHistory.add({
          "type": "Buy",
          "stockName": stockName,
          "price": price,
          "quantity": quantity,
          "date": DateTime.now(),
        });
      }
    });
  }

  void sellStock(int index) {
    setState(() {
      final stock = portfolio[index];
      double totalValue = stock["price"] * stock["quantity"];
      virtualBalance += totalValue;

      transactionHistory.add({
        "type": "Sell",
        "stockName": stock["name"],
        "price": stock["price"],
        "quantity": stock["quantity"],
        "date": DateTime.now(),
      });

      portfolio.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredStockList = stockList
        .where((stock) =>
    stock["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        stock["symbol"].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mock Investing"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Virtual Balance
            Text(
              "Virtual Balance: \$${virtualBalance.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Stock Search
            TextField(
              decoration: const InputDecoration(
                labelText: "Search for a stock (e.g., AAPL, Tesla)",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Stock List
            Expanded(
              child: ListView.builder(
                itemCount: filteredStockList.length,
                itemBuilder: (context, index) {
                  final stock = filteredStockList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text("${stock["name"]} (${stock["symbol"]})"),
                      subtitle: Text("Price: \$${stock["price"].toStringAsFixed(2)}"),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Mock buying 1 share
                          buyStock(stock["name"], stock["price"], 1);
                        },
                        child: const Text("Buy"),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Portfolio Section
            const Text(
              "Your Portfolio:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            portfolio.isEmpty
                ? const Text("No investments yet.")
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: portfolio.length,
              itemBuilder: (context, index) {
                final stock = portfolio[index];
                return Card(
                  child: ListTile(
                    title: Text("${stock["name"]}"),
                    subtitle: Text(
                        "Quantity: ${stock["quantity"]} | Price: \$${stock["price"].toStringAsFixed(2)}"),
                    trailing: ElevatedButton(
                      onPressed: () => sellStock(index),
                      child: const Text("Sell"),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Transaction History
            const Text(
              "Transaction History:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            transactionHistory.isEmpty
                ? const Text("No transactions yet.")
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactionHistory.length,
              itemBuilder: (context, index) {
                final transaction = transactionHistory[index];
                return Card(
                  child: ListTile(
                    title: Text(transaction["type"]),
                    subtitle: Text(
                        "${transaction["stockName"]} | Quantity: ${transaction["quantity"]} | Price: \$${transaction["price"].toStringAsFixed(2)}"),
                    trailing: Text(
                      transaction["date"].toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
