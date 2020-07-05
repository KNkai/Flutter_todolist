class Todo{
  int id;
  int idCate;
  String detail;
  String dateCreate;
  String dateFakeDate;
  String dateRealDate;
  int isDone;

  Todo({this.id, this.idCate, this.detail, this.dateCreate, this.dateFakeDate, this.dateRealDate, this.isDone});
  
  todoMap(){
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['idcate'] = idCate;
    map['detail'] = detail;
    map['date_create'] = dateCreate;
    map['date_fake_finish'] = dateFakeDate;
    map['date_real_finish'] = dateRealDate;
    map['isdone'] = isDone;

    return map;
  }
}