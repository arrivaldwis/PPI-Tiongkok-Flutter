import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './screens/cabang/Routes.dart';
import './tabs/beranda.dart' as _firstTab;
import './tabs/aktifitas.dart' as _secondTab;
import './tabs/cabang.dart' as _thirdTab;
import './screens/tentang/tentang.dart' as _tentangPage;
import './screens/sambutan.dart' as _sambutanPage;
import './screens/kontak.dart' as _kontakPage;
import './screens/kritiksaran.dart' as _kritikSaranPage;
import './screens/elibrary.dart' as _elibrary;
import './screens/lapordiri.dart' as _lapordiri;

void main() {
  Routes.initRoutes();
  runApp(new MaterialApp(
    title: 'PPI Tiongkok',
    theme: new ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.red, backgroundColor: Colors.white
    ),
    home: new Tabs(),
    onGenerateRoute: (RouteSettings settings) {
      switch (settings.name) {
        case '/tentang': return new FromRightToLeft(
          builder: (_) => new _tentangPage.About(),
          settings: settings,
        );
        case '/sambutan': return new FromRightToLeft(
          builder: (_) => new _sambutanPage.Support(),
          settings: settings,
        );
        case '/kontak': return new FromRightToLeft(
          builder: (_) => new _kontakPage.Kontak(),
          settings: settings,
        );
        case '/kriran': return new FromRightToLeft(
          builder: (_) => new _kritikSaranPage.Feedback(),
          settings: settings,
        );
        case '/Elib': return new FromRightToLeft(
          builder: (_) => new _elibrary.ELib(),
          settings: settings,
        );
        case '/lapordiri': return new FromRightToLeft(
          builder: (_) => new _lapordiri.Lapordiri(),
          settings: settings,
        );
      }
    },
    // routes: <String, WidgetBuilder> {
    //   '/about': (BuildContext context) => new _aboutPage.About(),
    // }
  ));
}

class FromRightToLeft<T> extends MaterialPageRoute<T> {
  FromRightToLeft({ WidgetBuilder builder, RouteSettings settings })
    : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {

    if (settings.isInitialRoute)
      return child;

    return new SlideTransition(
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black26,
              blurRadius: 25.0,
            )
          ]
        ),
        child: child,
      ),
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      )
      .animate(
        new CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        )
      ),
    );
  }
  @override Duration get transitionDuration => const Duration(milliseconds: 400);
}

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> {
  
  PageController _tabController;

  var _title_app = null;
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    this._title_app = TabItems[0].title;
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
    appBar: new AppBar(
      title: new Text(
        _title_app, 
        style: new TextStyle(
          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
        ),
      ),
      elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
    ),

    //Content of tabs
    body: new PageView(
      controller: _tabController,
      onPageChanged: onTabChanged,
      children: <Widget>[
        new _firstTab.HomeMain(),
        new _secondTab.Dashboard(),
        new _thirdTab.Settings()
      ],
    ),

    //Tabs
    bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS ?
      new CupertinoTabBar(
        activeColor: Colors.red,
        currentIndex: _tab,
        onTap: onTap,
        items: TabItems.map((TabItem) {
          return new BottomNavigationBarItem(
            title: new Text(TabItem.title),
            icon: new Icon(TabItem.icon),
          );
        }).toList(),
      ):
      new BottomNavigationBar(
        currentIndex: _tab,
        onTap: onTap,
        items: TabItems.map((TabItem) {
          return new BottomNavigationBarItem(
            title: new Text(TabItem.title),
            icon: new Icon(TabItem.icon),
          );
        }).toList(),
    ),

    //Drawer
    drawer: new Drawer(
      child: new ListView(
        children: <Widget>[
          new Container(
            height: 120.0,
            child: new DrawerHeader(
              padding: new EdgeInsets.all(0.0),
              decoration: new BoxDecoration(
                color: new Color(0xFFECEFF1),
              ),
              child: new Center(
                child: new Image.asset('res/logo.jpg',
                    width: 70.0, height: 120.0),
              ),
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.info),
            title: new Text('Tentang'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/tentang');
            }
          ),
          new ListTile(
            leading: new Icon(Icons.chat),
            title: new Text('Sambutan'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/sambutan');
            }
          ),
          new ListTile(
            leading: new Icon(Icons.contacts),
            title: new Text('Kontak'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/kontak');
            }
          ),
          new ListTile(
            leading: new Icon(Icons.feedback),
            title: new Text('Kritik dan Saran'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/kriran');
            }
          ),
          new ListTile(
              leading: new Icon(Icons.collections_bookmark),
              title: new Text('E-Library'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/Elib');
              }
          ),
          new ListTile(
              leading: new Icon(Icons.report),
              title: new Text('Lapor Diri'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/lapordiri');
              }
          ),
          /*new Divider(),
          new ListTile(
            leading: new Icon(Icons.exit_to_app),
            title: new Text('Keluar'),
            onTap: () {
              Navigator.pop(context);
            }
          ),*/
        ],
      )
    )
  );

  void onTap(int tab){
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState((){
      this._tab = tab;
    });

    switch (tab) {
      case 0:
        this._title_app = TabItems[0].title;
      break;

      case 1:
        this._title_app = TabItems[1].title;
      break;

      case 2:
        this._title_app = TabItems[2].title;
      break;
    }
  }
}

class TabItem {
  const TabItem({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Beranda', icon: Icons.home),
  const TabItem(title: 'Aktifitas', icon: Icons.photo_library),
  const TabItem(title: 'Cabang', icon: Icons.web)
];