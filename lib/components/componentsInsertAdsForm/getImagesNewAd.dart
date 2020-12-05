import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/insertAdsPages/imageFile.dart';
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
    List<ImageFile> images = CacheProviderInsertAd.of(context).imagesFile;
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
            return images != null && images[index].isImageBig == false
                ? Image.file(
                    images[index].image,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  )
                : images != null && images[index].isImageBig
                    ? Stack(
                        children: <Widget>[
                          Center(
                            child: Image.file(
                              images[index].image,
                              height: imagesHeight == null
                                  ? screenHeight * 0.40
                                  : imagesHeight,
                              width: screenWidth,
                              fit: BoxFit.cover,
                              gaplessPlayback: true,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.close,
                            size: AppSizes.size40,
                            color: Colors.red,
                          ),
                          Center(
                            child: Text(
                              AppTexts().warningBigImageInsertAd,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
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
                imageUrl: images[index].image,
              ),
            );
          },
        ),
      ),
    );
  }
}
