import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ini_resto/provider/preferences_provider.dart';
import 'package:ini_resto/provider/scheduling_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
        builder: (context, provider, child)
    {
      return Scaffold(
        appBar: AppBar(
            title: Text("Pengaturan")
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Material(
                    child: ListTile(
                      title: Text('Mode Gelap'),
                      trailing: Switch.adaptive(
                        value: provider.isDarkTheme,
                        onChanged: (value) {
                          provider.enableDarkTheme(value);
                        },
                      ),
                    ),
                  ),
                  Material(
                    child: ListTile(
                      title: Text('Pemberitahuan Restaurant'),
                      trailing: Consumer<SchedulingProvider>(
                        builder: (context, scheduled, _) {
                          return Switch.adaptive(
                            value: scheduled.isScheduled,
                            onChanged: (value) async {
                              scheduled.scheduledNews(value);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    );
  }
  }