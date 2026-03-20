import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/gradient_button.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 4;

  // Step 1 - photos
  final List<String?> _photos = List.filled(6, null);

  // Step 2 - bio
  final _bioController = TextEditingController();
  final List<String> _allInterests = [
    '🎵 Music', '🎬 Movies', '🍳 Cooking', '🏋️ Gym', '✈️ Travel',
    '🎨 Art', '☕ Coffee', '🎮 Gaming', '📸 Photo', '🥾 Hiking',
    '🍷 Wine', '📚 Reading', '🐕 Dogs', '🧘 Yoga', '🍕 Foodie',
  ];
  final Set<String> _selectedInterests = {};
  String _lookingFor = 'Serious Relationship';

  // Step 3 - location & discovery
  double _maxDistance = 50;
  RangeValues _ageRange = const RangeValues(18, 40);
  String _preferGender = 'Women';

  // Step 4 - verify
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/home');
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentStep = i),
                children: [
                  _PhotosStep(photos: _photos),
                  _BioStep(
                    bioController: _bioController,
                    allInterests: _allInterests,
                    selectedInterests: _selectedInterests,
                    lookingFor: _lookingFor,
                    onLookingForChanged: (v) =>
                        setState(() => _lookingFor = v),
                    onInterestToggle: (interest) {
                      setState(() {
                        if (_selectedInterests.contains(interest)) {
                          _selectedInterests.remove(interest);
                        } else if (_selectedInterests.length < 10) {
                          _selectedInterests.add(interest);
                        }
                      });
                    },
                  ),
                  _DiscoveryStep(
                    maxDistance: _maxDistance,
                    ageRange: _ageRange,
                    preferGender: _preferGender,
                    onDistanceChanged: (v) =>
                        setState(() => _maxDistance = v),
                    onAgeRangeChanged: (v) =>
                        setState(() => _ageRange = v),
                    onGenderChanged: (v) =>
                        setState(() => _preferGender = v),
                  ),
                  _VerifyStep(phoneController: _phoneController),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        children: [
          Row(
            children: [
              if (_currentStep > 0)
                GestureDetector(
                  onTap: _prevStep,
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                )
              else
                const SizedBox(width: 24),
              const Expanded(
                child: Center(
                  child: Text(
                    'ഇണ (Ina)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Step counter
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryPink, AppColors.primaryOrange],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_currentStep + 1}/$_totalSteps',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress bar
          Row(
            children: List.generate(_totalSteps, (i) {
              final filled = i <= _currentStep;
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: filled
                        ? const LinearGradient(
                            colors: [AppColors.primaryPink, AppColors.primaryOrange])
                        : null,
                    color: filled ? null : const Color(0xFF2A2A3E),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 8),
          Text(
            'PROFILE PERSONALIZATION',
            style: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.7),
              fontSize: 11,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: GradientButton(
        text: _currentStep == _totalSteps - 1 ? 'Get Started ✨' : 'Next →',
        onPressed: _nextStep,
      ),
    );
  }
}

// ── Step 1: Photos ────────────────────────────────────────────────────────────
class _PhotosStep extends StatelessWidget {
  final List<String?> photos;

  const _PhotosStep({required this.photos});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add your best\nphotos ✨',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add at least 2 photos to get started',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 28),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return _PhotoSlot(
                isMain: index == 0,
                hasPhoto: photos[index] != null,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PhotoSlot extends StatelessWidget {
  final bool isMain;
  final bool hasPhoto;

  const _PhotoSlot({required this.isMain, required this.hasPhoto});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isMain ? AppColors.primaryPink : AppColors.border,
          width: isMain ? 2 : 1,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Icon(
            Icons.add_photo_alternate_outlined,
            color: AppColors.textSecondary,
            size: 30,
          ),
          if (isMain)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryPink, AppColors.primaryOrange],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Main',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              width: 26,
              height: 26,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Step 2: Bio & Interests ───────────────────────────────────────────────────
class _BioStep extends StatelessWidget {
  final TextEditingController bioController;
  final List<String> allInterests;
  final Set<String> selectedInterests;
  final String lookingFor;
  final void Function(String) onLookingForChanged;
  final void Function(String) onInterestToggle;

  const _BioStep({
    required this.bioController,
    required this.allInterests,
    required this.selectedInterests,
    required this.lookingFor,
    required this.onLookingForChanged,
    required this.onInterestToggle,
  });

  @override
  Widget build(BuildContext context) {
    final lookingForOptions = [
      {'label': 'Serious Relationship', 'icon': '❤️', 'desc': 'Building something meaningful together'},
      {'label': 'Casual Dating', 'icon': '✨', 'desc': 'Taking it slow and seeing where it goes'},
      {'label': 'Friendship', 'icon': '🤝', 'desc': 'Meeting new people and making friends'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What makes you,\nyou? ✨',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Your matches will see this on your profile',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 24),

          // About Me
          Row(
            children: const [
              Icon(Icons.person_outline, color: AppColors.primaryPink, size: 18),
              SizedBox(width: 8),
              Text(
                'About Me',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: bioController,
              maxLength: 500,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "I'm a coffee enthusiast who loves weekend hikes...",
                hintStyle: TextStyle(color: AppColors.textHint),
                border: InputBorder.none,
                counterStyle: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Interests
          Row(
            children: [
              const Icon(Icons.people_outline, color: AppColors.primaryPink, size: 18),
              const SizedBox(width: 8),
              const Text(
                'Your Interests',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.info_outline, color: AppColors.textSecondary, size: 16),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [AppColors.primaryPink, AppColors.primaryOrange]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${selectedInterests.length} selected',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text('Select up to 10 things you love',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: allInterests.map((interest) {
              final isSelected = selectedInterests.contains(interest);
              return GestureDetector(
                onTap: () => onInterestToggle(interest),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: isSelected ? const LinearGradient(
                      colors: [AppColors.primaryPink, AppColors.primaryOrange],
                    ) : null,
                    color: isSelected ? null : AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected
                        ? null
                        : Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    interest,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // I'm looking for
          const Row(
            children: [
              Icon(Icons.favorite, color: AppColors.primaryPink, size: 18),
              SizedBox(width: 8),
              Text(
                "I'm looking for...",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...lookingForOptions.map((option) {
            final isSelected = lookingFor == option['label'];
            return GestureDetector(
              onTap: () => onLookingForChanged(option['label'] as String),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryPink : AppColors.border,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Text(option['icon'] as String, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            option['label'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            option['desc'] as String,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: isSelected ? const LinearGradient(
                          colors: [AppColors.primaryPink, AppColors.primaryOrange],
                        ) : null,
                        border: isSelected
                            ? null
                            : Border.all(color: AppColors.textSecondary),
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, color: Colors.white, size: 14)
                          : null,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ── Step 3: Discovery Preferences ─────────────────────────────────────────────
class _DiscoveryStep extends StatelessWidget {
  final double maxDistance;
  final RangeValues ageRange;
  final String preferGender;
  final void Function(double) onDistanceChanged;
  final void Function(RangeValues) onAgeRangeChanged;
  final void Function(String) onGenderChanged;

  const _DiscoveryStep({
    required this.maxDistance,
    required this.ageRange,
    required this.preferGender,
    required this.onDistanceChanged,
    required this.onAgeRangeChanged,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    final genders = ['Women', 'Men', 'Everyone'];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Discovery\nPreferences 🔍',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'We use these to show the most relevant matches',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 32),

          _PrefCard(
            title: 'Show Me',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: genders.map((g) {
                final isSelected = preferGender == g;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onGenderChanged(g),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [AppColors.primaryPink, AppColors.primaryOrange])
                            : null,
                        color: isSelected ? null : AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.transparent : AppColors.border,
                        ),
                      ),
                      child: Text(
                        g,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          _PrefCard(
            title: 'Maximum Distance',
            subtitle: '${maxDistance.round()} km',
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 4,
                thumbColor: AppColors.primaryPink,
                activeTrackColor: AppColors.primaryPink,
                inactiveTrackColor: AppColors.border,
                overlayShape: SliderComponentShape.noOverlay,
              ),
              child: Slider(
                value: maxDistance,
                min: 5,
                max: 200,
                onChanged: onDistanceChanged,
              ),
            ),
          ),
          const SizedBox(height: 16),

          _PrefCard(
            title: 'Age Range',
            subtitle: '${ageRange.start.round()} – ${ageRange.end.round()} years',
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 4,
                activeTrackColor: AppColors.primaryPink,
                inactiveTrackColor: AppColors.border,
                thumbColor: AppColors.primaryPink,
                overlayShape: SliderComponentShape.noOverlay,
                rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 10),
              ),
              child: RangeSlider(
                values: ageRange,
                min: 18,
                max: 70,
                onChanged: onAgeRangeChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrefCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const _PrefCard({required this.title, this.subtitle, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (subtitle != null) ...[
                const Spacer(),
                ShaderMask(
                  shaderCallback: (b) =>
                      AppColors.primaryGradient.createShader(b),
                  child: Text(
                    subtitle!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

// ── Step 4: Phone Verification ────────────────────────────────────────────────
class _VerifyStep extends StatelessWidget {
  final TextEditingController phoneController;

  const _VerifyStep({required this.phoneController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verify your\nnumber 📱',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'We\'ll send an OTP to verify your identity',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 40),

          // Phone input
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: AppColors.border),
                    ),
                  ),
                  child: const Text(
                    '🇮🇳 +91',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Phone number',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryPink.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primaryPink.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.security, color: AppColors.primaryPink, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your number is only used for verification and will never be shown to other users.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
