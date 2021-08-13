import 'package:flutter/material.dart';
import 'package:poke_cubit/widgets/common/enddrawer.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(),
      endDrawer: EndDrawer(),
      body: SafeArea(
        child: Center(
          child: Stack(
            //fit: StackFit.passthrough,
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, left: mediaQuery.size.width * 0.08),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              "Pokedex",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 29,
                                fontFamily: 'Google',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    width: mediaQuery.size.width * 0.9,
                    color: Colors.white30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    
    );
  }
}
