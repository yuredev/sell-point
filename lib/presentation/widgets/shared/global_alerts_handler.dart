import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/core/bindings.dart';
import 'package:sell_point/logic/cubits/global_alert/global_alert_cubit.dart';
import 'package:sell_point/logic/cubits/global_alert/global_alert_state.dart';
import 'package:sell_point/presentation/utils/view_utils.dart';

class GlobalAlertsHandler extends StatelessWidget {
  final Widget? child;

  const GlobalAlertsHandler({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlobalAlertCubit>.value(
      value: Bindings.get(),
      child: BlocListener<GlobalAlertCubit, GlobalAlertState>(
        listenWhen: (_, state) => state is GlobalAlertEmittedState,
        listener: (ctx, state) {
          ViewUtils.showSnackBar(
            ctx,
            (state as GlobalAlertEmittedState).message,
            isErrorMessage: state.isErrorMessage,
          );
        },
        child: child,
      ),
    );
  }
}
