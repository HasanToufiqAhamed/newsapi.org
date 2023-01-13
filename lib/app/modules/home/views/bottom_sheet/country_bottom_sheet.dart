import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryBottomSheet extends StatelessWidget {
  CountryBottomSheet({Key? key}) : super(key: key);

  List<String> countries = ['US', 'IN'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: ListView.builder(
          itemCount: countries.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var value = countries[index];
            return ListTile(
              title: Text(value),
              onTap: () {
                Get.back(result: value);
              },
            );
          },
        ),
      ),
    );
  }
}
