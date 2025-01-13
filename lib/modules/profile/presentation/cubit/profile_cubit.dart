import 'package:bloc/bloc.dart';
import 'package:challenge_petize/modules/profile/domain/entities/repo_entity.dart';
import 'package:challenge_petize/modules/profile/domain/usecase/profile_usecase.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.useCase}) : super(const ProfileInitial());
  final ProfileUseCase useCase;

  Future<void> getUserRepo({
    required String username,
  }) async {
    emit(const ProfileLoading());

    final (failure, result) = await useCase(username);

    if (result == null) {
      emit(ProfileError(failure?.message));
      return;
    }
    emit(ProfileSuccess(data: result));
  }
}
