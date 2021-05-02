part of 'services.dart';

class CartServices {
  static Future<int> addCart(Cart cart) async {
    //returns number of items inserted as an integer
    final db = await init(); //open database
    return db.insert(
      "Carts", cart.toMap(), //toMap() function from MemoModel
      conflictAlgorithm:
          ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  static Future<int> deleteCart(String id) async {
    //returns number of items deleted
    final db = await init();

    int result = await db.delete("Carts", //table name
        where: "product_id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
        );
    print("delete : $result");
    return result;
  }

  static Future<int> check(String id) async {
    final db = await init();
    int result = Sqflite.firstIntValue(await db
        .rawQuery("SELECT COUNT(*) FROM Carts WHERE product_id=?", [id]));
    print("check : $result");
    return result;
  }

  static Future<List<Cart>> fetchCart() async {
    //returns the memos as a list (array)

    final db = await init();
    final maps = await db
        .query("Carts"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return Cart(
        id: maps[i]['product_id'],
        title: maps[i]['title'],
        location: maps[i]['location'],
        ishalal: maps[i]['ishalal'],
        merchant: maps[i]['merchant'],
        photo: maps[i]['photo'],
        price: maps[i]['price'],
        weight: maps[i]['weight'],
        totalweight: maps[i]['totalweight'],
        subtotal: maps[i]['subtotal'],
        quantity: maps[i]['quantity'],
        stock: maps[i]['stock'],
      );
    });
  }

  static Future<List<Cart>> getCart() async {
    final db = await init();
    final maps = await db.query("Carts");

    return List.generate(maps.length, (i) {
      return Cart(
        id: maps[i]['product_id'],
        title: maps[i]['title'],
        location: maps[i]['location'],
        ishalal: maps[i]['ishalal'],
        merchant: maps[i]['merchant'],
        photo: maps[i]['photo'],
        price: maps[i]['price'],
        weight: maps[i]['weight'],
        totalweight: maps[i]['totalweight'],
        subtotal: maps[i]['subtotal'],
        quantity: maps[i]['quantity'],
        stock: maps[i]['stock'],
      );
    });
  }

  static Future<List<Cart>> getCartbyID(String id) async {
    final db = await init();
    final maps =
        await db.query("Carts", where: "product_id = ?", whereArgs: [id]);

    return List.generate(maps.length, (i) {
      return Cart(
        id: maps[i]['product_id'],
        title: maps[i]['title'],
        location: maps[i]['location'],
        ishalal: maps[i]['ishalal'],
        merchant: maps[i]['merchant'],
        photo: maps[i]['photo'],
        price: maps[i]['price'],
        weight: maps[i]['weight'],
        totalweight: maps[i]['totalweight'],
        subtotal: maps[i]['subtotal'],
        quantity: maps[i]['quantity'],
        stock: maps[i]['stock'],
      );
    });
  }

  static Future<int> calculateTotal() async {
    final db = await init();
    int result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT SUM(subtotal) FROM Carts"));
    print("total : $result");
    return result;
  }

  static Future<int> countProduct() async {
    final db = await init();
    int result =
        Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM Carts"));
    print("count : $result");
    return result;
  }

  static Future<int> updateCart(Cart cart) async {
    // returns the number of rows updated
    final db = await init();
    int result = await db.update("Carts", cart.toMap(),
        where: "product_id = ?", whereArgs: [cart.id]);
    print("update : $result");
    return result;
  }
}
