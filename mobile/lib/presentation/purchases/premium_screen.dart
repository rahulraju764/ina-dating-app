import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/gradient_button.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

enum BillingCycle { monthly, annual }
enum PremiumTier { gold, platinum }

class _PremiumScreenState extends State<PremiumScreen> {
  BillingCycle _selectedCycle = BillingCycle.annual;
  PremiumTier _selectedTier = PremiumTier.gold;

  final Map<PremiumTier, Map<BillingCycle, Map<String, String>>> _pricing = {
    PremiumTier.gold: {
      BillingCycle.monthly: {'price': '\$9.99', 'period': 'per month'},
      BillingCycle.annual: {'price': '\$6.25', 'period': 'per month • billed \$74.99/yr'},
    },
    PremiumTier.platinum: {
      BillingCycle.monthly: {'price': '\$19.99', 'period': 'per month'},
      BillingCycle.annual: {'price': '\$12.50', 'period': 'per month • billed \$149.99/yr'},
    },
  };

  final List<_Feature> _goldFeatures = [
    _Feature('Unlimited Swipes', 'Swipe as much as you want', Icons.all_inclusive, true),
    _Feature('See Who Liked You', 'Know who\'s interested before matching', Icons.visibility, true),
    _Feature('5 Super Likes/day', 'Stand out from the crowd', Icons.star, true),
    _Feature('1 Boost/month', 'Get to the top of the stack', Icons.bolt, true),
    _Feature('Rewind Last Swipe', 'Take back accidental swipes', Icons.replay, true),
    _Feature('Advanced Filters', 'Filter by education, lifestyle & more', Icons.filter_list, true),
    _Feature('Read Receipts', 'See when messages are read', Icons.done_all, false),
    _Feature('Priority Matching', 'Get shown to more people', Icons.trending_up, false),
  ];

  final List<_Feature> _platinumFeatures = [
    _Feature('Unlimited Swipes', 'Swipe as much as you want', Icons.all_inclusive, true),
    _Feature('See Who Liked You', 'Know who\'s interested before matching', Icons.visibility, true),
    _Feature('Unlimited Super Likes', 'Super like everyone you want', Icons.star, true),
    _Feature('Unlimited Boosts', 'Boost your profile anytime', Icons.bolt, true),
    _Feature('Rewind Last Swipe', 'Take back accidental swipes', Icons.replay, true),
    _Feature('Advanced Filters', 'Filter by education, lifestyle & more', Icons.filter_list, true),
    _Feature('Read Receipts', 'See when messages are read', Icons.done_all, true),
    _Feature('Priority Matching', 'Get shown to more people first', Icons.trending_up, true),
    _Feature('Profile Analytics', 'See who viewed and liked you', Icons.analytics, true),
    _Feature('Message Before Match', 'Send a message before matching', Icons.chat, true),
  ];

  @override
  Widget build(BuildContext context) {
    final features = _selectedTier == PremiumTier.gold ? _goldFeatures : _platinumFeatures;
    final pricing = _pricing[_selectedTier]![_selectedCycle]!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A0830), Color(0xFF0A0010)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'ഇണ Premium',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Hero header
                      const Column(
                        children: [
                          Text('👑', style: TextStyle(fontSize: 60)),
                          SizedBox(height: 8),
                          Text(
                            'Unlock Your Full\nPotential',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Get more matches & meaningful connections',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Tier selector
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: _TierTab(
                              label: '⭐ Gold',
                              isSelected: _selectedTier == PremiumTier.gold,
                              color: AppColors.gold,
                              onTap: () => setState(() => _selectedTier = PremiumTier.gold),
                            )),
                            Expanded(child: _TierTab(
                              label: '💎 Platinum',
                              isSelected: _selectedTier == PremiumTier.platinum,
                              color: Colors.white,
                              onTap: () => setState(() => _selectedTier = PremiumTier.platinum),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Billing cycle
                      Row(
                        children: [
                          Expanded(child: _BillingCard(
                            label: 'Monthly',
                            price: _pricing[_selectedTier]![BillingCycle.monthly]!['price']!,
                            period: '/month',
                            isSelected: _selectedCycle == BillingCycle.monthly,
                            onTap: () => setState(() => _selectedCycle = BillingCycle.monthly),
                          )),
                          const SizedBox(width: 12),
                          Expanded(child: _BillingCard(
                            label: 'Annual',
                            price: _pricing[_selectedTier]![BillingCycle.annual]!['price']!,
                            period: '/month',
                            isSelected: _selectedCycle == BillingCycle.annual,
                            badge: '40% OFF',
                            onTap: () => setState(() => _selectedCycle = BillingCycle.annual),
                          )),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Features
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  _selectedTier == PremiumTier.gold ? '⭐ GOLD FEATURES' : '💎 PLATINUM FEATURES',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: _selectedTier == PremiumTier.gold ? AppColors.gold : Colors.white,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ...features.map((f) => _FeatureTile(feature: f)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // CTA Section
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: const BoxDecoration(
                  color: Color(0xFF0F0F20),
                ),
                child: Column(
                  children: [
                    Text(
                      '${pricing['price']}  ${pricing['period']}',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GradientButton(
                      text: _selectedTier == PremiumTier.gold
                          ? 'Get Gold ⭐'
                          : 'Get Platinum 💎',
                      onPressed: () {},
                      colors: _selectedTier == PremiumTier.gold
                          ? [AppColors.gold, const Color(0xFFFF8C00)]
                          : [AppColors.primaryPink, AppColors.primaryOrange],
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Restore Purchases',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      ),
                    ),
                    const Text(
                      'Cancel anytime. Terms apply.',
                      style: TextStyle(color: AppColors.textHint, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Feature {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isIncluded;

  const _Feature(this.title, this.subtitle, this.icon, this.isIncluded);
}

class _FeatureTile extends StatelessWidget {
  final _Feature feature;

  const _FeatureTile({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: feature.isIncluded ? const LinearGradient(
                colors: [AppColors.primaryPink, AppColors.primaryOrange],
              ) : null,
              color: feature.isIncluded ? null : AppColors.inputFill,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              feature.icon,
              color: feature.isIncluded ? Colors.white : AppColors.textHint,
              size: 18,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: TextStyle(
                    color: feature.isIncluded ? Colors.white : AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  feature.subtitle,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                ),
              ],
            ),
          ),
          Icon(
            feature.isIncluded ? Icons.check_circle : Icons.remove_circle_outline,
            color: feature.isIncluded ? AppColors.onlineGreen : AppColors.textHint,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _TierTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _TierTab({required this.label, required this.isSelected, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(colors: [AppColors.primaryPink.withOpacity(0.8), AppColors.primaryOrange.withOpacity(0.8)])
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _BillingCard extends StatelessWidget {
  final String label;
  final String price;
  final String period;
  final bool isSelected;
  final String? badge;
  final VoidCallback onTap;

  const _BillingCard({
    required this.label,
    required this.price,
    required this.period,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [AppColors.primaryPink, AppColors.primaryOrange])
              : null,
          color: isSelected ? null : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.border,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: AppColors.primaryPink.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 6))]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                if (badge != null) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge!,
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 6),
            Text(
              price,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              period,
              style: TextStyle(
                color: isSelected ? Colors.white70 : AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
