import 'package:cocktail/model/drinks-model.dart';
import 'package:flutter/material.dart';

import '../../localdatabase/db-data.dart';
import '../../utils/constant/hexcolor.dart';
import '../../utils/constant/image.dart';
import '../../utils/constant/styles.dart';
import '../dashboard/widgets/card-view.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    favData();
  }

  List favDataList = [];
  int favCount = 0;

  void favData() async {
    List data = await DatabaseHelper.instance.favoriteData();
    if (data != null) {
      favDataList = [];
      favCount = data.length;
      for (int i = 0; i < data.length; i++) {
        favDataList.add(Drinks.fromJson(data[i]));
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: thereColor,
        appBar: AppBar(
          backgroundColor: thereColor,
          title: Image.asset(
            AppImages.icn_logo,
            fit: BoxFit.contain,
            width: 200,
          ),
          centerTitle: true,
        ),
        body: favDataList.isNotEmpty
            ? GridView.builder(
                itemCount: favDataList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CardView(
                    drink: favDataList[index],
                    callback: () {
                      favData();
                    },
                  ),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
              )
            : Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(122),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text(
                    'No data found',
                    style: cardTextStyle,
                  ),
                ),
              ));
  }
}
