class Category{
  int id;
  String title;
  String description;

  Category({this.id, this.title, this.description});

  categoryMap(){
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;

    return map;
  }
}