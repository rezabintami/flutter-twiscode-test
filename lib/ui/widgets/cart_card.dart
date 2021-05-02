part of 'widgets.dart';

class CartCard extends StatefulWidget {
  final Cart cart;
  final int total;
  final StreamController<int> scgrandtotal;

  CartCard(this.cart, this.scgrandtotal, this.total);
  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  StreamController<int> scqty = new StreamController<int>();
  StreamController<double> scweight = new StreamController<double>();

  @override
  Widget build(BuildContext context) {
    scqty.add(widget.cart.quantity);
    scweight.add(widget.cart.totalweight);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    height: 60,
                    width: 60,
                    child: (widget.cart.photo == "")
                        ? Image.asset(
                            "assets/no-image.jpg",
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            "https://ranting.twisdev.com/uploads/${widget.cart.photo}",
                            fit: BoxFit.cover,
                          )),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    widget.cart.title,
                    style: blackTextFont,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              "Rp " +
                                  NumberFormat.currency(
                                          locale: 'id_ID',
                                          decimalDigits: 0,
                                          symbol: '')
                                      .format(widget.cart.price),
                              style: orangeTextFont.copyWith(fontSize: 14)),
                          SizedBox(height: 5),
                          Text(
                            "(Baru)",
                            style: greyTextFont,
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              if (widget.cart.quantity > 1) {
                                // print("quantity 1 : ${widget.cart.quantity}");

                                int result = await CartServices.updateCart(Cart(
                                    id: widget.cart.id,
                                    ishalal: widget.cart.ishalal,
                                    location: widget.cart.location,
                                    merchant: widget.cart.merchant,
                                    photo: widget.cart.photo,
                                    price: widget.cart.price,
                                    weight: widget.cart.weight,
                                    totalweight: widget.cart.totalweight -
                                        widget.cart.weight,
                                    quantity: widget.cart.quantity - 1,
                                    stock: widget.cart.stock,
                                    subtotal: widget.cart.subtotal -
                                        widget.cart.price,
                                    title: widget.cart.title));
                                if (result == 1) {
                                  // print("quantity 1 : ${widget.cart.quantity}");

                                  widget.cart.quantity -= 1;
                                  widget.cart.totalweight -= widget.cart.weight;
                                  widget.cart.subtotal -= widget.cart.price;

                                  int total =
                                      await CartServices.calculateTotal();
                                  widget.scgrandtotal.add(total);
                                  // widget.productqty = widget.cart.quantity - 1;
                                  scqty.add(widget.cart.quantity);
                                  scweight.add(widget.cart.totalweight);
                                  // print("quantity 2 : ${widget.cart.quantity}");
                                  // print("kurang");
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          contentPadding: EdgeInsets.all(0.0),
                                          title: Center(
                                            child: Text("Delete?",
                                                style: blackTextFont.copyWith(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          content: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.22,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10, right: 10),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 5),
                                                Text("Product will be removed?",
                                                    style: greyTextFont
                                                        .copyWith(fontSize: 14),
                                                    textAlign:
                                                        TextAlign.center),
                                                SizedBox(height: 25),
                                                GestureDetector(
                                                  onTap: () async {
                                                    int result =
                                                        await CartServices
                                                            .deleteCart(
                                                                widget.cart.id);
                                                    if (result == 1) {
                                                      print("delete");
                                                      context
                                                          .read<CartCubit>()
                                                          .returnCart();
                                                      context
                                                          .read<CartCubit>()
                                                          .getCart();
                                                      Navigator.of(context)
                                                          .pop();
                                                      // scweight.close();
                                                      // scqty.close();
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "delete ${widget.cart.title}",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          backgroundColor:
                                                              Colors.black);
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: mainColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Delete",
                                                        style: whiteTextFont
                                                            .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Cancel",
                                                        style: blackTextFont
                                                            .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                    });
                              }
                            },
                            child: Container(
                              width: 20.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(2.0)),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 15.0,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              StreamBuilder(
                                stream: scqty.stream,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          snapshot.data.toString(),
                                          style: blackTextFont.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ));
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              SizedBox(height: 5),
                              StreamBuilder(
                                stream: scweight.stream,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    double weight = (snapshot.data / 1000);
                                    return Text("$weight kg",
                                        style: blackTextFont.copyWith(
                                            fontWeight: FontWeight.w400));
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                          GestureDetector(
                              onTap: () async {
                                // print("quantity 1 : ${widget.cart.quantity}");

                                int result = await CartServices.updateCart(Cart(
                                    id: widget.cart.id,
                                    ishalal: widget.cart.ishalal,
                                    location: widget.cart.location,
                                    merchant: widget.cart.merchant,
                                    photo: widget.cart.photo,
                                    price: widget.cart.price,
                                    weight: widget.cart.weight,
                                    totalweight: widget.cart.totalweight +
                                        widget.cart.weight,
                                    quantity: widget.cart.quantity + 1,
                                    stock: widget.cart.stock,
                                    subtotal: widget.cart.subtotal +
                                        widget.cart.price,
                                    title: widget.cart.title));
                                if (result == 1) {
                                  // print("quantity 2 : ${widget.cart.quantity}");
                                  // var memos = await CartServices.getCartbyID(
                                  //     widget.cart.id);
                                  // print(memos[0].quantity);
                                  widget.cart.quantity += 1;
                                  widget.cart.totalweight += widget.cart.weight;
                                  // widget.productqty = widget.cart.quantity + 1;
                                  widget.cart.subtotal += widget.cart.price;

                                  int total =
                                      await CartServices.calculateTotal();
                                  print("tambah total : $total");
                                  widget.scgrandtotal.add(total);
                                  scqty.add(widget.cart.quantity);
                                  scweight.add(widget.cart.totalweight);
                                  // print("quantity 2 : ${widget.cart.quantity}");
                                  // print("tambah");
                                }
                              },
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius: BorderRadius.circular(2.0)),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
