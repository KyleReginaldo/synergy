part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatEntity> chats;
  ChatLoaded({
    required this.chats,
  });
}

class ChatLoading extends ChatState {}

class ChatEmpty extends ChatState {}
