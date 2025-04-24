import 'dart:async';
import 'dart:convert';
import 'package:ch4nge/features/layers/domain/entities/activity_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_heatmap/flutter_map_heatmap.dart';
import 'package:latlong2/latlong.dart';

class GHGMap extends StatefulWidget {
  const GHGMap({
    super.key,
    required this.users,
    required this.activities,
  });

  final List<UserEntity> users;
  final Map<String, List<ActivityEntity>> activities;

  @override
  State<GHGMap> createState() => _GHGMapState();
}

class _GHGMapState extends State<GHGMap> with SingleTickerProviderStateMixin {
  final StreamController<void> _rebuildStream = StreamController.broadcast();
  List<WeightedLatLng> data = [];
  List<LatLng> sensors = [];
  List<Map<double, MaterialColor>> gradients = [
    HeatMapOptions.defaultGradient,
    {0.2: Colors.green, 0.4: Colors.yellow, 0.6: Colors.orange, 0.8: Colors.red}
  ];

  var index = 0;
  String? currentModalName;
  bool isModalSensor = false;
  late Map<String, Map<String, dynamic>> personDetails;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _rebuildStream.close();
    super.dispose();
  }

  Future<void> _loadData() async {

    var str = await rootBundle.loadString('assets/json_data/points.json');
    List<dynamic> result = jsonDecode(str);

    var str2 = await rootBundle.loadString('assets/json_data/sensors.json');
    List<dynamic> result2 = jsonDecode(str2);

    Map<String, Map<String, dynamic>> personDetails = {
      for (var user in widget.users)
        user.username: {
          "avatarUrl": user.profilePicUrl,
          "GHGIndex": user.ghgIndex,
          "lastActivities": widget.activities[user.username]?.map((activity) {
                return {
                  "label": activity.title,
                  "type": activity.value > 0 ? "good" : "bad",
                };
              }).toList() ??
              [],
        }
    };

    print(personDetails);
    setState(() {
      data = result
          .map((e) => e as List<dynamic>)
          .map((e) => WeightedLatLng(LatLng(e[0], e[1]), 1))
          .toList();
      sensors = result2
          .map((e) => e as List<dynamic>)
          .map((e) => LatLng(e[0], e[1]))
          .toList();
      this.personDetails = personDetails;
    });
  }

  void _showModal(String name, bool isSensor) {
    setState(() {
      currentModalName = name;
      isModalSensor = isSensor;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ModalContent(
        name: name,
        isSensor: isSensor,
        personDetails: personDetails,
      ),
    ).then((_) {
      setState(() {
        currentModalName = null;
        isModalSensor = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _rebuildStream.add(null));

    final sensorMarkers = sensors
        .map((e) => Marker(
              point: e,
              child: GestureDetector(
                onTap: () => _showModal("Sensor", true),
                child: const Icon(Icons.sensors, color: Colors.red, size: 50),
              ),
            ))
        .toList();

    return Stack(
      children: [
        FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(40.409264, 49.867092),
            initialZoom: 11.5,
            interactionOptions: InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
          ),
          children: [
            TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png"),
            if (data.isNotEmpty)
              HeatMapLayer(
                heatMapDataSource: InMemoryHeatMapDataSource(data: data),
                heatMapOptions:
                    HeatMapOptions(gradient: gradients[index], minOpacity: 0.1),
                reset: _rebuildStream.stream,
              ),
            MarkerLayer(
              markers: [
                ...sensorMarkers,
                ...widget.users.map((user) {
                  return Marker(
                    point: user.location,
                    width: 120.0,
                    height: 120.0,
                    child: GestureDetector(
                      onTap: () => _showModal(user.username, false),
                      child: Person(
                        name: user.username,
                        url: user.profilePicUrl,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
        if (currentModalName != null)
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: Container(color: Colors.black54),
          ),
      ],
    );
  }
}

class _ModalContent extends StatelessWidget {
  final String name;
  final bool isSensor;
  final Map<String, dynamic> personDetails;

  const _ModalContent({
    required this.name,
    required this.isSensor,
    required this.personDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          if (isSensor)
            const Icon(
              Icons.sensors,
              size: 40,
              color: Colors.red,
            ),
          if (!isSensor)
            CircleAvatar(
              radius: 40,
              backgroundImage:
                  NetworkImage(personDetails[name]?['avatarUrl'] ?? ''),
            ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'GHG Index',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        Icons.square,
                        size: 20,
                        color: index < (personDetails[name]?['GHGIndex'] ?? 0)
                            ? Colors.yellow
                            : Colors.grey,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (isSensor)
            const Column(
              children: [
                Row(
                  children: [
                    Text('CO2 Emission: '),
                    Spacer(),
                    Text('400 ppm'),
                  ],
                ),
                Row(
                  children: [
                    Text('Methane Emission: '),
                    Spacer(),
                    Text('1.8 ppm'),
                  ],
                ),
                Row(
                  children: [
                    Text('Nitrous Oxide Emission: '),
                    Spacer(),
                    Text('0.3 ppm'),
                  ],
                ),
              ],
            ),
          if (!isSensor)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Activities",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          const SizedBox(height: 10),
          if (!isSensor)
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: personDetails[name]?['lastActivities']?.length ?? 0,
                itemBuilder: (context, index) {
                  final activity =
                      personDetails[name]?['lastActivities'][index];
                  return Row(
                    children: [
                      Icon(
                        activity['type'] == "good"
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: activity['type'] == "good"
                            ? Colors.green
                            : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(activity['label']),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class Person extends StatelessWidget {
  final String name;
  final String url;

  const Person({super.key, required this.name, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent
            .withValues(blue: 1.0, alpha: 0.2), // Background color
        borderRadius: BorderRadius.circular(16.0), // Rounded corners
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              url,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
