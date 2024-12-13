class Massage {
  String massage;
  String id;
  Massage({
    required this.massage,
    required this.id,

  });

  factory Massage.fromjson(json) {
    return Massage(
      massage: json['message'],
      id : json['id'],
    );
  }
}
