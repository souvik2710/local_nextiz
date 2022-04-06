import 'package:flutter/material.dart';
import 'package:nextiz/login/demo.dart';

import 'events/sliver_layout.dart';
import 'login/layout.dart';

class AppRoutes {
  static const landingPage = '/';
  static const homeScreen = '/home';
  static const settings = '/settings';
  static const demo = '/demo';
  static const login= '/login';
  static const template= '/template';
  static const events = '/events';
}

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // case AppRoutes.homeScreen:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => ManageWebsiteMainPage(),
      //     settings: settings,
      //     fullscreenDialog: true,
      //   );
      case AppRoutes.login:
        return MaterialPageRoute<dynamic>(
          builder: (_) => LoginPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.demo:
        return MaterialPageRoute<dynamic>(
          builder: (_) => DemoPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.events:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SliverEventListPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      // case AppRoutes.demo:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => Example1(),
      //     settings: settings,
      //     fullscreenDialog: true,
      //   );

      default:
      // TODO: Throw
        return null;
    }
  }
}

/*
Call AppRoutes.pageName whenever needed

Example scenario in case of arguments passing
case AppRoutes.listingCategorySearch:
        Map<String, dynamic> args = settings.arguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => ListingCategorySearchView(queryParams: args,),
          settings: settings,
          fullscreenDialog: true,
        );
case AppRoutes.listingDetails:
        ListingDetailsArgs args = settings.arguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => ListingDetailsPage(offerID: args.offerID, favouriteCount: args.favouriteCount, commentCount: args.commentCount, dealCount: args.dealCount,viewCount: args.viewCount, isLoadingFromOfferCreateScreen: args.isLoadingFromOfferCreateScreen,),
          settings: settings,
          fullscreenDialog: true,
        );
 */