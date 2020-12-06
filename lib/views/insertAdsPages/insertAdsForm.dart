import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/components/componentsInsertAdsForm/getTitle.dart';
import 'package:varied_rent/models/models.dart';
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
  UniqueKey keyImages = UniqueKey();
  GlobalKey<FormState> _keyFormInsertNewAd = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _valueController = TextEditingController();
  String selectedItemOfCategoryType;
  bool haveBigImage = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<InsertAdsBloc, InsertAdsState>(
      listener: (context, state) async {
        if (state is InsertAdsFailurePage) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
            ),
          );
        } else if (state is SuccessOnSubmit) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(AppTexts().createNewAdSuccessInsertAd),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 7),
            ),
          );
          await Future.delayed(Duration(seconds: 3));
          AppRoutes.pop(context);
        }
      },
      child: BlocBuilder<InsertAdsBloc, InsertAdsState>(
        builder: (context, state) {
          return CacheProviderInsertAd(
            imagesSelected,
            imagesFile,
            keyImages,
            Form(
              key: _keyFormInsertNewAd,
              autovalidate: true,
              child: Container(
                height: screenHeight,
                width: screenWidth,
                color: AppColors.insertAdBackground,
                child: SafeArea(
                  child: ListView(
                    children: <Widget>[
                      returnHeader(),
                      SizedBox(height: screenHeight * 0.02),
                      imagesFile != null && imagesFile.length > 0
                          ? returnImagesAd()
                          : Container(
                              height: screenHeight * 0.40,
                              width: screenWidth,
                              child: RaisedButton(
                                elevation: 10,
                                color: AppColors.insertAdBigButtonAddImages,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.camera_enhance,
                                      size: AppSizes.size100,
                                    ),
                                    Text(AppTexts().clickAddImagesAd),
                                  ],
                                ),
                                onPressed: openGaleryImages,
                              ),
                            ),
                      SizedBox(height: AppSizes.size20),
                      returnTitleTextField(),
                      SizedBox(height: AppSizes.size20),
                      returnDescriptionField(),
                      SizedBox(height: AppSizes.size20),
                      returnCategoryField(),
                      SizedBox(height: AppSizes.size20),
                      returnRowValueFieldAndButtonSubmit(state),
                      SizedBox(height: AppSizes.size20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> openGaleryImages() async {
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
            actionBarTitle: AppTexts().getImagesAd,
            allViewTitle: AppTexts().titleGaleryImagesAd,
            selectCircleStrokeColor: "#000000",
            selectionLimitReachedText: AppTexts().messageAlertImagesAd),
      );
    } on PlatformException catch (e) {} on NoImagesSelectedException catch (e) {} on Exception catch (e) {}

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
            color: AppColors.insertAdSmallButtonAddImages,
            child: InkWell(
              splashColor: AppColors.insertAdSmallButtonAddImagesSplash,
              child: SizedBox(
                  width: AppSizes.size60,
                  height: AppSizes.size60,
                  child: Icon(
                    Icons.add_a_photo,
                    color: AppColors.insertAdIconSmallButtonAddImages,
                    size: AppSizes.size40,
                  )),
              onTap: () => openGaleryImages(),
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
        labelText: AppTexts().labelTextFieldTitleAd,
        hintText: AppTexts().hintTextFieldTitleAd,
        helperText: AppTexts().helperTextFieldTitleAd,
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
        labelText: AppTexts().labelTextFieldDescriptionAd,
        hintText: AppTexts().hintTextFieldDescriptionAd,
        helperText: AppTexts().helperTextFieldDescriptionAd,
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
        hint: AppTexts().hintTextFieldCategoryAd,
        helperText: AppTexts().helperTextFieldCategoryAd,
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

  Widget returnRowValueFieldAndButtonSubmit(InsertAdsState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      verticalDirection: VerticalDirection.up,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextFieldDefaultAplication(
              labelText: AppTexts().labelTextFieldValueAd,
              hintText: AppTexts().hintTextFieldValueAd,
              helperText: AppTexts().helperTextFieldValueAd,
              prefixIcon: Icons.monetization_on,
              inputController: _valueController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              validator: FieldValidators().valueFormNewAdFieldValidator,
            ),
          ),
        ),
        state is InsertAdsLoadingPage
            ? Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                        height: AppSizes.size60,
                        child: Center(child: returnsLinearProgressLoading))),
              )
            : Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: ButtonFormDefault(
                    heightButton: AppSizes.size60,
                    textButton: AppTexts().saveSubmitAd,
                    color: AppColors.insertAdSubmitButton,
                    onPressed: () {
                      onSubmitNewInsertValidateFields(state);
                    },
                  ),
                ),
              ),
      ],
    );
  }

  Widget get returnsLinearProgressLoading {
    return CircularProgressIndicator(
      backgroundColor: AppColors.insertAdSubmitButtonLoadingPrimary,
      valueColor: AlwaysStoppedAnimation<Color>(
          AppColors.insertAdSubmitButtonLoadingSecondary),
    );
  }

  onSubmitNewInsertValidateFields(InsertAdsState state) {
    state is! InsertAdsLoadingPage
        ? _keyFormInsertNewAd.currentState.validate()
            ? imagesFile == null || imagesFile.length < 1
                ? functionShowSnackBarErrors(AppTexts().errorAddOneImageAd, 5)
                : haveBigImage
                    ? functionShowSnackBarErrors(AppTexts().errorBigImageAd, 10)
                    : insertNewAd()
            : functionShowSnackBarErrors(AppTexts().errorFieldMandatoryAd, 5)
        : false;
  }

  insertNewAd() {
    Ad newAd = new Ad();
    newAd.title = _titleController.text;
    newAd.description = _descriptionController.text;
    newAd.category = selectedItemOfCategoryType.toString();
    newAd.value = _valueController.text;
    newAd.images = imagesFile;

    BlocProvider.of<InsertAdsBloc>(context).add(SubmitNewAds(newAd));
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
