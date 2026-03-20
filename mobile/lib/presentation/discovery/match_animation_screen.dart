import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/gradient_button.dart';

class MatchAnimationScreen extends StatefulWidget {
  final String matchedUserName;
  final String matchedUserPhoto;
  final String myPhoto;

  const MatchAnimationScreen({
    super.key,
    required this.matchedUserName,
    required this.matchedUserPhoto,
    required this.myPhoto,
  });

  @override
  State<MatchAnimationScreen> createState() => _MatchAnimationScreenState();
}

class _MatchAnimationScreenState extends State<MatchAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  late Animation<Offset> _leftSlide;
  late Animation<Offset> _rightSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    _scaleAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );

    _leftSlide = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _rightSlide = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [
              Color(0xFF4A0030),
              Color(0xFF0A0010),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hearts confetti visual
              const _HeartsBackground(),

              const Spacer(),

              // It's a Match text
              FadeTransition(
                opacity: _fadeAnim,
                child: ScaleTransition(
                  scale: _scaleAnim,
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            AppColors.primaryGradient.createShader(bounds),
                        child: const Text(
                          "It's a Match! 💘",
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You and ${widget.matchedUserName} liked each other!',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Profile photos side by side
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _leftSlide,
                    child: _ProfileCircle(isMe: true),
                  ),
                  const SizedBox(width: 8),

                  // Heart between
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.primaryPink,
                        size: 32,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),
                  SlideTransition(
                    position: _rightSlide,
                    child: _ProfileCircle(
                      isMe: false,
                      label: widget.matchedUserName,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    GradientButton(
                      text: 'Send Message 💬',
                      onPressed: () {
                        context.go('/matches');
                      },
                    ),
                    const SizedBox(height: 14),
                    GradientButton(
                      text: 'Keep Swiping →',
                      onPressed: () => context.go('/home'),
                      isOutlined: true,
                    ),
                  ],
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileCircle extends StatelessWidget {
  final bool isMe;
  final String? label;

  const _ProfileCircle({required this.isMe, this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppColors.primaryPink, AppColors.primaryOrange],
            ),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPink.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 4,
              ),
            ],
          ),
          child: const Icon(Icons.person, size: 60, color: Colors.white70),
        ),
        const SizedBox(height: 10),
        Text(
          isMe ? 'You' : (label ?? 'Match'),
          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _HeartsBackground extends StatelessWidget {
  const _HeartsBackground();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0,
      child: Stack(
        children: [
          // Floating hearts (visual only)
        ],
      ),
    );
  }
}
