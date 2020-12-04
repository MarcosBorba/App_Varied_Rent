import 'dart:io';

class ImageFile {
  File image;
  bool isImageBig;

  ImageFile(
    this.image, {
    this.isImageBig,
  });

  Future<bool> get verifyImageLength async {
    int imageLenght = await this.image.length().then((value) => value);
    if (imageLenght > 10000000) {
      isImageBig = true;
    } else {
      isImageBig = false;
    }
    return isImageBig;
  }
}
