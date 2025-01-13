part of 'profile_cubit.dart';



sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileSuccess extends ProfileState {
  final List<RepositoryEntity> data;

  const ProfileSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

final class ProfileError extends ProfileState {
  final String? message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
