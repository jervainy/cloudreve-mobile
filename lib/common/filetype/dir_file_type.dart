import 'package:cloudreve_mobile/common/iconfont.dart';
import 'package:flutter/material.dart';
import './file_type.dart';

class DirFileType extends FileType {

  @override
  Widget thumb() {
    return FileType.createThumbIcon(IconFont.fileTypeDefaultDir, paddingRight: 12);
  }

}