import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistemita/models/TodoItem.dart';
import 'package:sistemita/pages/addTodoAlertDialog.dart';

class TodosArchivesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodosArchivesPageState();
}

class _TodosArchivesPageState extends State<TodosArchivesPage> {
  CollectionReference _todosRef;
  FirebaseUser _user;


  @override
  void initState() {
    super.initState();
    _setUpTodosPage();
  }

  void _setUpTodosPage() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _user = user;
      _todosRef = Firestore.instance
          .collection('users')
          .document(_user.uid)
          .collection('todos');
    });
  }

  Widget _buildBody() {
    if (_todosRef == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return StreamBuilder(
        stream: _todosRef.where('archived', isEqualTo: true).snapshots(),
        builder: _buildTodoList,
      );
    }
  }

  Widget _buildTodoList(
      BuildContext builContext, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (snapshot.data.documents.length == 0) {
        return _buildEmptyMessage();
      } else {
        return ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            TodoItem item = TodoItem.from(document);
            return Dismissible(
              key: Key(item.id),
              background: Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    'Eliminar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onDismissed: (DismissDirection direction) {
                document.reference.delete();
              },
              child: Card(
                child: ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.description),
                ),
              ),
            );
          }).toList(),
        );
      }
    }
  }

  Widget _buildEmptyMessage() {
    return Center(
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.check,
            size: 45.0,
            color: Colors.blueGrey,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Text(
            'Parece que no tiene datos archivados',
            style: TextStyle(color: Colors.blueGrey),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  _addTodo() async {
    TodoItem item = await showDialog(
        context: context, builder: (_) => AddTodoAlertDialog());
    if (item != null) {
      await _todosRef.add(item.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _addTodo,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Archivos reciclados'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: _buildBody(),
        ));
  }
}
