part of 'home_cubit.dart';



sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}

final class HomeSuccess extends HomeState {
  final UserEntity data;

  const HomeSuccess({required this.data});

  @override
  List<Object> get props => [data];
}


