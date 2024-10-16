class Plant {
  final String imageUrl;
  final String title;
  final String description;
  final int wateringFrequency;

  Plant({
    String? imageUrl,
    required this.title,
    required this.description,
    required this.wateringFrequency,
  }) : imageUrl = imageUrl ??
            'assets/transparent-cartoon-plants-succulent-plant-free-music-free-mus-5edb68f1ca8e24.7611070815914375538297.jpg';
}
