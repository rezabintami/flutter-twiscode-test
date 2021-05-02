part of 'pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController<int> sccount = new StreamController<int>.broadcast();
  List<String> selectedCategory = List();
  List<String> selectedFilter = List();

  Future<void> getcount() async {
    int count = await CartServices.countProduct();
    sccount.add(count);
  }

  @override
  void initState() {
    super.initState();
    // getcount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Homepage',
              style: blackTextFont.copyWith(fontSize: 18),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: defaultMargin),
                child: Stack(
                  children: [
                    IconButton(
                      iconSize: 24,
                      onPressed: () async {
                        // context.read<ProductCubit>().returnProduct();
                        context.read<CartCubit>().getCart();
                        BlocProvider.of<PageBloc>(context).add(GoToCartPage());
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                        size: 24,
                      ),
                      color: Colors.black,
                    ),
                    StreamBuilder(
                      stream: sccount.stream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData && snapshot.data != 0) {
                          return Positioned(
                              top: 2,
                              right: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  snapshot.data.toString(),
                                  style: whiteTextFont.copyWith(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ));
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              )
            ]),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductInitial)
              return Container(
                child: Center(
                    child: SpinKitThreeBounce(size: 25, color: mainColor)),
              );
            else {
              ProductLoaded loaded = state as ProductLoaded;
              getcount();
              if (loaded.product == null) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No Internet Connection", style: blackTextFont),
                        RaisedButton(
                          color: Colors.orange,
                          onPressed: () {
                            context.read<ProductCubit>().returnProduct();
                            context.read<ProductCubit>().getProduct();
                          },
                          child: Text("Retry", style: whiteTextFont),
                        )
                      ],
                    ));
              } else {
                return Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: ListView(
                        children: [
                          SizedBox(height: 10),
                          GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: loaded.product.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.65,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 2,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) =>
                                  ProductCard(loaded.product[index], sccount))
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder) {
                                          return Container(
                                            height: 120,
                                            margin: EdgeInsets.only(top: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 3),
                                                  child: Text("Category",
                                                      style: blackTextFont
                                                          .copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                ),
                                                Container(
                                                  height: 45,
                                                  child: ListView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    padding: EdgeInsets.all(10),
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          print(
                                                              "Masakan Lokal");
                                                          context
                                                              .read<
                                                                  ProductCubit>()
                                                              .returnProduct();
                                                          if (selectedCategory
                                                              .any((element) =>
                                                                  element ==
                                                                  "Masakan Lokal")) {
                                                            selectedCategory.remove(
                                                                "Masakan Lokal");
                                                            if (selectedCategory
                                                                .isEmpty) {
                                                              if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Tertinggi")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Tertinggi");
                                                              } else if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Terendah")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Terendah");
                                                              } else {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "");
                                                              }
                                                            } else {
                                                              if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Tertinggi")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Tertinggi");
                                                              } else if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Terendah")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Terendah");
                                                              } else {
                                                                if (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Tertinggi")) {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "Tertinggi");
                                                                } else if (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Terendah")) {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "Terendah");
                                                                } else {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "");
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            selectedCategory.add(
                                                                "Masakan Lokal");
                                                            if (selectedFilter
                                                                .any((element) =>
                                                                    element ==
                                                                    "Tertinggi")) {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "Tertinggi");
                                                            } else if (selectedFilter
                                                                .any((element) =>
                                                                    element ==
                                                                    "Terendah")) {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "Terendah");
                                                            } else {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "");
                                                            }
                                                          }
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Text(
                                                            'Masakan Lokal',
                                                            style: (selectedCategory.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Masakan Lokal"))
                                                                ? whiteTextFont
                                                                : blackTextFont,
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                            color: (selectedCategory.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Masakan Lokal"))
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent,
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          print("Mancanegara");
                                                          context
                                                              .read<
                                                                  ProductCubit>()
                                                              .returnProduct();
                                                          if (selectedCategory
                                                              .any((element) =>
                                                                  element ==
                                                                  "Mancanegara")) {
                                                            selectedCategory
                                                                .remove(
                                                                    "Mancanegara");
                                                            if (selectedCategory
                                                                .isEmpty) {
                                                              if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Tertinggi")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Tertinggi");
                                                              } else if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Terendah")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Terendah");
                                                              } else {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "");
                                                              }
                                                            } else {
                                                              if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Tertinggi")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Tertinggi");
                                                              } else if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Terendah")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Terendah");
                                                              } else {
                                                                if (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Tertinggi")) {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "Tertinggi");
                                                                } else if (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Terendah")) {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "Terendah");
                                                                } else {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "");
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            selectedCategory.add(
                                                                "Mancanegara");
                                                            if (selectedFilter
                                                                .any((element) =>
                                                                    element ==
                                                                    "Tertinggi")) {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "Tertinggi");
                                                            } else if (selectedFilter
                                                                .any((element) =>
                                                                    element ==
                                                                    "Terendah")) {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "Terendah");
                                                            } else {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "");
                                                            }
                                                          }
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Text(
                                                            'Mancanegara',
                                                            style: (selectedCategory.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Mancanegara"))
                                                                ? whiteTextFont
                                                                : blackTextFont,
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                            color: (selectedCategory.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Mancanegara"))
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent,
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          print("Roti & Kue");
                                                          context
                                                              .read<
                                                                  ProductCubit>()
                                                              .returnProduct();
                                                          if (selectedCategory
                                                              .any((element) =>
                                                                  element ==
                                                                  "Roti & Kue")) {
                                                            selectedCategory
                                                                .remove(
                                                                    "Roti & Kue");
                                                            if (selectedCategory
                                                                .isEmpty) {
                                                              if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Tertinggi")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Tertinggi");
                                                              } else if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Terendah")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Terendah");
                                                              } else {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "");
                                                              }
                                                            } else {
                                                              if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Tertinggi")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Tertinggi");
                                                              } else if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Terendah")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Terendah");
                                                              } else {
                                                                if (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Tertinggi")) {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "Tertinggi");
                                                                } else if (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Terendah")) {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "Terendah");
                                                                } else {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "");
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            selectedCategory.add(
                                                                "Roti & Kue");
                                                            if (selectedFilter
                                                                .any((element) =>
                                                                    element ==
                                                                    "Tertinggi")) {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "Tertinggi");
                                                            } else if (selectedFilter
                                                                .any((element) =>
                                                                    element ==
                                                                    "Terendah")) {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "Terendah");
                                                            } else {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "");
                                                            }
                                                          }
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Text(
                                                            'Roti & Kue',
                                                            style: (selectedCategory.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Roti & Kue"))
                                                                ? whiteTextFont
                                                                : blackTextFont,
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                            color: (selectedCategory.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Roti & Kue"))
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent,
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          print("Frozen Food");
                                                          context
                                                              .read<
                                                                  ProductCubit>()
                                                              .returnProduct();
                                                          if (selectedCategory
                                                              .any((element) =>
                                                                  element ==
                                                                  "Frozen Food")) {
                                                            selectedCategory
                                                                .remove(
                                                                    "Frozen Food");
                                                            if (selectedCategory
                                                                .isEmpty) {
                                                              if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Tertinggi")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Tertinggi");
                                                              } else if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Terendah")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Terendah");
                                                              } else {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "");
                                                              }
                                                            } else {
                                                              if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Tertinggi")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Tertinggi");
                                                              } else if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Terendah")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Terendah");
                                                              } else {
                                                                if (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Tertinggi")) {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "Tertinggi");
                                                                } else if (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Terendah")) {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "Terendah");
                                                                } else {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "");
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            selectedCategory.add(
                                                                "Frozen Food");
                                                            if (selectedFilter
                                                                .any((element) =>
                                                                    element ==
                                                                    "Tertinggi")) {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "Tertinggi");
                                                            } else if (selectedFilter
                                                                .any((element) =>
                                                                    element ==
                                                                    "Terendah")) {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "Terendah");
                                                            } else {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "");
                                                            }
                                                          }
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Text(
                                                            'Frozen Food',
                                                            style: (selectedCategory.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Frozen Food"))
                                                                ? whiteTextFont
                                                                : blackTextFont,
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                            color: (selectedCategory.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Frozen Food"))
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent,
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          print("Lainnya");
                                                          context
                                                              .read<
                                                                  ProductCubit>()
                                                              .returnProduct();
                                                          if (selectedCategory
                                                              .any((element) =>
                                                                  element ==
                                                                  "Lainnya")) {
                                                            selectedCategory
                                                                .remove(
                                                                    "Lainnya");
                                                            if (selectedCategory
                                                                .isEmpty) {
                                                              if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Tertinggi")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Tertinggi");
                                                              } else if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Terendah")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Terendah");
                                                              } else {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "");
                                                              }
                                                            } else {
                                                              if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Tertinggi")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Tertinggi");
                                                              } else if (selectedFilter
                                                                  .any((element) =>
                                                                      element ==
                                                                      "Terendah")) {
                                                                context
                                                                    .read<
                                                                        ProductCubit>()
                                                                    .getProductbyCategory(
                                                                        selectedCategory,
                                                                        "Terendah");
                                                              } else {
                                                                if (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Tertinggi")) {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "Tertinggi");
                                                                } else if (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Terendah")) {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "Terendah");
                                                                } else {
                                                                  context
                                                                      .read<
                                                                          ProductCubit>()
                                                                      .getProductbyCategory(
                                                                          selectedCategory,
                                                                          "");
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            selectedCategory
                                                                .add("Lainnya");
                                                            if (selectedFilter
                                                                .any((element) =>
                                                                    element ==
                                                                    "Tertinggi")) {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "Tertinggi");
                                                            } else if (selectedFilter
                                                                .any((element) =>
                                                                    element ==
                                                                    "Terendah")) {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "Terendah");
                                                            } else {
                                                              context
                                                                  .read<
                                                                      ProductCubit>()
                                                                  .getProductbyCategory(
                                                                      selectedCategory,
                                                                      "");
                                                            }
                                                          }
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Text(
                                                            'Lainnya',
                                                            style: (selectedCategory.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Lainnya"))
                                                                ? whiteTextFont
                                                                : blackTextFont,
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                            color: (selectedCategory.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Lainnya"))
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Icon(Icons.list),
                                        SizedBox(width: 5),
                                        Text("Category", style: blueTextFont)
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder) {
                                          return Container(
                                            height: 120,
                                            margin: EdgeInsets.only(top: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 3),
                                                  child: Text("Filter",
                                                      style: blackTextFont
                                                          .copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                ),
                                                Container(
                                                  height: 45,
                                                  child: ListView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    padding: EdgeInsets.all(10),
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          print("Tertinggi");
                                                          context
                                                              .read<
                                                                  ProductCubit>()
                                                              .returnProduct();
                                                          if (selectedFilter
                                                                  .isEmpty ||
                                                              selectedFilter.any(
                                                                  (element) =>
                                                                      element ==
                                                                      "Terendah")) {
                                                            selectedFilter
                                                                .clear();
                                                            selectedFilter.add(
                                                                "Tertinggi");
                                                            context
                                                                .read<
                                                                    ProductCubit>()
                                                                .getProductbyCategory(
                                                                    selectedCategory,
                                                                    "Tertinggi");
                                                          } else {
                                                            selectedFilter
                                                                .clear();
                                                            context
                                                                .read<
                                                                    ProductCubit>()
                                                                .getProductbyCategory(
                                                                    selectedCategory,
                                                                    "");
                                                          }
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Text(
                                                            'Tertinggi',
                                                            style: (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Tertinggi"))
                                                                ? whiteTextFont
                                                                : blackTextFont,
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                            color: (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Tertinggi"))
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent,
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          print("Terendah");
                                                          context
                                                              .read<
                                                                  ProductCubit>()
                                                              .returnProduct();
                                                          if (selectedFilter
                                                                  .isEmpty ||
                                                              selectedFilter.any(
                                                                  (element) =>
                                                                      element ==
                                                                      "Tertinggi")) {
                                                            selectedFilter
                                                                .clear();
                                                            selectedFilter.add(
                                                                "Terendah");
                                                            context
                                                                .read<
                                                                    ProductCubit>()
                                                                .getProductbyCategory(
                                                                    selectedCategory,
                                                                    "Terendah");
                                                          } else {
                                                            selectedFilter
                                                                .clear();
                                                            context
                                                                .read<
                                                                    ProductCubit>()
                                                                .getProductbyCategory(
                                                                    selectedCategory,
                                                                    "");
                                                          }
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Text(
                                                            'Terendah',
                                                            style: (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Terendah"))
                                                                ? whiteTextFont
                                                                : blackTextFont,
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                            color: (selectedFilter.any(
                                                                    (element) =>
                                                                        element ==
                                                                        "Terendah"))
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Icon(Icons.filter_list),
                                        SizedBox(width: 5),
                                        Text("Filter", style: blueTextFont)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
                );
              }
            }
          },
        ));
  }
}
