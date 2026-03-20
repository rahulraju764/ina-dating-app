import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

final _newMatches = [
  {'name': 'Anjali', 'age': '23', 'isNew': true},
  {'name': 'Divya', 'age': '25', 'isNew': true},
  {'name': 'Kavya', 'age': '27', 'isNew': false},
  {'name': 'Nisha', 'age': '24', 'isNew': false},
  {'name': 'Sneha', 'age': '22', 'isNew': true},
];

final _conversations = [
  {
    'name': 'Meera',
    'age': '24',
    'message': 'Heyy! How are you doing? 😊',
    'time': '2m',
    'unread': 2,
    'isOnline': true,
  },
  {
    'name': 'Priya',
    'age': '26',
    'message': 'That sounds amazing! Would love ✨',
    'time': '15m',
    'unread': 0,
    'isOnline': false,
  },
  {
    'name': 'Nithya',
    'age': '25',
    'message': 'Are you free this weekend?',
    'time': '1h',
    'unread': 1,
    'isOnline': true,
  },
  {
    'name': 'Reshma',
    'age': '23',
    'message': "I love coffee too! ☕",
    'time': '3h',
    'unread': 0,
    'isOnline': false,
  },
  {
    'name': 'Anu',
    'age': '27',
    'message': 'Haha that was so funny 😂',
    'time': 'Yesterday',
    'unread': 0,
    'isOnline': false,
  },
];

class _MatchesScreenState extends State<MatchesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabs(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMatchesTab(),
                  _buildChatTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          const Text(
            'Matches & Chat',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(Icons.search, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryPink, AppColors.primaryOrange],
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        tabs: const [
          Tab(text: 'Matches'),
          Tab(text: 'Messages'),
        ],
      ),
    );
  }

  Widget _buildMatchesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // New matches header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Row(
              children: [
                ShaderMask(
                  shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
                  child: const Text(
                    'NEW MATCHES ✨',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'See All',
                  style: TextStyle(color: AppColors.primaryPink, fontSize: 13),
                ),
              ],
            ),
          ),

          // Horizontal scroll of new matches
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _newMatches.length,
              itemBuilder: (context, index) {
                final match = _newMatches[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [AppColors.primaryPink, AppColors.primaryOrange],
                                ),
                                border: Border.all(color: AppColors.background, width: 2),
                              ),
                              child: const Icon(Icons.person, size: 36, color: Colors.white60),
                            ),
                            if (match['isNew'] == true)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryPink,
                                    shape: BoxShape.circle,
                                    border: Border.fromBorderSide(
                                      BorderSide(color: Colors.black, width: 2),
                                    ),
                                  ),
                                  child: const Icon(Icons.star, size: 10, color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          match['name'] as String,
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        Text(
                          match['age'] as String,
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: AppColors.textSecondary, size: 20),
                  SizedBox(width: 10),
                  Text('Search your matches...', style: TextStyle(color: AppColors.textHint, fontSize: 14)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Matches list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _newMatches.length,
            itemBuilder: (context, index) {
              final m = _newMatches[index];
              return _MatchTile(
                name: m['name'] as String,
                age: m['age'] as String,
                onTap: () {
                  final name = m['name'] as String;
                  context.push('/chat/chat_${name.toLowerCase()}',
                      extra: {
                        'partnerName': name,
                        'partnerPhoto': '',
                        'isOnline': false,
                      });
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChatTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: _conversations.length,
      itemBuilder: (context, index) {
        final conv = _conversations[index];
        return _ConversationTile(
          name: conv['name'] as String,
          message: conv['message'] as String,
          time: conv['time'] as String,
          unread: conv['unread'] as int,
          isOnline: conv['isOnline'] as bool,
          onTap: () => context.push('/chat/chat_${(conv['name'] as String).toLowerCase()}',
              extra: {
                'partnerName': conv['name'],
                'partnerPhoto': '',
                'isOnline': conv['isOnline'],
              }),
        );
      },
    );
  }
}

class _MatchTile extends StatelessWidget {
  final String name;
  final String age;
  final VoidCallback onTap;

  const _MatchTile({required this.name, required this.age, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      onTap: onTap,
      leading: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.primaryPink, AppColors.primaryOrange],
          ),
        ),
        child: const Icon(Icons.person, color: Colors.white70, size: 28),
      ),
      title: Text('$name, $age', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      subtitle: const Text('Tap to say hi! 👋', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.textHint, size: 14),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unread;
  final bool isOnline;
  final VoidCallback onTap;

  const _ConversationTile({
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.isOnline,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                  ),
                  child: const Icon(Icons.person, color: Colors.white70, size: 28),
                ),
                if (isOnline)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppColors.onlineGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.background, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: unread > 0 ? FontWeight.bold : FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        time,
                        style: TextStyle(
                          color: unread > 0 ? AppColors.primaryPink : AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: unread > 0 ? Colors.white70 : AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      if (unread > 0)
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$unread',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
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
