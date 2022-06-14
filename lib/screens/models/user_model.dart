class User {
  final int id;
  final String? name;
  final String? imageURL;
  final bool isOnline;

  User({required this.id, this.name, this.imageURL, required this.isOnline});
}

final User currentUser =
    User(id: 0, name: "Olawale", imageURL: "/assets/images", isOnline: true);

final User ironMan =
    User(id: 1, name: "kehinde", imageURL: "/assets/images", isOnline: true);
final User captainAmerica = User(
  id: 2,
  name: 'Captain America',
  imageURL: 'assets/images/captain-america.jpg',
  isOnline: true,
);
final User hulk = User(
  id: 3,
  name: 'Hulk',
  imageURL: 'assets/images/hulk.jpg',
  isOnline: false,
);
final User scarletWitch = User(
  id: 4,
  name: 'Scarlet Witch',
  imageURL: 'assets/images/scarlet-witch.jpg',
  isOnline: false,
);
final User spiderMan = User(
  id: 5,
  name: 'Spider Man',
  imageURL: 'assets/images/spiderman.jpg',
  isOnline: true,
);
final User blackWindow = User(
  id: 6,
  name: 'Black Widow',
  imageURL: 'assets/images/black-widow.jpg',
  isOnline: false,
);
final User thor = User(
  id: 7,
  name: 'Thor',
  imageURL: 'assets/images/thor.png',
  isOnline: false,
);
final User captainMarvel = User(
  id: 8,
  name: 'Captain Marvel',
  imageURL: 'assets/images/captain-marvel.jpg',
  isOnline: false,
);
