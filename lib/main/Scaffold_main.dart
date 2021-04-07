import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
  AppBar({
    Key key,
    this.leading, //导航栏最左侧Widget，常见为抽屉菜单按钮或返回按钮。
    this.automaticallyImplyLeading = true, //如果leading为null，是否自动实现默认的leading按钮
    this.title,// 页面标题
    this.actions, // 导航栏右侧菜单
    this.bottom, // 导航栏底部菜单，通常为Tab按钮组
    this.elevation = 4.0, // 导航栏阴影
    this.centerTitle, //标题是否居中
    this.backgroundColor,
    ...   //其它属性见源码注释
  })
*/

void main() {
  runApp(MyApp());
}

/*
* MaterialApp 大部分情况下要作为 Flutter 的 根 Widget，并且 MaterialApp 和 Scaffold 经常是一起搭配使用的。
* */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo", //出现在 Android 的任务管理器上或者是 iOS 程序切换管理器中
      color: Colors.lightGreen, // title 的字体颜色
      home: ScaffoldRoute(),
    );
  }
}

class ScaffoldRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute>
    with SingleTickerProviderStateMixin {
  TabController _tabController; // Tab 控件器
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      print(_tabController.index.toString());
      switch (_tabController.index) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 顶部标题栏
        title: Text(
          "App Name",
        ),
        centerTitle: true,
        actions: [
          IconButton(
              // 标题栏右侧按钮
              icon: Icon(Icons.share),
              onPressed: () {
                _showSnackBar("share");
              }),
        ],
        leading: Builder(builder: (context) {
          // 设置标题栏左侧图标
          return IconButton(
              icon: Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              onPressed: () {
                // 打开抽屉控件
                Scaffold.of(context).openDrawer();
                // Scaffold.of(context).openEndDrawer();
              });
        }),
        bottom: TabBar(
          // 标题栏下面的选项卡
          controller: _tabController,
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
        ),
      ),
      body: TabBarView(
        // 可以通过 controller 跟 TabBar 联动的 View
        children: tabs.map((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              e,
              textScaleFactor: 5,
            ),
          );
        }).toList(),
        controller: _tabController,
      ),
      drawer: MyDrawer(),
      // 抽屉控件
      // endDrawer: MyDrawer(),
      bottomNavigationBar: MyBottomBar(),
      // 底部导航栏
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // 悬浮按钮
        child: Icon(Icons.add),
        onPressed: () {
          _showSnackBar("add");
        },
      ),
    );
  }

  void _showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      duration: Duration(seconds: 1),
    ));
  }
}

// 抽屉布局
class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Drawer 作为根布局
      child: MediaQuery.removePadding(
        // 移除 Drawer 默认的一些留白
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 38),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipOval(
                      // 头像
                      child: Image.asset(
                        "images/dog.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    // 姓名
                    "Dudu",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(
              // 列表选项
              children: [
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text("Add account"),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Manage accounts"),
                ),
              ],
            ))
          ],
        ),
        removeTop: true, // 移除顶部留白
      ),
    );
  }
}

// 底部导航栏
class MyBottomBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int _selectIndex = 1;

  @override
  Widget build(BuildContext context) {
    /*  return BottomNavigationBar(
        // 底部导航栏
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), label: "Business"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "School"),
        ],
        currentIndex: _selectIndex, // 当前选中 Item ，默认从0开始
        fixedColor: Colors.blue, // Item 选中时的颜色
        onTap: _onItemTapped);*/

    return BottomAppBar(
      color: Colors.white,
      shape: CircularNotchedRectangle(), //底部导航栏打一个圆形的洞
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {},
            focusColor: Colors.blue,
            autofocus: true,
          ),
          SizedBox(), // 中间位置空出来，只用作占位
          IconButton(icon: Icon(Icons.business), onPressed: () {}),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
}
