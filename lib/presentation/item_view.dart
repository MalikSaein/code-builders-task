import 'package:cached_network_image/cached_network_image.dart';
import 'package:cbtask/models/meme_model.dart';
import 'package:flutter/material.dart';

class ItemView extends StatelessWidget {
  final MemeModel meme;

  const ItemView({required this.meme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: .5)),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: meme.url!,
            height: 50,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meme.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text('Height : ${meme.height!.toString()}'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Width : ${meme.width!.toString()}'),
                  ],
                ),
                Text('Box Count : ${meme.boxCount!.toString()}'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
