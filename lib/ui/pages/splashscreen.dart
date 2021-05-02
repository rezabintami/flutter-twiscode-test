part of 'pages.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<PageBloc, PageState>(
      listener: (context, state) {
        if (state is OnSplashPageLoaded) {
          context.read<ProductCubit>().getProduct();
          BlocProvider.of<PageBloc>(context).add(GoToHomePage());
        }
      },
      child: Center(
        child: Text(
          'TWISCODE TEST',
          style:
              blackTextFont.copyWith(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
    ));
  }
}
