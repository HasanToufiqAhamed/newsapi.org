import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io' show Platform;

class MainLoader extends StatelessWidget {
  final double size;

  const MainLoader({
    this.size = 80,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: Platform.isIOS
            ? const CupertinoActivityIndicator(
                radius: 24,
              )
            : CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).primaryColor,
              ),
      ),
    );
  }
}
