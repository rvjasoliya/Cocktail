import 'package:cocktail/utils/constant/string.dart';
import 'package:flutter/material.dart';

import '../../localdatabase/db-data.dart';
import '../../model/drinks-model.dart';
import '../../utils/constant/hexcolor.dart';
import '../../utils/constant/image.dart';
import '../../utils/constant/singleTon.dart';
import '../../utils/constant/styles.dart';

class DrinkDetailScreen extends StatefulWidget {
  final Drinks? drink;
  const DrinkDetailScreen({Key? key, this.drink}) : super(key: key);

  @override
  State<DrinkDetailScreen> createState() => _DrinkDetailScreenState();
}

class _DrinkDetailScreenState extends State<DrinkDetailScreen> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    favDataGet();
  }

  favDataGet() async {
    List data = await DatabaseHelper.instance
        .checkIsfavoriteData(widget.drink?.idDrink);
    if (data.isNotEmpty) {
      isFav = true;
    } else {
      isFav = false;
    }
    setState(() {});
  }

  Widget imageView() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.maxFinite,
          height: (AppSession.shared.width! * 1.08),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            image: DecorationImage(
              image: NetworkImage(widget.drink?.strDrinkThumb ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: (AppSession.shared.width! / 2),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: const Alignment(0.0, -1),
                begin: const Alignment(0.0, 0.4),
                colors: <Color>[
                  Colors.black54,
                  Colors.black12.withOpacity(0.0)
                ],
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              (widget.drink?.strDrink ?? '').useCorrectEllipsis(),
              style: textFieldStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget titleView(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          (text).useCorrectEllipsis(),
          style: infoTitleStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget detailView(String text) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10.0, right: 10, left: 10, bottom: 15),
        child: Text(
          text,
          style: infoDetailStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  String getIngredient() {
    String ingredient = "";
    var ingredients = [
      widget.drink?.strIngredient1,
      widget.drink?.strIngredient2,
      widget.drink?.strIngredient3,
      widget.drink?.strIngredient4,
      widget.drink?.strIngredient5,
      widget.drink?.strIngredient6,
      widget.drink?.strIngredient7,
      widget.drink?.strIngredient8,
      widget.drink?.strIngredient9,
      widget.drink?.strIngredient10,
      widget.drink?.strIngredient11,
      widget.drink?.strIngredient12,
      widget.drink?.strIngredient12,
      widget.drink?.strIngredient13,
      widget.drink?.strIngredient14,
      widget.drink?.strIngredient15
    ];

    for (String? i in ingredients) {
      if (ingredient.isNotEmpty) {
        ingredient += ((i != null && i.isNotEmpty) ? "\n$i" : "");
      } else {
        ingredient += (i != null && i.isNotEmpty) ? i : "";
      }
    }
    return ingredient;
  }

  @override
  Widget build(BuildContext context) {
    AppSession.shared.height = MediaQuery.of(context).size.height;
    AppSession.shared.width = MediaQuery.of(context).size.width;
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
        actions: [
          MaterialButton(
            onPressed: () {
              DatabaseHelper.instance.favoriteUpdate(
                  widget.drink?.idDrink, (isFav != true ? "1" : "0"));
              isFav = !isFav;
              setState(() {});
            },
            minWidth: 0,
            padding: const EdgeInsets.all(10),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: const CircleBorder(),
            child: Icon(
              Icons.favorite_rounded,
              size: 28,
              color: isFav == true ? Colors.red : Colors.grey[400],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageView(),
            titleView('Category:'),
            detailView(
              widget.drink?.strCategory ?? '',
            ),
            const Divider(color: Colors.white, height: 1),
            titleView('Instructions:'),
            detailView(
              widget.drink?.strInstructionsDE ?? '',
            ),
            const Divider(color: Colors.white, height: 1),
            titleView('Ingredient:'),
            detailView(
              getIngredient(),
            ),
          ],
        ),
      ),
    );
  }
}
