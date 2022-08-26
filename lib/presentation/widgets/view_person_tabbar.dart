import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/widgets/text.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:synergy/presentation/cubits/posts/posts_cubit.dart';

class ViewPersonTabbar extends StatefulWidget {
  final TabController controller;
  final String uid;
  const ViewPersonTabbar(
      {Key? key, required this.controller, required this.uid})
      : super(key: key);

  @override
  State<ViewPersonTabbar> createState() => _ProfileTabBarState();
}

class _ProfileTabBarState extends State<ViewPersonTabbar> {
  int index = 0;
  @override
  void initState() {
    context.read<PostsCubit>().fetchUserPosts(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: TabBar(
            controller: widget.controller,
            onTap: (index) {
              setState(() {
                this.index = index;
              });
            },
            tabs: [
              Tab(
                icon: Iconify(
                  Ic.baseline_grid_on,
                  size: 20,
                  color: index != 0 ? Colors.grey : Colors.black,
                ),
              ),
              Tab(
                  icon: Iconify(
                Bi.person_square,
                size: 20,
                color: index != 1 ? Colors.grey : Colors.black,
              )),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          width: double.maxFinite,
          child: TabBarView(
            controller: widget.controller,
            children: [
              BlocBuilder<PostsCubit, PostsState>(
                builder: (context, state) {
                  if (state is UserPostLoaded) {
                    return GridView.count(
                      crossAxisCount: 3,
                      children: state.posts
                          .map(
                            (e) => Image.network(
                              e.postUrl,
                              fit: BoxFit.cover,
                            ),
                          )
                          .toList(),
                    );
                  } else if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is Empty) {
                    return const Center(
                      child: CustomText('No content.'),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const Center(child: CustomText('no data')),
            ],
          ),
        )
      ],
    );
  }
}
