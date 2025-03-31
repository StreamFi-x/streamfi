// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({Key? key}) : super(key: key);

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen>
    with SingleTickerProviderStateMixin {
  bool _profileVisibilityPublic = true;
  bool _profileVisibilityFollowers = false;
  bool _profileVisibilityPrivate = false;

  bool _tippingHistoryPublic = true;
  bool _tippingHistoryPrivate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {},
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Stream',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications_outlined),
                            onPressed: () {},
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: const Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.purple[400],
                        radius: 20,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Privacy and Security',
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 3,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Notification',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Manage your privacy preferences and security controls.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.purple[300],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Profile Visibility',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Choose who can see your profile.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _profileVisibilityPublic = true;
                          _profileVisibilityFollowers = false;
                          _profileVisibilityPrivate = false;
                        });
                      },
                      child: Row(
                        children: [
                          Checkbox(
                            value: _profileVisibilityPublic,
                            onChanged: (value) {
                              setState(() {
                                _profileVisibilityPublic = true;
                                _profileVisibilityFollowers = false;
                                _profileVisibilityPrivate = false;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Public (Everyone)',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _profileVisibilityPublic = false;
                          _profileVisibilityFollowers = true;
                          _profileVisibilityPrivate = false;
                        });
                      },
                      child: Row(
                        children: [
                          Checkbox(
                            value: _profileVisibilityFollowers,
                            onChanged: (value) {
                              setState(() {
                                _profileVisibilityPublic = false;
                                _profileVisibilityFollowers = true;
                                _profileVisibilityPrivate = false;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Followers Only',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _profileVisibilityPublic = false;
                          _profileVisibilityFollowers = false;
                          _profileVisibilityPrivate = true;
                        });
                      },
                      child: Row(
                        children: [
                          Checkbox(
                            value: _profileVisibilityPrivate,
                            onChanged: (value) {
                              setState(() {
                                _profileVisibilityPublic = false;
                                _profileVisibilityFollowers = false;
                                _profileVisibilityPrivate = true;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Private (Only Me)',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Tipping History Visibility',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Control who can see your tipping activity',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _tippingHistoryPublic = true;
                          _tippingHistoryPrivate = false;
                        });
                      },
                      child: Row(
                        children: [
                          Checkbox(
                            value: _tippingHistoryPublic,
                            onChanged: (value) {
                              setState(() {
                                _tippingHistoryPublic = true;
                                _tippingHistoryPrivate = false;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Public (Everyone)',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _tippingHistoryPublic = false;
                          _tippingHistoryPrivate = true;
                        });
                      },
                      child: Row(
                        children: [
                          Checkbox(
                            value: _tippingHistoryPrivate,
                            onChanged: (value) {
                              setState(() {
                                _tippingHistoryPublic = false;
                                _tippingHistoryPrivate = true;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Private (Only Me)',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
