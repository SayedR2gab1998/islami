import 'package:flutter/material.dart';
import 'package:islam/components/colors.dart';


void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    // save the last route or note
        (route) => false); // remove all last route

Widget defaultTextFormField({
  required TextEditingController controller,
  required String? Function(String? value) validator,
  required TextInputType inputType,
  required String label,
  required String prefix,
  IconData? suffix,
  Function()? onSuffixPressed,
  Function()? onTap,
  Function(String s)? onSubmit,
  Function(String v)? onChanged,
  bool isPassword = false,
  TextCapitalization textCapitalization = TextCapitalization.none,
  required BuildContext context,
}) =>
    Center(
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        obscureText: isPassword,
        onTap: onTap,
        onFieldSubmitted: onSubmit,
        textCapitalization: textCapitalization,
        style: TextStyle(
          color: white,
            fontFamily: 'Janna'
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black.withOpacity(0.5),
          labelStyle: TextStyle(
              color: white,
            fontFamily: 'Janna'
          ),
          labelText: label,
          prefixIcon: ImageIcon(AssetImage(prefix)
            ,color: gold,
          ),
          suffixIcon: IconButton(icon: Icon(suffix), onPressed: onSuffixPressed,color: gold,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: gold),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: gold),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: gold),
          ),
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );

Widget defaultButton({
  double width = double.infinity, // give it default width but can edit later
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 5.0,
  required String text,
  required Function()? onPressed,
}) =>
    Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: gold,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'Janna'
          ),
        ),
      ),
    );

Widget defaultTextButton(
    {required Function() function, required String text}) =>
    TextButton(
      onPressed: function,
      child: Text(text,
        style: const  TextStyle(
            fontSize: 16,
            color:  gold,
            fontFamily: 'Janna'
        ),
      ),
    );


Widget buildContainers({required String image, required String text,required Function() onTap}){
  return GestureDetector(
    onTap: (){
      onTap();
    },
    child: Container(
      decoration: BoxDecoration(
        color: gold,
        border: Border.all(color: gold),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Expanded(child: Image.asset(image,width: 150,)),
            Text(text,
              style: TextStyle(
                  fontFamily: 'Janna',
                  fontSize: 24,
                  color: black
              ),
            ),
          ],
        ),
      ),
    ),
  );
}