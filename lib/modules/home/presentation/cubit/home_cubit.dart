import 'package:challenge_petize/modules/home/domain/entities/user_entity.dart';
import 'package:challenge_petize/modules/home/domain/usecase/home_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.useCase}) : super(const HomeInitial());

  final HomeUseCase useCase;

  List<String> recentSearches = [];

  Future<void> getUser({
    required String username,
  }) async {
    emit(const HomeLoading());

    final (failure, result) = await useCase(username);

    if (result == null) {
      if (failure != null) {
        emit(HomeError(message: failure.message ?? 'Erro inesperado'));
      } else {
        emit(const HomeError(message: 'Erro inesperado'));
      }
      return;
    }

    emit(HomeSuccess(data: result));
  }

}
