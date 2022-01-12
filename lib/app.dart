import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/model/newsItem.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  List<Widget> _list = <Widget>[];
  bool isShowProgress = true;
  double layoutSize = 800;
  PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    fetchAlbum().then((news) {
      setState(() {
        isShowProgress = false;
        for (int i = 0; i < news.length; i++) {
          if (news[i].urlToImage != "") {
            _list.add(Pages(
                urlToImage: news[i].urlToImage,
                title: news[i].title,
                description: news[i].description,
                publishedAt: news[i].publishedAt));
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      var screenSize = MediaQuery.of(context).size;
      if (screenSize.width > layoutSize) {
        return Scaffold(
            body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Medical News",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28.0),
                    ),
                  ),
                  Flexible(
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 700,
                        ),
                        itemCount: _list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _list[index];
                        }),
                  )
                ],
              ),
              Visibility(
                  visible: isShowProgress,
                  child:
                      const Center(child: const CircularProgressIndicator())),
            ],
          ),
        ));
      } else {
        return Scaffold(
            body: Container(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    for (int i = 0; i < _list.length; i++) _list[i]
                  ],
                ),
              ),
              Visibility(
                  visible: isShowProgress,
                  child:
                      const Center(child: const CircularProgressIndicator())),
            ],
          ),
        ));
      }
    } else {
      return Scaffold(
          body: Container(
        child: Stack(
          children: <Widget>[
            PageView(
              controller: controller,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                for (int i = 0; i < _list.length; i++) _list[i]
              ],
              physics: const BouncingScrollPhysics(),
            ),
            Visibility(
                visible: isShowProgress,
                child: const Center(child: const CircularProgressIndicator())),
          ],
        ),
      ));
    }
  }

  Future<List<News>> fetchAlbum() async {
    if (false) {
      List<News> news = [];

      news.add(News(
          urlToImage:
              "https://i.gadgets360cdn.com/large/beeple_screenshot_christies_1615480377986.jpg",
          title:
              "NFT Sales Hit 25 Billion in 2021, But Growth Shows Signs of Slowing",
          description:
              "NFTs reached some 25 billion (roughly Rs. 1,84,690 crore) in 2021 as the speculative crypto asset exploded in popularity, data from market tracker DappRadar shows.",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "http://x7d4c5z5.stackpathcdn.com/wp-content/uploads/tc/2022/01/Truth-shall-set-you-free.gif",
          title: "TechCabal Daily - What Trumps Truth? - TechCabal",
          description:
              "Read today's edition of #TCDaily: Y Combinator ups the stakes- HealthLeap raises 1.1 million- What Trumps Truth?- Tech Probe- Opportunities",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "https://images.cointelegraph.com/images/1200_aHR0cHM6Ly9zMy5jb2ludGVsZWdyYXBoLmNvbS91cGxvYWRzLzIwMjItMDEvMjUzODc0N2YtZWM5Mi00ZjYxLWIwMzctMjZlYzVjOTJiNzFmLmpwZw==.jpg",
          title:
              "World’s biggest podcaster Joe Rogan has a ‘lot of hope’ for crypto",
          description:
              "The controversial podcaster said that crypto will either “fall apart completely,” or will give society an opportunity to come up with a \"better way to live our lives.",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "https://i.gadgets360cdn.com/large/beeple_screenshot_christies_1615480377986.jpg",
          title:
              "NFT Sales Hit 25 Billion in 2021, But Growth Shows Signs of Slowing",
          description:
              "NFTs reached some 25 billion (roughly Rs. 1,84,690 crore) in 2021 as the speculative crypto asset exploded in popularity, data from market tracker DappRadar shows.",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "http://x7d4c5z5.stackpathcdn.com/wp-content/uploads/tc/2022/01/Truth-shall-set-you-free.gif",
          title: "TechCabal Daily - What Trumps Truth? - TechCabal",
          description:
              "Read today's edition of #TCDaily: Y Combinator ups the stakes- HealthLeap raises 1.1 million- What Trumps Truth?- Tech Probe- Opportunities",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "https://images.cointelegraph.com/images/1200_aHR0cHM6Ly9zMy5jb2ludGVsZWdyYXBoLmNvbS91cGxvYWRzLzIwMjItMDEvMjUzODc0N2YtZWM5Mi00ZjYxLWIwMzctMjZlYzVjOTJiNzFmLmpwZw==.jpg",
          title:
              "World’s biggest podcaster Joe Rogan has a ‘lot of hope’ for crypto",
          description:
              "The controversial podcaster said that crypto will either “fall apart completely,” or will give society an opportunity to come up with a \"better way to live our lives.",
          publishedAt: "2022-01-11T06:20:18Z"));
      news.add(News(
          urlToImage:
              "https://i.gadgets360cdn.com/large/beeple_screenshot_christies_1615480377986.jpg",
          title:
              "NFT Sales Hit 25 Billion in 2021, But Growth Shows Signs of Slowing",
          description:
              "NFTs reached some 25 billion (roughly Rs. 1,84,690 crore) in 2021 as the speculative crypto asset exploded in popularity, data from market tracker DappRadar shows.",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "http://x7d4c5z5.stackpathcdn.com/wp-content/uploads/tc/2022/01/Truth-shall-set-you-free.gif",
          title: "TechCabal Daily - What Trumps Truth? - TechCabal",
          description:
              "Read today's edition of #TCDaily: Y Combinator ups the stakes- HealthLeap raises 1.1 million- What Trumps Truth?- Tech Probe- Opportunities",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "https://images.cointelegraph.com/images/1200_aHR0cHM6Ly9zMy5jb2ludGVsZWdyYXBoLmNvbS91cGxvYWRzLzIwMjItMDEvMjUzODc0N2YtZWM5Mi00ZjYxLWIwMzctMjZlYzVjOTJiNzFmLmpwZw==.jpg",
          title:
              "World’s biggest podcaster Joe Rogan has a ‘lot of hope’ for crypto",
          description:
              "The controversial podcaster said that crypto will either “fall apart completely,” or will give society an opportunity to come up with a \"better way to live our lives.",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "https://i.gadgets360cdn.com/large/beeple_screenshot_christies_1615480377986.jpg",
          title:
              "NFT Sales Hit 25 Billion in 2021, But Growth Shows Signs of Slowing",
          description:
              "NFTs reached some 25 billion (roughly Rs. 1,84,690 crore) in 2021 as the speculative crypto asset exploded in popularity, data from market tracker DappRadar shows.",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "http://x7d4c5z5.stackpathcdn.com/wp-content/uploads/tc/2022/01/Truth-shall-set-you-free.gif",
          title: "TechCabal Daily - What Trumps Truth? - TechCabal",
          description:
              "Read today's edition of #TCDaily: Y Combinator ups the stakes- HealthLeap raises 1.1 million- What Trumps Truth?- Tech Probe- Opportunities",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "https://images.cointelegraph.com/images/1200_aHR0cHM6Ly9zMy5jb2ludGVsZWdyYXBoLmNvbS91cGxvYWRzLzIwMjItMDEvMjUzODc0N2YtZWM5Mi00ZjYxLWIwMzctMjZlYzVjOTJiNzFmLmpwZw==.jpg",
          title:
              "World’s biggest podcaster Joe Rogan has a ‘lot of hope’ for crypto",
          description:
              "The controversial podcaster said that crypto will either “fall apart completely,” or will give society an opportunity to come up with a \"better way to live our lives.",
          publishedAt: "2022-01-11T06:20:18Z"));
      news.add(News(
          urlToImage:
              "https://i.gadgets360cdn.com/large/beeple_screenshot_christies_1615480377986.jpg",
          title:
              "NFT Sales Hit 25 Billion in 2021, But Growth Shows Signs of Slowing",
          description:
              "NFTs reached some 25 billion (roughly Rs. 1,84,690 crore) in 2021 as the speculative crypto asset exploded in popularity, data from market tracker DappRadar shows.",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "http://x7d4c5z5.stackpathcdn.com/wp-content/uploads/tc/2022/01/Truth-shall-set-you-free.gif",
          title: "TechCabal Daily - What Trumps Truth? - TechCabal",
          description:
              "Read today's edition of #TCDaily: Y Combinator ups the stakes- HealthLeap raises 1.1 million- What Trumps Truth?- Tech Probe- Opportunities",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "https://images.cointelegraph.com/images/1200_aHR0cHM6Ly9zMy5jb2ludGVsZWdyYXBoLmNvbS91cGxvYWRzLzIwMjItMDEvMjUzODc0N2YtZWM5Mi00ZjYxLWIwMzctMjZlYzVjOTJiNzFmLmpwZw==.jpg",
          title:
              "World’s biggest podcaster Joe Rogan has a ‘lot of hope’ for crypto",
          description:
              "The controversial podcaster said that crypto will either “fall apart completely,” or will give society an opportunity to come up with a \"better way to live our lives.",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "https://i.gadgets360cdn.com/large/beeple_screenshot_christies_1615480377986.jpg",
          title:
              "NFT Sales Hit 25 Billion in 2021, But Growth Shows Signs of Slowing",
          description:
              "NFTs reached some 25 billion (roughly Rs. 1,84,690 crore) in 2021 as the speculative crypto asset exploded in popularity, data from market tracker DappRadar shows.",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "http://x7d4c5z5.stackpathcdn.com/wp-content/uploads/tc/2022/01/Truth-shall-set-you-free.gif",
          title: "TechCabal Daily - What Trumps Truth? - TechCabal",
          description:
              "Read today's edition of #TCDaily: Y Combinator ups the stakes- HealthLeap raises 1.1 million- What Trumps Truth?- Tech Probe- Opportunities",
          publishedAt: "2022-01-11T06:20:18Z"));

      news.add(News(
          urlToImage:
              "https://images.cointelegraph.com/images/1200_aHR0cHM6Ly9zMy5jb2ludGVsZWdyYXBoLmNvbS91cGxvYWRzLzIwMjItMDEvMjUzODc0N2YtZWM5Mi00ZjYxLWIwMzctMjZlYzVjOTJiNzFmLmpwZw==.jpg",
          title:
              "World’s biggest podcaster Joe Rogan has a ‘lot of hope’ for crypto",
          description:
              "The controversial podcaster said that crypto will either “fall apart completely,” or will give society an opportunity to come up with a \"better way to live our lives.",
          publishedAt: "2022-01-11T06:20:18Z"));

      return news;
    } else {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&from=2022-01-10&category=health&apiKey=f33fd7c71cd940ceafdf652688af7cc5'));
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["articles"];

        List<News> news = [];
        for (int i = 0; i < data.length; i++) {
          news.add(News.fromJson(data[i]));
        }

        return news;
      } else {
        throw Exception('Failed to load album');
      }
    }
  }
}

class Pages extends StatefulWidget {
  final title;
  final description;
  final urlToImage;
  final publishedAt;

  Pages({this.title, this.description, this.urlToImage, this.publishedAt});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  double windowWidth = 0;

  double padding = 0;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      windowWidth = 500.0;
      return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        alignment: Alignment.center,
        child: SizedBox(
          width: windowWidth,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: windowWidth,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 300.0,
                    width: windowWidth,
                    child: FadeInImage.assetNetwork(
                      image: widget.urlToImage,
                      fit: BoxFit.cover,
                      placeholder: "assets/logo.png",
                      imageErrorBuilder: (context, url, error) => const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 8.0, top: 8),
                      child: Text(
                        widget.description,
                        style: const TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 16.0, top: 8),
                      child: Text(
                        "Published On " + widget.publishedAt,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      windowWidth = double.infinity;
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        alignment: Alignment.center,
        child: SizedBox(
            width: windowWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300.0,
                  width: windowWidth,
                  child: FadeInImage.assetNetwork(
                    image: widget.urlToImage,
                    fit: BoxFit.cover,
                    placeholder: "assets/logo.png",
                    imageErrorBuilder: (context, url, error) => const Icon(
                      Icons.broken_image,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                  // child: Image.network(
                  //   urlToImage,
                  //   fit: BoxFit.cover,
                  //   height: 300.0,
                  //   loadingBuilder: (BuildContext context, Widget child,
                  //       ImageChunkEvent? loadingProgress) {
                  //     if (loadingProgress == null) return child;
                  //     return SizedBox(
                  //       height: 300.0,
                  //       child: Center(
                  //         child: CircularProgressIndicator(
                  //           value: loadingProgress.expectedTotalBytes != null
                  //               ? loadingProgress.cumulativeBytesLoaded /
                  //                   loadingProgress.expectedTotalBytes!
                  //               : null,
                  //         ),
                  //       ),
                  //     );
                  //
                  //   },
                  // ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 8.0, top: 8),
                      child: Text(
                        widget.description,
                        style: const TextStyle(fontSize: 19),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 8.0, top: 8),
                        child: Text(
                          "Published On " + widget.publishedAt,
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
      );
    }
  }
}
