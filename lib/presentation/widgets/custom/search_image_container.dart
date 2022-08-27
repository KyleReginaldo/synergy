import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';

import '../../cubits/posts/posts_cubit.dart';

class SearchImageContainer extends StatefulWidget {
  const SearchImageContainer({Key? key}) : super(key: key);

  @override
  State<SearchImageContainer> createState() => _SearchImageContainerState();
}

class _SearchImageContainerState extends State<SearchImageContainer> {
  Future<void> onrefresh() async {
    context.read<PostsCubit>().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is Loaded) {
          return RefreshIndicator(
            onRefresh: onrefresh,
            child: Wrap(
              runAlignment: WrapAlignment.spaceAround,
              alignment: WrapAlignment.spaceAround,
              children: state.posts
                  .map((e) => Container(
                        margin: const EdgeInsets.all(1),
                        child: Image.network(
                          e.postUrl,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.32,
                          fit: BoxFit.cover,
                        ),
                      ))
                  .toList(),
            ),
          );
        } else if (state is Empty) {
          return const Center(
            child: CustomText('No content.'),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
