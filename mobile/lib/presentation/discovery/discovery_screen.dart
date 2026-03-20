import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

// Sample profile data
class _Profile {
  final String name;
  final int age;
  final String location;
  final String distance;
  final List<String> interests;
  final bool isVerified;
  final bool hasPremium;
  final String bio;
  final Color bgColor;

  const _Profile({
    required this.name,
    required this.age,
    required this.location,
    required this.distance,
    required this.interests,
    required this.isVerified,
    required this.hasPremium,
    required this.bio,
    required this.bgColor,
  });
}

class _DiscoveryScreenState extends State<DiscoveryScreen>
    with SingleTickerProviderStateMixin {
  final List<_Profile> _profiles = [
    _Profile(
      name: 'Meera',
      age: 24,
      location: 'Kochi',
      distance: '3 km away',
      interests: ['🎵 Music', '✈️ Travel', '📸 Photo'],
      isVerified: true,
      hasPremium: true,
      bio: 'Coffee addict | Amateur photographer | Weekend hiker',
      bgColor: const Color(0xFF1A1040),
    ),
    _Profile(
      name: 'Priya',
      age: 26,
      location: 'Thiruvananthapuram',
      distance: '12 km away',
      interests: ['🎨 Art', '📚 Reading', '🍳 Cooking'],
      isVerified: true,
      hasPremium: false,
      bio: 'Artist | Bookworm | Food explorer',
      bgColor: const Color(0xFF0A2040),
    ),
    _Profile(
      name: 'Anjali',
      age: 23,
      location: 'Kozhikode',
      distance: '28 km away',
      interests: ['🏋️ Gym', '🧘 Yoga', '🐕 Dogs'],
      isVerified: false,
      hasPremium: false,
      bio: 'Fitness freak | Yoga instructor | Dog lover',
      bgColor: const Color(0xFF1A0A35),
    ),
  ];

  int _currentIndex = 0;
  Offset _dragOffset = Offset.zero;
  bool _isDragging = false;
  late AnimationController _swipeController;

  @override
  void initState() {
    super.initState();
    _swipeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _swipeController.dispose();
    super.dispose();
  }

  void _onSwipeRight() {
    if (_currentIndex < _profiles.length) {
      _showMatchAnimation();
      setState(() {
        _dragOffset = Offset.zero;
        _isDragging = false;
        if (_currentIndex < _profiles.length - 1) {
          _currentIndex++;
        }
      });
    }
  }

  void _onSwipeLeft() {
    setState(() {
      _dragOffset = Offset.zero;
      _isDragging = false;
      if (_currentIndex < _profiles.length - 1) {
        _currentIndex++;
      }
    });
  }

  void _showMatchAnimation() {
    final profile = _profiles[_currentIndex];
    if (profile.name == 'Meera') {
      context.push('/match-animation', extra: {
        'userName': profile.name,
        'userPhoto': '',
        'myPhoto': '',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background cards (stacked look)
                  if (_currentIndex + 2 < _profiles.length)
                    Positioned(
                      top: 30,
                      child: Transform.scale(
                        scale: 0.88,
                        child: Opacity(
                          opacity: 0.5,
                          child: _buildCard(_profiles[_currentIndex + 2]),
                        ),
                      ),
                    ),
                  if (_currentIndex + 1 < _profiles.length)
                    Positioned(
                      top: 16,
                      child: Transform.scale(
                        scale: 0.94,
                        child: Opacity(
                          opacity: 0.75,
                          child: _buildCard(_profiles[_currentIndex + 1]),
                        ),
                      ),
                    ),

                  // Main draggable card
                  if (_currentIndex < _profiles.length)
                    GestureDetector(
                      onPanStart: (_) => setState(() => _isDragging = true),
                      onPanUpdate: (d) {
                        setState(() => _dragOffset += d.delta);
                      },
                      onPanEnd: (_) {
                        if (_dragOffset.dx > 100) {
                          _onSwipeRight();
                        } else if (_dragOffset.dx < -100) {
                          _onSwipeLeft();
                        } else {
                          setState(() {
                            _dragOffset = Offset.zero;
                            _isDragging = false;
                          });
                        }
                      },
                      child: Transform.translate(
                        offset: _dragOffset,
                        child: Transform.rotate(
                          angle: _dragOffset.dx * 0.002,
                          child: Stack(
                            children: [
                              _buildCard(_profiles[_currentIndex]),
                              // Like/Nope overlays
                              if (_isDragging && _dragOffset.dx > 30)
                                Positioned(
                                  top: 40,
                                  left: 32,
                                  child: _SwipeLabel(label: 'LIKE 💚', color: AppColors.onlineGreen),
                                ),
                              if (_isDragging && _dragOffset.dx < -30)
                                Positioned(
                                  top: 40,
                                  right: 32,
                                  child: _SwipeLabel(label: 'NOPE ❌', color: Colors.redAccent),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  if (_currentIndex >= _profiles.length)
                    const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.hourglass_empty, color: AppColors.textSecondary, size: 60),
                          SizedBox(height: 16),
                          Text(
                            'No more profiles nearby',
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                          ),
                          Text(
                            'Check back later!',
                            style: TextStyle(color: AppColors.textHint, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Action buttons
            if (_currentIndex < _profiles.length) _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          // Location
          Row(
            children: const [
              Icon(Icons.location_on, color: AppColors.primaryPink, size: 18),
              SizedBox(width: 4),
              Text(
                'Kochi, Kerala',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
            ],
          ),
          const Spacer(),

          // Notifications
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryPink,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Filter
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryPink, AppColors.primaryOrange],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.tune, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(_Profile profile) {
    final width = MediaQuery.of(context).size.width - 32;
    final height = MediaQuery.of(context).size.height * 0.54;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: profile.bgColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Placeholder avatar
          Positioned.fill(
            child: Center(
              child: Icon(
                Icons.person,
                size: 100,
                color: Colors.white.withOpacity(0.15),
              ),
            ),
          ),

          // Gradient overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  colors: [Colors.transparent, Color(0xDD000000)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.5, 1.0],
                ),
              ),
            ),
          ),

          // Content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${profile.name}, ${profile.age}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (profile.isVerified)
                        const Icon(Icons.verified, color: Color(0xFF3B82F6), size: 22),
                      if (profile.hasPremium) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.gold.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.gold.withOpacity(0.5)),
                          ),
                          child: const Text(
                            '⭐ GOLD',
                            style: TextStyle(color: AppColors.gold, fontSize: 10),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.primaryPink, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${profile.location} • ${profile.distance}',
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    profile.bio,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: profile.interests.map((i) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(i, style: const TextStyle(color: Colors.white, fontSize: 12)),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ),

          // View profile button
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: () => context.push('/profile/${profile.name.toLowerCase()}'),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24),
                ),
                child: const Icon(Icons.info_outline, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 8, 32, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Rewind
          _ActionBtn(
            icon: Icons.replay,
            size: 48,
            color: AppColors.textSecondary,
            onTap: () {},
          ),
          // Nope
          _ActionBtn(
            icon: Icons.close,
            size: 64,
            color: Colors.redAccent,
            onTap: _onSwipeLeft,
            shadow: Colors.redAccent,
          ),
          // Super Like
          _ActionBtn(
            icon: Icons.star,
            size: 48,
            color: const Color(0xFF3B82F6),
            onTap: () {},
          ),
          // Like
          _ActionBtn(
            icon: Icons.favorite,
            size: 64,
            isGradient: true,
            onTap: _onSwipeRight,
          ),
          // Boost
          _ActionBtn(
            icon: Icons.bolt,
            size: 48,
            color: AppColors.primaryOrange,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;
  final VoidCallback onTap;
  final bool isGradient;
  final Color? shadow;

  const _ActionBtn({
    required this.icon,
    required this.size,
    this.color,
    required this.onTap,
    this.isGradient = false,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isGradient ? null : AppColors.surface,
          gradient: isGradient
              ? const LinearGradient(
                  colors: [AppColors.primaryPink, AppColors.primaryOrange])
              : null,
          border: isGradient ? null : Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: (shadow ?? (isGradient ? AppColors.primaryPink : Colors.transparent))
                  .withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isGradient ? Colors.white : color,
          size: size * 0.44,
        ),
      ),
    );
  }
}

class _SwipeLabel extends StatelessWidget {
  final String label;
  final Color color;

  const _SwipeLabel({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
