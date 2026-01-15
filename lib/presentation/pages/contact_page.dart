import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html show window;

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendEmail() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final message = _messageController.text;
    
    final mailtoLink = 'mailto:olivercheruiyot09@gmail.com?subject=Portfolio Contact from $name&body=From: $name ($email)%0A%0A$message';
    
    if (kIsWeb) {
      html.window.open(mailtoLink, '_blank');
    } else {
      final Uri emailUri = Uri.parse(mailtoLink);
      try {
        if (await canLaunchUrl(emailUri)) {
          await launchUrl(emailUri, mode: LaunchMode.platformDefault);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not open email client')),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              const Text(
                "GET IN TOUCH",
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, letterSpacing: -1),
              ),
              const SizedBox(height: 10),
              const Text("Have a project in mind? Let's build something amazing together.",
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
              const SizedBox(height: 50),

              // Glassmorphic Contact Card
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 800,
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Form Section
                        Expanded(flex: 3, child: _buildContactForm()),
                        const SizedBox(width: 40),
                        // Socials Section
                        Expanded(flex: 2, child: _buildSocialSection()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildContactForm() {
    return Column(
      children: [
        _buildTextField("Full Name", Icons.person_outline, _nameController),
        const SizedBox(height: 20),
        _buildTextField("Email Address", Icons.email_outlined, _emailController),
        const SizedBox(height: 20),
        _buildTextField("Message", Icons.message_outlined, _messageController, maxLines: 5),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: _sendEmail,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4EE3C0),
              foregroundColor: const Color(0xFF1A2B4C),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text("SEND MESSAGE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String hint, IconData icon, TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
      ),
    );
  }

  Widget _buildSocialSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("CONNECT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 25),
        _socialTile(Icons.link, "LinkedIn", "oliver-cheruiyot"),
        _socialTile(Icons.code, "GitHub", "@Oliver9105"),
        _socialTile(Icons.alternate_email, "Email", "olivercheruiyot09@gmail.com"),
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1A2B4C).withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Column(
            children: [
              Icon(Icons.location_on_outlined, color: Color(0xFF1A2B4C)),
              SizedBox(height: 10),
              Text("Based in Kenya", style: TextStyle(fontWeight: FontWeight.w500)),
              Text("Available for remote work", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        )
      ],
    );
  }

  Widget _socialTile(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF1A2B4C),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}