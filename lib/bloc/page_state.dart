part of 'page_bloc.dart';

@immutable
abstract class PageState {}

class OnInitialPage extends PageState {}

class OnSplashPageLoading extends PageState {}

class OnSplashPageLoaded extends PageState {}

class OnHomePage extends PageState {}

class OnCartPage extends PageState {}
