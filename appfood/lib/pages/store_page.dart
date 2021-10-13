import 'package:appfood/pages/business_page/add_business_page.dart';
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  TextEditingController textControllerName = TextEditingController();
  TextEditingController textControllerAddress = TextEditingController();
  TextEditingController contactNumbers = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Negocios'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [addStore(context)],
        ),
      ),
    );
  }

  Widget addStore(context) {
    //final _sizeScreen = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddBusinessPage()));
        //addBusiness(_sizeScreen, context);
      },
      child: Card(
        child: Container(
          color: Color(0xffFEF9E7),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_business_outlined,
                color: Colors.grey[700],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Agregar nuevo negocio',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addBusiness(final _sizeScreen, context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0))),
            child: Container(
              height: _sizeScreen.height * 0.85,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Nuevo negocio',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  nameTextFiel(_sizeScreen),
                  SizedBox(
                    height: 20,
                  ),
                  nameAddress(_sizeScreen),
                  SizedBox(
                    height: 20,
                  ),
                  categoriesBusiness(_sizeScreen),
                ],
              ),
            ),
          );
        });
  }

  Widget nameTextFiel(_sizeScreen) {
    return Container(
      color: Colors.grey[200],
      child: TextFormField(
        controller: textControllerName,
        decoration: InputDecoration(
            icon: Icon(Icons.store_outlined),
            border: InputBorder.none,
            labelText: 'Negocio: '),
      ),
    );
  }

  Widget nameAddress(_sizeScreen) {
    return Container(
      color: Colors.grey[200],
      child: TextFormField(
        controller: textControllerAddress,
        decoration: InputDecoration(
            icon: Icon(Icons.location_on_outlined),
            border: InputBorder.none,
            labelText: 'Direccion: '),
      ),
    );
  }

  Widget categoriesBusiness(_sizeScreen) {
    return Container(
      color: Colors.grey[200],
      child: TextFormField(
        controller: textControllerAddress,
        decoration: InputDecoration(
            icon: Icon(Icons.category_outlined),
            border: InputBorder.none,
            labelText: 'Categoria'),
      ),
    );
  }
}
