import 'package:flutter/material.dart';

class FavoritePostRoute extends StatelessWidget {
  
  final List favoritePost;

  const FavoritePostRoute({Key? key, required this.favoritePost})
      : super(key: key);
//favoritePost[index]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              )),
        ),
      ),
        body: ListView.separated(
            itemCount: favoritePost.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              //bool isSaved = savedPost.contains(favoritePost[index]);
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          //image
                           SizedBox(
                          width: 67,
                          height: 64,
                          child: Image.network(
                                  favoritePost[index]["image"],
                                  errorBuilder: (context, error, stackTrace) {
                                  return Container();
                                  },
                                  fit: BoxFit.fill,
                                  ),
                        ),

                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                favoritePost[index]["title"],
                                style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                              ),
                              // ignore: avoid_unnecessary_containers
                              Text(
                                    favoritePost[index]["author"],
                                    style: const TextStyle(fontSize: 15),
                                  ),
                              Text(
                                favoritePost[index]["description"],
                              style: const TextStyle(fontSize: 15),)
                            ],
                          ),
                          ),
                        ),
                          // ignore: avoid_unnecessary_containers
                          // Container(
                          //   child: Row(
                          //     children: [
                          //       IconButton(
                          //           iconSize: 30,
                          //           onPressed: () {
                          //             //ListPost.removeAt(index);
                          //             setState(() {
                          //               favoritePost.indexOf(favoritePost[index]);
                          //               favoritePost.removeAt(index);
                          //             });
                          //           },
                          //           icon: const Icon(Icons.delete)),
                          //       IconButton(
                          //           //isSaved ? Icons.favorite : Icons.favorite_border,
                          //           //color: favoritePost[index] ? Colors.red : Colors.black,
                          //           color: Colors.pink,
                          //           iconSize: 30,
                          //           onPressed: () {
                          //             setState(() {
                          //               if (favoritePost[index]) {
                          //                 favoritePost.remove(favoritePost[index]);
                          //               } else {
                          //                 favoritePost.add(favoritePost[index]);
                          //               }
                          //             });
                          //           },
                          //           icon: const Icon(Icons.favorite)),
                          //     ],
                          //   ),
                          // )
                          Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  //isSaved ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.red,
                                  //color: Colors.pink,
                                  iconSize: 20,
                                  onPressed: () {
                                        setState(() {
                                        favoritePost.indexOf(favoritePost[index]);
                                        favoritePost.removeAt(index);
                                      });

                                  },
                                  icon: const Icon(Icons.favorite)),
                            ],
                          ),
                        )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  void setState(Null Function() param0) {}
}
