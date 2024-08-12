import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:islam/components/colors.dart';

class AzkarDetails extends StatefulWidget {
  const AzkarDetails({super.key, required this.item});
  final Map<String, dynamic> item;

  @override
  State<AzkarDetails> createState() => _AzkarDetailsState();
}

class _AzkarDetailsState extends State<AzkarDetails> {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          backgroundColor: gold,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Iconsax.arrow_right),
          ),
          title: Text('${widget.item['category']}',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Janna'
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.separated(
              itemBuilder: (context,index){
                return Card(
                  color: gold,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Expanded(
                      child: Text('${widget.item['array'][index]['text']}',
                        //maxLines: 3,
                        style: TextStyle(
                            fontFamily: 'Janna',
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context,index)=>SizedBox(height: 10,),
              itemCount: widget.item['array'].length
          ),
        ),
      ),
    );
  }
}
