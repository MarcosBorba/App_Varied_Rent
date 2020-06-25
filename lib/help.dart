/* 
CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: AppSizes.size50,
        items: <Widget>[
          Icon(
            Icons.menu,
            size: AppSizes.size30,
            color: AppColors().iconsColorDefault,
          ),
          Container(
            height: AppSizes.size20,
            child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.tertiaryColor, width: AppSizes.size4
                )
              ),
              fillColor: AppColors.tertiaryColor 
            ),
          ),
          ),
          Icon(
            Icons.chat,
            size: AppSizes.size30,
            color: AppColors().iconsColorDefault,
          ),
        ],
        color: AppColors().appBarColorDefault,
        buttonBackgroundColor: AppColors().appBarColorDefault,
        backgroundColor: AppColors().transparentBackground,
        animationCurve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 2),
        onTap: (index) {
          page = index;
          index == 0
              ? showModalBottomSheet<Null>(
                  context: context,
                  builder: (BuildContext context) => openBottomDrawer(),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    top: const Radius.circular(25.0),
                  )))
              : false;
        },
      )
 */
/* 
Container(
                      width: 250,
                      child: HomePageTextsFields(
                        contentPadding: EdgeInsets.zero,
                        hintText: "Search Products",
                        prefixIcon: Icons.search,
                        fillColor: Colors.white,
                        filled: true,
                        defaultFormColorBorder: AppColors.tertiaryColor,
                      ),
                    ), */

/* 
ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: BottomAppBar(
              color: AppColors.secondaryColor,
              child: SizedBox(
                height: AppSizes.size50,
                width: screenWidth,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: AppSizes.size40,
                        color: AppColors().iconsColorDefault,
                      ),
                      onPressed: () {
                        showModalBottomSheet<Null>(
                            context: context,
                            builder: (BuildContext context) =>
                                openBottomDrawer(),
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                              top: const Radius.circular(25.0),
                            )));
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        size: AppSizes.size40,
                        color: AppColors().iconsColorDefault,
                      ),
                      onPressed: () {
                        setState(() {
                          textFieldAparece = !textFieldAparece;
                        });
                      },
                    ),
                    Icon(
                      Icons.chat,
                      size: AppSizes.size40,
                      color: AppColors().iconsColorDefault,
                    ),
                  ],
                ),
              )),
        )
 */
/* 
RaisedButton(
                color: AppColors().buttonColorDefault,
                child: Text(
                  'logout',
                  style: TextStyle(color: AppColors().textsColorDefault),
                ),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                  final UserRepository userRepository = UserRepository(
                    userApiClient: UserApiClient(),
                  );
                  AppRoutes.push(
                      context,
                      LoginPage(
                        userRepository: userRepository,
                      ));
                },
              )
 */

/* 
HomePageBottomNavyBar(
          selectedIndex: navigationBarBottomIndex,
          onItemSelected: (index) => setState(() {
            navigationBarBottomIndex = index;
            index == 0
                ? showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                        openBottomDrawer(stateAuthentication))
                : index == 1
                    ? setState(() {
                        selectedSearchButton = !selectedSearchButton;
                      })
                    : index == 2 ? true : false;
          }),
          bottomNavyBarItems: listBottomNavyBarItems(),
        )
 */
//Aqui mudou
