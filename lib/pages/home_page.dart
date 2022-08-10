import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../services/rtdb_service.dart';
import 'detail_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "home_page";


  // Future<void> _showMyDialog(BuildContext context, int id, String userId, key) async {
  //   TextEditingController titleUpdateController = TextEditingController();
  //   TextEditingController contentUpdateController = TextEditingController();
  //   TextEditingController nameUpdateController = TextEditingController();
  //   TextEditingController lastnameUpdateController = TextEditingController();
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Update'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: nameUpdateController,
  //               decoration: const InputDecoration(
  //                 hintText: "Name",
  //               ),
  //             ),
  //             TextField(
  //               controller: lastnameUpdateController,
  //               decoration: const InputDecoration(
  //                 hintText: "Last name",
  //               ),
  //             ),
  //             TextField(
  //               controller: titleUpdateController,
  //               decoration: const InputDecoration(
  //                 hintText: "Title",
  //               ),
  //             ),
  //             TextField(
  //               controller: contentUpdateController,
  //               decoration: const InputDecoration(
  //                 hintText: "Content",
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: <Widget>[
  //           IconButton(onPressed: (){
  //             Navigator.of(context).pop();
  //           }, icon: const Icon(Icons.cancel_outlined)),
  //           IconButton(onPressed: (){
  //             Post p = Post(userId: userId, id: id, content: contentUpdateController.text, title: titleUpdateController.text, name: nameUpdateController.text, lastName: lastnameUpdateController.text);
  //             RTDBService.updatePost(p, key);
  //             Navigator.of(context).pop();
  //           }, icon: const Icon(Icons.done)),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  const Text("All Post"),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: RTDBService.database.child("post").onValue,
        builder: (context, snapshot){
          List<Post> posts = RTDBService.parseSnapshot(snapshot.data);
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: posts.length,
              itemBuilder: (context, index){
                return itemOfCarList(posts[index], context);
              }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 30,); },);
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: (){
           Navigator.pushNamed(context, DetailPage.id);
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
  // Widget _itemOfList(Post post, key,context, int id, String userid) {
  //   return ListTile(
  //     contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //     title: Text(post.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
  //     subtitle: Text(post.content, style: const TextStyle(fontSize: 18),),
  //     trailing:  Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         GestureDetector(
  //             onTap: ()=> _showMyDialog(context, id, userid, key),
  //             child: Icon(Icons.edit)),
  //         IconButton(
  //           onPressed: (){
  //             RTDBService.deletePost(key);
  //             print(key);
  //           },
  //           icon: const Icon(Icons.delete,),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  // Widget itemOfGrid(Post post, key, context, int id, String userid){
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           width: MediaQuery.of(context).size.width,
  //           height: MediaQuery.of(context).size.width,
  //           child: post.image != null
  //               ? Image.network(post.image!, fit: BoxFit.cover,)
  //               : const Image(
  //             image: NetworkImage("https://i.stack.imgur.com/y9DpT.jpg",),
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         SizedBox(height: 10,),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Text(post.name,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
  //                     const SizedBox(width: 10,),
  //                     Text(post.lastName,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
  //                   ],
  //                 ),
  //                 Text(post.title),
  //                 Text(post.content),
  //               ],
  //             ),
  //             Row(
  //               children: [
  //                 GestureDetector(
  //                     onTap: ()=> _showMyDialog(context, id, userid, key),
  //                     child: const Icon(Icons.edit, color: Colors.grey,)),
  //                 IconButton(
  //                   onPressed: (){
  //                     RTDBService.deletePost(key);
  //                     print(key);
  //                   },
  //                   icon: const Icon(Icons.delete, color: Colors.grey,),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
Widget itemOfCarList(Post post, context){
    return ColoredBox(
      color: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: GridView.count(
              crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Image.network(post.firstImage, fit: BoxFit.cover,),
                  Image.network(post.secondImage!, fit: BoxFit.cover),
                  Image.network(post.thirdImage!, fit: BoxFit.cover),
                  Image.network(post.fourthImage!, fit: BoxFit.cover),
                ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(post.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              const SizedBox(height: 5,),
              Text(post.info),
            ],
          ),

        ],
      ),
    );
}
}


