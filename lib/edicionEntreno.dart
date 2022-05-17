import 'package:flutter/material.dart';
import 'package:smart_trainer/detalleEntrenamiento.dart';
import 'package:smart_trainer/requests.dart';
import 'package:smart_trainer/training.dart';


class EdicionEntreno extends StatefulWidget {
  const EdicionEntreno({Key key, this.training}) : super(key: key);
  final Training training;

  @override
  _EdicionEntreno createState() => _EdicionEntreno(training);
}

class _EdicionEntreno extends State<EdicionEntreno>{
  _EdicionEntreno(this.training);
  final Training training;
  TextEditingController editingController = TextEditingController();
  String newName;
  DateTime newDate;


  void checkEdit(BuildContext context) {
    bool changed = false;
    print("New name: " + newName);
    print("Training name: " + training.name);
    if (training.name != newName && newName != null) {
      training.name = newName;
      changed = true;
    }

    if (newDate != null) {
      String newD = newDate.day.toString() + "-" + newDate.month.toString() + "-" + newDate.year.toString();
      print("New Date: " + newD);
      print("Training date: " + training.date);
      if (newD != training.date){
        training.date = newD;
        changed = true;
      }
    }

    if (changed == true){
      editTraining(training);
    }
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) => detalleEntrenamiento(training)));
  }

  void _selectDate(BuildContext context) async{
    newDate  = await showDatePicker(
      context: context,
      locale: const Locale("es", "ES"),
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF40916C),
              onPrimary: Colors.white,
              onSurface: Color.fromRGBO(34, 40, 47, 1),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: const Color(0xFF40916C),
              ),
            ),
          ),
          child: child,
        );
      },
    );
  }

  void _changeName(String value){
    newName = value;
  }

  void editT(BuildContext context) {
    bool changed = false;
    if (training.name != newName && newName != "") {
      changed = true;
    }

    if (training.date != newDate) {
      changed = true;
    }

    if (changed == true){

    }
  }

  @override
  Widget build(BuildContext context) {
    final bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom!=0.0;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(34, 40, 47, 1),
      appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: const Color(0xFF40916C),
          title: const Text('SmartTrainer', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.white, fontSize:22)),
          centerTitle: true,
          elevation: 2,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) => detalleEntrenamiento(training))),
            )
          ]
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(30, 25, 30, 8),
                child: TextField(
                  onChanged: (value) {
                    _changeName(value);
                  },
                  style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.white, fontSize:22),
                  controller: editingController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      label: Center(child: Text(training.name)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(
                              color: Color(0xFF40916C), width: 2.0
                          )
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(
                              color: Color(0xFF40916C), width: 2.0
                          )),
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.white, fontSize:20),
                      hintText: training.name,
                      hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.white60, fontSize:20),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              const Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(100, 10, 100, 5),
                child: Text(
                    "Cambiar fecha",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.white60, fontSize:16)),
              ),
              Padding(
                padding:  const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFF40916C),
                    child: IconButton(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(
                        Icons.calendar_month_rounded,
                        color:  Color.fromRGBO(34, 40, 47, 1),
                        size: 30,
                      ),
                    )
                ),
              ),
              Visibility(
                visible: !keyboardIsOpen,
                child: Padding(
                  padding:  const EdgeInsetsDirectional.fromSTEB(15, 35, 15, 15),
                  child: ElevatedButton(
                    onPressed: () => checkEdit(context),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF40916C))),
                    child: const Text(
                        "Confirmar",
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize:18)),
                  ),
                ),
              ),
              Visibility(
                visible: !keyboardIsOpen,
                child: Padding(
                  padding:  const EdgeInsetsDirectional.fromSTEB(15,15, 15, 35),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) => detalleEntrenamiento(training))),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(197, 38, 27, 1))),
                    child: const Text(
                        "Cancelar",
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize:18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

