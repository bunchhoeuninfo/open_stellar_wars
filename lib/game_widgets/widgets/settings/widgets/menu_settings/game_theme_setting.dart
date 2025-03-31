
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';

class GameThemeSetting extends StatefulWidget {
  final String currentTheme;
  final Function(String) onThemeChanged;

  const GameThemeSetting({super.key,required this.currentTheme, required this.onThemeChanged});

  @override
  State<GameThemeSetting> createState() => _GameThemeSettingState();
}

class _GameThemeSettingState extends State<GameThemeSetting> {
  late String _selectedTheme;

  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.currentTheme;
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.debug('Building Game Theme Setting');
    return _dropdownButton();
  }

  DropdownButton _dropdownButton() {
    LogUtil.debug('Building Game Theme Setting');
    return DropdownButton<String>(
      value: _selectedTheme,
      onChanged: (String? newValue) {
        setState(() {
          _selectedTheme = newValue!;
          widget.onThemeChanged(_selectedTheme);
        });
      },
      items: <String>['Light', 'Dark', 'Classic', 'Futuristic']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}