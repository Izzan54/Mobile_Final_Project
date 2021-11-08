import 'package:flutter/material.dart';

class FavoritePostRoute extends StatelessWidget {

  final List favoritePost;

  const FavoritePostRoute({
    Key? key,
    required this.favoritePost,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: 
          AppBar(
            elevation: 0,
            backgroundColor: Colors.blueGrey,
            leading: 
            IconButton(
                  icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                iconSize: 30,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
          ),
        ),

        body: 
        ListView.separated(
            itemCount: favoritePost.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[

                          SizedBox(
                            width: 67,
                            height: 64,
                            child: 
                            Image.network(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                Text(
                                    favoritePost[index]["title"],
                                    style: 
                                    const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  ),
                                  
                                  Text(
                                    favoritePost[index]["author"],
                                    style: const TextStyle(fontSize: 15),
                                  ),

                                  Text(
                                    favoritePost[index]["description"],
                                    style: const TextStyle(fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              
                              children: [
                                IconButton(
                                icon: const Icon(Icons.delete),
                                iconSize: 20,
                                onPressed: () {
                                    setState(() {
                                      favoritePost.indexOf(favoritePost[index]);
                                      favoritePost.removeAt(index);
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.favorite),
                                    color: Colors.red,
                                    iconSize: 20,
                                    onPressed: () {
                                    //   setState(() {
                                    //   favoritePost.indexOf(favoritePost[index]);
                                    //   favoritePost.removeAt(index);
                                    // });
                                    },
                                ),
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
