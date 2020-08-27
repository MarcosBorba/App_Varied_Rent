import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';

class AdsMaterialButton extends StatelessWidget {
  final double heightBodyScaffold =
      screenHeight - AppSizes.size60 - statusBarHeight;
  final List<Ad> listAds;
  final int indexListAds;
  final Color color;
  final double elevation;
  final Function onPressedAds;
  final Function onPressedEditAds;
  final Function onPressedDeleteAds;

  AdsMaterialButton({
    Key key,
    this.listAds,
    this.indexListAds,
    this.color = Colors.white,
    this.elevation,
    this.onPressedAds,
    this.onPressedEditAds,
    this.onPressedDeleteAds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: elevation == null ? AppSizes.size10 : elevation,
      onPressed: onPressedAds,
      padding: EdgeInsets.all(
        AppSizes.size12,
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: heightBodyScaffold * 0.30,
            width: screenWidth * 0.40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.size18),
              child: Image.network(
                listAds[indexListAds].images[0],
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
              ),
            ),
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
                            SmoothStarRating(
                              rating: 3.5,
                              isReadOnly: true,
                              size: AppSizes.size25,
                              filledIconData: Icons.star,
                              halfFilledIconData: Icons.star_half,
                              defaultIconData: Icons.star_border,
                              starCount: 5,
                              allowHalfRating: true,
                              color: Colors.yellow,
                              borderColor: Colors.yellow,
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
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: onPressedEditAds,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                          onPressed: onPressedDeleteAds,
                        ),
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
}
