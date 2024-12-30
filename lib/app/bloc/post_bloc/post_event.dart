abstract class PostEvent {}

class AddPost extends PostEvent {
  final String message;
  final String userID;
  AddPost(
    this.message,
    this.userID,
  );
}

class LoadPosts extends PostEvent {}
