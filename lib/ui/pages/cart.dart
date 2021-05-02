part of 'pages.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  StreamController<int> scgrandtotal = new StreamController<int>.broadcast();
  int total;
  Future<void> gettotal() async {
    total = await CartServices.calculateTotal();
    scgrandtotal.add(total);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        scgrandtotal.close();
        context.read<ProductCubit>().returnProduct();
        context.read<CartCubit>().returnCart();
        context.read<ProductCubit>().getProduct();
        context.read<PageBloc>().add(GoToHomePage());

        return;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Center(
              child: Text(
                "Shopping Cart",
                style: whiteTextFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          body: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartInitial)
                return Container(
                  child: Center(
                      child: SpinKitThreeBounce(size: 25, color: mainColor)),
                );
              else {
                CartLoaded loaded = state as CartLoaded;
                gettotal();
                if (loaded.cart.length == 0) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Empty Cart", style: blackTextFont),
                          RaisedButton(
                            color: Colors.orange,
                            onPressed: () {
                              context.read<CartCubit>().returnCart();
                              context.read<PageBloc>().add(GoToHomePage());
                            },
                            child: Text("Back", style: whiteTextFont),
                          )
                        ],
                      ));
                } else {
                  return Stack(
                    children: [
                      Container(
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                Container(
                                  color: Color(0xffF8F8F8),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: defaultMargin),
                                  margin: EdgeInsets.only(top: 8),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: loaded.cart.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CartCard(loaded.cart[index],
                                          scgrandtotal, total);
                                    },
                                  ),
                                ),
                                SizedBox(height: 80),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: defaultMargin),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: accentColor3.withOpacity(0.3),
                                blurRadius: 3,
                                offset: Offset(0, -3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Container(
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total Harga",
                                            style: blackTextFont.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Spacer(),
                                          StreamBuilder(
                                            stream: scgrandtotal.stream,
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  NumberFormat.currency(
                                                    locale: 'id_ID',
                                                    symbol: 'Rp',
                                                    decimalDigits: 0,
                                                  ).format(snapshot.data),
                                                  style: whiteTextFont.copyWith(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: mainColor,
                                                  ),
                                                );
                                              } else {
                                                return Text(
                                                  NumberFormat.currency(
                                                    locale: 'id_ID',
                                                    symbol: 'Rp',
                                                    decimalDigits: 0,
                                                  ).format(0),
                                                  style: whiteTextFont.copyWith(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: mainColor,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () async {},
                                      child: Container(
                                        height: double.infinity,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        decoration: BoxDecoration(
                                          color: mainColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Center(
                                            child: Text(
                                          // "Beli (${keranjangProduk.length.toString()})",
                                          "Order",
                                          style: whiteTextFont.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            },
          )),
    );
  }
}
