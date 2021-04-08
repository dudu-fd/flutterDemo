import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/* Model变化后会自动通知ChangeNotifierProvider（订阅者），ChangeNotifierProvider内部会重新构建InheritedWidget，
  而依赖该InheritedWidget的子孙Widget就会更新。*/

// 一个通用的InheritedWidget，保存任意需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  //共享状态使用泛型
  final T data;

  @override
  bool updateShouldNotify(covariant InheritedProvider<T> oldWidget) {
    // 在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    print("updateShouldNotify");
    return true;
  }
}

// 将要共享的状态放在一个 Model 类中，该类继承于 ChangeNotifier ，当 Model 数据更改时，就可以重新构建 InheritedProvider 了
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({Key key, this.data, this.child});

  final Widget child;

  final T data;

  // 定义一个便捷方法，方便子树中的 Widget 获取共享数据，listen 为可选参数，为false时不会注册依赖，即不会重新构建
  static T of<T>(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
            ?.widget as InheritedProvider<T>;
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    // 如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给 Model 添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除 Model 的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 这里用到了 InheritedWidget ，把对应的参数把传给它，通过 update 方法让它重新构建，来让依赖它的子 Widget 更新
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

// 这是一个便捷类，会获得当前 context 和指定数据类型的 Provider
class Consumer<T> extends StatelessWidget {
  Consumer({Key key, @required this.builder})
      : assert(builder != null),
        super(key: key);

  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
        context, ChangeNotifierProvider.of<T>(context)); // 自动获取 Model
  }
}

// 定义一个 Item 类 ，用于表示商品信息
class Item {
  double price; // 商品单价
  int count; // 商品数量
  Item(this.price, this.count);
}

// 定义一个保存购物车内商品数据的类
class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<Item> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice => _items.fold(
      0,
      (previousValue, element) =>
          previousValue + element.count * element.price);

  // 将 [item] 添加到购物车，这是唯一方式从外部改变购物车的方法
  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}

class CartWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 消费 CartModel 的 Widget ，语义非常明确，不需要手动获取 Model
                Consumer<CartModel>(
                    builder: (context, cart) => Text("总价： ${cart.totalPrice}")),
                // Builder(builder: (context) {
                //   print("Text build");
                //   var cart = ChangeNotifierProvider.of<CartModel>(context);
                //   return Text("总价： ${cart.totalPrice}");
                // }),
                Builder(builder: (context) {
                  print("ElevatedButton build");
                  return ElevatedButton(
                      // ElevatedButton 依赖了 ChangeNotifierProvider ，所以也会重新构建
                      onPressed: () {
                        //给购物车中添加商品，添加后总价会更新
                        // listen 设为false，不建立依赖关系
                        ChangeNotifierProvider.of<CartModel>(context,
                                listen: false)
                            .add(Item(20, 1));
                      },
                      child: Text("添加商品"));
                })
              ],
            );
          },
        ),
      ),
    );
  }
}
