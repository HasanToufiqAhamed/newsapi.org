import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:untitled/app/data/config/app_dimens.dart';
import 'package:untitled/app/routes/app_pages.dart';
import 'package:untitled/app/utilities/custom_widgets/list_tile/news_list_tile.dart';
import 'package:untitled/app/utilities/extensions/text.extensions.dart';
import 'package:untitled/app/utilities/extensions/widget.extensions.dart';
import 'package:untitled/app/utilities/text_fields/search_text_form_field.dart';

import '../../../utilities/custom_widgets/image/cache_image_view.dart';
import '../../../utilities/custom_widgets/loading/list_loader_footer.dart';
import '../../../utilities/custom_widgets/loading/main_loader.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.scaffoldPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Discover',
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                          ),
                          Obx(() {
                            return Text(
                              'News from all over the ${controller.country.value}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black26,
                                  ),
                            );
                          }),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.BOOK_MARK);
                        },
                        icon: const Icon(Icons.bookmark_rounded),
                      ),
                      Obx(
                        () {
                          if (controller.userImage.value.isNotEmpty) {
                            return InkWell(
                              onTap: () {
                                controller.signOut();
                              },
                              child: ClipRRect(
                                borderRadius: 50.circularRadius,
                                child: CacheImageView(
                                  url: controller.userImage.value,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            );
                          }
                          return InkWell(
                            onTap: () {
                              controller.googleSignIn();
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: 50.circularRadius,
                                  color: Colors.black.withOpacity(0.1)),
                              child: const Icon(
                                Icons.account_circle_outlined,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  AppDimens.scaffoldPadding.verticalSpacing,
                  SearchTextFormField(
                    hintText: 'Search',
                    controller: textEditingController,
                    suffixIcon: const Icon(
                      Icons.tune_rounded,
                      color: Colors.black38,
                    ),
                    onTapSuffix: () {
                      controller.selectCountry();
                      textEditingController.clear();
                    },
                    onFieldSubmitted: (v) {
                      controller.search(keyWord: v);
                      textEditingController.clear();
                    },
                  ),
                  AppDimens.scaffoldPadding.verticalSpacing,
                ],
              ),
            ),
            TabBar(
              onTap: (e) {
                controller.changeTab(value: e);
              },
              indicatorColor: Colors.black87,
              labelColor: Colors.black87,
              unselectedLabelColor: Colors.black45,
              indicatorWeight: 10,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                for (var value in controller.tabs) Tab(text: value.capitalize),
              ],
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.scaffoldPadding),
              controller: controller.tabController,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2,
                ),
                insets: EdgeInsets.only(left: 10, right: 10, bottom: 4),
              ),
              isScrollable: true,
            ),
            Expanded(
              child: GetBuilder<HomeController>(
                id: 'news',
                builder: (logic) {
                  if (logic.loadingForNews) {
                    return const MainLoader();
                  }
                  if (!logic.loadingForNews && logic.newsList.isEmpty) {
                    return const Icon(
                      Icons.sentiment_dissatisfied_rounded,
                      size: 120,
                      color: Colors.black12,
                    );
                  }
                  return ListView.builder(
                    controller: controller.productsScrollController,
                    padding: const EdgeInsets.all(AppDimens.scaffoldPadding),
                    itemCount: logic.newsList.length,
                    itemBuilder: (context, index) {
                      var data = logic.newsList[index];
                      return NewsListTile(
                        news: data,
                        onTap: () {
                          Get.toNamed(Routes.NEWS_DETAILS, parameters: {
                            'data': data.toString(),
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Obx(
              () => ListLoaderFooter(
                loading: controller.loadingMoreProduct.value,
                noMoreItem: controller.noMoreProduct.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
