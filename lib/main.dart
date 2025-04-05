import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sell_point/app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sell_point/core/bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final path = (await getApplicationDocumentsDirectory()).path;

  Bindings.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(path),
  );

  runApp(SellPointApp());
}
