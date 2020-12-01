import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackc19/provider/root_provider.dart';
import 'package:trackc19/widgets/country_report_chart.dart';
import 'package:trackc19/widgets/single_status.dart';

class SingleCountryDataScreen extends StatelessWidget {
  static final routeName = '/singleCountry';
  
  @override
  Widget build(BuildContext context) {
    final Map status = ModalRoute.of(context).settings.arguments;
    final rootProvider = Provider.of<RootProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${status["country"]}'),
      ),
      body: FutureBuilder(
        future: rootProvider.getHistoricData(country: status['country']),
        builder: (BuildContext context,AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return SingleChildScrollView(
                child: Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height/1.5,
                        child: CountryReportChart(deaths: snapshot.data['deaths'],recovered: snapshot.data['recovered'],)
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        SingleStatus(
                          label: 'Total Cases', 
                          amount: status['cases'],
                          color: Colors.orangeAccent,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(children: [
                      SingleStatus(
                        label: 'Active Cases', 
                        amount: status['active']
                      ),
                      SizedBox(width: 10),
                      SingleStatus(
                        label: 'Deaths', 
                        amount: status['deaths'],
                        color: Colors.redAccent,
                      ),
                    ],),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SingleStatus(label: 'Recovered', 
                        amount: status['recovered'],
                        color: Colors.green[600],
                      )
                      ],
                    ),
                    SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                        child: Container(
                        padding: EdgeInsets.all(12.0),
                        color: Colors.orangeAccent[100],
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Today\'s status',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            Row(
                              children: [
                                SingleStatus(
                                  label: 'Cases', 
                                  amount: status['todayCases'],
                                  color: Colors.orangeAccent,
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SingleStatus(
                                  label: 'Recovered', 
                                  amount: status['todayRecovered'],
                                  color: Colors.green[600],
                                ),
                                SizedBox(width:10),
                                SingleStatus(
                                  label: 'Deaths', 
                                  amount: status['todayDeaths'],
                                  color: Colors.redAccent,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else if(snapshot.hasError){
            return Center(child: Text('Error loading data'));
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}
