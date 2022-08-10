import 'dart:io';
import 'package:car_app/services/store_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/post_model.dart';
import '../services/rtdb_service.dart';
import '../services/util_service.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);
  static const String id = "detail_page";

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final ImagePicker imagePicker = ImagePicker();

  List<XFile> imageList =[];
  TextEditingController nameController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  bool isLoading = false;
  File? file1;
  File? file2;
  File? file3;
  File? file4;
  void _getImage()async{
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if(selectedImages!.isNotEmpty  && selectedImages.length > 3){
      imageList.addAll(selectedImages);
      file1 = File(selectedImages[0].path);
      file2 = File(selectedImages[1].path);
      file3 = File(selectedImages[2].path);
      file4 = File(selectedImages[3].path);
    }else{
      Utils.fireSnackBar("Please add at least 4 images", context);
      return;
    }


    setState(() {});
  }
  void _addPost() async{

    String name = nameController.text.trim();
    String info = infoController.text.trim();
    String? firstImage;
    String? secondImage;
    String? thirdImage;
    String? fourthImage;


    if(name.isEmpty || info.isEmpty){
      Utils.fireSnackBar("Please fill all gaps", context);
      return;
    }
    isLoading = true;
    setState(() {});

    if(imageList.length >= 3) {
      firstImage = await StorageService.uploadImage(file1!);
      secondImage = await StorageService.uploadImage(file2!);
      thirdImage = await StorageService.uploadImage(file3!);
      fourthImage = await StorageService.uploadImage(file4!);
    }else{
      Utils.fireSnackBar("Please add at least 4 images", context);
      return;
    }
    Post post = Post( name: name, info: info, firstImage : firstImage, secondImage: secondImage, thirdImage: thirdImage, fourthImage: fourthImage);
    await RTDBService.storePost(post).then((value) {
      Navigator.of(context).pop();
    });

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageList.isEmpty ?
                  GestureDetector(
                    onTap: _getImage,
                    child: SizedBox(
                      height: 125,
                      width: 125,
                      child:  const Image(
                        image: NetworkImage("https://i.stack.imgur.com/y9DpT.jpg"), fit: BoxFit.cover,
                      )

              ),
                    ): GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),itemCount: imageList.length, itemBuilder: (BuildContext context, index){
                    return Image.file(File(imageList[index].path), fit: BoxFit.cover,);
                    }
                    ),


                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                    ),
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20,),

                  TextField(
                    controller: infoController,
                    decoration: const InputDecoration(
                      hintText: "Last name",
                    ),
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20,),



                  // #sign_in
                  ElevatedButton(
                    onPressed: _addPost,
                    style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)
                    ),
                    child: const Text("Add", style: TextStyle(fontSize: 16),),
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: isLoading,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }}
