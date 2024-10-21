import 'package:flutter/material.dart';
import 'package:pokemon/utils/theme_mode.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    loadThemeMode().then((val) => setState(() => _themeMode = val));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
            leading: const Icon(Icons.lightbulb),
            title: const Text('Dark/Light Mode'),
            trailing: Text((_themeMode == ThemeMode.system)
                ? 'System'
                : (_themeMode == ThemeMode.dark ? 'Dark' : 'Light')),
            onTap: () async {
              var ret = await Navigator.of(context).push<ThemeMode>(
                  MaterialPageRoute(
                      builder: (context) =>
                          ThemeModeSelectionPage(mode: _themeMode)));
              setState(() => _themeMode = ret!);
              await saveThemeMode(_themeMode);
            }),
        SwitchListTile(
            title: const Text('Switch'), value: true, onChanged: (yes) => {}),
        CheckboxListTile(
            title: const Text('Switch'), value: true, onChanged: (yes) => {}),
        RadioListTile(
            title: const Text('Radio'),
            value: true,
            groupValue: true,
            onChanged: (yes) => {})
      ],
    );
  }
}

class ThemeModeSelectionPage extends StatefulWidget {
  const ThemeModeSelectionPage({super.key, required this.mode});
  final ThemeMode mode;

  @override
  ThemeModeSelectionPageState createState() => ThemeModeSelectionPageState();
}

class ThemeModeSelectionPageState extends State<ThemeModeSelectionPage> {
  ThemeMode current = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    current = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ListTile(
            leading: IconButton(
                onPressed: () => Navigator.pop<ThemeMode>(context, current),
                icon: const Icon(Icons.arrow_back)),
          ),
          RadioListTile<ThemeMode>(
              value: ThemeMode.system,
              groupValue: current,
              onChanged: (val) => {setState(() => current = val!)},
              title: const Text('System')),
          RadioListTile<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: current,
              onChanged: (val) => {setState(() => current = val!)},
              title: const Text('Dark')),
          RadioListTile<ThemeMode>(
              value: ThemeMode.light,
              groupValue: current,
              onChanged: (val) => {setState(() => current = val!)},
              title: const Text('Light')),
        ],
      )),
    );
  }
}
