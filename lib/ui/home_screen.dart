import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:html/parser.dart' show parse;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/ui/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/main_provider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isFavorite = false;
  MainProvider mainProvider = MainProvider();
  bool useMobileLayout;
  @override
  Widget build(BuildContext context) {
    mainProvider = Provider.of<MainProvider>(context);
    double shortestSide = MediaQuery.of(context).size.shortestSide;
    // Determine if we should use mobile layout or not, 600 here is
    // a common breakpoint for a typical 7-inch tablet.
    useMobileLayout = shortestSide < 600;
    return mainProvider.isLoading
      ? SplashScreen()
      : Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _buildCarouselSection(),
                  _buildInfoSection(),
                  Divider(color: Color(0xffadb1c4)),
                  _buildTrainerSection(),
                  Divider(color: Color(0xffadb1c4)),
                  _buildAboutSection(),
                  Divider(color: Color(0xffadb1c4)),
                  _buildFeesSection(),
                ],
              ),
              Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: useMobileLayout ? 10 : 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: useMobileLayout ? 18 : 38,
                        ),
                        onPressed: ()=>Fluttertoast.showToast(
                          msg: "تم الضغط على زر الرجوع",
                          toastLength: Toast.LENGTH_SHORT,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: useMobileLayout
                              ? SizedBox(
                                width: useMobileLayout ? 23 : 50,
                                height: useMobileLayout ? 23 : 50,
                                child: Image.asset('assets/img/share_icon.png')
                              )
                              : Icon(
                                Icons.share,
                                color: Colors.white,
                                size: useMobileLayout ? 18 : 38,
                              ),
                            onPressed: ()=>Fluttertoast.showToast(
                              msg: "تم الضغط على زر المشاركة",
                              toastLength: Toast.LENGTH_SHORT,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _isFavorite
                                ? Icons.star
                                : Icons.star_border,
                              color: Colors.white,
                              size: useMobileLayout ? 25 : 45,
                            ),
                            onPressed: (){
                              setState(()=> _isFavorite = !_isFavorite);
                              Fluttertoast.showToast(
                                msg: _isFavorite
                                  ? "تم إضافة الموضوع إلى المفضلة"
                                  : "تم حذف الموضوع من المفضلة",
                                toastLength: Toast.LENGTH_SHORT,
                              );
                            }
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                top: 40,
              ),
            ],
          ),
        ),
        bottomNavigationBar: MaterialButton(
          onPressed: ()=>Fluttertoast.showToast(
            msg: "تم الضغط على زر الحجز",
            toastLength: Toast.LENGTH_SHORT,
          ),
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff703081),
                  Color(0xff913faa),
                ],
              )
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "قم بالحجز الآن",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: useMobileLayout ? 15 : 25),
            ),
          ),
        ),
      );
  }

  Widget _buildCarouselSection(){
    return SizedBox(
      height: useMobileLayout ? 280.0 : 380,
      width: MediaQuery.of(context).size.width,
      child: Carousel(
        boxFit: BoxFit.cover,
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 500),
        dotColor: Colors.white.withOpacity(0.8),
        dotSize: useMobileLayout ? 7.0 : 12,
        dotIncreaseSize: 1.5,
        dotSpacing: useMobileLayout ? 11.5 : 21.5,
        dotBgColor: Colors.transparent,
        dotPosition: DotPosition.bottomLeft,
        dotVerticalPadding: useMobileLayout ? 6.0 : 16,
        dotHorizontalPadding: 8.0,
        showIndicator: true,
        indicatorBgPadding: 7.0,
        images: mainProvider.mainModel.img.map((element)=>NetworkImage(element)).toList(),
      ),
    );
  }  

  Widget _buildInfoSection(){
    String _date = DateFormat.EEEE('ar_EG').addPattern(',').add_d().add_MMMM().addPattern(',').add_jm().format(mainProvider.mainModel.date);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '# ${mainProvider.mainModel.interest}',
            style: useMobileLayout
              ? Theme.of(context).textTheme.bodyText1
              : Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: 7,),
          Text(
            mainProvider.mainModel.title,
            style: useMobileLayout
              ? Theme.of(context).textTheme.headline1
              : Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 7,),
          Row(
            children: <Widget>[
              SizedBox(
                width: useMobileLayout ? 19 : 29,
                height: useMobileLayout ? 19 : 29,
                child: Image.asset('assets/img/date_icon.png'),
              ),
              SizedBox(width: 5,),
              Text(
                _date,
                style: useMobileLayout
                  ? Theme.of(context).textTheme.bodyText1
                  : Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
          SizedBox(height: 7,),  
          Row(
            children: <Widget>[
              SizedBox(
                width: useMobileLayout ? 19 : 29,
                height: useMobileLayout ? 19 : 29,
                child: Image.asset('assets/img/address_icon.png'),
              ),
              SizedBox(width: 5,),
              Text(
                mainProvider.mainModel.address,
                style: useMobileLayout
                  ? Theme.of(context).textTheme.bodyText1
                  : Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ), 
        ],
      ),
    );
  }

  Widget _buildTrainerSection(){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(
                  mainProvider.mainModel.trainerImg,
                  height: useMobileLayout ? 30 : 50,
                  width: useMobileLayout ? 30 : 50,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                mainProvider.mainModel.trainerName,
                style: useMobileLayout
                  ? Theme.of(context).textTheme.headline2
                  : Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
          SizedBox(height: 7,),  
          Text(
            mainProvider.mainModel.trainerInfo,
            style: useMobileLayout
              ? Theme.of(context).textTheme.bodyText1
              : Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'عن الرحلة',
            style: useMobileLayout
              ? Theme.of(context).textTheme.headline2
              : Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 7,),
          Text(
            _parseHtmlString(mainProvider.mainModel.occasionDetail),
            style: useMobileLayout
              ? Theme.of(context).textTheme.bodyText1
              : Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }

  Widget _buildFeesSection(){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 8.0, right: 15.0, bottom: 15.0, left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'تكلفة الرحلة',
            style: useMobileLayout
              ? Theme.of(context).textTheme.headline2
              : Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 7,),
          Column(
            children: mainProvider.mainModel.reservTypes.map((element)=>Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  element.name,
                  style: useMobileLayout
                    ? Theme.of(context).textTheme.bodyText1
                    : Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  '${element.price} SAR',
                  style: useMobileLayout
                    ? Theme.of(context).textTheme.bodyText1
                    : Theme.of(context).textTheme.bodyText2,
                ),
              ],
            )).toList(),
          ),
        ],
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);
    String parsedString = parse(document.body.text).documentElement.text;
    return parsedString;
  }
}