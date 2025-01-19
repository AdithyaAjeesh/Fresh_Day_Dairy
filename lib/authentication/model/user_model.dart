class UserModel {
  String? userName;
  String? email;
  String? passWord;
  bool? isAdmin;
  int? previousMilkBalance;
  int? previousButterMilkBalance;
  int? previousGheeBalance;
  int? previousCurdBalance;
  int? previousButterBalance;
  int? milkDailyQuantity;
  int? milkDailyAmount;
  int? butterDailyQuantity;
  int? butterDailyAmount;
  int? butterMilkDailyQuantity;
  int? butterMilkDailyAmount;
  int? gheeDailyQuantity;
  int? gheeDailyAmount;
  int? curdDailyQuantity;
  int? curdDailyAmount;
  List<int> milkDailyTasks;
  List<int> gheeDailyTasks;
  List<int> curdDailyTasks;
  List<int> butterMilkDailyTasks;
  List<int> butterDailyTasks;

  // Constructor
  UserModel({
    this.userName,
    this.email,
    this.passWord,
    this.isAdmin,
    this.previousMilkBalance,
    this.previousButterMilkBalance,
    this.previousGheeBalance,
    this.previousCurdBalance,
    this.previousButterBalance,
    this.milkDailyAmount,
    this.milkDailyQuantity,
    this.butterDailyAmount,
    this.butterDailyQuantity,
    this.butterMilkDailyAmount,
    this.butterMilkDailyQuantity,
    this.curdDailyAmount,
    this.curdDailyQuantity,
    this.gheeDailyAmount,
    this.gheeDailyQuantity,
    List<int>? milkDailyTasks,
    List<int>? gheeDailyTasks,
    List<int>? curdDailyTasks,
    List<int>? butterMilkDailyTasks,
    List<int>? butterDailyTasks,
  })  : milkDailyTasks = milkDailyTasks ?? [],
        gheeDailyTasks = gheeDailyTasks ?? [],
        curdDailyTasks = curdDailyTasks ?? [],
        butterMilkDailyTasks = butterMilkDailyTasks ?? [],
        butterDailyTasks = butterDailyTasks ?? [];

  // From JSON constructor
  UserModel.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        email = json['email'],
        passWord = json['passWord'],
        isAdmin = json['isAdmin'],
        previousMilkBalance = json['previousMilkBalance'],
        previousButterMilkBalance = json['previousButterMilkBalance'],
        previousGheeBalance = json['previousGheeBalance'],
        previousCurdBalance = json['previousCurdBalance'],
        previousButterBalance = json['previousButterBalance'],
        milkDailyAmount = json['milkDailyAmount'],
        milkDailyQuantity = json['milkDailyQuantity'],
        butterDailyAmount = json['butterDailyAmount'],
        butterDailyQuantity = json['butterDailyQuantity'],
        butterMilkDailyAmount = json['butterMilkDailyAmount'],
        butterMilkDailyQuantity = json['butterMilkDailyQuantity'],
        gheeDailyAmount = json['gheeDailyAmount'],
        gheeDailyQuantity = json['gheeDailyQuantity'],
        curdDailyAmount = json['curdDailyAmount'],
        curdDailyQuantity = json['curdDailyQuantity'],
        milkDailyTasks = List<int>.from(json['milkDailyTasks'] ?? []),
        gheeDailyTasks = List<int>.from(json['gheeDailyTasks'] ?? []),
        curdDailyTasks = List<int>.from(json['curdDailyTasks'] ?? []),
        butterMilkDailyTasks =
            List<int>.from(json['butterMilkDailyTasks'] ?? []),
        butterDailyTasks = List<int>.from(json['butterDailyTasks'] ?? []);

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'passWord': passWord,
      'isAdmin': isAdmin,
      'previousMilkBalance': previousMilkBalance,
      'previousButterMilkBalance': previousButterMilkBalance,
      'previousGheeBalance': previousGheeBalance,
      'previousCurdBalance': previousCurdBalance,
      'previousButterBalance': previousButterBalance,
      'milkDailyAmount': milkDailyAmount,
      'milkDailyQuantity': milkDailyQuantity,
      'butterDailyAmount': butterDailyAmount,
      'butterDailyQuantity': butterDailyQuantity,
      'butterMilkDailyAmount': butterMilkDailyAmount,
      'butterMilkDailyQuantity': butterMilkDailyQuantity,
      'gheeDailyAmount': gheeDailyAmount,
      'gheeDailyQuantity': gheeDailyQuantity,
      'curdDailyAmount': curdDailyAmount,
      'curdDailyQuantity': curdDailyQuantity,
      'milkDailyTasks': milkDailyTasks,
      'gheeDailyTasks': gheeDailyTasks,
      'curdDailyTasks': curdDailyTasks,
      'butterMilkDailyTasks': butterMilkDailyTasks,
      'butterDailyTasks': butterDailyTasks,
    };
  }

  // Function to check if a task for a specific date is completed
  bool isMilkTaskCompletedForDate(int date) {
    return milkDailyTasks.contains(date);
  }

  bool isGheeTaskCompletedForDate(int date) {
    return gheeDailyTasks.contains(date);
  }

  bool isCurdTaskCompletedForDate(int date) {
    return curdDailyTasks.contains(date);
  }

  bool isButterMilkTaskCompletedForDate(int date) {
    return butterMilkDailyTasks.contains(date);
  }

  bool isButterTaskCompletedForDate(int date) {
    return butterDailyTasks.contains(date);
  }
}
