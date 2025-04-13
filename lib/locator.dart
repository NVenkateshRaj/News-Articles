import 'package:get_it/get_it.dart';
import 'package:newsarticle/service/api_service/hive_service.dart';
import 'package:newsarticle/service/common_service/dialog_service.dart';
import 'package:newsarticle/service/common_service/network_service.dart';

GetIt locator = GetIt.instance;

DialogService get dialogService => locator<DialogService>();
HiveService get hiveService => locator<HiveService>();


void setupLocator() {
  locator.registerLazySingleton(() => ConnectivityService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => HiveService());

}