// Employee Model
class Employee {
  final String empCode;
  final String empName;

  Employee({
    required this.empCode,
    required this.empName,
  });
}
// Dummy Employees
final List<Employee> employeesList = [
  Employee(empCode: "E123", empName: "John Doe"),
  Employee(empCode: "E124", empName: "Jane Smith"),
  Employee(empCode: "E125", empName: "Alice Johnson"),
];