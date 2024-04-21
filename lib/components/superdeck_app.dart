import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localstorage/localstorage.dart';
import 'package:signals/signals_flutter.dart';
import 'package:window_manager/window_manager.dart';

import '../../helpers/constants.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../models/options_model.dart';
import '../../superdeck.dart';
import '../helpers/theme.dart';
import '../screens/export_screen.dart';
import '../screens/home_screen.dart';
import 'molecules/exception_widget.dart';

class SuperDeckApp extends StatefulWidget {
  const SuperDeckApp({
    super.key,
    this.style,
    this.examples = const [],
  });

  final Style? style;
  final List<Example> examples;

  @override
  // ignore: library_private_types_in_public_api
  _SuperDeckAppState createState() => _SuperDeckAppState();
}

class _SuperDeckAppState extends State<SuperDeckApp> {
  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(SuperDeckApp oldWidget) {
    if (widget.style != oldWidget.style ||
        widget.examples != oldWidget.examples) {
      superdeck.update(
        style: widget.style,
        examples: widget.examples,
      );
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    superdeck.dispose();
  }

  Future<void> _initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    SignalsObserver.instance = null;

    await Future.wait([
      initLocalStorage(),
      SyntaxHighlight.initialize(),
      _initializeWindowManager(),
    ]);

    await superdeck.initialize(
      style: widget.style,
      examples: widget.examples,
    );
  }

  void onRetry() {
    superdeck.initialize(
      style: widget.style,
      examples: widget.examples,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Watch.builder(
      builder: (context) {
        if (superdeck.loading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (superdeck.error.value != null) {
          return ExceptionWidget(
            superdeck.error.value!,
            onRetry: onRetry,
          );
        }

        return MixTheme(
          data: MixThemeData.withMaterial(),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Superdeck',
            theme: theme,
            routerConfig: _router,
          ),
        );
      },
    );
  }
}

Future<void> _initializeWindowManager() async {
  if (kIsWeb) return;
  // Must add this line.
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: kResolution,
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    minimumSize: Size(640, 360),
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await windowManager.setAspectRatio(kAspectRatio);
}

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        // Return the widget that implements the custom shell (in this case
        // using a BottomNavigationBar). The StatefulNavigationShell is passed
        // to be able access the state of the shell and to navigate to other
        // branches in a stateful way.
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        // The route branch for the first tab of the bottom navigation bar.
        StatefulShellBranch(
          navigatorKey: _sectionANavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) {
                return const HomeScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/export',
              builder: (BuildContext context, GoRouterState state) {
                return const ExportScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
