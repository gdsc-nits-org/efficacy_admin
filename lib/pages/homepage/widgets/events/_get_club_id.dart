// import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/club/club_model.dart';

List<String?> getClubIDs(List<ClubModel> clubList){
  List<String?> clubIDList = [];
  for (var i = 0; i < clubList.length; i++) {
    clubIDList.add(clubList[i].id);
  }
  return clubIDList;
}
