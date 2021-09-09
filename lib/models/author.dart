class Author{

  String id;
  String name;
  String email;
  String avatar;
   String phone;
  Author(this.phone,this.id, this.name, this.email);


  factory Author.fromJson(Map<String, dynamic> json) 
  => Author(json['phone'].toString(),json['id'].toString(),json['name'].toString(),
    json['email'].toString(),
    );
}