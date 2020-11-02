import 'package:flutter/material.dart';

void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialPage;

  MainScreen({Key key, this.initialPage = 0}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final List<GlobalKey<MainPageStateMixin>> _pageKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  PageController _pageController;
  int _page;
  List<Widget> _pageList;

  @override
  void initState() {
    super.initState();
    _page = widget.initialPage ?? 0;
    _pageController = PageController(viewportFraction: 1.0, initialPage: _page);

    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageKeys[widget.initialPage].currentState.onPageVisible();
    });*/
    _pageList = [
      PageOne(
        key: _pageKeys[0],
        bgColor: Colors.purple,
      ),
      PageTwo(
        key: _pageKeys[1],
        bgColor: Colors.green,
      ),
      PageThree(
        key: _pageKeys[2],
        bgColor: Colors.amber,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Custom PageView"),
      ),
      body: Container(
        child: PageView(
          //physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _pageList,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: _onBottomNavItemPressed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('people'),
            icon: Icon(Icons.people),
          ),
          BottomNavigationBarItem(
            title: Text('timeline'),
            icon: Icon(Icons.history),
          ),
          BottomNavigationBarItem(
            title: Text('stats'),
            icon: Icon(Icons.pie_chart),
          ),
        ],
      ),
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    _onPageChanged(_page);
  }

  void _onPageChanged(int page) {
    for (int i = 0; i < _pageList.length; i++) {
      print(i);
      if (i != _page) {
        print('inner $i');
        _pageKeys[i].currentState?.onPageUnVisible();
      }
    }
    setState(() => _page = page);
    _pageKeys[_page].currentState.onPageVisible();

    /* for (var i in _pageList) if (_pageList.indexOf(i) != _page) _pageKeys[_page].currentState.onPageUnVisible();*/
  }

  void _onBottomNavItemPressed(int index) {
    setState(() => _page = index);
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
    );
  }
}

mixin MainPageStateMixin<T extends StatefulWidget> on State<T> {
  void onPageVisible();

  void onPageUnVisible();
}

class PageOne extends StatefulWidget {
  PageOne({Key key, this.val, this.bgColor}) : super(key: key);
  final double val;
  final Color bgColor;

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> with MainPageStateMixin {
  @override
  void onPageVisible() {
    print('_PageOneState onPageVisible');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void onPageUnVisible() {
    print('_PageOneState onPageUnVisible');
  }
}

class PageTwo extends StatefulWidget {
  PageTwo({Key key, this.val, this.bgColor}) : super(key: key);
  final double val;
  final Color bgColor;

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> with MainPageStateMixin {
  @override
  void onPageVisible() {
    print('_PageTwoState onPageVisible');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void onPageUnVisible() {
    print('_PageTwoState onPageUnVisible');
  }
}

class PageThree extends StatefulWidget {
  PageThree({Key key, this.val, this.bgColor}) : super(key: key);
  final double val;
  final Color bgColor;

  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> with MainPageStateMixin {
  @override
  void onPageVisible() {
    print('_PageThreeState onPageVisible');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void onPageUnVisible() {
    print('_PageThreeState onPageUnVisible');
  }
}
