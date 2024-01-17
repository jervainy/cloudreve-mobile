import 'package:cloudreve_mobile/api/webdav.dart';
import 'package:cloudreve_mobile/common/const.dart';
import 'package:cloudreve_mobile/common/filetype/file_type.dart';
import 'package:cloudreve_mobile/common/iconfont.dart';
import 'package:cloudreve_mobile/main.dart';
import 'package:cloudreve_mobile/models/file_model.dart';
import 'package:cloudreve_mobile/routes/netdisk/netdisk_sliver.dart';
import 'package:cloudreve_mobile/widgets/border_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum NetDiskViewType { grid, list }
enum NetDiskViewMode { selection, normal }

class SliverData {
  final FileItemModel fileItem;
  final FileType fileType;
  bool checked = false;
  SliverData(this.fileItem, this.fileType);
}

typedef SliverOpenCallback = void Function(BuildContext, int, SliverData);
typedef SliverSelectCallback = void Function(BuildContext, int, SliverData, bool);

class NetDiskView extends StatefulWidget {
  final String parent;
  const NetDiskView({super.key, this.parent = '/'});

  @override
  State<StatefulWidget> createState() => _NetDiskState();

}

class _NetDiskState extends State<NetDiskView> {
  List<SliverData> list = [];
  List<int> selectedList = [];
  String sortedBy = '';
  NetDiskViewType viewBy = NetDiskViewType.grid;
  NetDiskViewMode modeBy = NetDiskViewMode.normal;

  @override
  void initState() {
    super.initState();
    requestData();
  }

  void requestData() async {
    var data = await WebDavApi.fileList(widget.parent);
    var items = data.objects.map((e) => SliverData(e, FileType.parse(e.type, e.name))).toList();
    setState(() {
      list = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final body = Expanded(child: Container(
      padding: const EdgeInsets.only(left: contentHorizontalPadding, right: contentHorizontalPadding),
      child: fileListView(context),
    ));
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity, minHeight: double.infinity),
      decoration: const BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
      child: BorderBox(child: Column(
        children: modeBy == NetDiskViewMode.selection && selectedList.isNotEmpty ? [topWidget(context), body, renderAction(context)] : [topWidget(context), body],
      )),
    );
  }

  void onSliverOpen(BuildContext context, int index, SliverData sliverData) {
    if (sliverData.fileItem.type == 'dir') {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return NetDiskView(parent: widget.parent == '/' ? "${widget.parent}${sliverData.fileItem.name}" : "${widget.parent}/${sliverData.fileItem.name}");
          }
      ));
    } else {

    }
    print('sliverOpen1');
  }

  void onSliverSelect(BuildContext context, int index, SliverData sliverData, bool checked) {
    if (index >= 0 && index < list.length) {
      context.read<GlobalStore>().setBottomBarValue(false);
      setState(() {
        modeBy = NetDiskViewMode.selection;
        list[index].checked = checked;
        if (checked && !selectedList.contains(index)) {
          selectedList.add(index);
        }
        if (!checked) {
          selectedList.remove(index);
        }
      });
    }
  }

  NullableIndexedWidgetBuilder _itemBuilder(List<SliverData> objects) {
    return (BuildContext context, int index) {
      var obj = objects[index];
      // var fileType = FileType.parse(obj.type, obj.name);
      return NetDiskSliver(index, obj, viewBy, modeBy, onSliverSelect, onSliverOpen);
    };
  }

  Widget fileListView(BuildContext context) {
    if (list.isEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: 120),
        child: const Text('网盘内文件为空'),
      );
    }
    var renderView = viewBy == NetDiskViewType.grid ? renderGridView(list) : renderListView(list);
    // return BorderBox(child: renderView);
    return renderView;
  }

  Widget renderGridView(List<SliverData> objects) {
    return GridView.builder(
        padding: const EdgeInsets.only(top: 10),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8
        ),
        itemCount: objects.length,
        itemBuilder: _itemBuilder(objects)
    );
  }

  Widget renderListView(List<SliverData> objects) {
    return ListView.builder(
        itemCount: objects.length,
        itemBuilder: _itemBuilder(objects),
    );
  }


  Widget renderAction(BuildContext context) {
    const h = 48.0;
    var textItems = ['分享', '下载', '添加到', '移动', '删除'];
    if (selectedList.length == 1) {
      textItems.insert(0, '重命名');
    }
    return Container(
      constraints: const BoxConstraints(minHeight: h, maxHeight: h, minWidth: double.infinity),
      padding: const EdgeInsets.only(left: contentHorizontalPadding, right: contentHorizontalPadding),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide())
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: textItems.map((e) => TextButton(
            onPressed: () {

            },
            child: Text(e)
        )).toList(),
      ),
    );
  }

  Widget topSelectionWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  context.read<GlobalStore>().setBottomBarValue(true);
                  setState(() {
                    for (var value in selectedList) {
                      list[value].checked = false;
                    }
                    selectedList = [];
                    modeBy = NetDiskViewMode.normal;
                  });
                },
                child: const Text('取消')
            ),
            Text("${selectedList.length}/${list.length}")
          ],
        ),
        TextButton(
            onPressed: () {
              setState(() {
                for (var i = 0; i < list.length; i++) {
                  if (!list[i].checked) {
                    list[i].checked = true;
                    selectedList.add(i);
                  }
                }
              });
            },
            child: const Text('全选')
        )
      ],
    );
  }

  Widget topParentWidget(BuildContext context) {
    return Row();
  }

  Widget topNormalWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('文件', style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
        )),
        Row(children: [
          IconButton(icon: const Icon(IconFont.iconSearch), onPressed: () {

          }),
          IconButton(icon: const Icon(IconFont.iconFilter), onPressed: () {

          })
        ],)
      ],
    );
  }


  Widget topWidget(BuildContext context) {
    const h = 48.0;
    return BorderBox(child: Container(
        constraints: const BoxConstraints(minHeight: h, maxHeight: h),
        padding: const EdgeInsets.only(left: contentHorizontalPadding, right: contentHorizontalPadding),
        decoration: const BoxDecoration(
          // border: Border(bottom: BorderSide()),
          color: Colors.black12
        ),
        child: modeBy == NetDiskViewMode.selection ? topSelectionWidget(context) : topNormalWidget(context)
    ));
  }

}