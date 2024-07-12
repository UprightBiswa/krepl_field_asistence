import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState with ChangeNotifier {
  String _userType = '';
  String _employeeCode = '';
  String _employeeName = '';
  String _accessType = '';
  String _validFrom = '';
  String _validTo = '';
  String _status = '';
  String _region = '';
  String _placeCode = '';
  String _companyCode = '';
  String _companyName = '';
  String _plantCode = '';

  String get userType => _userType;
  String get employeeCode => _employeeCode;
  String get employeeName => _employeeName;
  String get accessType => _accessType;
  String get validFrom => _validFrom;
  String get validTo => _validTo;
  String get status => _status;
  String get region => _region;
  String get placeCode => _placeCode;
  String get companyCode => _companyCode;
  String get companyName => _companyName;
  String get plantCode => _plantCode;

  Future<void> setToken(
    String newUserType,
    String newEmployeeCode,
    String newEmployeeName,
    String newAccessType,
    String newValidFrom,
    String newValidTo,
    String newStatus,
    String newRegion,
    String newPlaceCode,
    String newCompanyCode,
    String newCompanyName,
    String newPlantCode,
  ) async {
    _userType = newUserType;
    _employeeCode = newEmployeeCode;
    _employeeName = newEmployeeName;
    _accessType = newAccessType;
    _validFrom = newValidFrom;
    _validTo = newValidTo;
    _status = newStatus;
    _region = newRegion;
    _placeCode = newPlaceCode;
    _companyCode = newCompanyCode;
    _companyName = newCompanyName;
    _plantCode = newPlantCode;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', _userType);
    await prefs.setString('employeeCode', _employeeCode);
    await prefs.setString('employeeName', _employeeName);
    await prefs.setString('accessType', _accessType);
    await prefs.setString('validFrom', _validFrom);
    await prefs.setString('validTo', _validTo);
    await prefs.setString('status', _status);
    await prefs.setString('region', _region);
    await prefs.setString('placeCode', _placeCode);
    await prefs.setString('companyCode', _companyCode);
    await prefs.setString('companyName', _companyName);
    await prefs.setString('plantCode', _plantCode);

    print('User Type saved: $_userType');
    print('Emp Code saved: $_employeeCode');
    print('Emp Name saved: $_employeeName');
    print('Emp Access Type saved: $_accessType');
    print('Emp Valid From saved: $_validFrom');
    print('Emp Valid TO saved: $_validTo');
    print('Emp Status saved: $_status');
    print('Region saved: $_region');
    print('Place Code saved: $_placeCode');
    print('Company Code saved: $_companyCode');
    print('Company Code Name saved: $_companyName');
    print('Plant Code saved: $_plantCode');

    notifyListeners();
  }

  Future<String?> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userType');
  }

  Future<String?> getEmployeeCode() async {
    print('Emp Status saved: $_employeeCode');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('employeeCode');
  }

  Future<String?> getEmployeeName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('employeeName');
  }

  Future<String?> getAccessType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessType');
  }

  Future<String?> getValidFrom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('validFrom');
  }

  Future<String?> getValidTo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('validTo');
  }

  Future<String?> getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('status');
  }

  Future<String?> getRegion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('region');
  }

  Future<String?> getPlaceCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('placeCode');
  }

  Future<String?> getCompanyCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('companyCode');
  }

  //plant code
  Future<String?> getPlantCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('plantCode');
  }

  

  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userType');
    await prefs.remove('employeeCode');
    await prefs.remove('employeeName');
    await prefs.remove('accessType');
    await prefs.remove('validFrom');
    await prefs.remove('validTo');
    await prefs.remove('status');
    await prefs.remove('region');
    await prefs.remove('placeCode');
    await prefs.remove('companyCode');
    await prefs.remove('companyName');
    await prefs.remove('plantCode');

    // Notify listeners after clearing data
    notifyListeners();
  }
}
