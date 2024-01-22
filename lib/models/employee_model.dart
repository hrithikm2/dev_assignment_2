class EmployeeModel {
  EmployeeModel({
    this.name,
    this.role,
    this.startDate,
    this.endDate,
    this.isPrevious,
  });

  EmployeeModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        role = json['role'] as String?,
        startDate = json['startDate'] as String?,
        endDate = json['endDate'] as String?,
        isPrevious = json['isPrevious'] as bool?;
  final String? name;
  final String? role;
  final String? startDate;
  final String? endDate;
  final bool? isPrevious;

  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role,
        'startDate': startDate,
        'endDate': endDate,
        'isPrevious': isPrevious,
      };
}
