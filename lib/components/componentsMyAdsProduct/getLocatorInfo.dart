import 'package:flutter/material.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';

//TODO: nivel 4 - definir texts, colors, routes....
class LocatorInfo extends StatelessWidget {
  SharedPref sharedPrefUser = SharedPref();
  List valuesSharedPrefUser = [];
  final double heightContainer;
  final double sizeNameText;
  final double sizeLandlordTypeText;
  final double sizeTitleTelephonesText;
  final double sizeTelephonesText;
  final String textTitleTelephone;

  LocatorInfo({
    Key key,
    this.heightContainer,
    this.sizeNameText,
    this.sizeLandlordTypeText,
    this.sizeTitleTelephonesText,
    this.sizeTelephonesText,
    this.textTitleTelephone = "Telephones:",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //TODO: nivel 1 - buscar forma de colocar imagem do usuario aqui
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(AppSizes.size12),
            child: ImageLogoApp(),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height:
                heightContainer == null ? screenHeight * 0.25 : heightContainer,
            width: screenWidth,
            margin: EdgeInsets.all(AppSizes.size12),
            child: FutureBuilder<List>(
                future: getFutureDados(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          snapshot.data[0].toString(),
                          style: TextStyle(
                            fontSize: sizeNameText == null
                                ? AppFontSize.s18
                                : sizeNameText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.00500,
                            bottom: screenHeight * 0.00500,
                          ),
                          child: Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          snapshot.data[1].toString(),
                          style: TextStyle(
                            fontSize: sizeLandlordTypeText == null
                                ? AppFontSize.s16
                                : sizeLandlordTypeText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.00500,
                            bottom: screenHeight * 0.00500,
                          ),
                          child: Divider(
                            indent: 30,
                            endIndent: 30,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          textTitleTelephone,
                          style: TextStyle(
                            fontSize: sizeTitleTelephonesText == null
                                ? AppFontSize.s15
                                : sizeTitleTelephonesText,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Text(
                          snapshot.data[2]['telephone1'].toString() +
                              "         " +
                              snapshot.data[2]['telephone2'].toString(),
                          style: TextStyle(
                            fontSize: sizeTelephonesText == null
                                ? AppFontSize.s13
                                : sizeTelephonesText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        LinearProgressIndicator(
                          backgroundColor: AppColors.tertiaryColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.secondaryColor,
                          ),
                        ),
                        Text(AppTexts
                            .myAccountTextToWaitForFutureBuilderDataToGetTheName)
                      ],
                    );
                  }
                }),
          ),
        ),
      ],
    );
  }

  Future<List> getFutureDados() async {
    await sharedPrefUser.read('name').then((value) {
      valuesSharedPrefUser.add(value);
    });
    await sharedPrefUser.read('landlordType').then((value) {
      valuesSharedPrefUser.add(value);
    });
    await sharedPrefUser.read('phones').then((value) {
      valuesSharedPrefUser.add(value);
    });
    return valuesSharedPrefUser;
  }
}
