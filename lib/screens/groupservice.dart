import 'group.dart';
import 'event.dart';

class GroupService {
  // Simulate fetching group events
  Future<List<Group>> fetchGroups() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    return [
      Group(
        id: 1,
        title: 'Games Club',
        description: 'Enjoy board games, card games, and social gaming events.',
        imageUrl: 'assets/games-club.jpg'
      ),
      Group(
        id: 2,
        title: 'Moda Social Club',
        description: 'Meet and mingle in Moda with other like-minded people.',
        imageUrl: 'assets/moda-social-club.jpg'
      ),
      Group(
        id: 3,
        title: 'Breakfast & Lunch Club',
        description: 'Delight in delicious breakfasts and hearty lunches.',
        imageUrl: 'assets/breakfast-club.jpg'
      ),
      Group(
        id: 4,
        title: 'Theatre Club',
        description: 'Experience the best theatre performances together.',
        imageUrl: 'assets/theatre-club.jpg'
      ),
      Group(
        id: 5,
        title: 'Special Events Club',
        description: 'Celebrate unique events and make memories.',
         imageUrl: 'assets/special-events.jpg'
      ),
    ];
  }
}
class EventService {
  Future<Event> fetchTheatreEvent() async {
    return Event(
      id: '1',
      title: 'Theatre Club Meetup - Improvisation Night',
      description:
          'Join us for an exciting night of theatre improvisation and fun activities!',
      dateTime: DateTime(2024, 1, 12, 18, 30),
      location: 'Istanbul Cultural Center, Üsküdar',
      googleFormUrl: 'https://forms.gle/exampleGoogleFormLink', // Replace this with your actual form URL
    );
  }
}