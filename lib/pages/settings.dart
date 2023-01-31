import 'package:flutter/material.dart';
import 'package:ice_live_viewer/provider/themeprovider.dart';
import 'package:ice_live_viewer/utils/storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(AppLocalizations.of(context)!.settings_title),
      ),
      body: ListView(
        children: <Widget>[
          SectionTitle(
            title: AppLocalizations.of(context)!.settings_sections_general_title,
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.settings_sections_general_uc_title),
            subtitle: Text(AppLocalizations.of(context)!.settings_sections_general_uc_subtitle),
            leading: const Icon(Icons.construction_rounded, size: 32),
            onTap: () {},
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.settings_sections_general_themecolor_title),
            subtitle: Text(AppLocalizations.of(context)!.settings_sections_general_themecolor_subtitle),
            leading: const Icon(Icons.color_lens, size: 32),
            onTap: () {
              Provider.of<AppThemeProvider>(context, listen: false)
                  .showThemeColorSelectorDialog(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.settings_sections_general_thememode_title),
            subtitle: Text(AppLocalizations.of(context)!.settings_sections_general_thememode_subtitle),
            leading: const Icon(Icons.dark_mode_rounded, size: 32),
            onTap: () {
              Provider.of<AppThemeProvider>(context, listen: false)
                  .showThemeModeSelectorDialog(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.settings_sections_general_language_title),
            subtitle: Text(AppLocalizations.of(context)!.settings_sections_general_language_subtitle),
            leading: const Icon(Icons.translate_rounded, size: 32),
            onTap: () {},
          ),
          SwitchTile(
            title: AppLocalizations.of(context)!.settings_sections_general_huyaresolution_title,
            subtitle: AppLocalizations.of(context)!.settings_sections_general_huyaresolution_subtitle,
            settingKey: 'use_custom_resolution_for_huya',
          ),
          SwitchTile(
            title: AppLocalizations.of(context)!.settings_sections_general_bilibilim3u8_title,
            subtitle: AppLocalizations.of(context)!.settings_sections_general_bilibilim3u8_subtitle,
            settingKey: 'use_m3u8',
          ),
          SectionTitle(
            title: AppLocalizations.of(context)!.settings_sections_experimental_title,
          ),
          SwitchTile(
            title: AppLocalizations.of(context)!.settings_sections_experimental_usewinnativeplayer_title,
            subtitle: AppLocalizations.of(context)!.settings_sections_experimental_usewinnativeplayer_subtitle,
            settingKey: 'use_native_player',
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.headline1),
    );
  }
}

class SwitchTile extends StatefulWidget {
  const SwitchTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.settingKey,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String settingKey;

  @override
  State<SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  bool? _toggled = false;

  @override
  void initState() {
    getSwitchPref(widget.settingKey).then((value) {
      _toggled = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: Text(widget.title),
        subtitle: Text(widget.subtitle),
        value: _toggled!,
        activeColor: Provider.of<AppThemeProvider>(context).themeColor,
        onChanged: (bool value) {
          switchPref(widget.settingKey);
          setState(() {
            _toggled = value;
          });
        });
  }
}
