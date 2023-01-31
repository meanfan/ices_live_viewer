import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

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
        title: Text(AppLocalizations.of(context)!.help_title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SectionTitle(title: AppLocalizations.of(context)!.help_body_sections_how_title,),
          TextTile(text: AppLocalizations.of(context)!.help_body_sections_how_text),
          SectionTitle(title: AppLocalizations.of(context)!.help_body_sections_support_title),
          TextTile(text: AppLocalizations.of(context)!.help_body_sections_support_text),
          SectionTitle(title: AppLocalizations.of(context)!.help_body_sections_playissue_title),
          TextTile(text: AppLocalizations.of(context)!.help_body_sections_playissue_text)
        ],
      ),
    );
  }
}

class TextTile extends StatelessWidget {
  const TextTile({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
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
