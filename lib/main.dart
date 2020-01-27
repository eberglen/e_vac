import 'package:e_vac/data_models/evac_centers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:e_vac/services/location_service.dart';
import 'package:provider/provider.dart';
import 'data_models/user_location.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      builder: (context) => LocationService().locationStream,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
          ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController _controller;
  PageController _pageController;
  int prevPage;
  List<Marker> allMarkers = [];


  @override
  void initState(){
    super.initState();
    evacList.forEach((element){
      allMarkers.add(Marker(
        markerId: MarkerId(element.evacName),
        draggable: false,
        infoWindow: InfoWindow(title: element.evacName, snippet: element.address),
        position: element.loclatlng
      ));
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)..addListener(_onScroll);
  }


  void _onScroll(){
    if(_pageController.page.toInt() != prevPage){
      prevPage = _pageController.page.toInt();
    }
  }

  _evacList(index){
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget){
        double value = 1;
        if (_pageController.position.haveDimensions){
          value = _pageController.page - index;
          value = (1-(value.abs() * 0.3) + 0.6).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 340.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
        onTap: () {
          moveCamera();
        },
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 20.0
                ),
                height: 125.0,
                width: 275.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    ),
                  ]
                ),
                child: Container(
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 90.0,
                        width: 90.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0)
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              evacList[index].thumbnail
                            ),
                            fit: BoxFit.cover
                          )
                        )
                      ),
                      SizedBox(width: 5.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            evacList[index].evacName,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            evacList[index].address,
                            style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Container(
                            width: 170.0,
                            child: Text(
                              evacList[index].description,
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          )
                        ],
                      )
                    ]
                  )
                )
              )
            )
          ]
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Vac'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 50.0,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(14.5764,121.0851),
                  zoom: 15.0
              ),
              markers: Set.from(allMarkers),
              onMapCreated: mapCreated,
            ),
          ),
          Positioned(
            bottom: 20.0,
            child: Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: _pageController,
                itemCount: evacList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _evacList(index);
                },
              ),
            )
          )
        ],
      ),
    );
  }
  void mapCreated(controller){
    setState((){
      _controller = controller;
    });
  }

  moveCamera(){
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: evacList[_pageController.page.toInt()].loclatlng,
        zoom: 17.0,
        bearing: 0.0,
        tilt: 0.0
      )
    ));
  }
}

