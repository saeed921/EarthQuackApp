
import 'package:earthquack_apps_by_rest_api/utility/utili.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/eq_data_providers.dart';

class EarthQuakePage extends StatefulWidget {
  static const String routeName="earthquake";
  const EarthQuakePage({Key? key}) : super(key: key);

  @override
  State<EarthQuakePage> createState() => _EarthQuakePageState();
}

class _EarthQuakePageState extends State<EarthQuakePage> {
  String? startTime;
  String? endTime;
  String? minValue;
  final minValueController=TextEditingController();
  bool isFirst = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (isFirst) {
      Provider.of<EqDataProvider>(context,listen: false).getCurrentDate();

      isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    minValueController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EarthQuake Servay"),
        leading: IconButton(icon: Icon(Icons.menu),onPressed: (){},),
      ),
      body: Column(
        //mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 4),
                child: Card(
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(startTime==null?"Start Time":"$startTime"),
                      IconButton(icon: Icon(Icons.date_range,color:Colors.cyan,size: 25,),

                        onPressed: (){
                          _showStartDatePickerDialog();
                        },),



                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 4),
                child: Card(
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(endTime==null?"End Time":"$endTime"),
                      IconButton(icon: Icon(Icons.date_range,color:Colors.cyan,size: 25,),

                        onPressed: (){
                          _showEndDatePickerDialog();
                        },),



                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    height: 100,
                    child: Padding(
                      padding:  const EdgeInsets.symmetric(vertical: 10,horizontal: 4),
                      child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const  EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                            child: TextField(
                              controller: minValueController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Enter Min Value"

                              ),

                            ),
                          )
                      ),
                    ),

                  )),
              IconButton(onPressed: (){
                _getData(context);
              }, icon: Icon(Icons.send,size: 30,color:Colors.cyan,)),
            ],
          ),
          SizedBox(height: 10,),
          Text("Your Selected Survay Data"),
          SizedBox(height: 10,),
          Consumer<EqDataProvider>(
              builder: (context, provider, child) =>
          provider.earthQuackModel==null?Text("Empty"):
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
                itemCount:provider.earthQuackModel!.features!.length ,
                itemBuilder: (context,index){
              final model= provider.earthQuackModel!.features![index];
              return ListTile(
                  tileColor: Colors.cyan,
                  leading: Card(
                    elevation: 10,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: model.properties!.mag==null? Text("No Data"):Text(model.properties!.mag!.toString()),
                      ),
                    ),
                  ),
                  title: model.properties!.place==null? Text("No Data"):Text(model.properties!.place!),
                  subtitle:  model.properties!.time==null? Text("No Data"):Text(getFormattedDate(model.properties!.time!)),

                );



            }),
          )),


        ],
      ),
    );
  }
  void _showStartDatePickerDialog() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(2022),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      setState(() {
        startTime= DateFormat("yyyy-MM-dd").format(selectedDate);
        print(startTime);
      });
    }
  }
  void _showEndDatePickerDialog() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      setState(() {
       endTime= DateFormat("yyyy-MM-dd").format(selectedDate);
        print(startTime);
      });
    }
  }
  void _getData(BuildContext context)async{
    minValue=minValueController.text;
    final provider= Provider.of<EqDataProvider>(context,listen: false);
    provider.setNewDate(startTime!, endTime!, minValue!);
    provider.getCurrentDate();


  }
}
