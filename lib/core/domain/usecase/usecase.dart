import 'package:challenge_petize/core/domain/failure/failure.dart';
import 'package:equatable/equatable.dart';


abstract interface class UseCase<Type, Params> {
  Future<(Failure?, Type?)> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object?> get props => [];
}
