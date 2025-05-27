import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Color primaryColor = Color(0xFF0A66C2);
  bool _isNotificationExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.arrow_back, color: primaryColor),
            SizedBox(width: 8),
            Text("Settings", style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserInfo(),
          Divider(thickness: 1),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildSettingTile(Icons.phone_forwarded, 'Forward Calls'),
                _buildExpandableTile(),
                _buildSettingTile(Icons.volume_up, 'Sound and Vibration'),
                _buildSettingTile(Icons.logout, 'Logout'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/user.jpg'), // Update with actual path
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Alison Alex", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 4),
              Text("123-456-7890", style: TextStyle(color: Colors.grey[700])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4),
      leading: CircleAvatar(
        backgroundColor: Colors.grey[100],
        child: Icon(icon, color: primaryColor),
      ),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  Widget _buildExpandableTile() {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 4),
          leading: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: Icon(Icons.notifications, color: primaryColor),
          ),
          title: Text('Notification'),
          trailing: Icon(
            _isNotificationExpanded ? Icons.expand_less : Icons.expand_more,
            size: 24,
          ),
          onTap: () {
            setState(() {
              _isNotificationExpanded = !_isNotificationExpanded;
            });
          },
        ),
        if (_isNotificationExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 72),
            child: Column(
              children: [
                _buildSubNotification('Missed call alert'),
                _buildSubNotification('Voicemail alert'),
                _buildSubNotification('Call reminders'),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSubNotification(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Switch(value: true, onChanged: (val) {}),
      ],
    );
  }
}
