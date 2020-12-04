/* return FutureBuilder<bool>(
              future: getLenghtImage(images[index]),
              builder: (context, snapshot) {
                if (snapshot.data != null && snapshot.data == true) {
                  return FutureBuilder<String>(
                    future: returnFilePath(images[index]),
                    builder: (context, snapshotFile) {
                      if (snapshotFile.data != null) {
                        return Image.file(
                          File(snapshotFile.data),
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                        );
                      }
                      return Container(
                        height: imagesHeight == null
                            ? screenHeight * 0.40
                            : imagesHeight,
                        width: screenWidth,
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  );
                } else if (snapshot.data != null && snapshot.data == false) {
                  return Stack(
                    children: <Widget>[
                      FutureBuilder<String>(
                        future: returnFilePath(images[index]),
                        builder: (context, snapshotFile) {
                          if (snapshotFile.data != null) {
                            return Image.file(
                              File(snapshotFile.data),
                              fit: BoxFit.cover,
                              gaplessPlayback: true,
                            );
                          }
                          return Container(
                            height: imagesHeight == null
                                ? screenHeight * 0.40
                                : imagesHeight,
                            width: screenWidth,
                            color: Colors.white,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.close,
                        size: AppSizes.size40,
                        color: Colors.red,
                      ),
                      Center(
                        child: Text(
                          "O tamanho da imagem deve ter no maximo 10 mb.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }
                return Container(
                  height:
                      imagesHeight == null ? screenHeight * 0.40 : imagesHeight,
                  width: screenWidth,
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );*/
/* 
Swiper(
          itemBuilder: (BuildContext context, int index) {
            return FutureBuilder<String>(
              future: returnFilePath(images[index]),
              builder: (_, snapshot) {
                return snapshot.hasData
                    ? Image.file(
                        File(snapshot.data),
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                      )
                    : Container(
                        height: imagesHeight == null
                            ? screenHeight * 0.40
                            : imagesHeight,
                        width: screenWidth,
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
              },
            );
          },
          itemCount: images != null ? images.length : 0,
          viewportFraction: 0.9,
          scale: 0.95,
          pagination: new SwiperPagination(),
          loop: false,
          onTap: (index) async {
            String imageFileUrl = await returnFilePath(images[index]);
            AppRoutes.push(
              context,
              ShowImagesNewProduct(
                imageUrl: imageFileUrl,
              ),
            );
          },
        ) */
