import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myFavoritesAdsPages/myFavoritesAdsProductInheritedClass.dart';

class FavoriteAdMaterialButton extends StatelessWidget {
  final double heightBodyScaffold = screenHeight - statusBarHeight;
  final int indexListAds;
  final Color color;
  final double elevationButton;
  final double elevationImage;
  final Function onPressedFavoriteAd;
  final Function onPressedDeleteFavoriteAd;

  FavoriteAdMaterialButton({
    Key key,
    this.indexListAds,
    this.color = Colors.white,
    this.elevationButton,
    this.onPressedFavoriteAd,
    this.onPressedDeleteFavoriteAd,
    this.elevationImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Ad> listAds = CacheProviderFavoriteAds.of(context).ads;

    return MaterialButton(
      color: Colors.white,
      elevation: elevationButton == null ? AppSizes.size10 : elevationButton,
      onPressed: onPressedFavoriteAd,
      padding: EdgeInsets.all(
        AppSizes.size12,
      ),
      child: Row(
        children: <Widget>[
          Material(
            elevation: elevationImage == null ? AppSizes.size3 : elevationImage,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey[300]),
              borderRadius: BorderRadius.circular(18.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
                height: heightBodyScaffold * 0.30,
                width: screenWidth * 0.40,
                child: listAds[indexListAds].images.length > 0 &&
                        listAds[indexListAds].images != null
                    ? Image.network(
                        listAds[indexListAds].images[0]['url'],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.broken_image,
                                color: Colors.red,
                                size: AppSizes.size50,
                              ),
                              Text(
                                "Error loading image!",
                                textAlign: TextAlign.center,
                              )
                            ],
                          );
                        },
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Entypo.picture,
                            color: Colors.grey[300],
                            size: AppSizes.size50,
                          ),
                          SizedBox(
                            height: AppSizes.size10,
                          ),
                          Text(
                            "No Images",
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(
                left: AppSizes.size12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                listAds[indexListAds].title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: AppSizes.size18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            listAds[indexListAds].starsEvaluations.length <= 0
                                ? SizedBox(
                                    height: AppSizes.size10,
                                  )
                                : FutureBuilder(
                                    future: sumEvaluationsValues(
                                        listAds[indexListAds].starsEvaluations),
                                    builder: (context, snapshot) {
                                      return snapshot.hasError ||
                                              snapshot.data == null
                                          ? Text("")
                                          : SmoothStarRating(
                                              rating: snapshot.data,
                                              isReadOnly: true,
                                              size: AppSizes.size25,
                                              filledIconData: Icons.star,
                                              halfFilledIconData:
                                                  Icons.star_half,
                                              defaultIconData:
                                                  Icons.star_border,
                                              starCount: 5,
                                              allowHalfRating: true,
                                              color: Colors.yellow,
                                              borderColor: Colors.yellow,
                                            );
                                    },
                                  ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('\$ '),
                            Expanded(
                              child: Text(
                                listAds[indexListAds].value + '/hr',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.size14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        returnBottomButtons(
                            Icon(Icons.favorite, color: Colors.red),
                            onPressedDeleteFavoriteAd,
                            false),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<double> sumEvaluationsValues(List adsListEvaluations) async {
    num sumEvaluations = await adsListEvaluations.reduce(
      (value, element) => value is num ? value + element : false,
    );
    var medianEvaluations = sumEvaluations / adsListEvaluations.length;
    return medianEvaluations as double;
  }

  Widget returnBottomButtons(Icon icon, Function onPressed, bool rightMargin) {
    return Container(
      width: screenWidth * 0.15,
      margin: rightMargin ? EdgeInsets.only(right: 5) : null,
      child: RaisedButton(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: icon,
        onPressed: onPressed,
      ),
    );
  }
}
