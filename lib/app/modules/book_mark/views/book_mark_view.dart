import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:untitled/app/utilities/custom_widgets/list_tile/news_list_tile.dart';
import 'package:untitled/app/utilities/extensions/text.extensions.dart';
import 'package:untitled/app/utilities/extensions/widget.extensions.dart';

import '../../../data/config/app_dimens.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/custom_widgets/image/cache_image_view.dart';
import '../controllers/book_mark_controller.dart';

class BookMarkView extends GetView<BookMarkController> {
  const BookMarkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Marks'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.bookMarkList.isEmpty) {
            return const Center(
              child: Icon(
                Icons.sentiment_dissatisfied_rounded,
                size: 120,
                color: Colors.black12,
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.scaffoldPadding,
              vertical: AppDimens.scaffoldPadding,
            ),
            itemCount: controller.bookMarkList.length,
            itemBuilder: (context, index) {
              var data = controller.bookMarkList[index];
              return NewsListTile(
                news: data,
                onTap: (){
                  Get.toNamed(Routes.NEWS_DETAILS, parameters: {
                    'data': data.toString(),
                  });
                },
                heroAnimation: false,
              );
            },
          );
        },
      ),
    );
  }
}
