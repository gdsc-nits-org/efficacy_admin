import 'dart:convert';

import 'package:efficacy_admin/controllers/utils/comparator.dart';
import 'package:efficacy_admin/models/institution/institution_model.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'functions/_save_impl.dart';
part 'functions/_create_impl.dart';
part 'functions/_check_duplicate_impl.dart';
part 'functions/_get_impl.dart';
part 'functions/_update_impl.dart';
part 'functions/_delete_impl.dart';
part 'functions/_delete_local_impl.dart';
part 'functions/_get_all_institutions_impl.dart';

class InstitutionController {
  const InstitutionController._();
  static const String _collectionName = "institutions";

  static Future<InstitutionModel> _save(InstitutionModel institution) async {
    return await _saveImpl(institution);
  }

  static Future<void> _checkDuplicate(InstitutionModel institution) async {
    return await _checkDuplicateImpl(institution);
  }

  static Future<InstitutionModel?> create(InstitutionModel institution) async {
    return await _createImpl(institution);
  }

  static Stream<InstitutionModel?> get({
    required String id,
    bool forceGet = false,
  }) {
    return _getImpl(id: id, forceGet: forceGet);
  }

  static Future<InstitutionModel> update(InstitutionModel institution) async {
    return await _updateImpl(institution);
  }

  static Future<void> delete({String? id, String? name}) async {
    return await _deleteImpl(id: id, name: name);
  }

  static Future<void> _deleteLocal(String id) async {
    return await _deleteLocalImpl(id);
  }

  static Future<List<InstitutionModel>> getAllInstitutions() async {
    return await _getAllInstitutionsImpl();
  }
}
