import 'package:check_in/models/location.dart';
import 'package:check_in/models/models.dart';
import 'package:check_in/providers/providers.dart';
import 'package:check_in/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String checkIn = '00:00';
  String checkOut = '00:00';

  double screenWidth = 0;
  double screenHeight = 0;
  Location _selectedLocation = Location(
    nama: '',
    latitude: 0,
    longitude: 0,
  );

  var _ischeckIn = false;
  var time;
  @override
  void initState() {
    super.initState();
    LocationService().checkPermission();
    _selectedLocation = Provider.of<Locations>(context, listen: false).items[0];
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 16),
                    child: const Text(
                      'Welcome',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 16),
                    child: RichText(
                      text: TextSpan(
                        text: DateTime.now().day.toString(),
                        style: const TextStyle(
                          color: Color.fromRGBO(121, 134, 203, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text:
                                DateFormat(' MMMM yyyy').format(DateTime.now()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'Adi Wirya',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          DateFormat('hh:mm:ss a').format(DateTime.now()),
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: const Text(
                  "Today's Status",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 32),
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.8),
                      blurRadius: 10,
                      offset: const Offset(2, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Check In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          checkIn,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Check Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          checkOut,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //record
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Records',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.3,
                child: FutureBuilder(
                  future: Provider.of<Records>(context, listen: false)
                      .fetchAndSetPlaces(),
                  builder: (context, snapshot) => snapshot.connectionState ==
                          ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Consumer<Records>(
                          builder: (context, record, child) => record
                                  .items.isEmpty
                              ? const Center(
                                  child: Text('No Records Yet'),
                                )
                              : ListView.builder(
                                  itemCount: record.items.length,
                                  itemBuilder: (context, index) => Column(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.location_on),
                                        title:
                                            Text(record.items[index].location),
                                        subtitle: Text(
                                          record.items[index].checks +
                                              ' ' +
                                              record.items[index].times,
                                        ),
                                        trailing: Text(
                                          record.items[index].dates,
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                          child: const Text('No Records Yet!!'),
                        ),
                ),
              ),
              //
              Consumer<Locations>(
                builder: (context, location, child) => location.items.isEmpty
                    ? child!
                    : DropdownButton(
                        value: _selectedLocation,
                        items: location.items
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.nama),
                              ),
                            )
                            .toList(),
                        onChanged: (item) {
                          setState(() {
                            _selectedLocation = item as Location;
                          });
                        },
                      ),
                child: const Text('No Location!!'),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final msg = await LocationService()
                        .checkDistance(_selectedLocation);
                    setState(() {
                      if (msg == 'OK') {
                        _ischeckIn = !_ischeckIn;
                        if (_ischeckIn) {
                          checkIn =
                              DateFormat('hh:mm a').format(DateTime.now());
                          time = checkIn;
                          Records().addRecord(
                            Record(
                              dates: DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now()),
                              location: _selectedLocation.nama,
                              times: time.toString(),
                              checks: _ischeckIn ? 'Check In' : 'Check Out',
                            ),
                          );
                        } else {
                          checkOut =
                              DateFormat('hh:mm a').format(DateTime.now());
                          time = checkOut;
                          Records().addRecord(
                            Record(
                              dates: DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now()),
                              location: _selectedLocation.nama,
                              times: time.toString(),
                              checks: _ischeckIn ? 'Check In' : 'Check Out',
                            ),
                          );
                        }
                        if (_ischeckIn) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Check In Success'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Check Out Success'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(msg),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    });
                  },
                  child: _ischeckIn
                      ? const Text('Check out')
                      : const Text('Check in'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _ischeckIn = false;
                      checkIn = '00:00';
                      checkOut = '00:00';
                    });
                  },
                  child: const Text('Reset'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
