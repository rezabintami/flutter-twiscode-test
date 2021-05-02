part of 'page_bloc.dart';

@immutable
abstract class PageEvent {}

class GoToSplashPage extends PageEvent {}

class GoToHomePage extends PageEvent {}

class GoToCartPage extends PageEvent {}
