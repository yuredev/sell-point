import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/core/constants/colors.dart';
import 'package:sell_point/core/constants/sizes.dart';
import 'package:sell_point/domain/dto/cart_dto/cart_dto.dart';
import 'package:sell_point/domain/user/user.dart';
import 'package:sell_point/logic/cubits/cart/action/action_cart_cubit.dart';
import 'package:sell_point/logic/cubits/cart/action/action_cart_state.dart';
import 'package:sell_point/logic/cubits/cart/flow/cart_flow_cubit.dart';
import 'package:sell_point/logic/cubits/cart/flow/cart_flow_state.dart';
import 'package:sell_point/logic/cubits/global_alert/global_alert_cubit.dart';
import 'package:sell_point/presentation/utils/view_utils.dart';
import 'package:sell_point/presentation/widgets/shared/button_widget.dart';

class PaymentPage extends StatefulWidget {
  final double total;
  final Map<int, int> productQuantities;
  final User user;

  const PaymentPage({
    super.key,
    required this.user,
    required this.total,
    required this.productQuantities,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final ActionCartCubit actionsCubit = context.read();
  late final GlobalAlertCubit alertCubit = context.read();
  final paidAmountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var change = 0.0;

  @override
  void dispose() {
    paidAmountController.dispose();
    super.dispose();
  }

  void calculateChange() {
    final paidAmount = double.tryParse(paidAmountController.text) ?? 0.0;
    setState(() {
      change = paidAmount - widget.total;
    });
  }

  Future<void> submitPayment(BuildContext context, CartDto cartDTO) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final paidAmount = double.tryParse(paidAmountController.text) ?? 0.0;
    if (paidAmount < widget.total) {
      ViewUtils.showSnackBar(
        context,
        'Valor insuficiente',
        isErrorMessage: true,
      );
      return;
    }
    actionsCubit.save(cartDTO);
  }

  String? validateAmountPaid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.main,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Valor Total: R\$ ${widget.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  validator: validateAmountPaid,
                  controller: paidAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Valor Pago (em dinheiro)',
                  ),
                  onChanged: (_) => calculateChange(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 46.0),
                child: Text(
                  'Troco: R\$ ${change.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Align(
                child: BlocConsumer<ActionCartCubit, ActionCartState>(
                  listener: (context, state) {
                    if (state is CartSavedState) {
                      alertCubit.fire('Venda salva!');
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    } else if (state is SaveProductErrorState) {
                      alertCubit.fire(
                        'Erro ao salvar venda',
                        isErrorMessage: true,
                      );
                    }
                  },
                  builder:
                      (
                        context,
                        actionState,
                      ) => BlocBuilder<CartFlowCubit, CartFlowState>(
                        builder:
                            (context, state) =>
                                state is AddingProductsState
                                    ? ButtonWidget(
                                      width:
                                          MediaQuery.of(context).size.width *
                                          .75,
                                      isLoading: actionState is SavingCartState,
                                      loadingText: 'Finalizando...',
                                      title: 'Finalizar Pagamento',
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      onPress:
                                          () => submitPayment(
                                            context,
                                            CartDto(
                                              id: 1, // mocado
                                              userId: widget.user.id,
                                              products: state.dtos,
                                            ),
                                          ),
                                      height: 42,
                                      leftIcon: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    )
                                    : SizedBox(),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
