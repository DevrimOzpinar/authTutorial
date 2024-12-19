import 'package:auto_route/auto_route.dart';
import 'package:hadi/core/routing/router.gr.dart';

List<AutoRoute> get routesomer => [
      CustomRoute(
        page: SignInRoute.page,
        initial: true,
      ),
      CustomRoute(
        page: SignUpRoute.page,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),
      CustomRoute(
        page: HomeViewRoute.page,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),
      CustomRoute(
        page: ForgotPasswordRoute.page,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      ),
    ];
