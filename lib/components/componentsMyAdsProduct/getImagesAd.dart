import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttericon/entypo_icons.dart';
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
        child: images != null && images.length > 0
            ? Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return new Image.network(
                    images[index]['url'],
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        ),
                      );
                    },
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
              )
            : Container(
                height: screenHeight * 0.40,
                width: screenWidth,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Entypo.picture,
                      color: Colors.grey[300],
                      size: AppSizes.size100,
                    ),
                    SizedBox(
                      height: AppSizes.size20,
                    ),
                    Text(
                      "No Images",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppFontSize.s18,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
