import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class AddEditPage extends StatefulWidget {
  final List list;
  final int index;
  AddEditPage({this.list,this.index});
  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {

  TextEditingController tipo = TextEditingController();
  TextEditingController def_tipo = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController description = TextEditingController();


  bool editMode = false;
  addUpdateData(){
    if(editMode){
      var url = 'http://192.168.100.6/php_mysql_crud/edit.php';
      http.post(url,body: {
        'id' : widget.list[widget.index]['id'],
        'ttype' : tipo.text,
        'tipraza' : def_tipo.text,
        'color' : color.text,
        'states' : state.text,
        'descriptions' : description.text,
      });
    }else{
      var url = 'http://192.168.100.6/php_mysql_crud/add.php';
      http.post(url,body: {
        'ttype' : tipo.text,
        'tipraza' : def_tipo.text,
        'color' : color.text,
        'states' : state.text,
        'descriptions' : description.text,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.index != null){
      editMode = true;
      tipo.text = widget.list[widget.index]['ttype'];
      def_tipo.text = widget.list[widget.index]['tipraza'];
      color.text = widget.list[widget.index]['color'];
      state.text = widget.list[widget.index]['states'];
      description.text = widget.list[widget.index]['descriptions'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(editMode ? 'Actualizar Registros' :'Añadir Registros'),),
      body: ListView(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: tipo,
              decoration: InputDecoration(
                labelText: 'Objeto/Mascota',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: def_tipo,
              decoration: InputDecoration(
                labelText: 'Tipo/Raza',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: color,
              decoration: InputDecoration(
                labelText: 'Color',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: state,
              decoration: InputDecoration(
                labelText: 'Estado',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: description,
              decoration: InputDecoration(
                labelText: 'Lugar',
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(8),
            child: RaisedButton(
              onPressed: (){
                setState(() {
                  addUpdateData();
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),),);
                debugPrint('Actualizando');
              },
              color: Colors.deepPurple,
              child: Text(editMode ? 'Actualizar' :'Guardar',style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
