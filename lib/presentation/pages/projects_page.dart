import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/style/tw_widgets.dart';

class ProjectsDesktopPage extends StatefulWidget {
  const ProjectsDesktopPage({super.key});

  @override
  State<ProjectsDesktopPage> createState() => _ProjectsDesktopPageState();
}

class _ProjectsDesktopPageState extends State<ProjectsDesktopPage> {
  String _activeCategory = "ALL";

  @override
  Widget build(BuildContext context) {
    bool isDesktop = TWResponsive.isDesktop(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          _buildHeader(isDesktop),
          _buildCategoryFilter(isDesktop),
          _buildProjectGrid(context),
        ],
      ),
      drawer: !isDesktop ? Drawer(child: _buildSidebarContents()) : null,
      appBar: !isDesktop ? AppBar(title: const Text("Projects"), backgroundColor: const Color(0xFF1A2B4C), foregroundColor: Colors.white) : null,
    );
  }

  Widget _buildSidebarContents() {
    return Column(
      children: [
        const SizedBox(height: 40),
        const FlutterLogo(size: 32),
        const SizedBox(height: 60),
        const Spacer(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildHeader(bool isDesktop) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(isDesktop ? 40 : 20, 60, isDesktop ? 40 : 20, 20),
      sliver: SliverToBoxAdapter(
        child: isDesktop 
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("MY PROJECTS", style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, letterSpacing: -1)),
                _buildSearchBar(),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("MY PROJECTS", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                _buildSearchBar(width: double.infinity),
              ],
            ),
      ),
    );
  }

  Widget _buildSearchBar({double width = 300}) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search projects...",
          prefixIcon: Icon(Icons.search, size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(bool isDesktop) {
    final categories = {
      "ALL": {"count": 3, "available": true},
      "WEB": {"count": 3, "available": true},
      "FULL STACK": {"count": 3, "available": true},
      "MOBILE": {"count": 0, "available": false},
      "UI/UX": {"count": 0, "available": false},
      "FLUTTER": {"count": 0, "available": false},
    };
    
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 20, vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.entries.map((entry) {
                  String cat = entry.key;
                  Map<String, dynamic> info = entry.value;
                  bool isMe = _activeCategory == cat;
                  bool isAvailable = info['available'];
                  int count = info['count'];
                  
                  return GestureDetector(
                    onTap: isAvailable ? () => setState(() => _activeCategory = cat) : null,
                    child: Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                cat, 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  color: isAvailable 
                                    ? (isMe ? Colors.black : Colors.grey) 
                                    : Colors.grey.withOpacity(0.5)
                                )
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '($count)', 
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isAvailable 
                                    ? Colors.grey 
                                    : Colors.grey.withOpacity(0.5)
                                )
                              ),
                            ],
                          ),
                          if (isMe && isAvailable) 
                            Container(
                              height: 3, 
                              width: 25, 
                              color: const Color(0xFF4EE3C0), 
                              margin: const EdgeInsets.only(top: 4)
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (!(categories[_activeCategory]!['available'] as bool))
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'No ${_activeCategory.toLowerCase()} projects available yet. Coming soon!',
                        style: TextStyle(color: Colors.orange[800], fontSize: 12),
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

  Widget _buildProjectGrid(BuildContext context) {
    bool isDesktop = TWResponsive.isDesktop(context);
    
    final allProjects = [
      {
        'title': 'Study Groups App',
        'tech': 'React.js • Flask',
        'category': 'WEB',
        'subcategory': 'FULL STACK',
        'liveUrl': 'https://fabulous-daifuku-b1a8fc.netlify.app/',
        'githubUrl': 'https://github.com/Oliver9105/study-groups-app.git',
      },
      {
        'title': 'Blog Space',
        'tech': 'React.js • Python',
        'category': 'WEB',
        'subcategory': 'FULL STACK',
        'liveUrl': 'https://oliver-blogspace.netlify.app/',
        'githubUrl': 'https://github.com/Oliver9105/Blogpost-APP.git',
      },
      {
        'title': 'STEMLearn',
        'tech': 'React.js • Python • MySQL',
        'category': 'WEB',
        'subcategory': 'FULL STACK',
        'liveUrl': 'https://superb-duckanoo-18547b.netlify.app/',
        'githubUrl': 'https://github.com/Zippy-sudo/STEMLearn_db.git',
      },
    ];
    
    // Filter projects based on active category
    final projects = _activeCategory == "ALL" 
      ? allProjects 
      : allProjects.where((project) => 
          project['category'] == _activeCategory || 
          project['subcategory'] == _activeCategory
        ).toList();
    
    return SliverPadding(
      padding: EdgeInsets.all(isDesktop ? 40 : 20),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isDesktop ? 3 : 1,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          childAspectRatio: isDesktop ? 1.6 : 2.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => DesktopProjectCard(
            id: (index + 1).toString(),
            title: projects[index]['title']!,
            tech: projects[index]['tech']!,
            liveUrl: projects[index]['liveUrl']!,
            githubUrl: projects[index]['githubUrl']!,
          ),
          childCount: projects.length,
        ),
      ),
    );
  }
}

class DesktopProjectCard extends StatefulWidget {
  final String id;
  final String title;
  final String tech;
  final String liveUrl;
  final String githubUrl;
  
  const DesktopProjectCard({
    super.key,
    required this.id,
    required this.title,
    required this.tech,
    required this.liveUrl,
    required this.githubUrl,
  });

  @override
  State<DesktopProjectCard> createState() => _DesktopProjectCardState();
}

class _DesktopProjectCardState extends State<DesktopProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isStudyGroup = widget.title == 'Study Groups App';
    bool isBlogSpace = widget.title == 'Blog Space';
    bool isStemLearn = widget.title == 'STEMLearn';
    return GestureDetector(
      onTap: () => context.push('/project-details/${widget.id}'),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: isHovered ? (Matrix4.identity()..translate(0, -8, 0)) : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: isStudyGroup ? const DecorationImage(
              image: AssetImage('assets/images/studygroup.png'),
              fit: BoxFit.cover,
            ) : isBlogSpace ? const DecorationImage(
              image: AssetImage('assets/images/blogp.png'),
              fit: BoxFit.cover,
            ) : isStemLearn ? const DecorationImage(
              image: AssetImage('assets/images/stemlearn.png'),
              fit: BoxFit.cover,
            ) : null,
            gradient: !isStudyGroup && !isBlogSpace && !isStemLearn ? const LinearGradient(
              colors: [Color(0xFF1A2B4C), Color(0xFF2B5876)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ) : null,
            boxShadow: [
              BoxShadow(
                color: isHovered ? const Color(0xFF4EE3C0).withOpacity(0.3) : Colors.black12,
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Container(
            decoration: isStudyGroup || isBlogSpace || isStemLearn ? BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.3)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ) : null,
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.rocket_launch, color: Color(0xFF4EE3C0), size: 30),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(widget.tech, style: const TextStyle(color: Colors.white60, fontSize: 13)),
                    ],
                  ),
                ),
                if (isHovered) const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
