import 'dart:convert';
import 'dart:io' as Io;
import 'dart:typed_data';

import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/ad_api_client.dart';
import 'package:varied_rent/repositories/ad_repository.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';

class MyAdsPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAdsPagesState();
}

class MyAdsPagesState extends State<MyAdsPages> {
  PickedFile _newImage;
  String base64os;
  List<Ad> adss = [];
  Uint8List testImage;
  double heightBodyScaffold = screenHeight - AppSizes.size60 - statusBarHeight;
  int navigationBarBottomIndex = 0;

  Future getImage() async {
    var image = await new ImagePicker().getImage(source: ImageSource.gallery);
    final bytes = await Io.File(image.path).readAsBytes();
    String img64 = base64Encode(bytes);
    print("imageimga : " + img64.substring(0, 100));
    setState(() {
      _newImage = image;
      base64os = img64;
      /* File imageFile = new File(_newImage.path);
      List<int> imageBytes = imageFile.readAsBytesSync();
      String base64Image = base64.encode(imageBytes);
      dois = base64Image; */
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MyAdProductBloc>(
        create: (_) {
          AdRepository adRepository = AdRepository(adApiClient: AdApiCLient());
          return MyAdProductBloc(adRepository: adRepository)
            ..add(MyAdProducPageStarted());
        },
        child: BlocListener<MyAdProductBloc, MyAdProductState>(
          listener: (context, state) {
            if (state is ShowMyAdProduct) {
              print("passou show");
              setState(() {
                print(state.ads);
                adss = state.ads;
                //final decodedBytes = base64Decode(adss[3].images[0]['data']);
              });
            }
          },
          child: BlocBuilder<MyAdProductBloc, MyAdProductState>(
            builder: (context, state) {
              return Scaffold(
                body: Container(
                  height: screenHeight,
                  width: screenWidth,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: adss.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: heightBodyScaffold * 0.30,
                        width: screenWidth,
                        margin: EdgeInsets.only(
                          top: AppSizes.size10,
                        ),
                        child: MaterialButton(
                          color: Colors.white,
                          elevation: AppSizes.size10,
                          onPressed: () => {},
                          padding: EdgeInsets.all(
                            AppSizes.size12,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: heightBodyScaffold * 0.30,
                                width: screenWidth * 0.40,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.size18),
                                  child: Image.network(
                                    adss[index].images[0],
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    adss[index].title,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                  halfFilledIconData:
                                                      Icons.star_half,
                                                  defaultIconData:
                                                      Icons.star_border,
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
                                                    adss[index].value + '/hr',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () => {},
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete_forever,
                                                color: Colors.red,
                                              ),
                                              onPressed: () => {},
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
                        ),
                      );
                    },
                  ),
                ),
                bottomNavigationBar: MyAccountPageFFNavigationBar(
                  selectedIndex: navigationBarBottomIndex,
                  onSelectTab: (index) {
                    setState(
                      () {
                        navigationBarBottomIndex = index;
                        index == 0 ? print("") : index == 1 ? print("") : false;
                      },
                    );
                  },
                  bottomNavyBarItems: listBottomFFNavigationBarItems(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<FFNavigationBarItem> listBottomFFNavigationBarItems() {
    var fFNavigationBarItem = [
      FFNavigationBarItem(
        iconData: FontAwesome.search,
        label: "Search",
      ),
      FFNavigationBarItem(
        iconData: Icons.add_circle,
        label: "Inserir Ads",
      ),
    ];
    return fFNavigationBarItem;
  }
}
