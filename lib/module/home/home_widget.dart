import 'package:flutter/material.dart';
import 'package:mclock/common/app_colors.dart';
import 'package:mclock/injector.dart';
import 'package:mclock/module/home/home_page.dart';
import 'package:mclock/module/home/home_viewmodel.dart';

class HomeWidget {
  final vm = inject<HomeViewmodel>();
  buildBottomBar(BuildContext context) {
    double allPadding = 10;
    double width = MediaQuery.of(context).size.width - allPadding * 2;
    double itemSize = width / PageType.values.length;

    return Container(
      decoration: BoxDecoration(color: AppColors.white, boxShadow: <BoxShadow>[
        BoxShadow(
          color: AppColors.grey,
          blurRadius: allPadding,
          offset: Offset.zero,
        )
      ]),
      padding: EdgeInsets.all(allPadding),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            AnimatedContainer(
              margin: EdgeInsets.only(left: itemSize * vm.selectedPage.index + itemSize / 2 - 3),
              duration: Duration(milliseconds: 150),
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                width: 6,
                height: 6,
              ),
            ),
            SafeArea(
                child: Row(
              children: [
                _getMenuItem(PageType.clock),
                _getMenuItem(PageType.alarm),
                _getMenuItem(PageType.settings),
              ],
            ))
          ],
        ),
      ),
    );
  }

  _getMenuItem(PageType page) {
    final isSelected = vm.selectedPage == page;

    return Expanded(
      child: InkWell(
        onTap: () => vm.onMenuChanged(page),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Icon(
              vm.getPageIcon(page),
              color: isSelected ? AppColors.accent : AppColors.grey,
              size: isSelected ? 25 : 30,
            ),
            if (isSelected)
              Text(
                vm.getPageTitle(page),
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
