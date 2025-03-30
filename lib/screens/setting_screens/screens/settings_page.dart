import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool emailNotificationEnabled = false;
  bool twoFactorAuthEnabled = false;
  final TextEditingController nameController =
      TextEditingController(text: 'Casssyy');
  final TextEditingController emailController =
      TextEditingController(text: 'Chidinma Cassandra');
  final TextEditingController bioController =
      TextEditingController(text: 'Chidinma Cassandra');
  final TextEditingController linkController = TextEditingController();

  final List<String> socialLinks = ["Cassandra Chidinma"];

  // Add these properties for avatar handling
  File? _imageFile;
  bool _isUploading = false;
  String? _uploadError;

  // Maximum file size (10MB in bytes)
  static const int maxFileSize = 10 * 1024 * 1024;

  // Update avatar selection properties
  int _selectedAvatarIndex = -1;
  String _currentAvatar = 'assets/images/avatar.png';
  bool _isCustomAvatar = false;

  final List<String> _availableAvatars = [
    'assets/images/lizard.png',
    'assets/images/lizard.png',
    'assets/images/lizard.png',
    'assets/images/lizard.png',
    'assets/images/lizard.png',
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.index = 0;
  }

  @override
  void dispose() {
    tabController.dispose();
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
    linkController.dispose();
    super.dispose();
  }

  void _showAvatarEditDialog() {
    _uploadError = null;
    _isUploading = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              child: Container(
                width: 298,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.8),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(28, 28, 28, 1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Edit Avatar',
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Color(0xFF2A2A2A),
                            radius: 20,
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.close,
                                    color: Colors.white, size: 23),
                                onPressed: () => Navigator.of(context).pop(),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 24),

                      // Wrap the main content in Expanded and SingleChildScrollView
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Current Avatar and Upload Button in a row
                              Row(
                                children: [
                                  // Current Avatar
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF9147FF).withOpacity(0.3),
                                    ),
                                    child: ClipOval(
                                      child:
                                          _isCustomAvatar && _imageFile != null
                                              ? _displaySelectedImage()
                                              : _selectedAvatarIndex != -1
                                                  ? Image.asset(
                                                      _availableAvatars[
                                                          _selectedAvatarIndex],
                                                      fit: BoxFit.cover)
                                                  : Image.asset(_currentAvatar,
                                                      fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(width: 12),

                                  // Upload Button
                                  Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: _isUploading
                                            ? null
                                            : () => _pickImage(setState),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF2A2A2A),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          minimumSize: Size(159, 37),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                        ),
                                        child: _isUploading
                                            ? SizedBox(
                                                width: 24,
                                                height: 24,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.white),
                                                ),
                                              )
                                            : Text(
                                                'Upload from device',
                                                style: GoogleFonts.inter(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 8),

                              // Error message if any
                              if (_uploadError != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    _uploadError!,
                                    style: TextStyle(
                                        color: Colors.red[400],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),

                              SizedBox(height: 8),

                              // Upload Instructions
                              Text(
                                'Upload in JPEG or PNG format with dimensions ranging from 128×128px to 1500×1500px, and maximum size of 10MB.',
                                style: GoogleFonts.inter(
                                    color: Color.fromRGBO(255, 255, 255, 0.6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 24),

                              // Or text
                              Center(
                                child: Text(
                                  'or choose from the avatars below',
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(height: 16),

                              // Avatar Selection
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    return Flexible(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedAvatarIndex = index;
                                            _isCustomAvatar = false;
                                            // Reset custom image when selecting predefined avatar
                                            _imageFile = null;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    15, 15, 15, 1),
                                                border: Border.all(
                                                    color: !_isCustomAvatar &&
                                                            _selectedAvatarIndex ==
                                                                index
                                                        ? Color(0xFF9147FF)
                                                        : Color.fromRGBO(
                                                            15, 15, 15, 1),
                                                    width: 2)),
                                            child: Image.asset(
                                                _availableAvatars[index],
                                                fit: BoxFit.contain),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .end, // Aligns the button to the right
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_isCustomAvatar && (_imageFile != null)) {
                                this.setState(() {
                                  _isCustomAvatar = true;
                                });
                                Navigator.of(context).pop();
                              } else if (_selectedAvatarIndex != -1) {
                                this.setState(() {
                                  _currentAvatar =
                                      _availableAvatars[_selectedAvatarIndex];
                                  _isCustomAvatar = false;
                                });
                                Navigator.of(context).pop();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(135, 36),
                              backgroundColor: Color(0xFF9147FF),
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Save Changes',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10)
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _displaySelectedImage() {
    return _imageFile != null
        ? Image.file(_imageFile!, fit: BoxFit.cover)
        : Image.asset(_currentAvatar, fit: BoxFit.cover);
  }

  Future<void> _pickImage(StateSetter setState) async {
    setState(() {
      _isUploading = true;
      _uploadError = null;
    });

    try {
      // Mobile implementation
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // Get file name and size
        final File file = File(image.path);
        final int fileSize = await file.length();
        final String fileName = image.name;

        // Validate file
        if (!_validateFileType(fileName)) {
          setState(() {
            _uploadError =
                'Invalid file format. Please upload JPG, PNG, or GIF.';
            _isUploading = false;
          });
          return;
        }

        if (!_validateFileSize(fileSize)) {
          setState(() {
            _uploadError = 'File too large. Maximum size is 10MB.';
            _isUploading = false;
          });
          return;
        }

        // Set the image
        setState(() {
          _imageFile = file;
          _isCustomAvatar = true;
          _selectedAvatarIndex = -1;
          _isUploading = false;
        });
      } else {
        // User canceled the picker
        setState(() {
          _isUploading = false;
        });
      }
    } catch (e) {
      setState(() {
        _uploadError = 'Error selecting image: $e';
        _isUploading = false;
      });
    }
  }

  bool _validateFileType(String fileName) {
    final lowercaseName = fileName.toLowerCase();
    return lowercaseName.endsWith('.jpg') ||
        lowercaseName.endsWith('.jpeg') ||
        lowercaseName.endsWith('.png') ||
        lowercaseName.endsWith('.gif');
  }

  bool _validateFileSize(int fileSize) {
    return fileSize <= maxFileSize;
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Settings',
            style: TextStyle(
                fontSize: isTablet ? 32 : 20,
                fontWeight: FontWeight.w800,
                height: isTablet ? 40 / 32 : 40 / 20,
                letterSpacing: 0,
                color: Color(0xffFFFFFF),
                fontFamily: 'PPN'),
            textAlign: TextAlign.left,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.black,
            child: TabBar(
              controller: tabController,
              indicator: BoxDecoration(
                border: const Border(
                  bottom: BorderSide(
                    color: Color(0xFF9147FF),
                    width: 4.0,
                  ),
                ),
              ),
              indicatorColor: Colors.transparent,
              labelStyle: GoogleFonts.inter(
                fontSize: isTablet ? 16 : 12,
                fontWeight: FontWeight.w500,
                height: isTablet ? 30 / 16 : 30 / 12,
                letterSpacing: 0,
                color: Color(0xFF9147FF),
              ),
              unselectedLabelStyle: GoogleFonts.inter(
                fontSize: isTablet ? 16 : 12,
                fontWeight: FontWeight.w500,
                height: isTablet ? 30 / 16 : 30 / 12,
                letterSpacing: 0,
                color: Colors.white,
              ),
              isScrollable: true,
              tabs: const [
                Tab(text: 'Profile'),
                Tab(text: 'Account'),
                Tab(text: 'Privacy and Security'),
                Tab(text: 'Notification'),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: TabBarView(
          controller: tabController,
          children: [
            buildProfileTab(isTablet),
            buildAccountTab(isTablet),
            const Center(child: Text('Privacy and Security Settings')),
            const Center(child: Text('Notification Settings')),
          ],
        ),
      ),
    );
  }

  Widget buildAccountTab(bool isTablet) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? constraints.maxWidth * 0.05 : 16,
            vertical: 20,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: double.infinity,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 34,
                      bottom: 34,
                    ),
                    width: isTablet ? 1055 : 342,
                    height: 127,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSwitchRow(
                          'Email Notification',
                          emailNotificationEnabled,
                          (value) {
                            setState(() {
                              emailNotificationEnabled = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        buildSwitchRow(
                          'Two-Factor Authentication (2FA)',
                          twoFactorAuthEnabled,
                          (value) {
                            setState(() {
                              twoFactorAuthEnabled = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.only(left: isTablet ? 790 : 210),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 8, bottom: 8),
                      height: 36,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff5A189A),
                          border:
                              Border.all(color: Color(0xff5A189A), width: 1),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x0D0A0D12),
                                offset: Offset(0, 1),
                                blurRadius: 2)
                          ]),
                      child: Center(
                        child: Text(
                          'Save Changes',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 20 / 14,
                            letterSpacing: 0,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSwitchRow(
    String label,
    bool currentValue,
    ValueChanged<bool> onChanged,
  ) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
              fontSize: isTablet ? 18 : 14,
              fontWeight: isTablet ? FontWeight.w700 : FontWeight.w600,
              color: Color(0xffFFFFFF),
              height: 18 / 14),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0x66000000),
            borderRadius: BorderRadius.circular(1000),
          ),
          width: 40,
          height: 20,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: SizedBox(
                width: 20,
                height: 20,
                child: Switch(
                  value: currentValue,
                  onChanged: onChanged,
                  activeColor: Color(0xFF9147FF),
                  activeTrackColor: Color(0xFF9147FF).withOpacity(0.5),
                  inactiveTrackColor: Colors.grey[800],
                  inactiveThumbColor: Colors.white,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Color(0xFF9147FF);
                    }
                    return Colors.grey[800]!;
                  }),
                  trackColor:
                      WidgetStateProperty.all<Color>(Colors.transparent),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProfileTab(bool isTablet) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? constraints.maxWidth * 0.05 : 16,
          vertical: 20,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 800 : double.infinity,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                buildAvatarSection(),
                const SizedBox(height: 24),
                Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 34, bottom: 38),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSectionTitle('Basic setting'),
                        const SizedBox(height: 16),

                        buildInputLabel('User Name'),
                        buildTextField(nameController),
                        const SizedBox(height: 4),
                        Text(
                          'You can only change your display name once every 1 months.',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 18 / 12,
                            letterSpacing: 0,
                            color: Color(0xffFFFFFF),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 16),

                        buildInputLabel('Email Address'),
                        buildTextField(emailController),
                        const SizedBox(height: 16),

                        buildInputLabel('Edit Bio'),
                        buildTextField(nameController, maxLines: 5),
                        const SizedBox(height: 4),
                        Text(
                          'Share a bit about yourself. (Max 150 words)',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 18 / 12,
                            letterSpacing: 0,
                            color: Color(0xffFFFFFF),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 24),

                        buildSectionTitle('Social Links'),
                        const SizedBox(height: 4),
                        isTablet
                            ? Row(
                                children: [
                                  Text(
                                    'Add up to 5 social media links to showcase your online presence.',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      height: 18 / 12,
                                      letterSpacing: 0,
                                      color: Color(0xffFFFFFF),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  buildSocialIcons(
                                    imagePath: 'assets/images/insta.png',
                                  ),
                                  SizedBox(width: 4),
                                  buildSocialIcons(
                                    imagePath: 'assets/images/x.png',
                                  ),
                                  SizedBox(width: 4),
                                  buildSocialIcons(
                                    imagePath: 'assets/images/f.png',
                                  ),
                                  SizedBox(width: 4),
                                  buildSocialIcons(
                                    imagePath: 'assets/images/y.png',
                                  ),
                                  SizedBox(width: 4),
                                  buildSocialIcons(
                                    imagePath: 'assets/images/d.png',
                                  ),
                                  SizedBox(width: 4),
                                  buildSocialIcons(
                                    imagePath: 'assets/images/t.png',
                                  ),
                                  SizedBox(width: 4),
                                  buildSocialIcons(
                                    imagePath: 'assets/images/g.png',
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    'Add up to 5 social media links to showcase your online presence.',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      height: 18 / 12,
                                      letterSpacing: 0,
                                      color: Color(0xffFFFFFF),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 4),
                                      buildSocialIcons(
                                        imagePath: 'assets/images/insta.png',
                                      ),
                                      SizedBox(width: 4),
                                      buildSocialIcons(
                                        imagePath: 'assets/images/x.png',
                                      ),
                                      SizedBox(width: 4),
                                      buildSocialIcons(
                                        imagePath: 'assets/images/f.png',
                                      ),
                                      SizedBox(width: 4),
                                      buildSocialIcons(
                                        imagePath: 'assets/images/y.png',
                                      ),
                                      SizedBox(width: 4),
                                      buildSocialIcons(
                                        imagePath: 'assets/images/d.png',
                                      ),
                                      SizedBox(width: 4),
                                      buildSocialIcons(
                                        imagePath: 'assets/images/t.png',
                                      ),
                                      SizedBox(width: 4),
                                      buildSocialIcons(
                                        imagePath: 'assets/images/g.png',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                        const SizedBox(height: 16),

                        buildInputLabel('Link URL'),
                        Column(
                          children: [
                            buildTextFieldFacebook(linkController,
                                maxLines: isTablet ? 2 : 3,
                                showPrefixIcon: true),
                            const SizedBox(height: 22),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 101,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Color(0xFF383838),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFF383838),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x0D0A0D12),
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 2),
                                child: Center(
                                  child: Text(
                                    'Add',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 24 / 16,
                                      letterSpacing: 0,
                                      color: Color(0xffFFFFFF),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Existing social links
                        //adding social lin
                        //..._socialLinks.map((link) => _buildSocialLinkItem(link)),
                      ],
                    )),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 40,
                    width: 129,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff9147FF),
                    ),
                    child: Center(
                      child: Text(
                        'Save Changes',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 20 / 14,
                          letterSpacing: 0,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildSocialIcons({
    required String imagePath,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    Alignment alignment = Alignment.center,
  }) {
    return Image.asset(
      imagePath,
      width: 14,
      height: 13.6,
      fit: fit,
      color: Color(0xffD9D9D9),
      colorBlendMode: colorBlendMode,
      alignment: alignment,
    );
  }

  Widget buildAvatarSection() {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                height: isTablet ? 120 : 60,
                width: isTablet ? 120 : 60,
                decoration: BoxDecoration(
                  color: Color(0xff0F0F0F),
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xff5A189A), width: 1),
                ),
                child: ClipOval(
                  child: _isCustomAvatar && _imageFile != null
                      ? _displaySelectedImage()
                      : Image.asset(
                          _currentAvatar,
                          fit: BoxFit.cover,
                        ),
                ),
              )
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    _showAvatarEditDialog();
                  },
                  child: Container(
                    width: isTablet ? 91 : 64,
                    height: isTablet ? 34 : 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff0A0D12),
                          offset: Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 14 : 7.5,
                        vertical: isTablet ? 8 : 4.31),
                    child: Center(
                      child: Text(
                        'Edit Avatar',
                        style: GoogleFonts.inter(
                          fontSize: isTablet ? 12 : 6.5,
                          fontWeight: FontWeight.w500,
                          height: isTablet ? 18 / 12 : 9.7 / 6.5,
                          letterSpacing: 0,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 405,
                  height: 38,
                  child: Text(
                    'Must be JPEG, PNG, or GIF and cannot exceed 10MB',
                    style: GoogleFonts.inter(
                      fontSize: isTablet ? 16 : 14,
                      fontWeight: FontWeight.w400,
                      height: isTablet ? 18 / 16 : 9.7 / 14,
                      letterSpacing: 0,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: isTablet ? 18 : 18,
        fontWeight: FontWeight.w500,
        height: isTablet ? 1 : 1,
        letterSpacing: 0,
        color: Color(0xff9147FF),
      ),
    );
  }

  Widget buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 18 / 14,
          letterSpacing: 0,
          color: Color(0xffFFFFFF),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        height: 18 / 12,
        letterSpacing: 0,
        color: Color(0xffFFFFFF),
      ),
    );
  }

  Widget buildTextFieldFacebook(TextEditingController controller,
      {int maxLines = 1, bool showPrefixIcon = false}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[800],
        hintText: 'https://www.instagram.com/in/nwanne-nnamani-1b0a03273/',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIcon: showPrefixIcon
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  'assets/images/f.png',
                  color: Colors.blue,
                  width: 11,
                  height: 20,
                ),
              )
            : null,
        prefixIconConstraints: showPrefixIcon
            ? const BoxConstraints(minWidth: 0, minHeight: 0)
            : null,
      ),
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        height: 18 / 12,
        letterSpacing: 0,
        color: const Color(0xffFFFFFF),
      ),
    );
  }

// Widget _buildSocialLinkItem(String link) {
//   return Container(
//     margin: const EdgeInsets.only(bottom: 12),
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//     decoration: BoxDecoration(
//       color: Colors.grey[900],
//       borderRadius: BorderRadius.circular(4),
//     ),
//     child: Row(
//       children: [
//         const Icon(Icons.facebook, color: Colors.white),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Text(
//             link,
//             style: const TextStyle(color: Colors.white),
//           ),
//         ),
//         IconButton(
//           icon: const Icon(Icons.edit, color: Colors.white),
//           onPressed: () {
//             // Edit link
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.delete, color: Colors.white),
//           onPressed: () {
//             setState(() {
//               socialLinks.remove(link);
//             });
//           },
//         ),
//       ],
//     ),
//   );
// }
}
