import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BootcampScreen extends StatelessWidget {
  const BootcampScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Financial Independence Bootcamp",
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
            SectionHeader(title: "Workshops & Tutorials"),
            InfoCard(
              title: "Interactive Sessions",
              description:
              "Interactive sessions on budgeting, debt management, investing basics, and credit building.",
              icon: Icons.work_outline,
            ),
            const SizedBox(height: 16),
            SectionHeader(title: "Step-by-Step Guidance"),
            InfoCard(
              title: "Build a Financial Foundation",
              description:
              "Walk through every aspect of creating a solid financial foundation, with easy-to-follow lessons and hands-on activities.",
              icon: Icons.directions_walk, // Fixed icon
            ),
            const SizedBox(height: 16),
            SectionHeader(title: "Interactive Quizzes & Progress Tracking"),
            InfoCard(
              title: "Track Your Progress",
              description:
              "Check your understanding after every module and earn badges as you advance through the program.",
              icon: Icons.quiz_outlined,
            ),
            const SizedBox(height: 16),
            SectionHeader(title: "Success Stories"),
            InfoCard(
              title: "Inspiration & Confidence",
              description:
              "Gain inspiration and confidence from stories of women who used these skills to achieve financial freedom.",
              icon: Icons.star_outline,
            ),
            const SizedBox(height: 16),
            SectionHeader(title: "Certificate of Completion"),
            InfoCard(
              title: "Mark Your Achievement",
              description:
              "Receive a certificate after completing the bootcamp to celebrate your success.",
              icon: Icons.school_outlined,
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
