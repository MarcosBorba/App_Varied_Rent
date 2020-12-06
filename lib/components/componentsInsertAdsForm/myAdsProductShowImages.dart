import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:varied_rent/utils/utils.dart';

class ShowImagesNewProduct extends StatefulWidget {
  final File imageUrl;

  const ShowImagesNewProduct({
    Key key,
    this.imageUrl,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() =>
      ShowImagesNewProductState(imageUrl: imageUrl);
}

class ShowImagesNewProductState extends State<ShowImagesNewProduct> {
  final File imageUrl;
  ShowImagesNewProductState({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PhotoView(
          imageProvider: FileImage(
            imageUrl,
          ),
          loadingBuilder: (context, event) {
            return Container(
              height: screenHeight,
              width: screenWidth,
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          loadFailedChild: Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                left: AppSizes.size12,
                right: AppSizes.size12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: AppColors.myAdsIconOnFailure,
                    size: AppSizes.size50,
                  ),
                  SizedBox(
                    height: AppSizes.size20,
                  ),
                  Text(
                    "Error on load Image",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: AppFontSize.s18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
