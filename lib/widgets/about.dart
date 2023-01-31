import 'package:flutter/material.dart';
import 'package:ice_live_viewer/utils/http/checkupdate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class About extends StatelessWidget {
  const About({
    this.version = '0.3.6',
    Key? key,
  }) : super(key: key);

  final String version;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(AppLocalizations.of(context)!.about_title),
        leading: const Icon(Icons.info_outline_rounded),
        onTap: () {
          showAboutDialog(
              context: context,
              applicationName: AppLocalizations.of(context)!.app_title,
              applicationVersion: version,
              applicationIcon: SizedBox(
                width: 60,
                child: Center(
                  child: Image.asset('assets/icon.png'),
                ),
              ),
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context)!.about_update_title),
                  leading: const Icon(
                    Icons.upload_rounded,
                    size: 32,
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => FutureBuilder(
                              future: judgeVersion(version),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List result =
                                      (snapshot.data as String).split('-');
                                  if (result[0] == '1') {
                                    return AlertDialog(
                                      title: Text(AppLocalizations.of(context)!.about_update_title),
                                      content: Text(AppLocalizations.of(context)!.about_update_dialog_text(result[1])),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(AppLocalizations.of(context)!.uni_dialog_button_cancel),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ElevatedButton(
                                          child: Text(AppLocalizations.of(context)!.uni_dialog_button_update),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _launchUrl(
                                                'https://github.com/meanfan/ices_live_viewer/releases');
                                            //launch(snapshot.data);
                                          },
                                        ),
                                      ],
                                    );
                                  } else {
                                    return AlertDialog(
                                      title: Text(AppLocalizations.of(context)!.about_update_title),
                                      content: Text(AppLocalizations.of(context)!.about_update_dialog_latest_text),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(AppLocalizations.of(context)!.uni_dialog_button_ok),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                } else if (snapshot.hasError) {
                                  return AlertDialog(
                                    title: Text(AppLocalizations.of(context)!.about_update_title),
                                    content: Text(AppLocalizations.of(context)!.about_update_dialog_failed_text(snapshot.error)),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(AppLocalizations.of(context)!.uni_dialog_button_ok),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                } else {
                                  return  AlertDialog(
                                    title: Text(AppLocalizations.of(context)!.uni_dialog_title_loading),
                                    content: const LinearProgressIndicator(
                                      minHeight: 10,
                                    ),
                                  );
                                }
                              },
                            ));
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.about_list_github_title),
                  leading: const Icon(
                    Icons.open_in_new_rounded,
                    size: 32,
                  ),
                  onTap: () {
                    _launchUrl('https://github.com/meanfan/ices_live_viewer');
                  },
                ),
              ]);
        });
  }
}

Future<void> _launchUrl(_url) async {
  //print('launching $_url');
  if (!await launchUrl(Uri.parse(_url))) {
    throw 'Could not launch $_url';
  }
}
