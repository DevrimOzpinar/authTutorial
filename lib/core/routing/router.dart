import 'package:auto_route/auto_route.dart';
import 'package:hadi/core/routing/routeromer.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        ...routesomer,
      ];
}
