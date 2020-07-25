import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';

//TODO: nivel 4 - colors,texts,sizes
class Description extends StatelessWidget {
  final int maxLines;
  final String textDescription;
  final Color textDescriptionColor;

  const Description({
    Key key,
    this.maxLines = 200,
    this.textDescription =
        "O Mestre na arte da vida faz pouca distinção entre o seu trabalho e o seu lazer, entre a sua mente e o seu corpo, entre a sua educação e a sua recreação, entre o seu amor e a sua religião. Ele dificilmente sabe distinguir um corpo do outro. Ele simplesmente persegue sua visão de excelência em tudo que faz, deixando para os outros a decisão de saber se está trabalhando ou se divertindo. Ele acha que está sempre fazendo as duas coisas simultaneamente.",
    this.textDescriptionColor = Colors.black87,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.only(
        left: screenWidth * 0.05,
        right: screenWidth * 0.05,
      ),
      child: TextField(
        enabled: false,
        readOnly: true,
        decoration: InputDecoration(
          hintMaxLines: maxLines,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.size12,
            ),
            borderSide: BorderSide(width: 2, color: Colors.grey[300]),
          ),
          hintText: textDescription,
          hintStyle: TextStyle(
            color: textDescriptionColor,
          ),
        ),
      ),
    );
  }
}
