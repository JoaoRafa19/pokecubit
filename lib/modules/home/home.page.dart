import 'package:flutter/material.dart';
import 'package:poke_cubit/widgets/common/enddrawer.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), endDrawer: EndDrawer());
  }
}
