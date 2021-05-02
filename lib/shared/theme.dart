part of 'shared.dart';

const double defaultMargin = 24;

Color mainColor = Colors.orange;
Color accentColor1 = Color(0xFF2C1F63);
Color accentColor2 = Color(0xFFFBD460);
Color accentColor3 = Color(0xFFADADAD);

TextStyle blackTextFont = GoogleFonts.roboto()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle blueTextFont = GoogleFonts.roboto()
    .copyWith(color: Colors.blue[800], fontWeight: FontWeight.w500);
TextStyle nocolorTextFont =
    GoogleFonts.roboto().copyWith(fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.roboto()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle orangeTextFont = GoogleFonts.roboto()
    .copyWith(color: Colors.orange, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.roboto()
    .copyWith(color: accentColor3, fontWeight: FontWeight.w500);
TextStyle whiteNumberFont = GoogleFonts.roboto().copyWith(color: Colors.white);
TextStyle yellowNumberFont = GoogleFonts.roboto().copyWith(color: accentColor2);
TextStyle goldNumberFont =
    GoogleFonts.roboto().copyWith(color: Color(0xFFC89B11));
