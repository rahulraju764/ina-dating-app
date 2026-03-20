import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/gradient_button.dart';

class GiftShopScreen extends StatefulWidget {
  const GiftShopScreen({super.key});

  @override
  State<GiftShopScreen> createState() => _GiftShopScreenState();
}

class _Gift {
  final String emoji;
  final String name;
  final int sparks;
  final bool isPopular;

  const _Gift({required this.emoji, required this.name, required this.sparks, this.isPopular = false});
}

class _SparkPackage {
  final int sparks;
  final double price;
  final String bonus;
  final bool isPopular;

  const _SparkPackage({required this.sparks, required this.price, this.bonus = '', this.isPopular = false});
}

class _GiftShopScreenState extends State<GiftShopScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedCategory = 0;
  int _selectedRecipient = 0;
  final int _myBalance = 240;

  final List<String> _categories = ['All', 'Romance', 'Fun', 'Luxury', 'Sweet'];

  final List<_Gift> _gifts = [
    const _Gift(emoji: '💐', name: 'Bouquet', sparks: 10),
    const _Gift(emoji: '❤️', name: 'Heart', sparks: 5, isPopular: true),
    const _Gift(emoji: '💎', name: 'Diamond', sparks: 100),
    const _Gift(emoji: '🍫', name: 'Chocolate', sparks: 15),
    const _Gift(emoji: '🌹', name: 'Red Rose', sparks: 8),
    const _Gift(emoji: '🎁', name: 'Gift Box', sparks: 20),
    const _Gift(emoji: '🦋', name: 'Butterfly', sparks: 12),
    const _Gift(emoji: '⭐', name: 'Star', sparks: 25, isPopular: true),
    const _Gift(emoji: '🎂', name: 'Cake', sparks: 30),
    const _Gift(emoji: '🏆', name: 'Trophy', sparks: 50),
    const _Gift(emoji: '🌺', name: 'Flower', sparks: 7),
    const _Gift(emoji: '💌', name: 'Love Letter', sparks: 18),
  ];

  final List<_SparkPackage> _packages = [
    const _SparkPackage(sparks: 100, price: 0.99),
    const _SparkPackage(sparks: 300, price: 2.49, bonus: '+50 Bonus', isPopular: true),
    const _SparkPackage(sparks: 650, price: 4.99, bonus: '+150 Bonus'),
    const _SparkPackage(sparks: 1500, price: 9.99, bonus: '+500 Bonus'),
  ];

  final List<Map<String, String>> _recentMatches = [
    {'name': 'Meera', 'online': 'true'},
    {'name': 'Priya', 'online': 'false'},
    {'name': 'Anjali', 'online': 'true'},
    {'name': 'Divya', 'online': 'false'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
                  _buildGiftsTab(),
                  _buildSparksTab(),
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
            '🎁 Gift Shop',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          // Spark balance
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryPink.withOpacity(0.3),
                  AppColors.primaryOrange.withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primaryPink.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                const Text('💎', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Text(
                  '$_myBalance Sparks',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
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
          Tab(text: '🎁 Send Gift'),
          Tab(text: '💎 Buy Sparks'),
        ],
      ),
    );
  }

  Widget _buildGiftsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Send to
          const Text(
            'SEND TO',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 11, letterSpacing: 1.5),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _recentMatches.length,
              itemBuilder: (context, index) {
                final match = _recentMatches[index];
                final isSelected = _selectedRecipient == index;

                return GestureDetector(
                  onTap: () => setState(() => _selectedRecipient = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 14),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: isSelected
                                    ? const LinearGradient(
                                        colors: [AppColors.primaryPink, AppColors.primaryOrange],
                                      )
                                    : null,
                                color: isSelected ? null : AppColors.surface,
                                border: Border.all(
                                  color: isSelected ? AppColors.primaryPink : AppColors.border,
                                  width: isSelected ? 2.5 : 1,
                                ),
                              ),
                              child: const Icon(Icons.person, color: Colors.white60, size: 28),
                            ),
                            if (match['online'] == 'true')
                              Positioned(
                                bottom: 2,
                                right: 2,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: AppColors.onlineGreen,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.background, width: 2),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          match['name']!,
                          style: TextStyle(
                            color: isSelected ? AppColors.primaryPink : Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // Category filter
          SizedBox(
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedCategory == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [AppColors.primaryPink, AppColors.primaryOrange])
                          : null,
                      color: isSelected ? null : AppColors.surface,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected ? Colors.transparent : AppColors.border,
                      ),
                    ),
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Gifts grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemCount: _gifts.length,
            itemBuilder: (context, index) {
              return _GiftCard(
                gift: _gifts[index],
                myBalance: _myBalance,
                onSend: () => _showSendDialog(_gifts[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSparksTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2A0A3A), Color(0xFF1A0A25)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.primaryPink.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                const Text('💎', style: TextStyle(fontSize: 40)),
                const SizedBox(height: 8),
                Text(
                  '$_myBalance',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Sparks Balance',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Need more Sparks? 💎',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          const Text(
            'Use Sparks to send gifts to your matches',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 20),

          // Packages
          ...List.generate(_packages.length, (index) {
            final pkg = _packages[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: pkg.isPopular ? AppColors.primaryPink : AppColors.border,
                  width: pkg.isPopular ? 1.5 : 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text('💎', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${pkg.sparks} Sparks',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (pkg.bonus.isNotEmpty) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [AppColors.primaryPink, AppColors.primaryOrange],
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    pkg.bonus,
                                    style: const TextStyle(color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          if (pkg.isPopular)
                            const Text(
                              '⭐ Most Popular',
                              style: TextStyle(color: AppColors.primaryPink, fontSize: 12),
                            ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.primaryPink, AppColors.primaryOrange],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '\$${pkg.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
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

  void _showSendDialog(_Gift gift) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A2E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(gift.emoji, style: const TextStyle(fontSize: 56)),
            const SizedBox(height: 12),
            Text(
              'Send ${gift.name}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              '${gift.sparks} Sparks • Your balance: $_myBalance Sparks',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 24),
            GradientButton(
              text: 'Send Gift 🎁',
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
            ),
          ],
        ),
      ),
    );
  }
}

class _GiftCard extends StatelessWidget {
  final _Gift gift;
  final int myBalance;
  final VoidCallback onSend;

  const _GiftCard({required this.gift, required this.myBalance, required this.onSend});

  @override
  Widget build(BuildContext context) {
    final canAfford = myBalance >= gift.sparks;

    return GestureDetector(
      onTap: onSend,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(gift.emoji, style: const TextStyle(fontSize: 36)),
                const SizedBox(height: 6),
                Text(
                  gift.name,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('💎', style: TextStyle(fontSize: 11)),
                    const SizedBox(width: 2),
                    Text(
                      '${gift.sparks}',
                      style: TextStyle(
                        color: canAfford ? AppColors.primaryPink : AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (gift.isPopular)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryPink, AppColors.primaryOrange],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('🔥', style: TextStyle(fontSize: 10)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
