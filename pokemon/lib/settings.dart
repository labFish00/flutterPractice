import 'package:flutter/material.dart';
import 'package:pokemon/models/theme_mode.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(
      builder: (context, mode, child) => ListTile(
          leading: const Icon(Icons.lightbulb),
          title: const Text('Dark/Light Mode'),
          trailing: Text((mode.mode == ThemeMode.system)
              ? 'System'
              : (mode.mode == ThemeMode.dark ? 'Dark' : 'Light')),
          onTap: () async {
            var ret = await Navigator.of(context).push<ThemeMode>(
                MaterialPageRoute(
                    builder: (context) =>
                        ThemeModeSelectionPage(mode: mode.mode)));
            if (ret != null) {
              mode.update(ret);
            }
          }),
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
  late ThemeMode current;

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
