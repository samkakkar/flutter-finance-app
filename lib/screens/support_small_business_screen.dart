import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportSmallBusinessScreen extends StatelessWidget {
  const SupportSmallBusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Support Small Businesses",
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
            SectionHeader(title: "Themed Groups"),
            InfoCard(
              title: "Tailored Support",
              description:
              "Participate in groups tailored to your needs, such as finance, entrepreneurship, visa-related challenges, or small business strategies.",
              icon: Icons.group_outlined,
            ),
            const SizedBox(height: 16),
            SectionHeader(title: "Real-Time Discussions"),
            InfoCard(
              title: "Engage in Live Q&A",
              description:
              "Engage in live Q&A sessions with financial experts, entrepreneurs, and peers to get your questions answered in real-time.",
              icon: Icons.chat_bubble_outline,
            ),
            const SizedBox(height: 16),
            SectionHeader(title: "Support Network"),
            InfoCard(
              title: "A Community That Understands",
              description:
              "Share your challenges and celebrate your wins with a group of women who understand and support your journey.",
              icon: Icons.support_agent_outlined,
            ),
            const SizedBox(height: 16),
            SectionHeader(title: "Privacy Controls"),
            InfoCard(
              title: "Your Privacy Matters",
              description:
              "Choose how much you want to share, ensuring a safe and comfortable environment for all users.",
              icon: Icons.privacy_tip_outlined,
            ),
            const SizedBox(height: 16),
            SectionHeader(title: "Resource Sharing"),
            InfoCard(
              title: "Tools for Success",
              description:
              "Group members can share tips, tools, and resources to help everyone succeed in their small business journey.",
              icon: Icons.share_outlined,
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
