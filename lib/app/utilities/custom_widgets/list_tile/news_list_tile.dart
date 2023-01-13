import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/app/utilities/extensions/text.extensions.dart';
import 'package:untitled/app/utilities/extensions/widget.extensions.dart';

import '../../../../domain/core/model/news/news_ui.model.dart';
import '../../../data/config/app_dimens.dart';
import '../image/cache_image_view.dart';

class NewsListTile extends StatelessWidget {
  final NewsUIModel news;
  final bool heroAnimation;
  final Function()? onTap;

  const NewsListTile({
    Key? key,
    required this.news,
    this.heroAnimation = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppDimens.scaffoldPadding),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: (AppDimens.scaffoldPadding / 2).circularRadius,
                child: heroAnimation
                    ? Hero(
                        tag: news.title,
                        child: CacheImageView(
                          url: news.urlToImage,
                          height: Get.width / 5,
                          width: Get.width / 5,
                        ),
                      )
                    : CacheImageView(
                        url: news.urlToImage,
                        height: Get.width / 5,
                        width: Get.width / 5,
                      ),
              ),
              20.horizontalSpacing,
              Expanded(
                child: Column(
                  children: [
                    Text(
                      news.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    8.verticalSpacing,
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule_rounded,
                          color: Colors.black12,
                          size: 18,
                        ),
                        6.horizontalSpacing,
                        Text(
                          news.publishedAt.formattedDateName,
                          style: const TextStyle(color: Colors.black26),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
