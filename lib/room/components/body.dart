import 'package:asset_management/room/components/create.dart';
import 'package:asset_management/taisan/taisan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff244a74),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Nhập tên phòng...',
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Color(0xff072a52),
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.black38,
                ),
                child: IconButton(
                  iconSize: 42,
                  color: Colors.white38,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateRoom()),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TaiSan(title: 'Phòng 01')),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 100,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        color: Color(0xff12355b),
                        borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Phòng 01',
                            style: TextStyle(fontSize: 30,color:Color(0xff6c8bad),fontWeight: FontWeight.bold),
                          ),
                          Divider(height: 6,),
                          Text(
                            '20 tài sản', style: TextStyle(color:Color(0xff6c8198)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TaiSan(title: 'Phòng 02')),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 100,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        color: Color(0xff12355b),
                        borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Phòng 02',
                            style: TextStyle(fontSize: 30,color:Color(0xff6c8bad),fontWeight: FontWeight.bold),
                          ),
                          Divider(height: 6,),
                          Text(
                            '20 tài sản',style: TextStyle(color:Color(0xff6c8198)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TaiSan(title: 'Phòng 03')),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 100,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        color: Color(0xff12355b),
                        borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Phòng 03',
                            style: TextStyle(fontSize: 30,color:Color(0xff6c8bad),fontWeight: FontWeight.bold),
                          ),
                          Divider(height: 6,),
                          Text(
                            '20 tài sản',style: TextStyle(color:Color(0xff6c8198)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 100,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Color(0xff12355b),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Phòng 04',
                          style: TextStyle(fontSize: 30,color:Color(0xff6c8bad),fontWeight: FontWeight.bold),
                        ),
                        Divider(height: 6,),
                        Text(
                          '20 tài sản',style: TextStyle(color:Color(0xff6c8198)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
