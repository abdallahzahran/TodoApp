import 'package:flutter/material.dart';

import '../../../core/translation/translation_helper.dart';


class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String _selectedLanguage = 'EN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Language', style: TextStyle(fontSize: 16)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () =>  TranslationHelper.changeLanguage(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedLanguage == 'AR' ? Colors.green : Colors.grey[300],
                    foregroundColor: _selectedLanguage == 'AR' ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    minimumSize: Size(40, 30),
                  ),
                  child: Text('AR', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => TranslationHelper.changeLanguage(false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedLanguage == 'EN' ? Colors.green : Colors.grey[300],
                    foregroundColor: _selectedLanguage == 'EN' ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    minimumSize: Size(40, 30),
                  ),
                  child: Text('EN', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          // ممكن تضيف هنا خيارات إعدادات تانية
        ],
      ),
    );
  }
}