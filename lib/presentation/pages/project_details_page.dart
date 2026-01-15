import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html show window;

class ProjectDetailsPage extends StatelessWidget {
  final String id;
  const ProjectDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final projects = {
      '1': {
        'title': 'STUDY GROUPS APP',
        'description': 'A collaborative learning platform that connects students for group study sessions. Features include real-time chat, session scheduling, and resource sharing.',
        'tech': ['React.js', 'Flask', 'Python', 'RESTful APIs'],
        'features': [
          {'title': 'Real-time Collaboration', 'desc': 'Implemented WebSockets for live group interactions.'},
          {'title': 'Session Management', 'desc': 'Built scheduling system with calendar integration.'},
          {'title': 'Resource Sharing', 'desc': 'Created file upload and sharing functionality.'},
        ],
        'liveUrl': 'https://fabulous-daifuku-b1a8fc.netlify.app/',
        'githubUrl': 'https://github.com/Oliver9105/study-groups-app.git',
      },
      '2': {
        'title': 'BLOG SPACE',
        'description': 'A modern blogging platform with rich text editing, user authentication, and social features. Enables users to create, share, and discover content.',
        'tech': ['React.js', 'Python', 'Flask', 'PostgreSQL'],
        'features': [
          {'title': 'Rich Text Editor', 'desc': 'Implemented markdown support and media embedding.'},
          {'title': 'User Authentication', 'desc': 'Built secure login system with JWT tokens.'},
          {'title': 'Social Features', 'desc': 'Added comments, likes, and user following.'},
        ],
        'liveUrl': 'https://oliver-blogspace.netlify.app/',
        'githubUrl': 'https://github.com/Oliver9105/Blogpost-APP.git',
      },
      '3': {
        'title': 'STEMLEARN',
        'description': 'An educational platform focused on STEM subjects. Provides interactive lessons, quizzes, and progress tracking for students.',
        'tech': ['Full Stack', 'React.js', 'Python', 'MySQL'],
        'features': [
          {'title': 'Interactive Lessons', 'desc': 'Created engaging content with animations and examples.'},
          {'title': 'Quiz System', 'desc': 'Built assessment tools with instant feedback.'},
          {'title': 'Progress Tracking', 'desc': 'Implemented analytics dashboard for students.'},
        ],
        'liveUrl': 'https://superb-duckanoo-18547b.netlify.app/',
        'githubUrl': 'https://github.com/Zippy-sudo/STEMLearn_db.git',
      },
    };

    final project = projects[id] ?? projects['1']!;

    return Scaffold(
      backgroundColor: const Color(0xFF1A2B4C),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            backgroundColor: Colors.transparent,
            leading: const BackButton(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'project_$id',
                child: Container(
                  decoration: BoxDecoration(
                    image: id == '1' ? const DecorationImage(
                      image: AssetImage('assets/images/studygroup.png'),
                      fit: BoxFit.cover,
                    ) : id == '2' ? const DecorationImage(
                      image: AssetImage('assets/images/blogp.png'),
                      fit: BoxFit.cover,
                    ) : id == '3' ? const DecorationImage(
                      image: AssetImage('assets/images/stemlearn.png'),
                      fit: BoxFit.cover,
                    ) : null,
                    gradient: id != '1' && id != '2' && id != '3' ? const LinearGradient(
                      colors: [Color(0xFF2B5876), Color(0xFF4E4376)],
                    ) : null,
                  ),
                  child: id != '1' && id != '2' && id != '3' ? const Center(
                    child: Icon(Icons.rocket_launch, size: 120, color: Colors.white),
                  ) : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -40),
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(project['title'] as String,
                              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 10),
                        _buildLiveButton(project['liveUrl'] as String),
                        const SizedBox(width: 10),
                        _buildGithubButton(project['githubUrl'] as String),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildTechStack(project['tech'] as List<String>),
                    const SizedBox(height: 40),
                    const Text("About", 
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    Text(
                      project['description'] as String,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.6),
                    ),
                    const SizedBox(height: 30),
                    ...((project['features'] as List<Map<String, String>>).map((feature) => 
                      _buildFeatureCard(feature['title']!, feature['desc']!)
                    ).toList()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchUrl(String url) {
    if (kIsWeb) {
      html.window.open(url, '_blank');
    } else {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildLiveButton(String url) {
    return ElevatedButton.icon(
      onPressed: () => _launchUrl(url),
      icon: const Icon(Icons.open_in_new),
      label: const Text("LIVE DEMO"),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4EE3C0),
        foregroundColor: const Color(0xFF1A2B4C),
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildGithubButton(String url) {
    return OutlinedButton.icon(
      onPressed: () => _launchUrl(url),
      icon: const Icon(Icons.code),
      label: const Text("VIEW SOURCE"),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF1A2B4C),
        side: const BorderSide(color: Color(0xFF1A2B4C)),
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildTechStack(List<String> tools) {
    return Wrap(
      spacing: 10,
      children: tools.map((tool) => Chip(
        label: Text(tool, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1A2B4C),
      )).toList(),
    );
  }

  Widget _buildFeatureCard(String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 5),
          Text(desc, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}