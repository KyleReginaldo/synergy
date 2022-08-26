import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:synergy/domain/entity/chat_entity.dart';
import 'package:synergy/domain/usecase/fetchchats.dart';
import 'package:synergy/domain/usecase/sendmessage.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._sendMessage, this._fetchChats) : super(ChatInitial());

  final SendMessage _sendMessage;
  final FetchChats _fetchChats;

  void sendMessage(
    String msg,
    String chatUid,
    String userId,
    String friendName,
  ) async {
    await _sendMessage(
      msg,
      chatUid,
      userId,
      friendName,
    );
  }

  void fetchChats(String chatUid) async {
    emit(ChatLoading());
    final chatStream = _fetchChats(chatUid);
    chatStream.listen((event) {
      if (event.isEmpty) {
        emit(ChatEmpty());
      } else {
        emit(ChatLoaded(chats: event));
      }
    });
  }
}
