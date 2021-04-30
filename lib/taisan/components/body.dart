import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'create.dart';
import 'detail.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:20,left: 20,right: 20),
      color: Color(0xff96ccd4),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Nhập mã tài sản...',
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.black12,
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
                      MaterialPageRoute(builder: (context) => Create()),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Detail()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 100,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        color: Color(0xffd1fdfe),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Máy in tiền',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.room),
                                Text('Phòng 01')
                              ],
                            ),
                            Row(
                              children: [
                                Text('Số Serial: '),
                                Text('01010110101010110101'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Ngày sử dụng: '),
                                Text('01/01/1999'),
                              ],
                            ),
                          ],
                        ),
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
                      color: Color(0xffd1fdfe),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Máy lạnh',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.room),
                              Text('Phòng 01')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Số Serial: '),
                              Text('01010110101010110101'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ngày sử dụng: '),
                              Text('01/01/1999'),
                            ],
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
                      color: Color(0xffd1fdfe),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Máy giặt',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.room),
                              Text('Phòng 01')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Số Serial: '),
                              Text('01010110101010110101'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ngày sử dụng: '),
                              Text('01/01/1999'),
                            ],
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
                      color: Color(0xffd1fdfe),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Máy in',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.room),
                              Text('Phòng 01')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Số Serial: '),
                              Text('01010110101010110101'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ngày sử dụng: '),
                              Text('01/01/1999'),
                            ],
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
                      color: Color(0xffd1fdfe),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Máy in',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.room),
                              Text('Phòng 01')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Số Serial: '),
                              Text('01010110101010110101'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ngày sử dụng: '),
                              Text('01/01/1999'),
                            ],
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
                      color: Color(0xffd1fdfe),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Máy in',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.room),
                              Text('Phòng 01')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Số Serial: '),
                              Text('01010110101010110101'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ngày sử dụng: '),
                              Text('01/01/1999'),
                            ],
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
                      color: Color(0xffd1fdfe),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Máy in',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.room),
                              Text('Phòng 01')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Số Serial: '),
                              Text('01010110101010110101'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ngày sử dụng: '),
                              Text('01/01/1999'),
                            ],
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
                      color: Color(0xffd1fdfe),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Máy in',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.room),
                              Text('Phòng 01')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Số Serial: '),
                              Text('01010110101010110101'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ngày sử dụng: '),
                              Text('01/01/1999'),
                            ],
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
                      color: Color(0xffd1fdfe),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Máy in',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.room),
                              Text('Phòng 01')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Số Serial: '),
                              Text('01010110101010110101'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ngày sử dụng: '),
                              Text('01/01/1999'),
                            ],
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
                      color: Color(0xffd1fdfe),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Máy in',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.room),
                              Text('Phòng 01')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Số Serial: '),
                              Text('01010110101010110101'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ngày sử dụng: '),
                              Text('01/01/1999'),
                            ],
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
                      color: Color(0xffd1fdfe),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Máy in',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.room),
                              Text('Phòng 01')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Số Serial: '),
                              Text('01010110101010110101'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ngày sử dụng: '),
                              Text('01/01/1999'),
                            ],
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
                      color: Color(0xffd1fdfe),
                      borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Máy in',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.room),
                              Text('Phòng 01')
                            ],
                          ),
                          Row(
                            children: [
                              Text('Số Serial: '),
                              Text('01010110101010110101'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ngày sử dụng: '),
                              Text('01/01/1999'),
                            ],
                          ),
                        ],
                      ),
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
