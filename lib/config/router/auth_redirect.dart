import 'package:go_router/go_router.dart';

class AuthRedirect {
  static String? call(GoRouterState state, bool isAuthenticated) {
    print("--- [GO_ROUTER REDIRECT] ---");
    print("Ubicación actual: ${state.matchedLocation}");
    print("¿Está autenticado?: $isAuthenticated");

    final bool isAtLogin =
        state.matchedLocation == '/' || state.matchedLocation == '/login';

    if (!isAuthenticated && !isAtLogin) {
      print(
        "Resultado: No autenticado y fuera de login -> Redirigiendo a /login",
      );
      return '/login';
    }

    if (isAuthenticated && isAtLogin) {
      print("Resultado: Autenticado y en login -> Redirigiendo a /home");
      return '/home';
    }

    print("Resultado: Todo ok -> No hay redirección (null)");
    print("----------------------------");
    return null;
  }
}
