import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

typedef DemoItemBodyBuilder<T> = Widget Function(DemoItem<T> item);

//Region Utara
String ppit_harbin = 'http://ppitiongkokharbin.org';
String ppit_beijing = 'http://www.permitbeijing.com';
String ppit_tianjin = 'http://tianjin.ppitiongkok.org';
String ppit_shijiazhuang = 'http://ppitshijiazhuang.org';
String ppit_zhengzhou = 'http://zhengzhou.ppitiongkok.org';

//Region Timur
String ppit_hangzhou = 'http://ppihangzhou.org';
String ppit_ningbo = 'http://permitningbo.org';
String ppit_shanghai = 'http://permitshanghai.com';
String ppit_wuxi = 'http://ppitiongkokwuxi.org';

//Region Selatan
String ppit_chongqing = 'http://ppitchongqing.com';
String ppit_guilin = 'http://himignu-ppitguilin.com';
String ppit_hongkong = 'http://ppihongkong.org';
String ppit_wuhan = 'http://ppitiongkokwuhan.org/';
String ppit_xiamen = 'http://permicxiamen.weebly.com';

class DualHeaderWithHint extends StatelessWidget {
  const DualHeaderWithHint({
    this.materialColor,
    this.name,
    this.showHint
  });

  final MaterialColor materialColor;
  final String name;
  final bool showHint;


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Container(
      color: Colors.red,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Text(
          name,
          style: new TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );


  }
}

class CollapsibleBody extends StatelessWidget {
  const CollapsibleBody({
    this.margin = EdgeInsets.zero,
    this.child,

  });

  final EdgeInsets margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Column(
        children: <Widget>[
          Container(
              decoration: new BoxDecoration(border: new Border.all(color: Colors.white), color: Colors.white),
              margin: const EdgeInsets.only(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0
              ) - margin,

              child: Center(
                  child: DefaultTextStyle(
                      style: textTheme.caption.copyWith(fontSize: 18.0),
                      child: child
                  )
              )
          ),

        ]
    );
  }
}

class DemoItem<T> {
  DemoItem({
    this.name,
    this.builder,
  });

  final String name;

  final DemoItemBodyBuilder<T> builder;

  T value;
  bool isExpanded = false;

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return DualHeaderWithHint(
        materialColor: Colors.red,
        name: name,
        showHint: isExpanded,
      );
    };
  }

  Widget build() => builder(this);
}

class Cabangcontent extends StatefulWidget {
  @override
  _CabangcontentState createState() => _CabangcontentState();
}

class _CabangcontentState extends State<Cabangcontent> {

  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  List<DemoItem<dynamic>> _demoItems;

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    _demoItems = <DemoItem<dynamic>>[
      DemoItem<String>(
          name: 'REGION UTARA',
          builder: (DemoItem<String> item) {
            void close() {
              setState(() {
                item.isExpanded = false;
              });
            }
            return Form(
                child: Builder(
                    builder: (BuildContext context) {
                      return CollapsibleBody(
                        child: new Column(
                            children: <Widget>[

                              new ListTile(
                                dense: true,
                                enabled: true,
                                isThreeLine: false,
                                onTap: () => Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => PPITHARBIN(),
                                  ),
                                ),
                                selected: true,
                                title: Text('PPIT Harbin', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                                leading: new Icon(Icons.star, color: Colors.red,),
                              ),

                              new ListTile(
                                dense: true,
                                enabled: true,
                                isThreeLine: false,
                                onTap: () => Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => PERMITBEIJING(),
                                  ),
                                ),
                                selected: true,
                                title: Text('Permit Beijing', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                                leading: new Icon(Icons.star, color: Colors.red,),
                              ),

                              new ListTile(
                                dense: true,
                                enabled: true,
                                isThreeLine: false,
                                onTap: () => Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => PPITTIANJIN(),
                                  ),
                                ),
                                selected: true,
                                title: Text('PPIT Tianjin', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                                leading: new Icon(Icons.star, color: Colors.red,),
                              ),

                              new ListTile(
                                dense: true,
                                enabled: true,
                                isThreeLine: false,
                                onTap: () => Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => PPITSHIJIAZHUANG(),
                                  ),
                                ),
                                selected: true,
                                title: Text('PPIT Shijiazhuang', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                                leading: new Icon(Icons.star, color: Colors.red,),
                              ),

                              new ListTile(
                                dense: true,
                                enabled: true,
                                isThreeLine: false,
                                onTap: () => Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => PPITZHENGZHOU(),
                                  ),
                                ),
                                selected: true,
                                title: Text('PPIT Zhengzhou', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                                leading: new Icon(Icons.star, color: Colors.red,),
                              ),

                            ]
                        ),
                      );
                    }
                )
            );
          }
      ),
      DemoItem<String>(
          name: 'REGION TIMUR',
          builder: (DemoItem<String> item) {
            void close() {
              setState(() {
                item.isExpanded = false;
              });
            }
            return Form(
                child: Builder(
                    builder: (BuildContext context) {
                      return CollapsibleBody(
                        child: new Column(
                          children: <Widget>[

                            new ListTile(
                              dense: true,
                              enabled: true,
                              isThreeLine: false,
                              onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => PPITHANGZHOU(),
                                ),
                              ),
                              selected: true,
                              title: Text('PPIT Hangzhou', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                              leading: new Icon(Icons.star, color: Colors.red,),
                            ),

                            new ListTile(
                              dense: true,
                              enabled: true,
                              isThreeLine: false,
                              onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => PPITNINGBO(),
                                ),
                              ),
                              selected: true,
                              title: Text('PPIT Ningbo', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                              leading: new Icon(Icons.star, color: Colors.red,),
                            ),

                            new ListTile(
                              dense: true,
                              enabled: true,
                              isThreeLine: false,
                              onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => PPITSHANGHAI(),
                                ),
                              ),
                              selected: true,
                              title: Text('PPIT Shanghai', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                              leading: new Icon(Icons.star, color: Colors.red,),
                            ),

                            new ListTile(
                              dense: true,
                              enabled: true,
                              isThreeLine: false,
                              onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => PPITWUXI(),
                                ),
                              ),
                              selected: true,
                              title: Text('PPIT Wuxi', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                              leading: new Icon(Icons.star, color: Colors.red,),
                            ),

                          ],
                        ),
                      );
                    }
                )
            );
          }
      ),
      DemoItem<String>(
          name: 'REGION SELATAN',
          builder: (DemoItem<String> item) {
            void close() {
              setState(() {
                item.isExpanded = false;
              });
            }
            return Form(
                child: Builder(
                    builder: (BuildContext context) {
                      return CollapsibleBody(
                        child: new Column(
                          children: <Widget>[

                            new ListTile(
                              dense: true,
                              enabled: true,
                              isThreeLine: false,
                              onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => PPITCHONGQING(),
                                ),
                              ),
                              selected: true,
                              title: Text('PPIT Chongqing', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                              leading: new Icon(Icons.star, color: Colors.red,),
                            ),

                            new ListTile(
                              dense: true,
                              enabled: true,
                              isThreeLine: false,
                              onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => PPITGUILIN(),
                                ),
                              ),
                              selected: true,
                              title: Text('PPIT Guilin', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                              leading: new Icon(Icons.star, color: Colors.red,),
                            ),

                            new ListTile(
                              dense: true,
                              enabled: true,
                              isThreeLine: false,
                              onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => PPITHONGKONG(),
                                ),
                              ),
                              selected: true,
                              title: Text('PPIT Hongkong', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                              leading: new Icon(Icons.star, color: Colors.red,),
                            ),

                            new ListTile(
                              dense: true,
                              enabled: true,
                              isThreeLine: false,
                              onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => PPITWUHAN(),
                                ),
                              ),
                              selected: true,
                              title: Text('PPIT Wuhan', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                              leading: new Icon(Icons.star, color: Colors.red,),
                            ),

                            new ListTile(
                              dense: true,
                              enabled: true,
                              isThreeLine: false,
                              onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => PPITXIAMEN(),
                                ),
                              ),
                              selected: true,
                              title: Text('PPIT Xiamen', style: new TextStyle(fontSize: 16.0, color: Colors.red),),
                              leading: new Icon(Icons.star, color: Colors.red,),
                            ),

                          ],
                        ),
                      );
                    }
                )
            );
          }
      ),
    ];

  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            margin: const EdgeInsets.all(24.0),
            child: ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _demoItems[index].isExpanded = !isExpanded;
                  });
                },
                children: _demoItems.map((DemoItem<dynamic> item) {
                  return ExpansionPanel(
                      isExpanded: item.isExpanded,
                      headerBuilder: item.headerBuilder,
                      body: item.build()
                  );
                }).toList()
            ),
          ),
        ),
      ),
    );
  }
}

//Class Region Utara
class PPITHARBIN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_harbin,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('PPIT Harbin'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}

class PERMITBEIJING extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_beijing,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('Permit Beijing'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}

class PPITTIANJIN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_tianjin,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('PPIT Tianjin'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}

class PPITSHIJIAZHUANG extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_shijiazhuang,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('PPIT Shijiazhuang'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}

class PPITZHENGZHOU extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_zhengzhou,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('PPIT Zhengzhou'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}

//Class Region Timur
class PPITHANGZHOU extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_hangzhou,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('PPIT Hangzhou'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}

class PPITNINGBO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_ningbo,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('PPIT Ningbo'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}

class PPITSHANGHAI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_shanghai,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('PPIT Shanghai'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}

class PPITWUXI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_wuxi,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('PPIT Wuxi'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}

//Class Region Selatan
class PPITCHONGQING extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_chongqing,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('PPIT CHONGQING'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}

class PPITGUILIN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_guilin,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('PPIT Guilin'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}

class PPITHONGKONG extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_hongkong,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('PPIT Hongkong'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}

class PPITWUHAN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_wuhan,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('PPIT Wuhan'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}

class PPITXIAMEN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[
        new WebviewScaffold(
          url: ppit_xiamen,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: new Text('PPIT Xiamen'),
          ),
          withLocalStorage: true,
          withZoom: true,
        ),
      ],
    );
  }
}