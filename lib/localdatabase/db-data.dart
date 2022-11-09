import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/drinks-model.dart';

class DatabaseHelper {
  static const _databaseName = "drinkData.db";
  static const _databaseVersion = 1;

  static final drinksTable = '$Drinks';
  static const fromDate = '';
  static const toDate = '';
  static const advance = '';

  static const idDrink = 'idDrink';
  static const strDrink = 'strDrink';
  static const strDrinkAlternate = 'strDrinkAlternate';
  static const strTags = 'strTags';
  static const strVideo = 'strVideo';
  static const strCategory = 'strCategory';
  static const strIBA = 'strIBA';
  static const strAlcoholic = 'strAlcoholic';
  static const strGlass = 'strGlass';
  static const strInstructions = 'strInstructions';
  static const strInstructionsES = 'strInstructionsES';
  static const strInstructionsDE = 'strInstructionsDE';
  static const strInstructionsFR = 'strInstructionsFR';
  static const strInstructionsIT = 'strInstructionsIT';
  static const strInstructionsZHHANS = 'strInstructionsZHHANS';
  static const strInstructionsZHHANT = 'strInstructionsZHHANT';
  static const strDrinkThumb = 'strDrinkThumb';
  static const strIngredient1 = 'strIngredient1';
  static const strIngredient2 = 'strIngredient2';
  static const strIngredient3 = 'strIngredient3';
  static const strIngredient4 = 'strIngredient4';
  static const strIngredient5 = 'strIngredient5';
  static const strIngredient6 = 'strIngredient6';
  static const strIngredient7 = 'strIngredient7';
  static const strIngredient8 = 'strIngredient8';
  static const strIngredient9 = 'strIngredient9';
  static const strIngredient10 = 'strIngredient10';
  static const strIngredient11 = 'strIngredient11';
  static const strIngredient12 = 'strIngredient12';
  static const strIngredient13 = 'strIngredient13';
  static const strIngredient14 = 'strIngredient14';
  static const strIngredient15 = 'strIngredient15';
  static const strMeasure1 = 'strMeasure1';
  static const strMeasure2 = 'strMeasure2';
  static const strMeasure3 = 'strMeasure3';
  static const strMeasure4 = 'strMeasure4';
  static const strMeasure5 = 'strMeasure5';
  static const strMeasure6 = 'strMeasure6';
  static const strMeasure7 = 'strMeasure7';
  static const strMeasure8 = 'strMeasure8';
  static const strMeasure9 = 'strMeasure9';
  static const strMeasure10 = 'strMeasure10';
  static const strMeasure11 = 'strMeasure11';
  static const strMeasure12 = 'strMeasure12';
  static const strMeasure13 = 'strMeasure13';
  static const strMeasure14 = 'strMeasure14';
  static const strMeasure15 = 'strMeasure15';
  static const strImageSource = 'strImageSource';
  static const strImageAttribution = 'strImageAttribution';
  static const strCreativeCommonsConfirmed = 'strCreativeCommonsConfirmed';
  static const dateModified = 'dateModified';
  static const isFav = 'isFav';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    if (kDebugMode) {
      print(path);
    }
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $drinksTable (
       $idDrink TEXT PRIMARY KEY,
       $strDrink TEXT NOT NULL,
       $strDrinkAlternate TEXT NOT NULL,
       $strTags TEXT NOT NULL,
       $strVideo TEXT NOT NULL,
       $strCategory TEXT NOT NULL,
       $strIBA TEXT NOT NULL,
       $strAlcoholic TEXT NOT NULL,
       $strGlass TEXT NOT NULL,
       $strInstructions TEXT NOT NULL,
       $strInstructionsES TEXT NOT NULL,
       $strInstructionsDE TEXT NOT NULL,
       $strInstructionsFR TEXT NOT NULL,
       $strInstructionsIT TEXT NOT NULL,
       $strInstructionsZHHANS TEXT NOT NULL,
       $strInstructionsZHHANT TEXT NOT NULL,
       $strDrinkThumb TEXT NOT NULL,
       $strIngredient1 TEXT NOT NULL,
       $strIngredient2 TEXT NOT NULL,
       $strIngredient3 TEXT NOT NULL,
       $strIngredient4 TEXT NOT NULL,
       $strIngredient5 TEXT NOT NULL,
       $strIngredient6 TEXT NOT NULL,
       $strIngredient7 TEXT NOT NULL,
       $strIngredient8 TEXT NOT NULL,
       $strIngredient9 TEXT NOT NULL,
       $strIngredient10 TEXT NOT NULL,
       $strIngredient11 TEXT NOT NULL,
       $strIngredient12 TEXT NOT NULL,
       $strIngredient13 TEXT NOT NULL,
       $strIngredient14 TEXT NOT NULL,
       $strIngredient15 TEXT NOT NULL,
       $strMeasure1 TEXT NOT NULL,
       $strMeasure2 TEXT NOT NULL,
       $strMeasure3 TEXT NOT NULL,
       $strMeasure4 TEXT NOT NULL,
       $strMeasure5 TEXT NOT NULL,
       $strMeasure6 TEXT NOT NULL,
       $strMeasure7 TEXT NOT NULL,
       $strMeasure8 TEXT NOT NULL,
       $strMeasure9 TEXT NOT NULL,
       $strMeasure10 TEXT NOT NULL,
       $strMeasure11 TEXT NOT NULL,
       $strMeasure12 TEXT NOT NULL,
       $strMeasure13 TEXT NOT NULL,
       $strMeasure14 TEXT NOT NULL,
       $strMeasure15 TEXT NOT NULL,
       $strImageSource TEXT NOT NULL,
       $strImageAttribution TEXT NOT NULL,
       $strCreativeCommonsConfirmed TEXT NOT NULL,
       $dateModified TEXT NOT NULL,
       $isFav TEXT
      )''');
  }

  Future<void> drinkDataInsert(List<Drinks> data) async {
    Database? db = await instance.database;
    for (int i = 0; i < data.length; i++) {
      var drinkData = data[i];
      List existData = await checkExistData(drinkData.idDrink);
      if (existData.isNotEmpty) {
        var result = await db!.rawQuery(''' UPDATE $drinksTable SET
      "$strDrink" = "${drinkData.strDrink ?? ''}",
      "$strDrinkAlternate" = "${drinkData.strDrinkAlternate ?? ''}",
      "$strTags" = "${drinkData.strTags ?? ''}",
      "$strVideo" = "${drinkData.strVideo ?? ''}",
      "$strCategory" = "${drinkData.strCategory ?? ''}",
      "$strIBA" = "${drinkData.strIBA ?? ''}",
      "$strAlcoholic" = "${drinkData.strAlcoholic ?? ''}",
      "$strGlass" = "${drinkData.strGlass ?? ''}",
      "$strInstructions" = "${drinkData.strInstructions ?? ''}",
      "$strInstructionsES" = "${drinkData.strInstructionsES ?? ''}",
      "$strInstructionsDE" = "${drinkData.strInstructionsDE ?? ''}",
      "$strInstructionsFR" = "${drinkData.strInstructionsFR ?? ''}",
      "$strInstructionsIT" = "${drinkData.strInstructionsIT ?? ''}",
      "$strInstructionsZHHANS" = "${drinkData.strInstructionsZHHANS ?? ''}",
      "$strInstructionsZHHANT" = "${drinkData.strInstructionsZHHANT ?? ''}",
      "$strDrinkThumb" = "${drinkData.strDrinkThumb ?? ''}",
      "$strIngredient1" = "${drinkData.strIngredient1 ?? ''}",
      "$strIngredient2" = "${drinkData.strIngredient2 ?? ''}",
      "$strIngredient3" = "${drinkData.strIngredient3 ?? ''}",
      "$strIngredient4" = "${drinkData.strIngredient4 ?? ''}",
      "$strIngredient5" = "${drinkData.strIngredient5 ?? ''}",
      "$strIngredient6" = "${drinkData.strIngredient6 ?? ''}",
      "$strIngredient7" = "${drinkData.strIngredient7 ?? ''}",
      "$strIngredient8" = "${drinkData.strIngredient8 ?? ''}",
      "$strIngredient9" = "${drinkData.strIngredient9 ?? ''}",
      "$strIngredient10" = "${drinkData.strIngredient10 ?? ''}",
      "$strIngredient11" = "${drinkData.strIngredient11 ?? ''}",
      "$strIngredient12" = "${drinkData.strIngredient12 ?? ''}",
      "$strIngredient13" = "${drinkData.strIngredient13 ?? ''}",
      "$strIngredient14" = "${drinkData.strIngredient14 ?? ''}",
      "$strIngredient15" = "${drinkData.strIngredient15 ?? ''}",
      "$strMeasure1" = "${drinkData.strMeasure1 ?? ''}",
      "$strMeasure2" = "${drinkData.strMeasure2 ?? ''}",
      "$strMeasure3" = "${drinkData.strMeasure3 ?? ''}",
      "$strMeasure4" = "${drinkData.strMeasure4 ?? ''}",
      "$strMeasure5" = "${drinkData.strMeasure5 ?? ''}",
      "$strMeasure6" = "${drinkData.strMeasure6 ?? ''}",
      "$strMeasure7" = "${drinkData.strMeasure7 ?? ''}",
      "$strMeasure8" = "${drinkData.strMeasure8 ?? ''}",
      "$strMeasure9" = "${drinkData.strMeasure9 ?? ''}",
      "$strMeasure10" = "${drinkData.strMeasure10 ?? ''}",
      "$strMeasure11" = "${drinkData.strMeasure11 ?? ''}",
      "$strMeasure12" = "${drinkData.strMeasure12 ?? ''}",
      "$strMeasure13" = "${drinkData.strMeasure13 ?? ''}",
      "$strMeasure14" = "${drinkData.strMeasure14 ?? ''}",
      "$strMeasure15" = "${drinkData.strMeasure15 ?? ''}",
      "$strImageSource" = "${drinkData.strImageSource ?? ''}",
      "$strImageAttribution" = "${drinkData.strImageAttribution ?? ''}",
      "$strCreativeCommonsConfirmed" = "${drinkData.strCreativeCommonsConfirmed ?? ''}",
      "$dateModified" = "${drinkData.dateModified ?? ''}" WHERE ${DatabaseHelper.idDrink} = "${drinkData.idDrink ?? ''}"
      ''');
      } else {
        var result = await db!.rawQuery('''INSERT INTO $drinksTable (
      "$idDrink",
      "$strDrink",
      "$strDrinkAlternate",
      "$strTags",
      "$strVideo",
      "$strCategory",
      "$strIBA",
      "$strAlcoholic",
      "$strGlass",
      "$strInstructions",
      "$strInstructionsES",
      "$strInstructionsDE",
      "$strInstructionsFR",
      "$strInstructionsIT",
      "$strInstructionsZHHANS",
      "$strInstructionsZHHANT",
      "$strDrinkThumb",
      "$strIngredient1",
      "$strIngredient2",
      "$strIngredient3",
      "$strIngredient4",
      "$strIngredient5",
      "$strIngredient6",
      "$strIngredient7",
      "$strIngredient8",
      "$strIngredient9",
      "$strIngredient10",
      "$strIngredient11",
      "$strIngredient12",
      "$strIngredient13",
      "$strIngredient14",
      "$strIngredient15",
      "$strMeasure1",
      "$strMeasure2",
      "$strMeasure3",
      "$strMeasure4",
      "$strMeasure5",
      "$strMeasure6",
      "$strMeasure7",
      "$strMeasure8",
      "$strMeasure9",
      "$strMeasure10",
      "$strMeasure11",
      "$strMeasure12",
      "$strMeasure13",
      "$strMeasure14",
      "$strMeasure15",
      "$strImageSource",
      "$strImageAttribution",
      "$strCreativeCommonsConfirmed",
      "$dateModified"
      ) 
      VALUES(
      "${drinkData.idDrink ?? ''}",
      "${drinkData.strDrink ?? ''}",
      "${drinkData.strDrinkAlternate ?? ''}",
      "${drinkData.strTags ?? ''}",
      "${drinkData.strVideo ?? ''}",
      "${drinkData.strCategory ?? ''}",
      "${drinkData.strIBA ?? ''}",
      "${drinkData.strAlcoholic ?? ''}",
      "${drinkData.strGlass ?? ''}",
      "${drinkData.strInstructions ?? ''}",
      "${drinkData.strInstructionsES ?? ''}",
      "${drinkData.strInstructionsDE ?? ''}",
      "${drinkData.strInstructionsFR ?? ''}",
      "${drinkData.strInstructionsIT ?? ''}",
      "${drinkData.strInstructionsZHHANS ?? ''}",
      "${drinkData.strInstructionsZHHANT ?? ''}",
      "${drinkData.strDrinkThumb ?? ''}",
      "${drinkData.strIngredient1 ?? ''}",
      "${drinkData.strIngredient2 ?? ''}",
      "${drinkData.strIngredient3 ?? ''}",
      "${drinkData.strIngredient4 ?? ''}",
      "${drinkData.strIngredient5 ?? ''}",
      "${drinkData.strIngredient6 ?? ''}",
      "${drinkData.strIngredient7 ?? ''}",
      "${drinkData.strIngredient8 ?? ''}",
      "${drinkData.strIngredient9 ?? ''}",
      "${drinkData.strIngredient10 ?? ''}",
      "${drinkData.strIngredient11 ?? ''}",
      "${drinkData.strIngredient12 ?? ''}",
      "${drinkData.strIngredient13 ?? ''}",
      "${drinkData.strIngredient14 ?? ''}",
      "${drinkData.strIngredient15 ?? ''}",
      "${drinkData.strMeasure1 ?? ''}",
      "${drinkData.strMeasure2 ?? ''}",
      "${drinkData.strMeasure3 ?? ''}",
      "${drinkData.strMeasure4 ?? ''}",
      "${drinkData.strMeasure5 ?? ''}",
      "${drinkData.strMeasure6 ?? ''}",
      "${drinkData.strMeasure7 ?? ''}",
      "${drinkData.strMeasure8 ?? ''}",
      "${drinkData.strMeasure9 ?? ''}",
      "${drinkData.strMeasure10 ?? ''}",
      "${drinkData.strMeasure11 ?? ''}",
      "${drinkData.strMeasure12 ?? ''}",
      "${drinkData.strMeasure13 ?? ''}",
      "${drinkData.strMeasure14 ?? ''}",
      "${drinkData.strMeasure15 ?? ''}",
      "${drinkData.strImageSource ?? ''}",
      "${drinkData.strImageAttribution ?? ''}",
      "${drinkData.strCreativeCommonsConfirmed ?? ''}",
      "${drinkData.dateModified ?? ''}"
      )''');
      }
    }
  }

  Future favoriteUpdate(String? id, String isFav) async {
    Database? db = await DatabaseHelper.instance.database;
    print(
        '''UPDATE ${DatabaseHelper.drinksTable} SET ${DatabaseHelper.isFav} = $isFav WHERE ${DatabaseHelper.idDrink} = $id ''');
    var result = await db!.rawQuery(
        '''UPDATE ${DatabaseHelper.drinksTable} SET ${DatabaseHelper.isFav} = $isFav WHERE ${DatabaseHelper.idDrink} = $id ''');
    return result;
  }

  Future getAllData() async {
    Database? db = await DatabaseHelper.instance.database;
    var result =
        await db!.rawQuery("SELECT * FROM ${DatabaseHelper.drinksTable} ");
    return result;
  }

  Future favoriteData() async {
    Database? db = await DatabaseHelper.instance.database;
    var result = await db!.rawQuery(
        "SELECT * FROM ${DatabaseHelper.drinksTable} WHERE ${DatabaseHelper.isFav} = '1'");
    return result;
  }

  Future checkIsfavoriteData(String? id) async {
    Database? db = await DatabaseHelper.instance.database;
    var result = await db!.rawQuery(
        "SELECT * FROM ${DatabaseHelper.drinksTable} WHERE (${DatabaseHelper.idDrink} = $id AND ${DatabaseHelper.isFav} = '1')");

    return result;
  }

  Future checkExistData(String? id) async {
    Database? db = await DatabaseHelper.instance.database;
    var result = await db!.rawQuery(
        "SELECT * FROM ${DatabaseHelper.drinksTable} WHERE ${DatabaseHelper.idDrink} = $id");
    return result;
  }
}
