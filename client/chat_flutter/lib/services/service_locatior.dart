import 'package:chat_flutter/views/stateModel/home_screen_model.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  //serviceLocator.registerFactory<HomeScreenModel>(() => HomeScreenModel());//old

  serviceLocator.registerSingleton<HomeScreenModel>(HomeScreenModel()); //new 1

//  serviceLocator.registerLazySingleton<HomeScreenModel>(() => HomeScreenModel());
}
