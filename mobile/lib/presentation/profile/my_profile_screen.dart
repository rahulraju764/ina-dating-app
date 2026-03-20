import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(context),
                _buildCompletionCard(context),
                _buildPhotosSection(context),
                _buildInfoSection(),
                _buildInterestsSection(),
                _buildSettingsSection(context),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 260,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.background,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.person_outline, color: Colors.white),
      ),
      actions: [
        GestureDetector(
          onTap: () => context.push('/edit-profile'),
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryPink, AppColors.primaryOrange],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Edit',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: () => context.push('/settings'),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2A0A30), Color(0xFF0A0A0F)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Stack(
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.primaryPink, AppColors.primaryOrange],
                        ),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryPink.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.person, size: 55, color: Colors.white70),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: AppColors.onlineGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.fiber_manual_record, size: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Rahul, 25',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.verified, color: Color(0xFF3B82F6), size: 22),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.gold.withOpacity(0.5)),
                ),
                child: const Text(
                  '⭐ GOLD',
                  style: TextStyle(color: AppColors.gold, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.primaryPink, size: 14),
              const SizedBox(width: 4),
              const Text('Kochi, Kerala', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              const SizedBox(width: 16),
              const Icon(Icons.work_outline, color: AppColors.textSecondary, size: 14),
              const SizedBox(width: 4),
              const Text('Software Engineer', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Coffee addict | Weekend hiker | Amateur photographer. Looking for someone to explore Kerala with! 🌴',
            style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryPink.withOpacity(0.15),
            AppColors.primaryOrange.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryPink.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                'Complete your profile ✨',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text('78% done', style: TextStyle(color: AppColors.primaryPink, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.78,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryPink),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '+ Add more photos • + Add your job • + Connect Instagram',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'MANAGE PHOTOS',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                  letterSpacing: 1.5,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Edit',
                  style: TextStyle(color: AppColors.primaryPink, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: index == 0
                        ? Border.all(color: AppColors.primaryPink, width: 2)
                        : Border.all(color: AppColors.border),
                  ),
                  child: index == 0
                      ? Stack(
                          children: [
                            const Center(
                              child: Icon(Icons.person, color: Colors.white54, size: 36),
                            ),
                            Positioned(
                              bottom: 4,
                              left: 4,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [AppColors.primaryPink, AppColors.primaryOrange],
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: Colors.black, width: 2),
                                ),
                                child: const Text('Main', style: TextStyle(color: Colors.white, fontSize: 9)),
                              ),
                            ),
                          ],
                        )
                      : index == 4
                          ? const Center(
                              child: Icon(Icons.add, color: AppColors.textSecondary, size: 28),
                            )
                          : const Center(
                              child: Icon(Icons.person, color: Colors.white54, size: 36),
                            ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    final info = [
      {'icon': Icons.cake_outlined, 'label': 'Birthday', 'value': 'March 15, 1999'},
      {'icon': Icons.school_outlined, 'label': 'Education', 'value': 'NIT Calicut'},
      {'icon': Icons.height, 'label': 'Height', 'value': "5'10\""},
      {'icon': Icons.favorite_outline, 'label': 'Looking for', 'value': 'Serious Relationship'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ABOUT ME',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          ...info.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Icon(item['icon'] as IconData, color: AppColors.primaryPink, size: 18),
                const SizedBox(width: 12),
                Text(
                  '${item['label']}:',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
                const SizedBox(width: 8),
                Text(
                  item['value'] as String,
                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildInterestsSection() {
    final interests = ['🎵 Music', '✈️ Travel', '📸 Photo', '☕ Coffee', '🥾 Hiking', '🎮 Gaming'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'INTERESTS',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: interests.map((i) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryPink, AppColors.primaryOrange],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(i, style: const TextStyle(color: Colors.white, fontSize: 13)),
            )).toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    final options = [
      {'icon': Icons.star_outline, 'label': '⭐ Upgrade to Gold', 'isHighlight': true},
      {'icon': Icons.tune_outlined, 'label': 'Edit Preferences'},
      {'icon': Icons.privacy_tip_outlined, 'label': 'Privacy Settings'},
      {'icon': Icons.pause_circle_outline, 'label': 'Pause Profile'},
      {'icon': Icons.help_outline, 'label': 'Help & Support'},
      {'icon': Icons.delete_outline, 'label': 'Delete Account', 'isDanger': true},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SETTINGS',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: List.generate(options.length, (index) {
                final opt = options[index];
                final isHighlight = opt['isHighlight'] == true;
                final isDanger = opt['isDanger'] == true;
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        opt['icon'] as IconData,
                        color: isDanger
                            ? Colors.redAccent
                            : isHighlight
                                ? AppColors.gold
                                : AppColors.textSecondary,
                      ),
                      title: Text(
                        opt['label'] as String,
                        style: TextStyle(
                          color: isDanger
                              ? Colors.redAccent
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.textHint,
                        size: 14,
                      ),
                      onTap: () {
                        if (isHighlight) context.push('/premium');
                        if (opt['label'] == 'Edit Preferences') context.push('/settings');
                      },
                    ),
                    if (index < options.length - 1)
                      const Divider(
                        height: 1,
                        indent: 56,
                        color: AppColors.divider,
                      ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
