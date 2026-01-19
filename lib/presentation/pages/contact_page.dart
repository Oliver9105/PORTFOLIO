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

  void _launchUrl(String url) async {
    if (url.startsWith('mailto:')) {
      _sendEmailDirect(url.replaceFirst('mailto:', ''));
      return;
    }
    
    if (kIsWeb) {
      html.window.open(url, '_blank');
    } else {
      final Uri uri = Uri.parse(url);
      try {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open link: $e')),
          );
        }
      }
    }
  }

  void _sendEmailDirect(String email) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email: $email'),
          action: SnackBarAction(
            label: 'Copy',
            onPressed: () {
              // Copy email to clipboard functionality can be added here
            },
          ),
        ),
      );
    }
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
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        bool isWide = constraints.maxWidth > 600;
                        return isWide 
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 2, child: _buildContactForm()),
                                const SizedBox(width: 40),
                                Expanded(child: _buildSocialSection()),
                              ],
                            )
                          : Column(
                              children: [
                                _buildContactForm(),
                                const Divider(height: 60),
                                _buildSocialSection(),
                              ],
                            );
                      },
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
      children: [
        const Text("CONNECT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialIcon(Icons.business, "https://www.linkedin.com/in/oliver-cheruiyot-a807852b0", "LinkedIn"),
            const SizedBox(width: 30),
            _socialIcon(Icons.code_outlined, "https://github.com/Oliver9105", "GitHub"),
            const SizedBox(width: 30),
            _socialIcon(Icons.email_outlined, "mailto:olivercheruiyot09@gmail.com", "Email"),
          ],
        ),
        const SizedBox(height: 30),
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

  Widget _socialIcon(IconData icon, String url, String label) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xFF1A2B4C),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}