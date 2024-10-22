import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_making_app/model.dart';
import 'package:food_making_app/recipe_web_view.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class Search extends StatefulWidget {
  String query;
   Search(this.query, {super.key});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading=true;

  TextEditingController searchController=TextEditingController();
  List reciptCatList = [{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"}];
  List<RecipeModal> recipeList=<RecipeModal>[];
  @override
  void initState() {
    super.initState();
    getData(widget.query);
  }
  Future<void> getData(String query) async {
    try {
      String url =
          "https://api.edamam.com/search?q=$query&app_id=c228704c&app_key=a217ee9ea02980250a9805146d0c3101";
      Response response = await http.get(Uri.parse(url));
      Map<String, dynamic> data = jsonDecode(response.body);

      List<RecipeModal> tempList = [];
      data["hits"].forEach((element) {
        RecipeModal recipeModal = RecipeModal.fromMap(element["recipe"]);
        tempList.add(recipeModal);
      });

      setState(() {
        isLoading=false;
        recipeList = tempList;
      });

      for (var recipe in recipeList) {
        log(recipe.appImgUrl);
      }
    } catch (e) {
      log("Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xff213A50),Color(0xff071938)
                      ]
                  )
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                String searchValue = searchController.text
                                    .trim();
                                if (searchValue.isEmpty) {
                                  if (kDebugMode) {
                                    print("Empty search");
                                  }
                                } else {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Search(searchValue)));

                                  debugPrint("click huva $searchValue");
                                }
                              },
                              child: const Icon(
                                Icons.search,
                                color: Colors.blue,
                              )),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: const InputDecoration(
                                hintText: "Let' Cooking Something New!" ,
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: isLoading? const Center(
                      child: SpinKitWaveSpinner(
                        color: Colors.green,
                        size: 50,
                      ),
                    )
                        :ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recipeList.length,
                        itemBuilder: (context,index)
                        {
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RecipeWebView(recipeList[index].appUrl)));
                            },
                            child:Card(
                              margin: const EdgeInsets.all(16),
                              shadowColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              elevation: 0.5,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    child: Image.network(
                                      recipeList[index].appImgUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                  ),
                                  Positioned(
                                      left: 0,
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                          decoration: const BoxDecoration(
                                            color: Colors.black26,
                                          ),
                                          child: Text(recipeList[index].appLabel,style: const TextStyle(color: Colors.white,fontSize: 18),))
                                  ),
                                  Positioned(
                                      right: 0,
                                      height: 40,
                                      width: 80,
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10.0),
                                                  bottomLeft: Radius.circular(10)
                                              )
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.local_fire_department),
                                                Text(recipeList[index].appCalories.toString().substring(0,5)),
                                              ],
                                            ),
                                          ))
                                  )
                                ],
                              ),
                            ) ,
                          );
                        }),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}
