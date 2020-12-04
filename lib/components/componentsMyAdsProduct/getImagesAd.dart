import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProductInheritedClass.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProductShowImages.dart';

class ImagesAd extends StatelessWidget {
  final Color backgroundOpacityImages;
  final double imagesHeight;
  final double elevation;

  ImagesAd({
    Key key,
    this.backgroundOpacityImages = AppColors.backgroundOpacityImages,
    this.imagesHeight,
    this.elevation,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List images = CacheProvider.of(context).imagesAd;
    return Material(
      color: backgroundOpacityImages.withOpacity(0.1),
      elevation: elevation == null ? AppSizes.size20 : elevation,
      child: Container(
        height: imagesHeight == null ? screenHeight * 0.40 : imagesHeight,
        width: screenWidth,
        color: Colors.transparent,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            print("object passou");
            return new Image.network(
              images[index]['url'],
              fit: BoxFit.cover,
            );
          },
          itemCount: images.length,
          viewportFraction: 0.9,
          scale: 0.95,
          pagination: new SwiperPagination(),
          onTap: (index) {
            AppRoutes.push(
              context,
              ShowImagesProduct(
                imageUrl: images[index]['url'],
              ),
            );
          },
        ),
      ),
    );
  }
}
