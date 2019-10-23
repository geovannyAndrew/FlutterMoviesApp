import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movies at cinema'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swipeCards()
          ],
        ),
      )
    );
  }

  Widget _swipeCards() {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      height: 300,
      child: Swiper(
          itemBuilder: (BuildContext context,int index){
            return Image.network("http://via.placeholder.com/350x150",
              fit: BoxFit.fill
            );
          },
          itemCount: 3,
          pagination: SwiperPagination(),
          itemWidth: 250,
          layout: SwiperLayout.STACK,
        ),
    );
  }
}