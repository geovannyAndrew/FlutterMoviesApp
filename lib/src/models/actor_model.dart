class Cast{

  List<Actor> actors = List();

  Cast.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    actors = jsonList.map((item){
      return Actor.fromJsonMap(item);
    }).toList();
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String,dynamic> jsonMap){
    this.castId     = jsonMap["cast_id"];
    this.character  = jsonMap["character"];
    this.creditId   = jsonMap["credit_id"];
    this.gender     = jsonMap["gender"];
    this.id         = jsonMap["id"];
    this.name       = jsonMap["name"];
    this.order      = jsonMap["order"];
    this.profilePath= jsonMap["profile_path"];
  }

  String get profilePathUrl{
    if(profilePath == null){
      return 'https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png';
    }
    else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}

