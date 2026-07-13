import 'package:auto_route/auto_route.dart';
import 'package:client_app/src/common/client_app_localization_x.dart';
import 'package:client_app/src/features/app_navigation/presentation/observers/bottom_nav_visibility_observer.dart';
import 'package:client_app/src/features/app_navigation/presentation/providers/scroll_to_top_provider.dart';
import 'package:client_app/src/features/app_navigation/presentation/widgets/nav_bar.dart';
import 'package:client_app/src/features/app_navigation/presentation/widgets/nav_bar_item.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final ValueNotifier<bool> _bottomNavVisible = ValueNotifier(true);
  VoidCallback? _scrollToTop;

  @override
  void dispose() {
    _bottomNavVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScrollToTopProvider(
    onScrollToTop: () => _scrollToTop?.call(),
    onRegisterCallback: (callback) => _scrollToTop = callback,
    child: AutoTabsRouter(
      navigatorObservers: () => [
        BottomNavVisibilityObserver(onVisibilityChanged: _setBottomNavVisible),
      ],
      builder: (context, child) {
        final tabsRouter = context.tabsRouter;
        final l10n = context.l10n;
        return Scaffold(
          extendBody: true,
          body: child,
          bottomNavigationBar: ValueListenableBuilder<bool>(
            valueListenable: _bottomNavVisible,
            builder: (context, visible, child) => visible
                ? NavBar(
                    initialPage: tabsRouter.activeIndex,
                    onPageChanged: (index) {
                      if (index == tabsRouter.activeIndex) {
                        _scrollToTop?.call();
                      } else {
                        tabsRouter.setActiveIndex(index);
                      }
                    },
                    items: [
                      NavBarItem(
                        icon: const Icon(Icons.home, size: 20),
                        label: l10n.home,
                      ),
                      NavBarItem(
                        icon: const Icon(Icons.person, size: 20),
                        label: l10n.profile,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    ),
  );

  void _setBottomNavVisible(bool visible) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _bottomNavVisible.value != visible) {
        _bottomNavVisible.value = visible;
      }
    });
  }
}
