import 'package:flutter/material.dart';
import 'package:sistemita/models/TodoItem.dart';

class AddTodoAlertDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddTodoAlertDialogState();
}

class _AddTodoAlertDialogState extends State<AddTodoAlertDialog> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title;
  String _description;

  _saveTodo(){
final formState=_formKey.currentState;
if(!formState.validate())return;
formState.save();
Navigator.of(context)
    .pop(TodoItem(_title,description: _description,complete: false
,archived: false));
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Agregar todo'),
      contentPadding: EdgeInsets.all(20.0),
      content: Container(
        child: Form(
          key: _formKey,
          child: Flex(
            direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              onSaved: (val){
                setState(() {
                  _title=val;
                });
              },
              decoration: InputDecoration(labelText: 'Título'),
              validator: (val)=>val==''?'Por favor ingresa el titulo':null,
            ),
            TextFormField(
              onSaved: (val){
                setState(() {
                  _description=val;
                });
              },
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
          ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.of(context).pop(null);
          },
          textColor: Colors.blueGrey,
          child: Text('Cancelar'),
        ),
        RaisedButton(
          onPressed: _saveTodo,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Text('Agregar'),
        ),
      ],
    );
  }
}
