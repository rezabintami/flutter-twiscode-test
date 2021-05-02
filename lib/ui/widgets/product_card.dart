part of 'widgets.dart';

class ProductCard extends StatelessWidget {
  final Product pr;
  final StreamController<int> sccount;

  ProductCard(this.pr, this.sccount);
  @override
  Widget build(BuildContext context) {
    // int price = int.parse(pr.price);
    int stock;
    double weight;
    (pr.weight == "") ? weight = 0 : weight = double.parse(pr.weight);
    (pr.stock == "") ? stock = 0 : stock = int.parse(pr.stock);

    return GestureDetector(
      onTap: () async {
        print(weight);
        // if (stock > 0) {
        int result = await CartServices.check(pr.id);
        // print(result);
        if (result == 0) {
          await CartServices.addCart(Cart(
              id: pr.id,
              ishalal: pr.ishalal,
              location: pr.location,
              merchant: pr.merchant,
              photo: pr.photo,
              price: pr.price,
              weight: weight,
              totalweight: weight,
              subtotal: pr.price,
              quantity: 1,
              stock: stock,
              title: pr.title));
          int total = await CartServices.calculateTotal();
          int count = await CartServices.countProduct();
          sccount.add(count);
          print(total);
          print(count);
        } else {
          List<Cart> getcart = await CartServices.getCartbyID(pr.id);
          await CartServices.updateCart(Cart(
              id: getcart[0].id,
              ishalal: getcart[0].ishalal,
              location: getcart[0].location,
              merchant: getcart[0].merchant,
              photo: getcart[0].photo,
              price: getcart[0].price,
              weight: getcart[0].weight,
              totalweight: getcart[0].totalweight + weight,
              quantity: getcart[0].quantity + 1,
              stock: getcart[0].stock,
              subtotal: getcart[0].subtotal + pr.price,
              title: getcart[0].title));
          int total = await CartServices.calculateTotal();
          int count = await CartServices.countProduct();
          print(total);
          print(count);
        }
        Fluttertoast.showToast(
            msg: "add ${pr.title}",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black);
        // } else {
        //   Fluttertoast.showToast(
        //       msg: "product stock is empty",
        //       toastLength: Toast.LENGTH_SHORT,
        //       backgroundColor: Colors.red);
        // }
      },
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    child: Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        child: (pr.photo == "")
                            ? Image.asset(
                                "assets/no-image.jpg",
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                "https://ranting.twisdev.com/uploads/${pr.photo}",
                                fit: BoxFit.cover,
                              )),
                  ),
                  SizedBox(height: 5),
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.04,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: AutoSizeText(
                      pr.title,
                      maxLines: 1,
                      presetFontSizes: [14, 13, 12],
                      style: blackTextFont.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w200),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                        "Rp " +
                            NumberFormat.currency(
                                    locale: 'id_ID',
                                    decimalDigits: 0,
                                    symbol: '')
                                .format(pr.price),
                        style: orangeTextFont.copyWith(fontSize: 14)),
                  ),
                  (pr.location == "")
                      ? Container()
                      : Container(
                          padding: EdgeInsets.only(left: 5, top: 2),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                size: 12,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Flexible(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Text(
                                    pr.location,
                                    style: greyTextFont.copyWith(
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          )),
                  Container(
                      padding: EdgeInsets.only(left: 5, top: 2),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 12,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                              child: Text(
                                pr.merchant,
                                style: greyTextFont.copyWith(
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 5),
                  (pr.stock == "0" || pr.stock == "")
                      ? Container()
                      : Container(
                          padding: EdgeInsets.all(6),
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text("READY STOCK",
                              style: whiteTextFont.copyWith(
                                  fontSize: 10, fontWeight: FontWeight.w400))),
                ],
              ),
            ),
          ),
          (pr.ishalal == "1")
              ? Positioned(
                  right: 15.0,
                  bottom: 30.0,
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Image.asset("assets/halal.png"),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
