import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photodiary/assistant_method.dart';
import 'package:photodiary/widgets/dropdown_widget.dart';
import 'package:photodiary/widgets/text_input.dart';

import '../bloc/product_bloc.dart';



class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  bool isChecked = false;
  final TextEditingController commentController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  final List<String> dropList = ["LocA","LocB", "LocC", "LocD"];
  final List<String> dropListDate = ["2020-06-29","2020-06-30", "2020-06-01", "2020-06-02"];
  final List<String> dropListArea = ["Select Area","Select AreaA", "Select Areab", "Select AreaC"];
  final List<String> dropListTask = ["Task Category","Task CategoryA", "Task CategoryB", "Task CategoryC"];
  final List<String> dropListEvent = ["Select an event","Select an eventA", "Select an eventB", "Select an eventC"];
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    List<XFile>? imagess;

    final AssistantMethod assistantMethod = AssistantMethod();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: (){

          },
          icon: Icon(Icons.cancel, color: Colors.white,),
        ),
        title: Text("New Diary"),
        backgroundColor: Colors.black,

      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Color.fromRGBO(238, 243, 243, 1.0),
          child: Column(

            children: [
              Container(
                height: 60,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 5,),
                      Text("20041075| TAP-NS-North Strathfield")
                    ],
                  ),
                ),
              ),
              Container(

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Container(

                              child: Text("Add to site diary", style: TextStyle(fontSize: 25, fontWeight:FontWeight.bold),)),
                          Container(
                            margin:EdgeInsets.only(right: 15),
                            child: Container(

                                child: Icon(Icons.question_mark, color: Colors.white,size: 20,),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                               borderRadius: BorderRadius.circular(20)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(

                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 9,
                            color: Color.fromRGBO(140, 140, 140, 1.0),
                            offset: Offset(2, 5),
                          )
                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                            child: Text("Add Photos to site diary",style: TextStyle(fontSize: 15, fontWeight:FontWeight.w800),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Divider(color: Colors.grey.withAlpha(50), thickness: 1,),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: BlocBuilder<ProductBloc, ProductState>(
                                builder: (context, state) => state.images != null
                                    ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    itemCount: state.images!.length,
                                    itemBuilder: (_, i) => Stack(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 120,
                                          margin: EdgeInsets.only(left: 3.0, right: 3.0),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: FileImage(File(state.images![i].path)),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        Positioned(
                                          right: 2,
                                            child: IconButton(onPressed: (){

                                            }, icon: Icon(Icons.cancel))),

                                      ],
                                    )
                                    )
                                    : Icon(
                                  Icons.photo_camera,
                                  size: 80,
                                  color: Colors.grey,
                                )),

                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),

                            width: double.infinity,
                            height: 70,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(164, 210, 64, 1.0),
                                  shadowColor: Colors.grey,

                                ),
                                onPressed: ()async{
                                  final ImagePicker _picker = ImagePicker();

                                 final List<XFile>? images = await _picker.pickMultiImage();
                                  if (images != null) {
                                    productBloc.add(onSelectMultipleImageEvent(images));
                                  }

                                  setState(() {
                                    imagess = images;
                                  });


                                },
                                child: Text("Add a Photo")
                            ),


                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text("Include in photo gallery"),
                              ),
                              Checkbox(
                                checkColor: Color.fromRGBO(107, 255, 84, 1.0),
                                value: isChecked,
                              onChanged: (isChanged){
                               setState(() {
                                 isChecked = isChanged!;
                               });
                              },
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children:  [
                    Container(
                      
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 10,right:10, top: 20, bottom: 30),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 9,
                              color: Color.fromRGBO(140, 140, 140, 1.0),
                              offset: Offset(2, 5),
                            )
                          ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                            child: Text("Comments",style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Divider(color: Colors.grey, thickness: 1,),
                          ),
                          Container(),
                          TextInput(
                            textEditingController: commentController,
                            hint: "Comments",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children:  [
                    Container(

                      width: double.infinity,
                      padding: EdgeInsets.only(left: 10,right:10, top: 20, bottom: 30),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 9,
                              color: Color.fromRGBO(140, 140, 140, 1.0),
                              offset: Offset(2, 5),
                            )
                          ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                            child: Text("Details",style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Divider(color: Colors.grey, thickness: 1,),
                          ),
                          DropDownText(dropList: dropListDate),
                          DropDownText(dropList: dropListArea),
                          DropDownText(dropList: dropListTask),
                          TextInput(
                            textEditingController: tagController,
                            hint: "Tags",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children:  [
                    Container(


                      width: double.infinity,
                      padding: EdgeInsets.only(left: 10,right:10, top: 20, bottom: 30),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(

                              blurRadius: 9,
                              color: Color.fromRGBO(140, 140, 140, 1.0),
                              offset: Offset(2, 5),
                            )
                          ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                               child: Text("Link to existing Event?",style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold),),
                             ),
                             Checkbox(value: isChecked,
                               onChanged: (isChanged){
                                 setState(() {
                                   isChecked = isChanged!;
                                 });
                               },
                             )
                           ],
                         ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Divider(color: Colors.grey.withAlpha(50), thickness: 1,),
                          ),
                          Container(),
                          DropDownText(dropList: dropListEvent),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(

                padding: EdgeInsets.symmetric(horizontal: 10),

                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(164, 210, 64, 1.0),
                      shadowColor: Colors.grey,

                    ),
                    onPressed: (){

                      assistantMethod.uploadImage("images", imagess);
                    },
                    child: Text("Next")
                ),


              ),
            ],
          ),
        ),
      ),
    );
  }
}

