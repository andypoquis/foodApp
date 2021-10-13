import 'package:appfood/pages/camara_page.dart';
import 'package:flutter/material.dart';

class BussinesDataPage extends StatefulWidget {
  final String idBussines, nameRubric, nameBussines;
  BussinesDataPage(this.idBussines, this.nameRubric, this.nameBussines);

  @override
  _BussinesDataPageState createState() => _BussinesDataPageState();
}

class _BussinesDataPageState extends State<BussinesDataPage> {
  bool isChangedName = false;
  TextEditingController textControllerName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (!isChangedName) {
      textControllerName.text = widget.nameBussines;
      isChangedName = true;
    }
    final sizeScreen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text('Gestionar datos'),
              SizedBox(
                height: 20,
              ),
              nameTextField(sizeScreen),
              SizedBox(
                height: 20,
              ),
              CameraWidget(true, true, textControllerName.text, '', '',
                  widget.idBussines, '', '', '', ''),

              // containerButton(sizeScreen)
            ],
          ),
        ),
      ),
    );
  }

  Widget nameTextField(sizeScreen) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
          keyboardType: TextInputType.text,
          controller: textControllerName,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Negocio',
          )),
    );
  }

  // Widget containerButton(sizeScreen) {
  //   return Container(
  //     width: sizeScreen.width * 0.35,
  //     height: 55,
  //     child: TextButton(
  //         style: ButtonStyle(
  //           backgroundColor: MaterialStateProperty.all<Color>(
  //               Color.fromRGBO(252, 175, 3, 1)),
  //           foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
  //           overlayColor: MaterialStateProperty.resolveWith<Color>(
  //             (Set<MaterialState> states) {
  //               if (states.contains(MaterialState.hovered))
  //                 return Colors.yellow.withOpacity(0.04);
  //               if (states.contains(MaterialState.focused) ||
  //                   states.contains(MaterialState.pressed))
  //                 return Colors.yellow.withOpacity(0.12);
  //               return Colors.yellow
  //                   .withOpacity(0.12); // Defer to the widget's default.
  //             },
  //           ),
  //         ),
  //         onPressed: () {},
  //         child: Text('Guardar')),
  //   );
  // }
}
