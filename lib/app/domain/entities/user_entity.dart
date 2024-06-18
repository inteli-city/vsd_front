class UserEntity {
  final String userId;
  final String name;
  final String imageUrl;
  final String region;
  final String adress;
  final int adressNumber;

  const UserEntity({
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.region,
    required this.adress,
    required this.adressNumber,
  });
}
