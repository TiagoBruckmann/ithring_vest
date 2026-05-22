import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';

import 'package:ithring_vest/core/domain/source/local/injection/injection.config.dart';

final getIt = GetIt.I;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();