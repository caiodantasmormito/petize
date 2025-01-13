import 'package:challenge_petize/modules/home/domain/entities/user_entity.dart';
import 'package:challenge_petize/modules/home/domain/usecase/home_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.useCase}) : super(const HomeInitial());

  final HomeUseCase useCase;

  Future<void> getUser({
    required String username,
  }) async {
    emit(const HomeLoading());

    final (failure, result) = await useCase(username);

    if (result == null) {
      emit(HomeError(failure?.message));

      return;
    }

    emit(HomeSuccess(data: result));
  }
}
