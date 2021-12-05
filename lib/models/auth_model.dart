class AuthModel{
 bool status ;
 String message;
 UserData data;

 AuthModel.fromJson(Map<String ,dynamic>json,){
   this.status=json['status'];
   this.message=json['message'];
   this.data=json['data'] != null ? UserData.fromJson(json['data'])  : null;

 }
}
class UserData{
 int id;
 String name ;
 String email;
 String phone;
 String image;
 int points;
 int cerdit;
 String token;

UserData.fromJson(Map<String,dynamic>json){
  this.id=json['id'];
  this.name=json['name'];
  this.email=json['email'];
  this.phone=json['phone'];
  this.image=json['image'];
  this.points=json['points'];
  this.cerdit=json['cerdit'];
  this.token=json['token'];
  
}
}