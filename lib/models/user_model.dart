class UserModel {
  final dynamic? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  UserModel({
     this.id,
     this.email,
     this.firstName,
     this.lastName,
     this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
  String get fullName => "$firstName $lastName";
}

class UserApiResponse {
  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final List<UserModel> users;

  UserApiResponse({
     this.page,
     this.perPage,
     this.total,
     this.totalPages,
    required this.users,
  });

  factory UserApiResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<UserModel> usersList = list.map((i) => UserModel.fromJson(i)).toList();

    return UserApiResponse(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      users: usersList,
    );
  }
}
