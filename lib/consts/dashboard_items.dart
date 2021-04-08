import 'package:flutter/material.dart';

import '../pages/game/game_page.dart';
import '../pages/home/home_page.dart';
import '../pages/lucky/lucky.dart';

final dashboardItems = [
  {
    'item': GamePage(),
    'label': 'Game',
    'icon': Icons.sports_esports_outlined,
    'activeIcon': Icons.sports_esports,
  },
  {
    'item': HomePage(),
    'label': 'Home',
    'icon': Icons.home_outlined,
    'activeIcon': Icons.home,
  },
  {
    'item': Lucky(),
    'label': 'Lucky Diamond',
    'icon': Icons.monetization_on_outlined,
    'activeIcon': Icons.monetization_on,
  },
];
