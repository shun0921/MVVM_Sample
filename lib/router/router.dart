import 'package:go_router/go_router.dart';
import 'package:mvvm_sample/ui/home/home_page.dart';

// GoRouter のルート定義をまとめるクラス
class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(title: ''),
      ),
    ],
  );
}
