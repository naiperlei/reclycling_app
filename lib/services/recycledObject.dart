import 'dart:convert';

class recycledObject{

  String name;
  String image;

  recycledObject({ required this.name, required this.image});
  // Future<void> getObject() async {
  //
  //   try{
  //     //make the request
  //     Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
  //     Map data = jsonDecode(response.body);
  //     //print(data);
  //
  //     //get properties from data
  //     String datetime = data['utc_datetime'];
  //     String offset = data['utc_offset'].substring(1,3);
  //     //print(datetime);
  //     //print(offset);
  //
  //     //create DateTime object
  //     DateTime now = DateTime.parse(datetime);
  //     now = now.add(Duration(hours: int.parse(offset)));
  //
  //     //set the time property
  //     isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
  //     time = DateFormat.jm().format(now);
  //   }catch(e){
  //     print('caught error: $e');
  //     time = 'could not get time data';
  //   }
  //
  //
  //
  // }

}