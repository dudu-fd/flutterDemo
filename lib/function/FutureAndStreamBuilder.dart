import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// FutureBuilder 会依赖一个 Future，它会根据所依赖的 Future 的状态来动态构建自身

/// StreamBuilder 会依赖一个 Stream，它会根据所依赖的 Stream 的状态来动态构建自身
/// 和 Future 不同的是，它可以接收多个异步操作的结果，它常用于会多次读取数据的异步任务场景，如网络内容下载、文件读写等

class FutureAndStreamBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return FutureWidget();
    return StreamWidget();
  }
}

class FutureWidget extends StatelessWidget {
  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "我是从网上获取的数据");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<String>(
          future: mockNetworkData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.toString());
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              // 请求失败，显示错误
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                // 请求成功，显示数据
                return Text("Contents: ${snapshot.data}");
              }
            } else {
              // 请求中，显示 loading
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

class StreamWidget extends StatelessWidget {
  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      return i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<int>(
        stream: counter(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          print(snapshot.toString());
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("none: 没有Stream");
            case ConnectionState.waiting:
              return Text("waiting: 等待数据...");
            case ConnectionState.active:
              return Text("active: ${snapshot.data}");
            case ConnectionState.done:
              return Text("done: Stream 已关闭");
          }
          return null;
        },
      ),
    );
  }
}
