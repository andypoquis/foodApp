import 'package:appfood/logic/logic_business_user.dart';
import 'package:appfood/model/business.dart';
import 'package:appfood/pages/business_page/add_business_page.dart';
import 'package:appfood/pages/business_page/detail_bussines_page.dart';
import 'package:appfood/shared/shared_preference.dart';
import 'package:appfood/theme/theme_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuHamburger extends StatefulWidget {
  MenuHamburger({key}) : super(key: key);

  @override
  _MenuHamburgerState createState() => _MenuHamburgerState();
}

class _MenuHamburgerState extends State<MenuHamburger> {
  final moviesRef = FirebaseFirestore.instance
      .collection('business')
      .withConverter<BusinessDocument>(
        fromFirestore: (snapshot, _) =>
            BusinessDocument.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  final bussinesRef = FirebaseFirestore.instance
      .collection('business')
      .withConverter<BusinessDocument>(
          fromFirestore: (snpashot, _) =>
              BusinessDocument.fromJson(snpashot.data()!),
          toFirestore: (business, _) => business.toJson());
  List? dataBussines;
  Future<void> main() async {
    // Obtain science-fiction movies
    final prefs = await SharedPreferences.getInstance();
    List<QueryDocumentSnapshot<BusinessDocument>> bussinesData = await moviesRef
        .where('clientId', isEqualTo: prefs.getStringList('data_client')![0])
        .get()
        .then((snapshot) => snapshot.docs);
    final uwu = await SharedPreferencesData().getDataClient();

    name = uwu[1];
    id = uwu[0];

    dataBussines = bussinesData;
  }

  String name = '', id = '';
  List<String> _data = ['', '', ''];
  final myLogic2 = LogicBusinessUser();
  bool isBussinesContainer = false;
  @override
  void initState() {
    super.initState();
    // setState(() {
    //   showData();
    //   main();

    //   //if (dataClient[0] != '') myLogic2.getBusinessUser('lzgNPt1k5XFa2iBSdZBk');
    // });
    _loadDataClient();
    main();
  }

  void _loadDataClient() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _data = (prefs.getStringList('data_client') ?? []);
    });
  }

  @override
  void dispose() {
    //myLogic2.cancel();
    super.dispose();
  }

  // Future<void> showData() async {
  //   SharedPreferences prefrs = await SharedPreferences.getInstance();

  //   final dataClient = prefrs.getStringList('data_client') ?? [];
  //   ('Email: ${dataClient[0]}');
  // }

  @override
  Widget build(BuildContext context) {
    // myLogic2.getBusinessUser(dataClient![0]);s

    //_loadDataClient();

    //print('email: ${dataClient![1]}');
    return Container(
        child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            child: Drawer(
                child: Container(
              padding: EdgeInsets.all(20),
              color: Color(0XFFFEE6B5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          'https://i.pinimg.com/564x/3f/50/e4/3f50e4f1f01ee3c58eecd9730b38d04a.jpg',
                          width: 75,
                        ),
                      ),
                      Expanded(child: Container()),
                      name == null ? Text('No data') : textName(),
                      Expanded(child: Container())
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Menu Rapidito',
                    style: TextStyle(
                        color: Palette.kToDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  SizedBox(height: 25),
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: [
                          itemMenu(Icons.person_outline, 'Perfil', 0),
                          SizedBox(
                            height: 15,
                          ),
                          itemMenu(Icons.store_outlined, 'Negocio', 1),
                          itemBusiness(),
                          SizedBox(
                            height: 15,
                          ),
                          itemMenu(Icons.help_outline, 'Ayuda', 2),
                        ],
                      ),
                    ),
                  ),
                  logOutItem(Icons.login_outlined, 'Cerrar sesión')
                ],
              ),
            ))));
  }

  Widget itemMenu(IconData itemIcon, String titleItem, int index) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 1:
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => StorePage()));
            setState(() {
              isBussinesContainer = !isBussinesContainer;
            });
            break;

          case 5:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddBusinessPage()));
            break;
          default:
        }
      },
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(5),
              child: Icon(
                itemIcon,
                color: Palette.kToDark,
              )),
          SizedBox(
            width: 15,
          ),
          Text(
            titleItem,
            style:
                TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }

  Widget itemBusiness() {
    double sizeContainer = 0;
    if (!isBussinesContainer) {
      return Container();
    } else {
      if (dataBussines != null) sizeContainer = 45 * (dataBussines!.length / 1);
      return Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 25),
            height: sizeContainer,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: dataBussines!.length,
                itemBuilder: (_, index) => Column(
                      children: [
                        addBussinesItem(dataBussines![index]['name'],
                            dataBussines![index].id, index),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    )),
          ),
          SizedBox(
            height: 0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: itemMenu(Icons.add_business_outlined, 'Agregar negocio', 5),
          ),
        ],
      );

      // return Container(
      //   child: ValueListenableBuilder<List<Business>?>(
      //     valueListenable: myLogic2.business,
      //     builder: (context, bussines, _) {
      //       if (bussines != null) sizeContainer = 45 * (bussines.length / 1);
      //       print('Esto es un dato: ${bussines![0].address}');
      //       return Column(
      //         children: [
      //           SizedBox(
      //             height: 10,
      //           ),
      //           Container(
      //             padding: EdgeInsets.only(left: 25),
      //             height: sizeContainer,
      //             child: ListView.builder(
      //                 physics: NeverScrollableScrollPhysics(),
      //                 itemCount: bussines.length,
      //                 itemBuilder: (_, index) => Column(
      //                       children: [
      //                         GestureDetector(
      //                           child: addBussinesItem(bussines[index].name),
      //                         ),
      //                         SizedBox(
      //                           height: 15,
      //                         )
      //                       ],
      //                     )),
      //           ),
      //           SizedBox(
      //             height: 20,
      //           ),
      //           Padding(
      //             padding: EdgeInsets.only(left: 25),
      //             child: itemMenu(
      //                 Icons.add_business_outlined, 'Agregar negocio', 5),
      //           ),
      //         ],
      //       );
      //     },
      //   ),
      // );
    }
  }

  Widget logOutItem(IconData itemIcon, String titleItem) {
    return Row(
      children: [
        Icon(
          itemIcon,
          color: Palette.kToDark,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          titleItem,
          style:
              TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
        ),
        Expanded(child: Container())
      ],
    );
  }

  Widget textName() {
    String? name2 = name;
    String newName = '';
    int count = 0;

    for (int i = 0; i < name2.length; i++) {
      if (name2.substring(count, i) != ' ') {
        newName += name2.substring(count, i);

        count = i;
      } else {
        break;
      }
    }
    return Text(
      '¡Hola, $newName!',
      style: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey[800]),
    );
  }

  Widget addBussinesItem(titleItem, String idBusiness, int index) {
    return GestureDetector(
      onTap: () async {
        print('la data es: ${dataBussines![index]['name']}');
        List newDataBusiness = [dataBussines![index]];

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailPageBussines(id, idBusiness, newDataBusiness)));
      },
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.storefront_outlined,
                color: Palette.kToDark,
              )),
          SizedBox(
            width: 15,
          ),
          Text(
            titleItem,
            style:
                TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
