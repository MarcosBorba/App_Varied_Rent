import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/components/componentsInsertAdsForm/getTitle.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/insertAdsPages/imageFile.dart';
import 'package:varied_rent/views/insertAdsPages/insertAdsProductInheritedClass.dart';

class InsertAdsForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InsertAdsFormState();
}

class InsertAdsFormState extends State<InsertAdsForm> {
  List<Asset> imagesSelected = List<Asset>();
  List<ImageFile> imagesFile = List<ImageFile>();
  SwiperController swiperController = new SwiperController();
  UniqueKey keyImages = new UniqueKey();
  GlobalKey<FormState> _keyFormInsertNewAd = new GlobalKey();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _valueController = new TextEditingController();
  String selectedItemOfCategoryType;
  bool haveBigImage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight,
      width: screenWidth,
      color: Colors.white,
      child: SafeArea(
        child: CacheProviderInsertAd(
          imagesSelected,
          imagesFile,
          swiperController,
          keyImages,
          Form(
            key: _keyFormInsertNewAd,
            autovalidate: true,
            child: ListView(
              children: <Widget>[
                returnHeader(),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                imagesFile != null && imagesFile.length > 0
                    ? returnImagesAd()
                    : Container(
                        height: screenHeight * 0.40,
                        width: screenWidth,
                        child: RaisedButton(
                          elevation: 10,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.camera_enhance,
                                size: AppSizes.size100,
                              ),
                              Text("Clique para Adicionar Imagens"),
                            ],
                          ),
                          onPressed: loadAssets2,
                        ),
                      ),
                SizedBox(height: AppSizes.size20),
                returnTitleTextField(),
                SizedBox(height: AppSizes.size20),
                returnDescriptionField(),
                SizedBox(height: AppSizes.size20),
                returnCategoryField(),
                SizedBox(height: AppSizes.size20),
                returnRowValueFieldAndButtonSubmit(),
                SizedBox(height: AppSizes.size20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loadAssets2() async {
    List<Asset> imagesNew;
    haveBigImage = false;
    try {
      imagesNew = await MultiImagePicker.pickImages(
        maxImages: 5,
        selectedAssets: imagesSelected,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
            actionBarColor: "#059dc0",
            statusBarColor: "#059dc0",
            actionBarTitle: "Get Images",
            allViewTitle: "All Photos",
            selectCircleStrokeColor: "#000000",
            selectionLimitReachedText: "You can select up to 5 images"),
      );
    } on PlatformException catch (e) {
      print("###################### 1");
    } on NoImagesSelectedException catch (e) {
      print("###################### 2");
      print(imagesNew);
      print(imagesSelected);
      print(imagesFile);
    } on Exception catch (e) {
      print("###################### 3");
    }

    if (imagesNew == null) {
      await returnListFiles(imagesSelected);
    } else {
      imagesSelected = imagesNew;
      await returnListFiles(imagesSelected);
    }
    setState(() {
      keyImages = new UniqueKey();
      print(imagesNew);
      print(imagesSelected);
      print(imagesFile);
    });
  }

  Future returnListFiles(List<Asset> resultListAssets) async {
    imagesFile.clear();
    await Future.forEach(
      resultListAssets,
      (Asset newAsset) async {
        String pathFile = await returnFilePath(newAsset);
        imagesFile.add(ImageFile(File(pathFile)));
      },
    );
    await verifyImageLength();
  }

  Future verifyImageLength() async {
    await Future.forEach(imagesFile, (ImageFile imagesFiles) async {
      imagesFiles.isImageBig = await imagesFiles.verifyImageLength;
      imagesFiles.isImageBig ? haveBigImage = true : false;
    });
  }

  Future<String> returnFilePath(Asset asset) async =>
      await FlutterAbsolutePath.getAbsolutePath(asset.identifier);

  Widget returnHeader() {
    return new TitleInsertAd();
  }

  Widget returnImagesAd() {
    return Stack(
      children: <Widget>[
        ImagesNewAd(),
        Positioned(
          top: AppSizes.size10,
          right: AppSizes.size50,
          child: Material(
            elevation: 15,
            shape: CircleBorder(),
            color: Colors.white,
            child: InkWell(
              splashColor: AppColors.secondaryColor,
              child: SizedBox(
                  width: AppSizes.size60,
                  height: AppSizes.size60,
                  child: Icon(
                    Icons.add_a_photo,
                    color: AppColors.tertiaryColor,
                    size: AppSizes.size40,
                  )),
              onTap: () => loadAssets2(),
            ),
          ),
        ),
      ],
    );
  }

  Widget returnTitleTextField() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFieldDefaultAplication(
        labelText: "Title",
        hintText: "Type your ad title",
        helperText: "Ex: Gol quadrado 1995",
        prefixIcon: Icons.title,
        inputController: _titleController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        validator: FieldValidators().titleFormNewAdFieldValidator,
      ),
    );
  }

  Widget returnDescriptionField() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFieldDefaultAplication(
        labelText: "Description",
        hintText: "Type your ad description",
        helperText: "Ex: Este veiculo é muito lindo e confortavel.",
        prefixIcon: Icons.description,
        inputController: _descriptionController,
        maxLines: null,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        validator: FieldValidators().descriptionFormNewAdFieldValidator,
      ),
    );
  }

  Widget returnCategoryField() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: DropDownButtonSelectorDefault(
        prefixIcon: Icons.category,
        suffixIcon: Icons.arrow_drop_down,
        hint: "Category",
        helperText: "Selecione ma categoria para o seu produto",
        items: AppTexts().categoryAdsTypesList,
        value: selectedItemOfCategoryType,
        onChanged: (String newItemSelected) {
          FocusScope.of(context).nextFocus();
          _dropDownItemCategorySelected(newItemSelected);
        },
        validator: FieldValidators().categoryTypeFormNewAdFieldValidator,
      ),
    );
  }

  void _dropDownItemCategorySelected(String newItem) {
    setState(() {
      this.selectedItemOfCategoryType = newItem;
    });
  }

  Widget returnRowValueFieldAndButtonSubmit() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      verticalDirection: VerticalDirection.up,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextFieldDefaultAplication(
              labelText: "Value",
              hintText: "0.00",
              helperText: "Value por hora",
              prefixIcon: Icons.monetization_on,
              inputController: _valueController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              validator: FieldValidators().valueFormNewAdFieldValidator,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ButtonFormDefault(
              heightButton: AppSizes.size60,
              textButton: "Save",
              color: AppColors.tertiaryColor,
              onPressed: onSubmitNewInsert,
            ),
          ),
        ),
      ],
    );
  }

  onSubmitNewInsert() {
    imagesFile == null || imagesFile.length == 0
        ? functionShowSnackBarErrors('Adicione pelomenos 1 imagem', 5)
        : haveBigImage
            ? functionShowSnackBarErrors(
                'OBSERVE AS IMAGENS: Tem uma Imagem muito grande, coloque imagens de até 10mb.',
                10)
            : false;
    print(
        "have big value  ###################################################################### " +
            haveBigImage.toString());
    print("submit new ad");
  }

  functionShowSnackBarErrors(String message, int duration) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: duration),
      ),
    );
  }
}
