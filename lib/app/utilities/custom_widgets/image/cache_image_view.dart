import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImageView extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color color;

  const CacheImageView({
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color = Colors.black12,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        color: color,
        width: width,
        height: height,
        child: const SizedBox(),
      ),
      errorWidget: (context, url, error) => Container(
        color: color,
        height: height,
        width: width,

        child: const Icon(
          Icons.image_rounded,
          color: Colors.black26,
        ),
      ),
    );
  }
}
