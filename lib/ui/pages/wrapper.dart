part of 'pages.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String splashscreen;

  @override
  Widget build(BuildContext context) {
    // if (splashscreen != null) {
    //   if (!(prevPageEvent is GoToHomePage)) {
    // prevPageEvent = GoToSplashPage();
    // BlocProvider.of<PageBloc>(context).add(prevPageEvent);

    // if (!(prevPageEvent is GoToHomePage)) {
    prevPageEvent = GoToSplashPage();
    // context.watch<ProductCubit>().getProduct();
    BlocProvider.of<PageBloc>(context).add(prevPageEvent);

    //   }
    // } else {
    //   prevPageEvent = GoToSplashPage();
    //   BlocProvider.of<PageBloc>(context).add(prevPageEvent);
    // }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPageLoading)
            ? SplashScreenPage()
            : (pageState is OnHomePage)
                ? HomePage()
                : (pageState is OnCartPage) ? CartPage() : Container());
  }
}
