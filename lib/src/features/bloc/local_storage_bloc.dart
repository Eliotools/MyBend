import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mybend/src/enum/local_storage_key_enum.dart';
import 'package:mybend/src/helpers/local_storage_helper.dart';
import 'package:mybend/src/model/activity.dart';
import 'package:mybend/src/model/data_dto.dart';
import 'package:mybend/src/model/history.dart';
import 'package:mybend/src/model/home_state.dart';
import 'package:mybend/src/model/session.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class LocalStorageBloc extends Cubit<BendState> {
  LocalStorageBloc() : super(BendInitial());

  void getItems() {
    initLocalStorage();
    final name =
        LocalStorageHelper.getItemOrNull(LocalStorageKeyEnum.name, parse: true)
            as String?;
    if (name.isNull) {
      return emit(BendLoginIn());
    }
    emit(
      BendLoaded<DataDto>(
        data: DataDto(
          name: name,
          exercices: (LocalStorageHelper.getItemOrNull(
                      LocalStorageKeyEnum.exercices,
                      parse: true) as List?)
                  ?.map((e) => Activity.fromJson(e as Map<String, Object?>))
                  .toList() ??
              [],
          sessions: (LocalStorageHelper.getItemOrNull(
                      LocalStorageKeyEnum.sessions,
                      parse: true) as List?)
                  ?.map((e) => Session.fromJson(e as Map<String, Object?>))
                  .toList() ??
              [],
          xp: int.tryParse(
                  LocalStorageHelper.getItemOrNull(LocalStorageKeyEnum.xp)
                      .toString()) ??
              0,
          history: ((LocalStorageHelper.getItemOrNull(
                      LocalStorageKeyEnum.history,
                  parse: true) as List?)
                  ?.map((e) => History.fromJson(e as Map<String, Object?>))
                  .toList()) ??
              [],
          current: Activity.fromJsonOrNull((LocalStorageHelper.getItemOrNull(
              LocalStorageKeyEnum.current,
              parse: true) as Map<String, Object?>?)),
        ),
      ),
    );
  }
}
