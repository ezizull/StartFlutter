import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Modul extends StatelessWidget {
  final String title;
  final String about;
  final String grade;
  final bool present;

  const Modul({
    required this.title,
    required this.about,
    required this.grade,
    required this.present,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 230,
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.only(bottom: 20),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Modul $title",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            about,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 35,
                width: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Grade: $grade',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 14,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: grade == 'A' || grade == 'B' || grade == 'C'
                        ? HexColor('81D070')
                        : HexColor('E46163'),
                    borderRadius: BorderRadius.circular(20)),
              ),
              Container(
                height: 35,
                width: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      present ? 'Present' : 'Not yet',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: present ? HexColor('81D070') : HexColor('cccccc'),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ],
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            child: Text(
              present ? 'View Attachment' : 'Upload Attachment',
              style: TextStyle(
                  color: present ? HexColor('ff7020') : Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            decoration: BoxDecoration(
                color: present ? HexColor('efefef') : HexColor('ff7020'),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: present ? HexColor('ff7020') : Colors.transparent,
                  width: present ? 1.5 : 0,
                )),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: HexColor('ffffff'),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: HexColor('cccccc').withOpacity(0.6),
            blurRadius: 6,
            spreadRadius: 0.001,
          )
        ],
      ),
    );
  }
}
