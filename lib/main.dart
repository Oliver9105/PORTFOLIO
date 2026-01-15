import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'theme_provider.dart';
import 'presentation/pages/projects_page.dart';
import 'presentation/pages/profile_page.dart';
import 'presentation/pages/contact_page.dart';
import 'presentation/pages/project_details_page.dart';
import 'core/style/tw_widgets.dart'; // To use your TWResponsive helper

// 1. THE LAYOUT SHELL: This keeps the sidebar persistent
class ScaffoldWithNavbar extends StatelessWidget {
  final Widget child;
  const ScaffoldWithNavbar({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = TWResponsive.isDesktop(context);

    return Scaffold(
      // Mobile Drawer
      drawer: isDesktop ? null : Drawer(child: _buildSidebarContents(context)),
      appBar: isDesktop ? null : AppBar(
        title: const Text("Portfolio"),
        backgroundColor: const Color(0xFF1A2B4C),
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          // Persistent Sidebar on Desktop
          if (isDesktop) 
            Container(
              width: 100,
              color: const Color(0xFF1A2B4C),
              child: _buildSidebarContents(context),
            ),
          Expanded(child: child), // This is where Projects, Profile, etc. appear
        ],
      ),
    );
  }

  Widget _buildSidebarContents(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const FlutterLogo(size: 32),
        const SizedBox(height: 60),
        _navIcon(context, Icons.grid_view_rounded, '/', "Projects"),
        _navIcon(context, Icons.person_outline, '/profile', "Profile"),
        _navIcon(context, Icons.mail_outline, '/contact', "Contact"),
        const Spacer(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _navIcon(BuildContext context, IconData icon, String path, String label) {
    bool isActive = GoRouterState.of(context).uri.toString() == path;
    return GestureDetector(
      onTap: () => context.go(path),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white10 : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: isActive ? Colors.white : Colors.white54),
      ),
    );
  }
}

// 2. THE ROUTER CONFIGURATION
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => ScaffoldWithNavbar(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const ProjectsDesktopPage()),
        GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
        GoRoute(path: '/contact', builder: (context, state) => const ContactPage()),
        GoRoute(
          path: '/project-details/:id',
          builder: (context, state) => ProjectDetailsPage(id: state.pathParameters['id'] ?? '0'),
        ),
      ],
    ),
  ],
);

// main() and MyApp classes remain the same...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}