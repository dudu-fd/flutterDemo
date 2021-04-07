import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
*
     ListView({
      ...
      //可滚动widget公共参数
      Axis scrollDirection = Axis.vertical,
      bool reverse = false,
      ScrollController controller,
      bool primary,
      ScrollPhysics physics,
      EdgeInsetsGeometry padding,

      //ListView各个构造函数的共同参数
      double itemExtent,
      bool shrinkWrap = false,
      bool addAutomaticKeepAlives = true,
      bool addRepaintBoundaries = true,
      double cacheExtent,

      //子widget列表
      List<Widget> children = const <Widget>[],
      })

   itemExtent：
   该参数如果不为null，则会强制children的“长度”为itemExtent的值；这里的“长度”是指滚动方向上子组件的长度，
   也就是说如果滚动方向是垂直方向，则itemExtent代表子组件的高度；如果滚动方向为水平方向，则itemExtent就代表子组件的宽度。
   在ListView中，指定itemExtent比让子组件自己决定自身长度会更高效，这是因为指定itemExtent后，滚动系统可以提前知道列表的长度，
   而无需每次构建子组件时都去再计算一下，尤其是在滚动位置频繁变化时（滚动系统需要频繁去计算列表高度）。

   shrinkWrap：
   该属性表示是否根据子组件的总长度来设置ListView的长度，默认值为false 。默认情况下，ListView的会在滚动方向尽可能多的占用空间。
   当ListView在一个无边界(滚动方向上)的容器中时，shrinkWrap必须为true。

   addAutomaticKeepAlives：
   该属性表示是否将列表项（子组件）包裹在AutomaticKeepAlive 组件中；典型地，在一个懒加载列表中，如果将列表项包裹在AutomaticKeepAlive中，
   在该列表项滑出视口时它也不会被GC（垃圾回收），它会使用KeepAliveNotification来保存其状态。如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。

   addRepaintBoundaries：
   该属性表示是否将列表项（子组件）包裹在RepaintBoundary组件中。当可滚动组件滚动时，将列表项包裹在RepaintBoundary中可以避免列表项重绘，
   但是当列表项重绘的开销非常小（如一个颜色块，或者一个较短的文本）时，不添加RepaintBoundary反而会更高效。和addAutomaticKeepAlive一样，
   如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。
 */

class ListViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return DefaultListView();
    // return BuilderListView();
    // return SeparatedListView();
    return LoadMoreListView();
  }
}

/*
*    默认构造方法
*   只有少量的子组件的情况，因为这种方式需要将所有children都提前创建好（这需要做大量工作），而不是等到子widget真正显示的时候再创建，
*   也就是说通过默认构造函数构建的ListView没有应用基于Sliver的懒加载模型。实际上通过此方式创建的ListView和使用 SingleChildScrollView+Column 的
*   方式没有本质的区别。
* */
class DefaultListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      children: [
        const Text('I\'m dedicating every day to you'),
        const Text('Domestic life was never quite my style'),
        const Text('When you smile, you knock me out, I fall apart'),
        const Text('And I thought I was so smart'),
      ],
    );
  }
}

/*
  适合列表项比较多（或者无限）的情况，因为只有当子组件真正显示的时候才会被创建，
  也就说通过该构造函数创建的ListView是支持基于Sliver的懒加载模型的。
*/
class BuilderListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text("$index"),
        );
      },
      itemCount: 100, // 列表数量为100，如果是null，则无限数量
      itemExtent: 50, // 强制高度为50
    );
  }
}

/*
* 可以在生成的列表项之间添加一个分割组件，它比ListView.builder多了一个separatorBuilder参数，该参数是一个分割组件生成器
* */
class SeparatedListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(
      color: Colors.blue,
      thickness: 2, // 分割线厚度
      indent: 10, // 左侧的缩进距离
      endIndent: 10, // 右侧的缩进距离
    );
    Widget divider2 = Divider(
      color: Colors.green,
    );
    return ListView.separated(
        // 项目项构造器
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("$index"),
          );
        },
        // 分割线构造器
        separatorBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? divider1 : divider2;
        },
        itemCount: 100);
  }
}

/* 带有加载更多的列表演示 */
class LoadMoreListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadMoreListViewState();
}

class _LoadMoreListViewState extends State<LoadMoreListView> {
  static const loadingTag = "##loading##"; // 表尾标记
  var _words = <String>[loadingTag]; //列表数据，范型为 String

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("单词列表"),
        ),
        Expanded(
            // Expanded 将自动拉伸填充剩余空间
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  // 如果到了列表尾部
                  if (_words[index] == loadingTag) {
                    // 不足100条，继续获取数据，要减去尾部标记位数据
                    if (_words.length - 1 < 100) {
                      // 获取数据
                      _retrieveData();
                      // 显示加载 loading
                      return Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    } else {
                      // 已经加载了 100 条数据，不再获取数据，显示没有更多
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "没有更多了",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                  }
                  // 不是上述的情况，则正常显示内容
                  return ListTile(
                    title: Text(_words[index]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                      height: 0,
                    ),
                itemCount: _words.length))
      ],
    );
  }

  // 加载数据
  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      // 重新构建列表
      setState(() {
        _words.insertAll(
            _words.length - 1,
            // 每次生成20个单词
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }
}
