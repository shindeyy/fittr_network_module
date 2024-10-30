class RootData<T> {
  final T data;

  RootData({required this.data});

  // Generic fromJson method to handle various data types for the 'data' field
  factory RootData.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return RootData(
      data: fromJsonT(json['data'] as Map<String, dynamic>),
    );
  }
}