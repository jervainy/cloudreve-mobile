import 'package:cloudreve_mobile/common/iconfont.dart';
import 'package:cloudreve_mobile/widgets/border_box.dart';
import 'package:flutter/cupertino.dart';

class FileModel {
  final String parentId;
  List<FileItemModel> objects;
  FileModel(this.parentId, this.objects);
}

class FileItemModel {
  final String id;
  final String path;
  final String name;
  final String type;
  final int size;
  final String createdAt;
  final String lastAt;
  const FileItemModel(this.id, this.path, this.name, this.type, {
    this.size = 0, this.createdAt = '', this.lastAt = ''
  });

  Widget icon() {
    Widget widget = Container(
      margin: EdgeInsets.zero,
      child: const Icon(IconFont.fileTypeUnknown, size: 72),
    );
    if ("dir" == type) {
      widget = Container(
        margin: const EdgeInsets.only(right: 15),
        child: const Icon(IconFont.fileTypeDefaultDir, size: 72),
      );
    } else {
      int index = name.lastIndexOf(".");
      if (index != -1) {
        var suffix = name.substring(index + 1);
        switch (suffix) {
          case "docx":
            widget = Container(
              margin: EdgeInsets.zero,
              child: const Icon(IconFont.fileTypeDoc, size: 72),
            );
            break;
        }
      }
    }

    return BorderBox(child: widget);
  }

}


