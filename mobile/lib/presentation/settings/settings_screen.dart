import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _matchNotifications = true;
  bool _messageNotifications = true;
  bool _darkMode = true;
  bool _incognitoMode = false;
  bool _hideDistance = false;
  bool _showOnlineStatus = true;
  int _maxDistance = 50;
  RangeValues _ageRange = const RangeValues(20, 35);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text('Settings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          _SectionHeader('ACCOUNT'),
          _SettingsTile(
            icon: Icons.person_outline,
            label: 'Edit Profile',
            onTap: () => context.push('/edit-profile'),
          ),
          _SettingsTile(
            icon: Icons.star_outline,
            label: 'Manage Subscription',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryPink, AppColors.primaryOrange],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('GOLD', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
            onTap: () => context.push('/premium'),
          ),
          _SettingsTile(
            icon: Icons.phone_outlined,
            label: 'Phone Number',
            value: '+91 xxxxxxx890',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.email_outlined,
            label: 'Email Address',
            value: 'rahul@example.com',
            onTap: () {},
          ),

          _SectionHeader('DISCOVERY'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Maximum Distance', style: TextStyle(color: Colors.white, fontSize: 15)),
                    const Spacer(),
                    Text('$_maxDistance km', style: const TextStyle(color: AppColors.primaryPink, fontWeight: FontWeight.bold)),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.primaryPink,
                    thumbColor: AppColors.primaryPink,
                    inactiveTrackColor: AppColors.border,
                    overlayColor: AppColors.primaryPink.withOpacity(0.2),
                  ),
                  child: Slider(
                    value: _maxDistance.toDouble(),
                    min: 1,
                    max: 200,
                    onChanged: (v) => setState(() => _maxDistance = v.toInt()),
                  ),
                ),
                Row(
                  children: [
                    const Text('Age Range', style: TextStyle(color: Colors.white, fontSize: 15)),
                    const Spacer(),
                    Text(
                      '${_ageRange.start.toInt()} - ${_ageRange.end.toInt()}',
                      style: const TextStyle(color: AppColors.primaryPink, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.primaryPink,
                    thumbColor: AppColors.primaryPink,
                    inactiveTrackColor: AppColors.border,
                    rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 10),
                  ),
                  child: RangeSlider(
                    values: _ageRange,
                    min: 18,
                    max: 60,
                    onChanged: (v) => setState(() => _ageRange = v),
                  ),
                ),
              ],
            ),
          ),

          _SectionHeader('PRIVACY'),
          _SettingsSwitch(
            icon: Icons.security_outlined,
            label: 'Incognito Mode',
            subtitle: 'Only visible to people you\'ve liked',
            value: _incognitoMode,
            onChanged: (v) => setState(() => _incognitoMode = v),
          ),
          _SettingsSwitch(
            icon: Icons.location_off_outlined,
            label: 'Hide Distance',
            value: _hideDistance,
            onChanged: (v) => setState(() => _hideDistance = v),
          ),
          _SettingsSwitch(
            icon: Icons.circle_outlined,
            label: 'Show Online Status',
            value: _showOnlineStatus,
            onChanged: (v) => setState(() => _showOnlineStatus = v),
          ),

          _SectionHeader('NOTIFICATIONS'),
          _SettingsSwitch(
            icon: Icons.notifications_outlined,
            label: 'Push Notifications',
            value: _pushNotifications,
            onChanged: (v) => setState(() => _pushNotifications = v),
          ),
          _SettingsSwitch(
            icon: Icons.favorite_outline,
            label: 'New Matches',
            value: _matchNotifications,
            onChanged: (v) => setState(() => _matchNotifications = v),
          ),
          _SettingsSwitch(
            icon: Icons.chat_bubble_outline,
            label: 'Messages',
            value: _messageNotifications,
            onChanged: (v) => setState(() => _messageNotifications = v),
          ),

          _SectionHeader('APPEARANCE'),
          _SettingsSwitch(
            icon: Icons.dark_mode_outlined,
            label: 'Dark Mode',
            value: _darkMode,
            onChanged: (v) => setState(() => _darkMode = v),
          ),

          _SectionHeader('SUPPORT'),
          _SettingsTile(icon: Icons.help_outline, label: 'Help Centre', onTap: () {}),
          _SettingsTile(icon: Icons.privacy_tip_outlined, label: 'Privacy Policy', onTap: () {}),
          _SettingsTile(icon: Icons.description_outlined, label: 'Terms of Service', onTap: () {}),
          _SettingsTile(icon: Icons.feedback_outlined, label: 'Send Feedback', onTap: () {}),

          _SectionHeader('DANGER ZONE'),
          _SettingsTile(
            icon: Icons.logout,
            label: 'Logout',
            onTap: () => context.go('/welcome'),
            isDanger: true,
          ),
          _SettingsTile(
            icon: Icons.delete_forever_outlined,
            label: 'Delete Account',
            onTap: () {},
            isDanger: true,
          ),

          const SizedBox(height: 60),
          const Center(
            child: Text(
              'Ina v1.0.0 • Made with ❤️ in Kerala',
              style: TextStyle(color: AppColors.textHint, fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 11,
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool isDanger;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
    this.trailing,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: isDanger ? Colors.redAccent : AppColors.textSecondary, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isDanger ? Colors.redAccent : Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (value != null)
              Text(value!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            if (trailing != null) trailing!,
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              color: isDanger ? Colors.redAccent.withOpacity(0.5) : AppColors.textHint,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSwitch extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitch({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                ),
                if (subtitle != null)
                  Text(subtitle!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryPink,
            activeTrackColor: AppColors.primaryPink.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
