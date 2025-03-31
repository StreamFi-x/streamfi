import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  // State variables for checkboxes
  bool newFollowers = true;
  bool mentionsReplies = false;
  bool liveStreamAlerts = false;
  bool tippingNotifications = false;
  bool weeklyUpdates = true;
  bool securityAlerts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF8A56FF),
              radius: 18,
              child: ClipOval(
                child: Image.asset(
                  'assets/profile.png', // Replace with actual profile image path
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab navigation
          SizedBox(
            height: 50,
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Privacy and Security',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Notification',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.purple, fontSize: 16),
                      ),
                      Container(
                        height: 3,
                        margin: const EdgeInsets.only(top: 4),
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Control how you receive updates and alerts.',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'General Notifications',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // General notification checkboxes
                      buildCheckbox('New Followers', newFollowers, (value) {
                        setState(() => newFollowers = value!);
                      }),
                      buildCheckbox('Mentions & Replies', mentionsReplies, (value) {
                        setState(() => mentionsReplies = value!);
                      }),
                      buildCheckbox('Live Stream Alerts', liveStreamAlerts, (value) {
                        setState(() => liveStreamAlerts = value!);
                      }),
                      buildCheckbox('Tipping Notifications', tippingNotifications, (value) {
                        setState(() => tippingNotifications = value!);
                      }),
                      const SizedBox(height: 24),
                      const Text(
                        'Email Notifications',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Email notification checkboxes
                      buildCheckbox('Weekly Updates & Announcements', weeklyUpdates, (value) {
                        setState(() => weeklyUpdates = value!);
                      }),
                      buildCheckbox('Security Alerts', securityAlerts, (value) {
                        setState(() => securityAlerts = value!);
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCheckbox(String label, bool value, Function(bool?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.purple;
                  }
                  return Colors.transparent;
                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

// Main application for testing
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamVibe Notifications',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      ),
      home: const NotificationSettingsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}