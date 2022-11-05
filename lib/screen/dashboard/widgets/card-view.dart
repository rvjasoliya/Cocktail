import 'package:cocktail/screen/detailscreen/drink-detail-screen.dart';
import 'package:cocktail/utils/constant/string.dart';
import 'package:flutter/material.dart';

import '../../../model/drinks-model.dart';
import '../../../utils/constant/hexcolor.dart';
import '../../../utils/constant/styles.dart';

class CardView extends StatelessWidget {
  final Drinks? drink;

  const CardView(
      this.drink,
      );

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return DrinkDetailScreen(drink: drink,);
        }));
      },
      child: Card(
        //elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: 220.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(drink?.strDrinkThumb ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (drink?.strDrink ?? '').useCorrectEllipsis(),
                  style: cardTextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
      ),
    );;
  }
}