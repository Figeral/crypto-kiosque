import 'package:flutter/material.dart';
import '../../../models/usermodel.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:crypto_kiosque/Configs/backend_server.dart';
import 'package:crypto_kiosque/views/MainContentScreens/profilePage/profile.dart';
import 'package:crypto_kiosque/views/MainContentScreens/settings%20screen/paage.dart';

//  import 'package:ecowatt/pages/home_page.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final RecordModel? _model = Server().server.authStore.model;
  @override
  Widget build(BuildContext context) {
    final user = UserModel.userGenerator(_model!.data);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
        children: [
          Row(
            children: [
              const SizedBox(width: 18),
              const SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                user.username,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsItem(Icons.person, 'Account', const ProfilePage()),

          const SizedBox(height: 12),
          _buildSettingsItem(Icons.lock, "Password and Access", const SettingPage()),
          const SizedBox(height: 12),
          _buildSettingsItem(Icons.language, 'Language', const SettingPage()),
          const SizedBox(height: 12),
          _buildSettingsItem(
              Icons.notifications, 'Notifications', const SettingPage()),
          const SizedBox(height: 12),
          _buildSettingsItem(Icons.storage, 'Data Storage', const SettingPage()),
          const SizedBox(height: 12),
          _buildSettingsItem(
              Icons.privacy_tip, 'Confidentiality Politics', const SettingPage()),
          const SizedBox(height: 12),
          _buildSettingsItem(
              Icons.info, 'Application Information', const SettingPage()),
          const SizedBox(height: 8),
          // const Center(
          //   child: Text(
          //     'Powered by Arthur Kemdjo',
          //     style: TextStyle(
          //         color: Color(0XFF808080),
          //         fontSize: 6,
          //         fontFamily: 'Inter',
          //         fontWeight: FontWeight.w600),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, Widget destination) {
    return SizedBox(
      height: 50,
      child: ListTile(
        trailing: const Icon(Icons.keyboard_arrow_right_outlined),
        // selected: true,
        titleAlignment: ListTileTitleAlignment.center,
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
      ),
    );
  }
}
