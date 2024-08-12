import 'package:flutter/material.dart';
import 'package:islam/components/cache_helper.dart';
import 'package:islam/components/colors.dart';
import 'package:islam/components/constants.dart';
import 'package:islam/models/tasbeeh_model.dart';

class Bearish extends StatefulWidget {
  const Bearish({super.key});

  @override
  State<Bearish> createState() => _BearishState();
}

class _BearishState extends State<Bearish> {

  List<TasbeehModel> tasbeehModel = [
    TasbeehModel(
      name: 'سبحان الله',
      tasbeehPeriod: 33,
      totalCount: 0,
    ),
    TasbeehModel(
      name: 'الحمد لله',
      tasbeehPeriod: 33,
      totalCount: 0,
    ),
    TasbeehModel(
      name: 'لا إله إلا الله',
      tasbeehPeriod: 33,
      totalCount: 0,
    ),
    TasbeehModel(
      name: 'الله أكبر',
      tasbeehPeriod: 33,
      totalCount: 0,
    ),
    TasbeehModel(
      name: 'سبحان الله والحمد لله ولا إاله إلا الله والله أكبر',
      tasbeehPeriod: 33,
      totalCount: 0,
    ),
    TasbeehModel(
      name: 'سبحان الله وبحمده',
      tasbeehPeriod: 33,
      totalCount: 0,
    ),
    TasbeehModel(
      name: 'سبحان الله وبحمده سبحان الله العظيم',
      tasbeehPeriod: 33,
      totalCount: 0,
    ),
    TasbeehModel(
      name: 'استغفر الله',
      tasbeehPeriod: 33,
      totalCount: 0,
    ),
    TasbeehModel(
      name: 'حسبي الله ونعم الوكيل',
      tasbeehPeriod: 33,
      totalCount: 0,
    ),
    TasbeehModel(
      name: 'لا إله إلا الله سبحانك إني كنت من الظالمين',
      tasbeehPeriod: 33,
      totalCount: 0,
    ),
    TasbeehModel(
      name: 'اللهم صلي علي سيدنا محمد',
      tasbeehPeriod: 33,
      totalCount: 0,
    ),
    TasbeehModel(
      name: 'لا إاله إلا الله وحده لا شريك له وله الحمد وهو علي كل شئ قدير',
      tasbeehPeriod: 33,
      totalCount: 0,
    ),
    TasbeehModel(
      name: 'لا حول ولا قوة إلا بالله',
      tasbeehPeriod: 33,
      totalCount: 0,
    ),
  ];
  void incrementCounter(int index){
    setState(() {
      tasbeehModel[index].totalCount++;
    });
    saveData(index);
  }

  saveData(int index){
    key = 'tasbeeh_${index}_count';
    CacheHelper.saveData(key: key!, value: tasbeehModel[index].totalCount);
  }


  @override @override
  void initState() {
    loadData();
    super.initState();
  }
  loadData(){
    setState(() {
      for(int i = 0;i< tasbeehModel.length;i++){
        key = 'tasbeeh_${i}_count';
        int? count = CacheHelper.getData(key:key!);
        if(count != null)
        {
          tasbeehModel[i].totalCount = count;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        title: Text('المسبحة',
          style: TextStyle(
            fontFamily: 'Janna',
            fontSize: 22,
            color: white
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: gold
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('وَالذَّاكِرِينَ اللَّهَ كَثِيرًا وَالذَّاكِرَاتِ أَعَدَّ اللَّهُ لَهُم مَّغْفِرَةً وَأَجْرًا عَظِيمًا',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Janna',
                  fontSize: 20,
                  color: black
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                itemBuilder: (context,index)=>Container(
                  decoration: BoxDecoration(
                    color: gold,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tasbeehModel[index].name,
                                style: TextStyle(
                                    fontFamily: 'Janna',
                                    fontSize: 20
                                ),
                              ),
                              Text('عدد التسبيح: ${tasbeehModel[index].totalCount}',
                                style: TextStyle(
                                    fontFamily: 'Janna',
                                    fontSize: 20,
                                    color: grey
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: (){incrementCounter(index);},
                            child: Text('سبح',
                              style: TextStyle(
                                color: gold,
                                fontFamily: 'Janna',
                                fontSize: 20
                              ),
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context,index)=> SizedBox(height: 10,),
                itemCount: tasbeehModel.length
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class TasbeehWidget extends StatelessWidget {
  final TasbeehModel tasbeehModel;
  const TasbeehWidget({super.key, required this.tasbeehModel,});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: gold,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text('دورة التسبيح: ${tasbeehModel.tasbeehPeriod}',
              style: TextStyle(
                fontFamily: 'Janna',
                fontSize: 20,
                color: grey
              ),
            ),
          ],
        ),
      ),
    );
  }
}


