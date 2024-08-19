// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthState with ChangeNotifier {
//   String _userType = '';
//   String _employeeCode = '';
//   String _employeeName = '';
//   String _accessType = '';
//   String _validFrom = '';
//   String _validTo = '';
//   String _status = '';
//   String _region = '';
//   String _placeCode = '';
//   String _companyCode = '';
//   String _companyName = '';
//   String _plantCode = '';

//   String get userType => _userType;
//   String get employeeCode => _employeeCode;
//   String get employeeName => _employeeName;
//   String get accessType => _accessType;
//   String get validFrom => _validFrom;
//   String get validTo => _validTo;
//   String get status => _status;
//   String get region => _region;
//   String get placeCode => _placeCode;
//   String get companyCode => _companyCode;
//   String get companyName => _companyName;
//   String get plantCode => _plantCode;

//   Future<void> setToken(
//     String newUserType,
//     String newEmployeeCode,
//     String newEmployeeName,
//     String newAccessType,
//     String newValidFrom,
//     String newValidTo,
//     String newStatus,
//     String newRegion,
//     String newPlaceCode,
//     String newCompanyCode,
//     String newCompanyName,
//     String newPlantCode,
//   ) async {
//     _userType = newUserType;
//     _employeeCode = newEmployeeCode;
//     _employeeName = newEmployeeName;
//     _accessType = newAccessType;
//     _validFrom = newValidFrom;
//     _validTo = newValidTo;
//     _status = newStatus;
//     _region = newRegion;
//     _placeCode = newPlaceCode;
//     _companyCode = newCompanyCode;
//     _companyName = newCompanyName;
//     _plantCode = newPlantCode;

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('userType', _userType);
//     await prefs.setString('employeeCode', _employeeCode);
//     await prefs.setString('employeeName', _employeeName);
//     await prefs.setString('accessType', _accessType);
//     await prefs.setString('validFrom', _validFrom);
//     await prefs.setString('validTo', _validTo);
//     await prefs.setString('status', _status);
//     await prefs.setString('region', _region);
//     await prefs.setString('placeCode', _placeCode);
//     await prefs.setString('companyCode', _companyCode);
//     await prefs.setString('companyName', _companyName);
//     await prefs.setString('plantCode', _plantCode);

//     print('User Type saved: $_userType');
//     print('Emp Code saved: $_employeeCode');
//     print('Emp Name saved: $_employeeName');
//     print('Emp Access Type saved: $_accessType');
//     print('Emp Valid From saved: $_validFrom');
//     print('Emp Valid TO saved: $_validTo');
//     print('Emp Status saved: $_status');
//     print('Region saved: $_region');
//     print('Place Code saved: $_placeCode');
//     print('Company Code saved: $_companyCode');
//     print('Company Code Name saved: $_companyName');
//     print('Plant Code saved: $_plantCode');

//     notifyListeners();
//   }

//   Future<String?> getUserType() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('userType');
//   }

//   Future<String?> getEmployeeCode() async {
//     print('Emp Status saved: $_employeeCode');
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('employeeCode');
//   }

//   Future<String?> getEmployeeName() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('employeeName');
//   }

//   Future<String?> getAccessType() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('accessType');
//   }

//   Future<String?> getValidFrom() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('validFrom');
//   }

//   Future<String?> getValidTo() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('validTo');
//   }

//   Future<String?> getStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('status');
//   }

//   Future<String?> getRegion() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('region');
//   }

//   Future<String?> getPlaceCode() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('placeCode');
//   }

//   Future<String?> getCompanyCode() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('companyCode');
//   }

//   //plant code
//   Future<String?> getPlantCode() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('plantCode');
//   }

//   Future<void> clearToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('userType');
//     await prefs.remove('employeeCode');
//     await prefs.remove('employeeName');
//     await prefs.remove('accessType');
//     await prefs.remove('validFrom');
//     await prefs.remove('validTo');
//     await prefs.remove('status');
//     await prefs.remove('region');
//     await prefs.remove('placeCode');
//     await prefs.remove('companyCode');
//     await prefs.remove('companyName');
//     await prefs.remove('plantCode');

//     // Notify listeners after clearing data
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/helpers/utils/dioservice/dio_service.dart';

class AuthState with ChangeNotifier {
  String _workplaceCode = '';
  String _hrEmployeeCode = '';
  String _employeeName = '';
  String _fatherName = '';
  String _designation = '';
  String _dateOfJoining = '';
  String _headquarter = '';
  String _mobileNumber = '';
  String _email = '';
  String _company = '';
  String _dateOfLeaving = '';
  String _staffType = '';
  String _deviceToken = '';

  String get workplaceCode => _workplaceCode;
  String get hrEmployeeCode => _hrEmployeeCode;
  String get employeeName => _employeeName;
  String get fatherName => _fatherName;
  String get designation => _designation;
  String get dateOfJoining => _dateOfJoining;
  String get headquarter => _headquarter;
  String get mobileNumber => _mobileNumber;
  String get email => _email;
  String get company => _company;
  String get dateOfLeaving => _dateOfLeaving;
  String get staffType => _staffType;
  String get deviceToken => _deviceToken;

  Future<void> setToken(
    String newWorkplaceCode,
    String newHrEmployeeCode,
    String newEmployeeName,
    String newFatherName,
    String newDesignation,
    String newDateOfJoining,
    String newHeadquarter,
    String newMobileNumber,
    String newEmail,
    String newCompany,
    String newDateOfLeaving,
    String newStaffType,
    String newDeviceToken,
  ) async {
    _workplaceCode = newWorkplaceCode;
    _hrEmployeeCode = newHrEmployeeCode;
    _employeeName = newEmployeeName;
    _fatherName = newFatherName;
    _designation = newDesignation;
    _dateOfJoining = newDateOfJoining;
    _headquarter = newHeadquarter;
    _mobileNumber = newMobileNumber;
    _email = newEmail;
    _company = newCompany;
    _dateOfLeaving = newDateOfLeaving;
    _staffType = newStaffType;
    _deviceToken = newDeviceToken;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('workplaceCode', _workplaceCode);
    await prefs.setString('hrEmployeeCode', _hrEmployeeCode);
    await prefs.setString('employeeName', _employeeName);
    await prefs.setString('fatherName', _fatherName);
    await prefs.setString('designation', _designation);
    await prefs.setString('dateOfJoining', _dateOfJoining);
    await prefs.setString('headquarter', _headquarter);
    await prefs.setString('mobileNumber', _mobileNumber);
    await prefs.setString('email', _email);
    await prefs.setString('company', _company);
    await prefs.setString('dateOfLeaving', _dateOfLeaving);
    await prefs.setString('staffType', _staffType);
    await prefs.setString('deviceToken', _deviceToken);

    print('Workplace Code saved: $_workplaceCode');
    print('HR Employee Code saved: $_hrEmployeeCode');
    print('Employee Name saved: $_employeeName');
    print('Father Name saved: $_fatherName');
    print('Designation saved: $_designation');
    print('Date of Joining saved: $_dateOfJoining');
    print('Headquarter saved: $_headquarter');
    print('Mobile Number saved: $_mobileNumber');
    print('Email saved: $_email');
    print('Company saved: $_company');
    print('Date of Leaving saved: $_dateOfLeaving');
    print('Staff Type saved: $_staffType');
    print('Device Token saved: $_deviceToken');

    notifyListeners();
  }

  Future<String?> getWorkplaceCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('workplaceCode');
  }

  Future<String?> getHrEmployeeCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('hrEmployeeCode');
  }

  Future<String?> getEmployeeName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('employeeName');
  }

  Future<String?> getFatherName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('fatherName');
  }

  Future<String?> getDesignation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('designation');
  }

  Future<String?> getDateOfJoining() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('dateOfJoining');
  }

  Future<String?> getHeadquarter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('headquarter');
  }

  Future<String?> getMobileNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mobileNumber');
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<String?> getCompany() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('company');
  }

  Future<String?> getDateOfLeaving() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('dateOfLeaving');
  }

  Future<String?> getStaffType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('staffType');
  }

  Future<String?> getDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('deviceToken');
  }

  void setDeviceTokenInDio(DioService dioService) {
    if (_deviceToken.isNotEmpty) {
      dioService.setDeviceToken(_deviceToken);
    }
  }

  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('workplaceCode');
    await prefs.remove('hrEmployeeCode');
    await prefs.remove('employeeName');
    await prefs.remove('fatherName');
    await prefs.remove('designation');
    await prefs.remove('dateOfJoining');
    await prefs.remove('headquarter');
    await prefs.remove('mobileNumber');
    await prefs.remove('email');
    await prefs.remove('company');
    await prefs.remove('dateOfLeaving');
    await prefs.remove('staffType');
    await prefs.remove('deviceToken');

    // Notify listeners after clearing data
    notifyListeners();
  }
}
