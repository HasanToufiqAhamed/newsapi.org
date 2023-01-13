import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app/data/config/app_dimens.dart';

class ListLoaderFooter extends StatelessWidget {
  final bool loading;
  final bool noMoreItem;
  final String noItemMessage;

  const ListLoaderFooter({
    required this.loading,
    required this.noMoreItem,
    this.noItemMessage = 'No news left!',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!loading && !noMoreItem) {
      return const SizedBox();
    }
    return SizedBox(
      height: AppDimens.scaffoldPadding * 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (loading == true)
            SizedBox(
              height: AppDimens.scaffoldPadding,
              width: AppDimens.scaffoldPadding,
              child: Platform.isIOS
                  ? const CupertinoActivityIndicator(
                      radius: 16,
                    )
                  : CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).primaryColor,
                    ),
            ),
          if (noMoreItem == true)
            SizedBox(
              height: AppDimens.scaffoldPadding * 2,
              child: Center(
                child: Text(
                  noItemMessage,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
