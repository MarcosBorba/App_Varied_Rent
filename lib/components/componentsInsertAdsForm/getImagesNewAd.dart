import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/insertAdsPages/insertAdsProductInheritedClass.dart';
import 'package:varied_rent/views/insertAdsPages/myAdsProductShowImages.dart';

class ImagesNewAd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ImagesNewAdState();
}

class ImagesNewAdState extends State<ImagesNewAd> {
  final Color backgroundOpacityImages;
  final double imagesHeight;
  final double elevation;

  ImagesNewAdState({
    Key key,
    this.backgroundOpacityImages = AppColors.backgroundOpacityImages,
    this.imagesHeight,
    this.elevation,
  });
  @override
  Widget build(BuildContext context) {
    List<File> images = CacheProviderInsertAd.of(context).imagesFile;
    UniqueKey keySwiper = CacheProviderInsertAd.of(context).keyImages;
    return Material(
      color: backgroundOpacityImages.withOpacity(0.1),
      elevation: elevation == null ? AppSizes.size20 : elevation,
      child: Container(
        height: imagesHeight == null ? screenHeight * 0.40 : imagesHeight,
        width: screenWidth,
        color: Colors.transparent,
        child: Swiper(
          key: keySwiper,
          itemBuilder: (BuildContext context, int index) {
            return FutureBuilder(
              future: getLenghtImage(images[index]),
              builder: (_, snapshot) {
                return snapshot.data != null && snapshot.data
                    ? Image.file(
                        images[index],
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                      )
                    : Container(
                        height: imagesHeight == null
                            ? screenHeight * 0.40
                            : imagesHeight,
                        width: screenWidth,
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
              },
            );
          },
          itemCount: images != null ? images.length : 0,
          viewportFraction: 0.9,
          scale: 0.95,
          pagination: new SwiperPagination(),
          index: 0,
          //loop: false,
          onTap: (index) async {
            AppRoutes.push(
              context,
              ShowImagesNewProduct(
                imageUrl: images[index],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> getLenghtImage(File file) async {
    int assetVerify = await file.length();
    bool verifyImageLength = assetVerify > 10000000 ? false : true;
    return verifyImageLength;
  }
}
