import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:untitled/app/data/config/app_dimens.dart';
import 'package:untitled/app/utilities/extensions/text.extensions.dart';
import 'package:untitled/app/utilities/extensions/widget.extensions.dart';

import '../../../utilities/custom_widgets/image/cache_image_view.dart';
import '../controllers/news_details_controller.dart';

class NewsDetailsView extends GetView<NewsDetailsController> {
  const NewsDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            stretch: true,
            // pinned: true,
            onStretchTrigger: () {
              return Future<void>.value();
            },
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              onPressed: () => Get.back(),
            ),
            actions: [
              Obx(
                () => IconButton(
                  icon: Icon(
                    controller.isBookMarked.value? Icons.bookmark_rounded: Icons.bookmark_border_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    controller.makeBookmark();
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              )
            ],
            // expandedHeight: AppDimens.displayHeight(context: context) / 2.6,
            expandedHeight: Get.width / 1.25,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
              ],
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: controller.news?.title ?? '',
                    child: CacheImageView(
                      url: controller.news?.urlToImage ?? '',
                      height: Get.width,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(
                    AppDimens.scaffoldPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.news?.title ?? '',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      16.verticalSpacing,
                      Text(
                        controller.news?.publishedAt.formattedDateName ?? '',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      16.verticalSpacing,
                      Text(
                        controller.news?.description ?? '',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      16.verticalSpacing,
                      Text(
                        controller.news?.content ?? '',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: Get.width,
                      )
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
