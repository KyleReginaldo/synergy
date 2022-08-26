import 'package:bloc/bloc.dart';
import 'package:synergy/domain/entity/comment_entity.dart';
import 'package:synergy/domain/entity/post_entity.dart';
import 'package:synergy/domain/usecase/fetchcomments.dart';
import 'package:synergy/domain/usecase/getpost.dart';
import 'package:synergy/domain/usecase/sendcomment.dart';
import 'package:meta/meta.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit(this._sendComment, this._fetchComments, this._getPosts)
      : super(CommentInitial());

  final SendComment _sendComment;
  final FetchComments _fetchComments;
  final GetPost _getPosts;

  void sendComment(CommentEntity comment, String uid) async {
    await _sendComment(comment, uid);
  }

  void fetchComments(String uid) async {
    emit(CommentLoading());
    final commentStream = _fetchComments(uid);
    commentStream.listen((event) async {
      if (event.isEmpty) {
        final post = await _getPosts(uid);
        emit(CommentEmpty(posts: post));
      } else {
        emit(CommentLoaded(comments: event));
      }
    });
  }
}
