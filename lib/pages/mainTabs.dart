import 'package:flutter/material.dart';
import 'package:sistemita/pages/settings.dart';
import 'package:sistemita/pages/todos.dart';
import 'package:sistemita/pages/todosArchive.dart';

class MainTabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
            length: 3,
            child: new Scaffold(
              body: TabBarView(
                children: <Widget>[
                  TodosPage(),
                  TodosArchivesPage(),
                  SettingsPage(),
                ],
              ),
              bottomNavigationBar: PreferredSize(
                preferredSize: Size(60.0, 60.0),
                child: Container(
                  height: 60.0,
                  child: TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    labelStyle: TextStyle(fontSize: 10.0),
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(Icons.list),
                        text: 'Todos',
                      ),
                      Tab(
                        icon: Icon(Icons.history),
                        text: 'Archivos',
                      ),
                      Tab(
                        icon: Icon(Icons.settings),
                        text: 'Ajustes',
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
