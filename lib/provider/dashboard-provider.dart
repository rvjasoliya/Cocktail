import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/dashboard-model.dart';
import 'api-service-provider.dart';

class DashboardProvider extends ChangeNotifier {
  Future<Autogenerated>? _getDashboardData;

  Future<Autogenerated>? get getDashboardData => _getDashboardData;

  Future<Autogenerated?> getDataFromDashboardApi(BuildContext context) async {
    _getDashboardData =
        Provider.of<APIServicesProvider>(context).getDashboardDataApi();
    return await _getDashboardData;
  }
}
