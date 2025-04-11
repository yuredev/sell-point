import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/core/constants/colors.dart';
import 'package:sell_point/core/constants/sizes.dart';
import 'package:sell_point/core/routes.dart';
import 'package:sell_point/logic/cubits/user/load/load_users_cubit.dart';
import 'package:sell_point/logic/cubits/user/load/load_users_state.dart';
import 'package:sell_point/presentation/widgets/sellers_page/user_item_of_list_component.dart';

class SellersPage extends StatefulWidget {
  const SellersPage({super.key});

  @override
  State<SellersPage> createState() => _SellersPageState();
}

class _SellersPageState extends State<SellersPage> {
  late final LoadUsersCubit loadUsersCubit = context.read();

  @override
  void initState() {
    super.initState();
    loadUsersCubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.main,
        title: const Text(
          'Selecionar vendedor',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.defaultHorizontalPadding,
          vertical: Sizes.defaultVerticalPadding,
        ),
        child: BlocBuilder<LoadUsersCubit, LoadUsersState>(
          builder:
              (context, state) => RefreshIndicator(
                onRefresh: () async {
                  loadUsersCubit.load();
                },
                child: CustomScrollView(
                  slivers: [
                    if (state is UsersLoadedState)
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final user = state.users[index];
                          return UserItemOfListWidget(
                            user: user,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.products,
                                arguments: user,
                              );
                            },
                          );
                        }, childCount: state.users.length),
                      )
                    else if (state is LoadingUsersState)
                      SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          List.generate(10, (i) {
                            return UserItemOfListWidget(isLoading: true);
                          }),
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
