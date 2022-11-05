import 'dart:async';
import 'package:cocktail/screen/dashboard/widgets/card-view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../model/dashboard-model.dart';
import '../../model/drinks-model.dart';
import '../../provider/api-service-provider.dart';
import '../../provider/dashboard-provider.dart';
import '../../utils/constant/hexcolor.dart';
import '../../utils/constant/image.dart';
import '../../utils/constant/singleTon.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  final TextEditingController searchController = TextEditingController();

  late List<Drinks> _drinksList;
  List<Drinks> _searchDrinkList = [];

  String _searchText = "";

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    searchSetup();
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  void searchSetup() {
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        setState(() {
          _searchText = "";
          _buildSearchList();
        });
      } else {
        setState(() {
          _searchText = searchController.text;
          _buildSearchList();
        });
      }
    });
  }

  List<Drinks> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _searchDrinkList = _drinksList;
    } else {
      _searchDrinkList = _drinksList
          .where((element) => element.strDrink?.toLowerCase().contains(_searchText
          .toLowerCase()) ?? false)
          .toList();
      if (kDebugMode) {
        print('${_searchDrinkList.length}');
      }
      return _searchDrinkList;
    }
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSession.shared.height = MediaQuery.of(context).size.height;
    AppSession.shared.width = MediaQuery.of(context).size.width;
    return Consumer<DashboardProvider>(
      builder: (context, providerObj, child) {
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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _connectionStatus.index == 4
                  ? const Center(child: Text("you're offline"))
                  : dashboardWidgetList(context),
            )
        );
      },
    );
  }
  Widget searchField() {
    return TextField(
      onChanged: (value) {
        _searchDrinkList.length;
      },
      controller: searchController,
      cursorColor: Colors.white30,
      decoration: const InputDecoration(
        labelText: 'Search drink',
        prefixIcon: Icon(Icons.search,color: Colors.white,),
        prefixIconColor: Colors.white30,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(width: 1,color: Colors.white),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(width: 1,color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(width: 1,color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          ),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        //hintText: "Search drink",
        hintStyle: TextStyle(fontSize: 16,color: Colors.white30, fontFamily: 'Poppins-Regular',),
        labelStyle: TextStyle(fontSize: 16,color: Colors.white, fontFamily: 'Poppins-Regular',),
      ),
    );
  }

  Widget dashboardWidgetList(BuildContext context) =>
      FutureProvider<Autogenerated?>(
        create: (_) => Provider.of<DashboardProvider>(context)
            .getDataFromDashboardApi(context),
        initialData: null,
        child: Consumer<Autogenerated?>(
          builder: (context, dashboardData, _) {
            print('dashboardData');
            print(dashboardData);
            _drinksList = dashboardData?.drinks ?? [];
            _buildSearchList();
            return Provider.of<APIServicesProvider>(context).status ==
                Status.authenticating
                ? const Center(child: CircularProgressIndicator(color: Colors.white30,))
                : Provider.of<APIServicesProvider>(context).status ==
                Status.authenticated
                ? dashboardData != null
                ? Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  child: searchField()
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: _searchDrinkList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CardView(_searchDrinkList[index]),
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ),
                  ),
                )
              ],
            )
                : const Text("Error please try again")
                : const Text("Unauthenticated");
          },
        ),
      );

}
