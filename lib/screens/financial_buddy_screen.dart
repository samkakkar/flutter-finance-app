import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinancialBuddyScreen extends StatelessWidget {
  const FinancialBuddyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Match with a Financial Buddy",
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: "Business Starter Kits"),
            InfoCard(
              title: "Start Your Business",
              description:
              "Access checklists, templates, and step-by-step guides to help you set up your business successfully.",
              icon: Icons.business_center_outlined,
            ),
            const SizedBox(height: 16),
            SectionHeader(title: "E-Commerce Integration"),
            InfoCard(
              title: "Sell Online",
              description:
              "Easily create an online store and start selling your products or services directly through the app.",
              icon: Icons.shopping_cart_outlined,
            ),
            const SizedBox(height: 16),
            SectionHeader(title: "Funding Opportunities"),
            InfoCard(
              title: "Explore Funding Options",
              description:
              "Get up-to-date information about grants, loans, and crowdfunding opportunities designed specifically for immigrant women.",
              icon: Icons.attach_money_outlined,
            ),
            const SizedBox(height: 16),
            SectionHeader(title: "Business Analytics Tools"),
            InfoCard(
              title: "Track Your Growth",
              description:
              "Track sales, manage inventory, and monitor growth metrics in a simple, user-friendly dashboard.",
              icon: Icons.analytics_outlined,
            ),
            const SizedBox(height: 16),
            SectionHeader(title: "Success Stories & Inspiration"),
            InfoCard(
              title: "Learn from Success",
              description:
              "Read inspiring stories of women who have successfully built their businesses using the resources available in the app.",
              icon: Icons.star_outlined,
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
      style: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const InfoCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
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
              color: Colors.red,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
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

