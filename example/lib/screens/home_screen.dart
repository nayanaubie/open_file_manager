import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file_manager/open_file_manager.dart';

import '../utils/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _androidFolderTypes = [
    AndroidFolderType.recent,
    AndroidFolderType.download,
    AndroidFolderType.other,
  ];
  var _selectedAndroidFolderType = AndroidFolderType.download;

  final _formKey = GlobalKey<FormState>();

  /// Used to get the folder path from the user.
  /// In Android, must required when folder type is "Other".
  /// In iOS, optional.
  final _folderPathController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Open File Manager Example')),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (Platform.isAndroid) ...[
              const Text(
                'Select Android Folder Type',
                style: TextStyle(fontSize: 20),
              ),
              RadioGroup<AndroidFolderType>(
                groupValue: _selectedAndroidFolderType,
                onChanged: (folderType) {
                  if (folderType != _selectedAndroidFolderType) {
                    setState(
                      () =>
                          _selectedAndroidFolderType =
                              folderType ?? _selectedAndroidFolderType,
                    );
                  }
                },
                child: ListView.builder(
                  itemCount: _androidFolderTypes.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemBuilder:
                      (context, i) => RadioListTile<AndroidFolderType>(
                        value: _androidFolderTypes[i],
                        title: Text(_androidFolderTypes[i].name.capitalize()),
                      ),
                ),
              ),
            ],
            if (_selectedAndroidFolderType == AndroidFolderType.other ||
                Platform.isIOS) ...[
              Text(
                'Write ${Platform.operatingSystem} folder path below ${Platform.isIOS ? '(optional)' : ''}:',
                style: const TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextFormField(
                  controller: _folderPathController,
                  decoration: InputDecoration(
                    hintText:
                        'e.g. ${Platform.isAndroid ? 'Pictures/Screenshots' : 'Reports/Sheets'}',
                    labelText: 'Folder Path',
                  ),
                  validator: (value) {
                    if (Platform.isAndroid &&
                        _selectedAndroidFolderType == AndroidFolderType.other) {
                      if (value == null || value.isEmpty) {
                        return 'Folder path cannot be empty';
                      }
                    }
                    return null;
                  },
                ),
              ),
            ],
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  openFileManager(
                    androidConfig: AndroidConfig(
                      folderType: _selectedAndroidFolderType,
                      folderPath: _folderPathController.text.trim(),
                    ),
                    iosConfig: IosConfig(
                      folderPath: _folderPathController.text.trim(),
                    ),
                  );
                }
              },
              child: const Text('Open File Manager'),
            ),
          ],
        ),
      ),
    );
  }
}
