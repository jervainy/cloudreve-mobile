import 'package:cloudreve_mobile/common/iconfont.dart';
import 'package:cloudreve_mobile/main.dart';
import 'package:cloudreve_mobile/routes/netdisk/netdisk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardPageState();

}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: context.watch<GlobalStore>().showBottomBar ? BottomNavigationBar(
        currentIndex: _pageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(IconFont.iconList), label: '列表'),
          BottomNavigationBarItem(icon: Icon(IconFont.iconTransfer), label: '传输'),
          BottomNavigationBarItem(icon: Icon(IconFont.iconUserGroup), label: '我的'),
        ],
        onTap: (page) {
          setState(() {
            _pageIndex = page;
          });
          _pageController.jumpToPage(page);
        },
      ) : null,
      body: Container(
        constraints: const BoxConstraints(minWidth: double.infinity, minHeight: double.infinity),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide())
        ),
        child: PageView(
          controller: _pageController,
          children: const [
            NetDiskView(),
            Icon(IconFont.iconTransfer),
            Icon(IconFont.iconUserGroup)
          ],
        )
      )
    );
  }

}
