import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/editAdsPages/editAdsProductInheritedClass.dart';
import 'package:varied_rent/views/insertAdsPages/imageFile.dart';

//TODO: nivel 4: images,colors,texts....
class ImagesEditAd extends StatefulWidget {
  final Function(dynamic) onRemoveImageDatabase;

  const ImagesEditAd({Key key, this.onRemoveImageDatabase}) : super(key: key);
  @override
  State<StatefulWidget> createState() =>
      ImagesEditAdState(onRemoveImageDatabase: onRemoveImageDatabase);
}

class ImagesEditAdState extends State<ImagesEditAd> {
  final Color backgroundOpacityImages;
  final double imagesHeight;
  final double elevation;
  final Function(dynamic) onRemoveImageDatabase;

  ImagesEditAdState({
    Key key,
    this.backgroundOpacityImages = AppColors.backgroundOpacityImages,
    this.imagesHeight,
    this.elevation,
    this.onRemoveImageDatabase,
  });
  @override
  Widget build(BuildContext context) {
    List images = CacheProviderEditAd.of(context).allImages;
    UniqueKey keySwiper = CacheProviderEditAd.of(context).keyImages;
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
            if (images != null && images[index].runtimeType != ImageFile) {
              return Stack(
                children: <Widget>[
                  Center(
                    child: Image.network(
                      images[index]['url'],
                      height: imagesHeight == null
                          ? screenHeight * 0.40
                          : imagesHeight,
                      width: screenWidth,
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                    ),
                  ),
                  Positioned(
                    top: AppSizes.size10,
                    left: AppSizes.size30,
                    child: Material(
                      elevation: 15,
                      shape: CircleBorder(),
                      color: AppColors.insertAdSmallButtonAddImages,
                      child: InkWell(
                        splashColor:
                            AppColors.insertAdSmallButtonAddImagesSplash,
                        child: SizedBox(
                            width: AppSizes.size60,
                            height: AppSizes.size60,
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: AppSizes.size40,
                            )),
                        onTap: () => onRemoveImageDatabase(images[index]),
                      ),
                    ),
                  ),
                ],
              );
            } else if (images != null) {
              if (images[index].isImageBig == false) {
                return Image.file(
                  images[index].image,
                  height:
                      imagesHeight == null ? screenHeight * 0.40 : imagesHeight,
                  width: screenWidth,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                );
              } else {
                return Stack(
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
                        AppTexts().warningBigImageAd,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }
            } else {
              return Container(
                height:
                    imagesHeight == null ? screenHeight * 0.40 : imagesHeight,
                width: screenWidth,
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          itemCount: images != null ? images.length : 0,
          viewportFraction: 0.9,
          scale: 0.95,
          pagination: new SwiperPagination(),
          index: 0,
          //loop: false,
          onTap: (index) async {
            images[index].runtimeType != ImageFile
                ? AppRoutes.push(
                    context,
                    ShowImagesEditAd(
                      imageUrl: images[index]['url'],
                    ),
                  )
                : AppRoutes.push(
                    context,
                    ShowImagesEditAd(
                      imageUrl: images[index].image,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
