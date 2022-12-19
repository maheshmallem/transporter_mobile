class HomeOptionsModel {
  int id;
  String name;
  String url;
  String desc;
  HomeOptionsModel(
      {required this.id,
      required this.name,
      required this.url,
      this.desc = ''});
}
