import 'package:cloudreve_mobile/widgets/border_box.dart';
import 'package:flutter/material.dart';
import './netdisk.dart';

class NetDiskSliver extends StatelessWidget {
  final int index;
  final NetDiskViewType viewBy;
  final NetDiskViewMode modeBy;
  final SliverData sliverData;
  final SliverSelectCallback onSelect;
  final SliverOpenCallback onOpen;
  const NetDiskSliver(this.index, this.sliverData, this.viewBy, this.modeBy, this.onSelect, this.onOpen, {super.key});


  @override
  Widget build(BuildContext context) {
    var renderWidget = viewBy == NetDiskViewType.grid ? renderGridSliver(context) : renderListSliver(context);
    return GestureDetector(child: renderWidget);
  }

  Widget wrapGestureDetector(BuildContext context, Widget child) {
    return GestureDetector(
      child: child,
      onTap: () {
        onOpen(context, index, sliverData);
      },
      onLongPress: () {
        onSelect(context, index, sliverData, true);
      },
    );
  }

  Widget renderGridSliver(BuildContext context) {
    final body = Column(
      children: [
        sliverData.fileType.thumb(),
        // renderName(),
        // renderDate()
      ],
    );
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      child: wrapGestureDetector(context, Stack(
        alignment: Alignment.center,
        children: _iSCheckMode() ? [body, Positioned(
            top: 0,
            right: 0,
            child: renderCheckbox(context)
        )] : [body],
      )),
    );
  }

  Widget renderListSliver(BuildContext context) {
    return Container();
  }

  Widget renderName() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Text(sliverData.fileItem.name, maxLines: 2, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87
        ),)
    );
  }

  Widget renderDate() {
    var str = sliverData.fileItem.lastAt.substring(0, 10);
    return Container(
        margin: const EdgeInsets.only(top: 2),
        child: Text(str, maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: const TextStyle(
          fontSize: 12,
          color: Colors.black38
        ),)
    );
  }

  Widget renderCheckbox(BuildContext context) {
    return Checkbox(
        value: sliverData.checked,
        onChanged: (checked) {
          if (checked != null) {
            onSelect(context, index, sliverData, checked);
          }
        },
      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused
        };
        if (states.contains(MaterialState.disabled)) {
          return ThemeData.from(colorScheme: const ColorScheme.light()).disabledColor;
        }
        if (states.contains(MaterialState.selected)) {
          return Colors.blue;
        }
        if (states.any(interactiveStates.contains)) {
          return Colors.red;
        }
        return Colors.white;
      }),
    );
  }

  bool _iSCheckMode() {
    return modeBy == NetDiskViewMode.selection;
  }


}
