class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace1.png',
      title: 'User interface Design',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'User interface Design',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
    Category(
      imagePath: 'assets/design_course/interFace1.png',
      title: 'User interface Design',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'User interface Design',
      lessonCount: 22,
      money: 18,
      rating: 4.6,
    ),
  ];

  static List<Category> themeWeddingList = <Category>[
    Category(
      imagePath: 'assets/theme/nautical.jpeg',
      title: 'Nautical wedding theme',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/theme/bohemian.jpeg',
      title: 'Bohemian wedding',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/theme/garden.jpeg',
      title: 'Garden wedding',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/theme/rustic.jpeg',
      title: 'Rustic wedding',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/theme/beach.jpeg',
      title: 'Beach wedding',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/theme/fairytale.jpeg',
      title: 'Fairytale wedding',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/theme/romantic.jpg',
      title: 'Romantic wedding',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/theme/tropical.jpg',
      title: 'Tropical wedding theme',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
  ];
}
