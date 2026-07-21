import 'package:flowery/config/base_state/base_state.dart';
import 'package:flowery/modules/auth/domain/entities/apply_body_entity.dart';
import 'package:flowery/modules/auth/domain/use_cases/apply_use_case.dart';
import 'package:flowery/modules/auth/domain/use_cases/get_countries_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplyCubit extends Cubit<BaseState> {
  ApplyCubit(this.getCountriesUseCase, this.applyUseCase)
    : super(const BaseState.initial());
  final GetCountriesUseCase getCountriesUseCase;
  final ApplyUseCase applyUseCase;
  Future<void> getCountries() async {
    emit(const BaseState.loading());
    final result = await getCountriesUseCase.getCountries();
    result.when(
      success: (data) {
        emit(BaseState.success(data));
      },
      error: (exception) {
        emit(BaseState.error(exception));
      },
    );
  }

  Future<void> apply(ApplyBodyEntity body) async {
    emit(const BaseState.loading());
    final result = await applyUseCase.apply(body);
    result.when(
      success: (data) {
        emit(BaseState.success(data));
      },
      error: (exception) {
        emit(BaseState.error(exception));
      },
    );
  }
}