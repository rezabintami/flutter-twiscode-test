part of 'services.dart';

Future<Database> init() async {
  Directory directory = await getApplicationDocumentsDirectory();
  final path = join(directory.path, "cart.db");

  return await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // await db.execute("
    //       CREATE TABLE Carts(
    //       id INTEGER PRIMARY KEY AUTOINCREMENT,
    //       product_id TEXT,
    //       title TEXT,
    //       location TEXT,
    //       merchant TEXT,
    //       price INTEGER,
    //       ishalal TEXT,
    //       stock INTEGER,
    //       photo TEXT,
    //       quantity INTEGER
    //       )");
    await db.execute("CREATE TABLE Carts ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "product_id TEXT,"
        "title TEXT,"
        "location TEXT,"
        "merchant TEXT,"
        "weight DOUBLE,"
        "totalweight DOUBLE,"
        "price INTEGER,"
        "ishalal TEXT,"
        "stock INTEGER,"
        "photo TEXT,"
        "quantity INTEGER,"
        "subtotal INTEGER"
        ")");
  });
}
