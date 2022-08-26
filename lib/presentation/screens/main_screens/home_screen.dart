import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:synergy/presentation/cubits/posts/posts_cubit.dart';

import '../../widgets/post_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<PostsCubit>().fetchPosts();
    super.initState();
  }

  Future<void> onRefresh() async {
    context.read<PostsCubit>().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is Loaded) {
          return RefreshIndicator(
            onRefresh: onRefresh,
            color: Colors.black,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: SingleChildScrollView(
              child: Column(
                children: state.posts
                    .map(
                      (e) => PostContainer(
                        post: e,
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        } else if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Empty) {
          return const Center(
            child: CustomText('No content available'),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
