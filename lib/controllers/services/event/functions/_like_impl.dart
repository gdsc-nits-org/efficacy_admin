part of '../event_controller.dart';

Future<EventModel> _toggleLikeImpl(
    {required String userEmail, required EventModel event}) async {
  List<String> liked = List.from(event.liked);
  bool couldRemove = liked.remove(userEmail);
  if (!couldRemove) {
    liked.add(userEmail);
  }

  event = event.copyWith(liked: liked);
  return await EventController.update(event);
}
