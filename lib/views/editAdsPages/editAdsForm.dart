import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/views/insertAdsPages/imageFile.dart';
import 'package:varied_rent/views/editAdsPages/editAdsProductInheritedClass.dart';

class EditAdsForm extends StatefulWidget {
  final String idAd;
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;
  final String category;
  final UniqueKey keyImages;
  final String locator_fk;
  final List starsEvaluations;

  const EditAdsForm(
      {Key key,
      this.idAd,
      this.titleAd,
      this.descriptionAd,
      this.valueAd,
      this.imagesAd,
      this.category,
      this.keyImages,
      this.locator_fk,
      this.starsEvaluations})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => EditAdsFormState(
      idAd: idAd,
      titleAd: titleAd,
      descriptionAd: descriptionAd,
      valueAd: valueAd,
      imagesContinue: imagesAd,
      category: category,
      keyEditImages: keyImages,
      locator_fk: locator_fk,
      starsEvaluations: starsEvaluations);
}

class EditAdsFormState extends State<EditAdsForm> {
  GlobalKey<FormState> _keyFormEditAd = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _valueController = TextEditingController();
  String selectedItemOfCategoryType;
  UniqueKey keyEditImages;

  String idAd;
  String titleAd;
  String descriptionAd;
  String valueAd;
  String category;
  String locator_fk;
  List starsEvaluations;

  List<Asset> imagesSelected = List<Asset>();

  List allImages = List();
  List imagesAwsRemove = List();
  List<ImageFile> imagesAwsInsert = List<ImageFile>();
  List imagesContinue = List();
  bool haveBigImage;
  int acceptHowManyImages;

  EditAdsFormState({
    this.idAd,
    this.titleAd,
    this.descriptionAd,
    this.valueAd,
    this.imagesContinue,
    this.category,
    this.keyEditImages,
    this.locator_fk,
    this.starsEvaluations,
  });

  @override
  void initState() {
    super.initState();
    setFieldsData();
  }

  setFieldsData() {
    print("init State");
    _titleController.text = titleAd;
    _descriptionController.text = descriptionAd;
    selectedItemOfCategoryType = category;
    _valueController.text = valueAd;
    keyEditImages = keyEditImages;
    imagesContinue.forEach((element) {
      allImages.add(element);
    });
    acceptHowManyImages = imagesContinue.length;
    haveBigImage = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditAdsBloc, EditAdsState>(
      listener: (context, state) async {
        if (state is EditAdsFailurePage) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
            ),
          );
        } else if (state is SuccessOnEditSubmit) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(AppTexts().updateSuccessEditAd),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 5),
            ),
          );
          await Future.delayed(Duration(seconds: 2));
          Navigator.of(context).pop(MyAdsPageStarted());
        }
      },
      child: BlocBuilder<EditAdsBloc, EditAdsState>(
        builder: (context, state) {
          return CacheProviderEditAd(
            keyEditImages,
            allImages,
            Form(
              key: _keyFormEditAd,
              autovalidate: true,
              child: Container(
                height: screenHeight,
                width: screenWidth,
                color: AppColors.editAdBackground,
                child: SafeArea(
                  child: ListView(
                    children: <Widget>[
                      returnHeader(),
                      SizedBox(height: screenHeight * 0.02),
                      allImages != null && allImages.length > 0
                          ? returnImagesAd()
                          : Container(
                              height: screenHeight * 0.40,
                              width: screenWidth,
                              child: RaisedButton(
                                elevation: 10,
                                color: AppColors.editAdBigButtonAddImages,
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

  Widget returnHeader() {
    return new TitleEditAd();
  }

  Widget returnImagesAd() {
    return Stack(
      children: <Widget>[
        ImagesEditAd(
          onRemoveImageDatabase: (value) => removeImageAws(value),
        ),
        Positioned(
          top: AppSizes.size10,
          right: AppSizes.size50,
          child: Material(
            elevation: 15,
            shape: CircleBorder(),
            color: AppColors.editAdSmallButtonAddImages,
            child: InkWell(
              splashColor: AppColors.editAdSmallButtonAddImagesSplash,
              child: SizedBox(
                  width: AppSizes.size60,
                  height: AppSizes.size60,
                  child: Icon(
                    Icons.add_a_photo,
                    color: AppColors.editAdIconSmallButtonAddImages,
                    size: AppSizes.size40,
                  )),
              onTap: () => openGaleryImages(),
            ),
          ),
        ),
      ],
    );
  }

  Function removeImageAws(value) {
    acceptHowManyImages--;
    imagesAwsRemove.add(value);
    allImages.remove(value);
    imagesContinue.remove(value);

    setState(() {
      print("allImages: " + allImages.toString());
      print("imagesAwsInsert: " + imagesAwsInsert.toString());
      print("imagesAwsRemove: " + imagesAwsRemove.toString());
      print("imagesContinue: " + imagesContinue.toString());
    });
  }

  Future<void> openGaleryImages() async {
    List<Asset> imagesNew;
    haveBigImage = false;
    try {
      imagesNew = await MultiImagePicker.pickImages(
        maxImages: 5 - acceptHowManyImages,
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
      keyEditImages = new UniqueKey();
      print("newImages: " + imagesNew.toString());
      print("imagesSelected: " + imagesSelected.toString());
      print("allImages: " + allImages.toString());
      print("imagesAwsInsert: " + imagesAwsInsert.toString());
      print("imagesAwsRemove: " + imagesAwsRemove.toString());
      print("imagesContinue: " + imagesContinue.toString());
    });
  }

  Future returnListFiles(List<Asset> resultListAssets) async {
    imagesAwsInsert.clear();
    await getToClearImageFilesAllImages();
    await Future.forEach(
      resultListAssets,
      (Asset newAsset) async {
        String pathFile = await returnFilePath(newAsset);
        imagesAwsInsert.add(ImageFile(File(pathFile)));
      },
    );
    await verifyImageLength();
  }

  Future getToClearImageFilesAllImages() async {
    var toRemoveFiles = [];
    await Future.forEach(allImages, (element) {
      if (element.runtimeType == ImageFile) toRemoveFiles.add(element);
    });
    await clearImageFilesAllImages(toRemoveFiles);
  }

  Future clearImageFilesAllImages(toRemoveFiles) async {
    allImages.removeWhere((element) => toRemoveFiles.contains(element));
  }

  Future verifyImageLength() async {
    await Future.forEach(imagesAwsInsert, (ImageFile imagesFiles) async {
      imagesFiles.isImageBig = await imagesFiles.verifyImageLength;
      imagesFiles.isImageBig ? haveBigImage = true : false;
      allImages.add(imagesFiles);
    });
  }

  Future<String> returnFilePath(Asset asset) async =>
      await FlutterAbsolutePath.getAbsolutePath(asset.identifier);

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

  Widget returnRowValueFieldAndButtonSubmit(EditAdsState state) {
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
              maxLines: 1,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              validator: FieldValidators().valueFormNewAdFieldValidator,
            ),
          ),
        ),
        state is EditAdsLoadingPage
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
                    color: AppColors.editAdSubmitButton,
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
      backgroundColor: AppColors.editAdSubmitButtonLoadingPrimary,
      valueColor: AlwaysStoppedAnimation<Color>(
          AppColors.editAdSubmitButtonLoadingSecondary),
    );
  }

  onSubmitNewInsertValidateFields(EditAdsState state) {
    print(_keyFormEditAd.currentState.validate().toString());
    state is! InsertAdsLoadingPage
        ? _keyFormEditAd.currentState.validate()
            ? allImages == null || allImages.length < 2
                ? functionShowSnackBarErrors(AppTexts().errorAddOneImageAd, 5)
                : haveBigImage
                    ? functionShowSnackBarErrors(AppTexts().errorBigImageAd, 10)
                    : updateAd()
            : functionShowSnackBarErrors(AppTexts().errorFieldMandatoryAd, 5)
        : false;
  }

  updateAd() {
    Ad newAd = new Ad();
    newAd.id = idAd;
    newAd.locator_fk = locator_fk;
    newAd.starsEvaluations = starsEvaluations;
    newAd.title = _titleController.text;
    newAd.description = _descriptionController.text;
    newAd.category = selectedItemOfCategoryType.toString();
    newAd.value = _valueController.text;
    newAd.images = imagesAwsInsert;

    BlocProvider.of<EditAdsBloc>(context)
        .add(SubmitEditAds(newAd, imagesAwsRemove));
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
