import 'package:go_marche/view_models/cart_provider.dart';
import 'package:go_marche/view_models/login_provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

import '../view_models/profile_provider.dart';

List<SingleChildWidget> providersList = [
  ChangeNotifierProvider(create: (_) => LoginProvider()),
  ChangeNotifierProvider(create: (_) => ProfileProvider()),
  ChangeNotifierProvider(create: (_) => CartProvider()),
];
