/* 
@override
  Widget build(BuildContext context) {
    return BlocBuilder<EditEmailBloc, EditEmailState>(
      builder: (context, state) {
        return Container(
          height: screenHeight,
          width: screenWidth,
          color: AppColors.primaryColor,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              state is EditEmailSuccessfullyConcluded
                  ? tela2(context)
                  : tela1(context)
              /* SizedBox(
                    height: screenHeight * 0.15,
                    width: screenWidth,
                    child: returnsAAlignWithTittleSignup(),
                  ),
                  Container(
                    height: screenHeight * 0.80,
                    margin: EdgeInsets.only(
                        left: screenWidth * 0.03, right: screenWidth * 0.03),
                    child: EditEmailFormConfirmUser(),
                  ), */
            ],
          ),
        );
      },
    );
  }

  Widget returnsAAlignWithTittleSignup() {
    return Align(
      alignment: Alignment.center,
      child: returnsATittleTextSignup(),
    );
  }

  Widget returnsATittleTextSignup() {
    return Text(
      "Confirm your email and password to update your email",
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
      style: TextStyle(
        color: AppColors().defaultTitleColor,
        fontSize: AppFontSize.s20,
      ),
    );
  }

  Widget tela1(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 100,
        width: screenWidth,
        child: MaterialButton(
          child: Text("tela1 => tela2"),
          onPressed: () {
            BlocProvider.of<EditEmailBloc>(context)
                .add(EditEmailButtonConfirmUserPressed());
          },
        ),
      ),
    );
  }

  Widget tela2(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 100,
        width: screenWidth,
        child: MaterialButton(
          child: Text("tela2 => tela1"),
          onPressed: () {
            BlocProvider.of<EditEmailBloc>(context)
                .add(EditEmailButtonConfirmEditEmailPressed());
          },
        ),
      ),
    );
  } */
