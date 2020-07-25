import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:varied_rent/utils/utils.dart';

//TODO: nivel 4 - definir cores,texts,sizes..
class ImagesAd extends StatelessWidget {
  final Color backgroundOpacityImages;
  final double imagesHeight;
  final List images;
  final double elevation;

  ImagesAd({
    Key key,
    this.backgroundOpacityImages = AppColors.tertiaryColor,
    this.imagesHeight,
    this.images,
    this.elevation = 20,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundOpacityImages.withOpacity(0.1),
      elevation: elevation,
      child: Container(
        height: imagesHeight == null ? screenHeight * 0.40 : imagesHeight,
        width: screenWidth,
        color: Colors.transparent,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              images[index],
              fit: BoxFit.cover,
            );
          },
          itemCount: images.length,
          viewportFraction: 0.9,
          scale: 0.95,
          pagination: new SwiperPagination(),
        ),
      ),
    );
  }
}
