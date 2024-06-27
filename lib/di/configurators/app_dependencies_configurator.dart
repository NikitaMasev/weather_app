import 'dart:async';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_app/data/sources/shared/shared_platform_persistent_impl.dart';
import 'package:weather_app/di/models/app_dependencies.dart';
import 'package:weather_app/di/models/environments.dart';

sealed class AppDependenciesState {
  factory AppDependenciesState.initial() => AppDependenciesInitial();

  factory AppDependenciesState.loading({
    required final double progressPercent,
    required final String description,
  }) =>
      AppDependenciesLoading(
        progressPercent: progressPercent,
        description: description,
      );

  factory AppDependenciesState.success({
    required final AppDependencies appDependencies,
  }) =>
      AppDependenciesSuccess(appDependencies: appDependencies);
}

final class AppDependenciesInitial implements AppDependenciesState {}

final class AppDependenciesLoading implements AppDependenciesState {
  AppDependenciesLoading({
    required this.progressPercent,
    required this.description,
  });

  final double progressPercent;
  final String description;
}

final class AppDependenciesSuccess implements AppDependenciesState {
  AppDependenciesSuccess({required this.appDependencies});

  final AppDependencies appDependencies;
}

final class AppDependenciesConfigurator {
  AppDependenciesConfigurator({
    required final Env env,
    required final SharedPlatformPersistentImpl sharedPlatformPersistentImpl,
    required final AppLocalizations appLocalizations,
  })  : _env = env,
        _sharedPlatformPersistentImpl = sharedPlatformPersistentImpl,
        _appLocalizations = appLocalizations;

  final Env _env;
  final SharedPlatformPersistentImpl _sharedPlatformPersistentImpl;
  final AppLocalizations _appLocalizations;

  final _controllerDependenciesState = StreamController<AppDependenciesState>();

  Stream<AppDependenciesState> get streamDependenciesState =>
      _controllerDependenciesState.stream.asBroadcastStream();

  Future<AppDependencies> startConfiguration() async {
    _controllerDependenciesState.add(
      AppDependenciesLoading(
        progressPercent: 0,
        description: _appLocalizations.dependInitFirst,
      ),
    );

    await Future.delayed(Duration(milliseconds: 300));

    _controllerDependenciesState.add(
      AppDependenciesLoading(
        progressPercent: 0.25,
        description: _appLocalizations.dependInitStore,
      ),
    );

    await Future.delayed(Duration(seconds: 1));

    _controllerDependenciesState.add(
      AppDependenciesLoading(
        progressPercent: 0.5,
        description: _appLocalizations.dependInitUserRepo,
      ),
    );

    await Future.delayed(Duration(milliseconds: 100));

    _controllerDependenciesState.add(
      AppDependenciesLoading(
        progressPercent: 1,
        description: _appLocalizations.dependReady,
      ),
    );

    final appDependencies = AppDependencies(data: 1);

    _controllerDependenciesState.add(
      AppDependenciesSuccess(appDependencies: AppDependencies(data: 1)),
    );

    return appDependencies;
  }

  Future<void> dispose() => _controllerDependenciesState.close();
}
