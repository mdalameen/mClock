import 'package:flutter/material.dart';
import 'package:mclock/common/app_colors.dart';

class ClockWrapperWidget extends StatelessWidget {
  final VoidCallback onAddPressed;
  List<WrapContent> children;
  ClockWrapperWidget(this.onAddPressed, this.children);

  @override
  Widget build(BuildContext context) {
    double gridSize = (MediaQuery.of(context).size.width - 30) / 2;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        InkWell(
          onTap: onAddPressed,
          child: Container(
            alignment: Alignment.center,
            width: gridSize,
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(gridSize / 10),
              width: gridSize,
              height: gridSize,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.clockOuter),
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.clockInner),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 30,
                    ),
                    Text('Add', style: TextStyle(color: Colors.black, fontSize: 18))
                  ],
                ),
              ),
            ),
          ),
        ),
        ...List.generate(
            children.length,
            (index) => ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: gridSize),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: gridSize,
                        child: Column(
                          children: [
                            SizedBox(
                              width: gridSize,
                              height: gridSize,
                              child: children[index].child,
                            ),
                            Text(children[index].text)
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: PopupMenuButton<String>(
                          enabled: true,
                          onSelected: (_) => children[index].onTapped(),
                          itemBuilder: (_) => <PopupMenuItem<String>>[
                            PopupMenuItem(
                              child: Text('Delete'),
                              value: 'Delete',
                              enabled: true,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
      ],
    );
  }
}

class WrapContent {
  VoidCallback onTapped;
  Widget child;
  String text;

  WrapContent(this.onTapped, this.child, this.text);
}
