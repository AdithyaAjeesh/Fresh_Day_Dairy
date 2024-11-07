class UserModel {
  String? userName;
  String? email;
  String? passWord;
  bool? isAdmin;
  List<DailyTasks>? milkDailyTasks;
  List<DailyTasks>? gheeDailyTasks;
  List<DailyTasks>? curdDailyTasks;
  List<DailyTasks>? butterMilkDailyTasks;

  List<DailyTasks>? butterDailyTasks;

  UserModel({
    this.userName,
    this.email,
    this.passWord,
    this.isAdmin,
    this.milkDailyTasks,
    this.gheeDailyTasks,
    this.curdDailyTasks,
    this.butterMilkDailyTasks,
    this.butterDailyTasks,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    passWord = json['passWord'];
    isAdmin = json['isAdmin'];
    milkDailyTasks = (json['milkDailyTasks'] as List<dynamic>?)
        ?.map((item) => DailyTasks.fromJson(item as Map<String, dynamic>))
        .toList();
    gheeDailyTasks = (json['gheeDailyTasks'] as List<dynamic>?)
        ?.map((item) => DailyTasks.fromJson(item as Map<String, dynamic>))
        .toList();
    curdDailyTasks = (json['curdDailyTasks'] as List<dynamic>?)
        ?.map((item) => DailyTasks.fromJson(item as Map<String, dynamic>))
        .toList();
    butterMilkDailyTasks = (json['butterMilkDailyTasks'] as List<dynamic>?)
        ?.map((item) => DailyTasks.fromJson(item as Map<String, dynamic>))
        .toList();
    butterDailyTasks = (json['butterDailyTasks'] as List<dynamic>?)
        ?.map((item) => DailyTasks.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'passWord': passWord,
      'isAdmin': isAdmin,
      'milkDailyTasks': milkDailyTasks,
      'gheeDailyTasks': gheeDailyTasks,
      'curdDailyTasks': curdDailyTasks,
      'butterMilkDailyTasks': butterMilkDailyTasks,
      'butterDailyTasks': butterDailyTasks,
    };
  }
}

class DailyTasks {
  String? id;
  String? date;
  String? amount;
  String? quantity;

  DailyTasks({
    this.id,
    this.date,
    this.amount,
    this.quantity,
  });

  DailyTasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    amount = json['amount'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'amount': amount,
      'quantity': quantity,
    };
  }
}
