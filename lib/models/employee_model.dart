class EmployeeModel {
  EmployeeModel({
    this.id,
    this.name,
    this.role,
    this.startDate,
    this.endDate,
    this.isPrevious,
  });

  EmployeeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['name'] as String?,
        role = json['role'] as String?,
        startDate = json['startDate'] as String?,
        endDate = json['endDate'] as String?,
        isPrevious = json['isPrevious'] as int?;
  final String? name;
  final String? role;
  final String? startDate;
  final String? endDate;
  final int? isPrevious;
  final String? id;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'startDate': startDate,
        'endDate': endDate,
        'isPrevious': isPrevious,
      };
}
