## DEVELOPED BY RAFAEL DIAS ##

# coinmarketcap

A Flutter project with Bloc and Clean Architecture.

## Dependency injection
Register the class in _setupDI function in app_initialization.dart file (use the correct register mode - registerSingleton/registerFactory/registerLazySingleton).

Example: DependencyService.registerSingleton<AppRouter>(AppRouter());

## Routing and navigation
To add a new route, follow these steps:
- Create the new page
- Add a new constant in app_routes.dart
- Add a new route in app_router.dart in _registerRoutes function

To navigate between pages, use the NavigationService (see navigation_service.dart to more options for navigation).

Example: 
final NavigationService navigationService = DependencyService.resolve<NavigationService>();

navigationService.pushNamed(
    AppRoutes.LISTCOINS,
);

## Generated localizations files
- Update all .arb files in lib/core/l10n folder
- Go to the terminal in the root project folder and run the command: dart run intl_utils:generate
(this command will generate AppLocalizations class with all strings from each .arb file for each locale)

To use the string in your page, use this import:
import 'package:coinmarketcap/core/l10n/l10n.dart';
Example: Text(AppLocalizations.current.appTitle)

## Build / Run
To build/run the app:
flutter run --debug ./lib/main.dart

flutter build apk --release ./lib/main.dart
