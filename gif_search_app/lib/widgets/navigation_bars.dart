import 'package:flutter/material.dart';

Widget buildBottomNavigationBar(
    BuildContext context, int selectedIndex, ValueChanged<int> onItemTapped) {
  return BottomNavigationBar(
    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
    unselectedItemColor: Theme.of(context).colorScheme.secondary,
    showUnselectedLabels: true,
    showSelectedLabels: false,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favorites',
      ),
    ],
    currentIndex: selectedIndex,
    onTap: onItemTapped,
  );
}

Widget buildVerticalNavBar(BuildContext context, int selectedIndex,
    ValueChanged<int> onDestinationSelected) {
  return NavigationRail(
    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    minWidth: 50,
    selectedIndex: selectedIndex,
    selectedIconTheme:
        IconThemeData(color: Theme.of(context).colorScheme.onPrimaryContainer),
    unselectedIconTheme: IconThemeData(
      color: Theme.of(context).colorScheme.secondary,
    ),
    labelType: NavigationRailLabelType.none,
    onDestinationSelected: onDestinationSelected,
    destinations: const <NavigationRailDestination>[
      NavigationRailDestination(
        icon: Icon(Icons.search),
        label: Text('Search'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.favorite),
        label: Text('Favorites'),
      ),
    ],
  );
}
