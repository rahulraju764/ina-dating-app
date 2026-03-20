import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/gradient_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      title: 'Find Your ',
      titleHighlight: 'ഇണ',
      subtitle: 'Discover people nearby who share\nyour interests and heart',
      icon: Icons.favorite,
    ),
    _OnboardingData(
      title: 'Match &',
      titleHighlight: ' Connect',
      subtitle: 'Swipe right on people you like\nand start meaningful conversations',
      icon: Icons.favorite_border,
    ),
    _OnboardingData(
      title: 'Build',
      titleHighlight: ' Connections',
      subtitle: 'Chat, gift, and call your matches\nto build deep relationships',
      icon: Icons.chat_bubble_outline,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          // Background glow
          Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.6,
                  colors: [
                    Color(0x55FF2D78),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Dots background
          const _DotsBackground(),

          Column(
            children: [
              Expanded(
                flex: 5,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemCount: _pages.length,
                  itemBuilder: (context, index) =>
                      _OnboardingPage(data: _pages[index]),
                ),
              ),

              // Bottom sheet
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF111118),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                padding: const EdgeInsets.fromLTRB(28, 20, 28, 40),
                child: Column(
                  children: [
                    // Drag handle
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A40),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Page title
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: _pages[_currentPage].title,
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: _pages[_currentPage].titleHighlight,
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryPink,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _pages[_currentPage].subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Page indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: i == _currentPage ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: i == _currentPage
                                ? AppColors.primaryPink
                                : const Color(0xFF2A2A40),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Get Started Button
                    GradientButton(
                      text: 'Get Started',
                      onPressed: () => context.go('/register'),
                    ),
                    const SizedBox(height: 16),

                    // Sign In link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.go('/login'),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: AppColors.primaryPink,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // People found match
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: AppColors.primaryPink,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '50,000+ PEOPLE FOUND THEIR MATCH',
                          style: TextStyle(
                            color: AppColors.textSecondary.withOpacity(0.7),
                            fontSize: 11,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        data.icon,
        size: 80,
        color: AppColors.primaryPink.withOpacity(0.8),
      ),
    );
  }
}

class _DotsBackground extends StatelessWidget {
  const _DotsBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DotsPainter(),
      size: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * 0.55,
      ),
    );
  }
}

class _DotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2A2A3A)
      ..style = PaintingStyle.fill;

    const spacing = 28.0;
    const radius = 1.8;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _OnboardingData {
  final String title;
  final String titleHighlight;
  final String subtitle;
  final IconData icon;

  _OnboardingData({
    required this.title,
    required this.titleHighlight,
    required this.subtitle,
    required this.icon,
  });
}
