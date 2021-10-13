import 'package:appfood/pages/bussinesItemMenu/bussines_data_page.dart';
import 'package:appfood/pages/bussinesItemMenu/category_product_page.dart';
import 'package:appfood/pages/bussinesItemMenu/contac_number_page.dart';
import 'package:appfood/pages/bussinesItemMenu/product_menu_page.dart';
import 'package:appfood/theme/theme_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPageBussines extends StatefulWidget {
  final String idClient;
  final String idBusiness;
  final List dataBusiness;
  DetailPageBussines(this.idClient, this.idBusiness, this.dataBusiness);

  @override
  _DetailPageBussinesState createState() =>
      _DetailPageBussinesState(this.idBusiness);
}

class _DetailPageBussinesState extends State<DetailPageBussines> {
  TextEditingController textContrllerPhoneContact = TextEditingController();
  TextEditingController textContrllerDescriptionPhoneContact =
      TextEditingController();

  _DetailPageBussinesState(String idBusiness) {
    this.id = idBusiness;
  }
  String id = '';
  @override
  void initState() {
    super.initState();
    id = widget.idBusiness;
  }

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> _documentStream =
        FirebaseFirestore.instance.collection('business').doc(id).snapshots();
    final sizeScreen = MediaQuery.of(context).size;

    return StreamBuilder<DocumentSnapshot>(
        stream: _documentStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
                color: Colors.white,
                child: Center(child: Text('Something went wrong')));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()));
          }

          //dataNumberContact = snapshot.data!['contactNumbers'];

          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              title: Text(widget.dataBusiness[0]['name'].toString()),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  imgContainer(sizeScreen, widget.dataBusiness[0]['imageUrl']),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: sizeScreen.height * 0.6,
                    child: GridView.count(
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 6.0,
                        crossAxisCount: 2,
                        children: [
                          itemOptionPremiun(sizeScreen),
                          itemOption(sizeScreen, Icons.storefront_outlined,
                              'Gestionar datos', 0, snapshot.data, context),
                          itemOption(sizeScreen, Icons.category_outlined,
                              'Gestionar Categoria', 1, snapshot.data, context),
                          itemOption(sizeScreen, Icons.restaurant_menu_outlined,
                              'Gestionar menu', 2, snapshot.data, context),
                          itemOption(sizeScreen, Icons.phone_android_outlined,
                              'Gestionar telefonos', 3, snapshot.data, context),
                          itemOption(sizeScreen, Icons.watch_later_outlined,
                              'Gestionar horarios', 4, snapshot.data, context),
                        ]),
                  ),
                ],
              ),
            ),
          ));
        });
  }

  Widget imgContainer(sizeScreen, String url) {
    return Container(
      width: sizeScreen.width,
      height: 250,
      child: Image.network(
        '$url',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget itemOption(sizeScreen, IconData icon, String title, int index, data,
      BuildContext context) {
    List<String> categories = [];
    for (int i = 0; i < data!['categories'].length; i++) {
      categories.add(data!['categories'][i].toString());
    }

    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BussinesDataPage(widget.idBusiness,
                        data!['rubic'].toString(), data!['name'].toString())));
            break;
          case 1:
            manageCategoryProduct(sizeScreen, context, data['categories']);
            break;
          case 2:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductMenuPage(
                        widget.idBusiness,
                        data!['name'],
                        data!['menu'],
                        categories,
                        data!['rubic'])));
            // manageMenu(sizeScreen, context, data!['menu']);
            break;
          case 3:
            managePhoneContact(sizeScreen, context, data!['contactNumbers']);
            break;
          case 4:
            break;

          default:
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Palette.kToDark),
        padding: EdgeInsets.all(5),
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Color(0xff283747),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '$title',
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff283747),
                  fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.chevron_right,
              color: Color(0xff283747),
            )
          ],
        ),
      ),
    );
  }

  Widget itemOptionPremiun(sizeScreen) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Color(0xff283747)),
      padding: EdgeInsets.all(5),
      height: 50,
      child: Column(
        children: [
          Image.network('https://img.icons8.com/color/48/000000/confetti.png'),
          SizedBox(
            width: 10,
          ),
          Text(
            'Unete a nuestros planes',
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[100],
                fontWeight: FontWeight.bold),
          ),
          Expanded(child: Container()),
          Icon(
            Icons.chevron_right,
            color: Colors.grey[100],
          )
        ],
      ),
    );
  }

  void managePhoneContact(final _sizeScreen, BuildContext context, List data) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return ContacNumberPage(widget.idBusiness, data);
        });
  }

  void manageCategoryProduct(
      final _sizeScreen, BuildContext context, List data) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return CategoryProductPage(widget.idBusiness, data);
        });
  }

  // void manageMenu(final _sizeScreen, context, List data) {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       backgroundColor: Colors.transparent,
  //       context: context,
  //       builder: (context) {
  //         return ProductMenuPage(widget.idBusiness, data);
  //       });
  // }
}
