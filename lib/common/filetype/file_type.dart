import 'package:cloudreve_mobile/common/filetype/xlsx_file_type.dart';
import 'package:flutter/material.dart';
import 'package:cloudreve_mobile/widgets/border_box.dart';
import './docx_file_type.dart';
import './dir_file_type.dart';
import './unknown_file_type.dart';
import './web_file_type.dart';
import './pic_file_type.dart';
import './zip_file_type.dart';
import './tar_file_type.dart';

abstract class FileType {

  static const double thumbSize = 72;

  static FileType parse(String type, String name) {
    if (type == 'dir') return DirFileType();
    int index = name.lastIndexOf(".");
    if (index == -1) return UnknownFileType();
    var suffix = name.substring(index + 1);
    if (suffix.startsWith('doc')) return DocxFileType();
    if (suffix.startsWith('xls')) return XlsxFileType();
    if (suffix.contains('htm') || suffix.contains('xml')) return WebFileType();
    if (suffix.contains('jpeg') || suffix.contains('jpg') || suffix.contains('png')) return PicFileType();
    if (suffix.contains('tar')) return TarFileType();
    if (suffix.contains('zip')) return ZipFileType();
    return UnknownFileType();
  }

  static Widget createThumbIcon(IconData iconData, { double paddingLeft = 0, double paddingRight = 0 }) {
    // return BorderBox(child: Container(
    //   padding: EdgeInsets.only(left: paddingLeft, right: paddingRight),
    //   child: Icon(iconData, size: FileType.thumbSize),
    // ));
    return Container(
      padding: EdgeInsets.only(left: paddingLeft, right: paddingRight),
      child: Icon(iconData, size: FileType.thumbSize),
    );
  }

  Widget thumb();

}