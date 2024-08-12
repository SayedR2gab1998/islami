class TasbeehModel{
  String name;
  int totalCount;
  int tasbeehPeriod;

  TasbeehModel({required this.name, required this.tasbeehPeriod,required this.totalCount});

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'totalCount':totalCount,
      'tasbeehPeriod':tasbeehPeriod,
    };
  }

  factory TasbeehModel.fromMap(Map<String,dynamic>map){
    return TasbeehModel(
      name: map['name'],
      totalCount:map['totalCount'],
      tasbeehPeriod: map['tasbeehPeriod'],
    );
  }
}