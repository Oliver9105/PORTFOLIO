import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ABOUT ME",
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, letterSpacing: -1),
            ),
            const SizedBox(height: 40),
            
            // Main Profile Layout
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column 1: Avatar & Quick Info
                Expanded(
                  flex: 2,
                  child: _buildBioSection(),
                ),
                const SizedBox(width: 60),
                // Column 2: Skills & Experience
                Expanded(
                  flex: 3,
                  child: _buildSkillsSection(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [Color(0xFF4EE3C0), Color(0xFF2B5876)]),
          ),
          child: const CircleAvatar(
            radius: 100,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/Untitled.jpeg'),
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          "Software Developer",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A2B4C)),
        ),
        const SizedBox(height: 15),
        const Text(
          "Passionate software developer with expertise in full-stack development. Skilled in building scalable applications using modern technologies and frameworks.",
          style: TextStyle(fontSize: 16, color: Colors.black54, height: 1.6),
        ),
        const SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.download_rounded),
          label: const Text("DOWNLOAD CV"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A2B4C),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("MY TECH STACK", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildSkillChip("React.js"),
            _buildSkillChip("Angular.js"),
            _buildSkillChip("HTML5"),
            _buildSkillChip("CSS3"),
            _buildSkillChip("Python (Flask)"),
            _buildSkillChip("RESTful APIs"),
            _buildSkillChip("PostgreSQL"),
            _buildSkillChip("MySQL"),
            _buildSkillChip("Git"),
            _buildSkillChip("VS Code"),
            _buildSkillChip("Agile"),
          ],
        ),
        const SizedBox(height: 50),
        const Text("EXPERIENCE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 20),
        _buildExperienceTile("Software Engineering Student", "Moringa School", "2024"),
      ],
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF2B5876), Color(0xFF4E4376)]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildExperienceTile(String role, String company, String date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          const Icon(Icons.work_outline, color: Color(0xFF4EE3C0)),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(role, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("$company • $date", style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}