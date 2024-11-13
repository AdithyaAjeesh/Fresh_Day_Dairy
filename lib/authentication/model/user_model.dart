class UserModel {
  String? userName;
  String? email;
  String? passWord;
  bool? isAdmin;
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
  List<int> milkDailyTasks; // Non-nullable with default empty list
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

// class UserModel {
//   String? userName;
//   String? email;
//   String? passWord;
//   bool? isAdmin;
//   List<DailyTask> milkDailyTasks; // Non-nullable with default empty list
//   List<DailyTask> gheeDailyTasks;
//   List<DailyTask> curdDailyTasks;
//   List<DailyTask> butterMilkDailyTasks;
//   List<DailyTask> butterDailyTasks;

//   // Constructor
//   UserModel({
//     this.userName,
//     this.email,
//     this.passWord,
//     this.isAdmin,
//     List<DailyTask>? milkDailyTasks,
//     List<DailyTask>? gheeDailyTasks,
//     List<DailyTask>? curdDailyTasks,
//     List<DailyTask>? butterMilkDailyTasks,
//     List<DailyTask>? butterDailyTasks,
//   })  : milkDailyTasks = milkDailyTasks ?? [],
//         gheeDailyTasks = gheeDailyTasks ?? [],
//         curdDailyTasks = curdDailyTasks ?? [],
//         butterMilkDailyTasks = butterMilkDailyTasks ?? [],
//         butterDailyTasks = butterDailyTasks ?? [];

//   // From JSON constructor
//   UserModel.fromJson(Map<String, dynamic> json)
//       : userName = json['userName'],
//         email = json['email'],
//         passWord = json['passWord'],
//         isAdmin = json['isAdmin'],
//         milkDailyTasks = (json['milkDailyTasks'] as List<dynamic>?)
//                 ?.map((item) => DailyTask.fromJson(item))
//                 .toList() ??
//             [],
//         gheeDailyTasks = (json['gheeDailyTasks'] as List<dynamic>?)
//                 ?.map((item) => DailyTask.fromJson(item))
//                 .toList() ??
//             [],
//         curdDailyTasks = (json['curdDailyTasks'] as List<dynamic>?)
//                 ?.map((item) => DailyTask.fromJson(item))
//                 .toList() ??
//             [],
//         butterMilkDailyTasks = (json['butterMilkDailyTasks'] as List<dynamic>?)
//                 ?.map((item) => DailyTask.fromJson(item))
//                 .toList() ??
//             [],
//         butterDailyTasks = (json['butterDailyTasks'] as List<dynamic>?)
//                 ?.map((item) => DailyTask.fromJson(item))
//                 .toList() ??
//             [];

//   // To JSON method
//   Map<String, dynamic> toJson() {
//     return {
//       'userName': userName,
//       'email': email,
//       'passWord': passWord,
//       'isAdmin': isAdmin,
//       'milkDailyTasks': milkDailyTasks.map((e) => e.toJson()).toList(),
//       'gheeDailyTasks': gheeDailyTasks.map((e) => e.toJson()).toList(),
//       'curdDailyTasks': curdDailyTasks.map((e) => e.toJson()).toList(),
//       'butterMilkDailyTasks':
//           butterMilkDailyTasks.map((e) => e.toJson()).toList(),
//       'butterDailyTasks': butterDailyTasks.map((e) => e.toJson()).toList(),
//     };
//   }

//   // Function to check if a task for a specific date is completed
//   bool isMilkTaskCompletedForDate(int date) {
//     return milkDailyTasks.any((task) => task.tasks?.contains(date) ?? false);
//   }
// }

// class DailyTask {
//   List<int>? tasks; // A list of dates when tasks were completed
//   String? amount;
//   String? quantity;

//   // Constructor
//   DailyTask({this.tasks, this.amount, this.quantity});

//   // From JSON constructor
//   factory DailyTask.fromJson(Map<String, dynamic> json) {
//     return DailyTask(
//       tasks: List<int>.from(json['tasks'] ?? []),
//       amount: json['amount'],
//       quantity: json['quantity'],
//     );
//   }

//   // To JSON method
//   Map<String, dynamic> toJson() {
//     return {
//       'tasks': tasks ?? [],
//       'amount': amount,
//       'quantity': quantity,
//     };
//   }
// }
