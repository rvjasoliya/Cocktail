import 'package:cocktail/screen/detailscreen/drink-detail-screen.dart';
import 'package:cocktail/utils/constant/string.dart';
import 'package:flutter/material.dart';

import '../../../model/drinks-model.dart';
import '../../../utils/constant/styles.dart';

class CardView extends StatefulWidget {
  final Drinks? drink;
  Function? callback;
  CardView({this.drink, this.callback, Key? key}) : super(key: key);

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DrinkDetailScreen(
                      drink: widget.drink,
                    ))).then((value) {
          widget.callback!();
        });
      },
      child: Card(
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
                      image: NetworkImage(widget.drink?.strDrinkThumb ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (widget.drink?.strDrink ?? '').useCorrectEllipsis(),
                  style: cardTextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
      ),
    );
  }
}
