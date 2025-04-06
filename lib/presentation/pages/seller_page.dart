import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/core/constants/colors.dart';
import 'package:sell_point/core/routes.dart';
import 'package:sell_point/logic/cubits/cart/load/load_carts_cubit.dart';
import 'package:sell_point/logic/cubits/cart/load/load_carts_state.dart';
import 'package:sell_point/presentation/components/seller_page/user_item_of_list_component.dart';

class SellerPage extends StatelessWidget {
  const SellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loadCartsCubit = context.read<LoadCartsCubit>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Vendedor', style: TextStyle(color: Colors.white)),
        backgroundColor: SellPointColors.main,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: BlocBuilder<LoadCartsCubit, LoadCartsState>(
          builder:
              (context, state) => RefreshIndicator(
                onRefresh: () async {
                  loadCartsCubit.load();
                },
                child: CustomScrollView(
                  slivers: [
                    if (state is CartsLoadedState)
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final cart = state.carts[index];
                          return UserItemOfListComponent(
                            cart: cart,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.products,
                                arguments: cart,
                              );
                            },
                          );
                        }, childCount: state.carts.length),
                      )
                    else if (state is LoadingCartsState ||
                        state is InitialLoadCartsState)
                      SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          List.generate(10, (i) {
                            return UserItemOfListComponent(isLoading: true);
                          }),
                        ),
                      )
                    else if (state is CartsLoadErrorState)
                      const SliverFillRemaining(
                        child: Center(
                          child: Text("Erro ao carregar os carrinhos"),
                        ),
                      ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
