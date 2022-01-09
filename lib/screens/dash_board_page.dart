import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_video/models/item_model.dart';
import 'package:resturant_video/providers/display_provider.dart';
import 'package:resturant_video/values/color.dart';
import 'package:resturant_video/functions/show_snack.dart';
import 'package:resturant_video/widget/clippers/menuClip.dart';
import 'package:resturant_video/screens/home.dart';
import 'package:resturant_video/screens/invoice.dart';
import 'package:resturant_video/screens/messages.dart';
import 'package:resturant_video/screens/profile.dart';
import 'package:resturant_video/screens/search.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 3;
  AnimationController controller;
  Animation animation;
  List<Item> appBarItem = [
    Item(
      title: 'My Profile',
      body: ProfileScreen(),
    ),
    Item(
      title: 'Messages  ',
      body: MessagesScreen(),
    ),
    Item(
      title: 'Invoice   ',
      body: InvoiceScreen(),
    ),
    Item(
      title: 'Home      ',
      body: HomePage(),
    ),
  ];

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    animation = Tween<double>(begin: 240, end: 240).animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40),
        width: size.width,
        child: Stack(
          children: <Widget>[
            buildMenuBar(size),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 68,
                right: 16,
                bottom: 16,
              ),
              child: true
                  ? Consumer<AppDisplayProvider>(
                      builder: (context, model, child) {
                        return model.body;
                      },
                    )
                  : IndexedStack(
                      index: currentIndex,
                      children: [
                        ProfileScreen(),
                        MessagesScreen(),
                        InvoiceScreen(),
                        HomePage(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuBar(Size size) {
    return ClipPath(
      clipper: MenuClip(),
      child: Container(
        height: size.height,
        width: 55,
        color: mainColor,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 72,
            ),
            Image.asset(
              'images/menu.png',
              width: 50,
              height: 50,
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                showSnack(context, SafeArea(child: Searchscreen()));
              },
              child: Image.asset(
                'images/Search.png',
                width: 50,
                height: 50,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Expanded(
              child: Column(
                children: List.generate(
                  appBarItem.length,
                  (index) {
                    Item item = appBarItem[index];
                    return Expanded(
                      child: buildRotatedBox(
                        '${item.title}',
                        isSelected: currentIndex == index,
                        onPressed: () {
                          // setState(() {
                          //   currentIndex = index;
                          // });
                          var display = context.read<AppDisplayProvider>();
                          display.changeTo(item.body);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            Image.asset(
              'images/cart.png',
              width: 50,
              height: 50,
            ),
            SizedBox(
              height: 58,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRotatedBox(
    String text, {
    bool isSelected: false,
    onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: RotatedBox(
        quarterTurns: -1,
        child: Container(
          // width: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isSelected ? mainBlue : Colors.transparent,
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
