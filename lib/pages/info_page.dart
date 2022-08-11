import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';

class InfoPage extends StatelessWidget {
  Post post;
  InfoPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:  Container(
                        width: MediaQuery.of(context).size.width-100,
                        height: MediaQuery.of(context).size.width-100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CachedNetworkImage(imageUrl: post.firstImage, fit: BoxFit.cover,),
                      ),),
                  const SizedBox(width: 10,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:  Container(
                      width: MediaQuery.of(context).size.width-50,
                      height: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CachedNetworkImage(imageUrl: post.secondImage!, fit: BoxFit.cover,),
                    ),),
                  const SizedBox(width: 10,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:  Container(
                      width: MediaQuery.of(context).size.width-50,
                      height: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CachedNetworkImage(imageUrl: post.thirdImage!, fit: BoxFit.cover,),
                    ),),
                  const SizedBox(width: 10,),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:  Container(
                      width: MediaQuery.of(context).size.width-50,
                      height: MediaQuery.of(context).size.width-50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CachedNetworkImage(imageUrl: post.fourthImage!, fit: BoxFit.cover,),
                    ),),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Container()),
          ],
        ),
    );
  }
}

