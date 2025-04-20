import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_heatmap/flutter_map_heatmap.dart';
import 'package:latlong2/latlong.dart';

class GHGMap extends StatefulWidget {
  const GHGMap({super.key});

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

  // Updated person details to include activity type (good or bad)
  Map<String, Map<String, dynamic>> personDetails = {
    "Me": {
      "avatarUrl":
          'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
      "lastSeen": "Online",
      "GHGIndex": 3,
      "lastActivities": [
        {"label": "Preferred walking over driving", "type": "good"},
        {"label": "Used public transport", "type": "good"},
        {"label": "Ordered food delivery", "type": "bad"}
      ]
    },
    "Rena": {
      "avatarUrl":
          'https://media.licdn.com/dms/image/v2/D4E03AQFBIu9J-kB1vg/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1719592835289?e=1749081600&v=beta&t=q0rtR0XkdszZIbllG59gYCvi9HYV65NlYVH0p0yZ990',
      "lastSeen": "Last seen 2 hours ago",
      "GHGIndex": 4,
      "lastActivities": [
        {"label": "Drove to work", "type": "bad"},
        {"label": "Recycled plastic", "type": "good"},
        {"label": "Turned off lights", "type": "good"}
      ]
    },
    "Pavel": {
      "avatarUrl":
          'https://media.licdn.com/dms/image/v2/C4E03AQGrdlO8sT78ug/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1663355766652?e=1749081600&v=beta&t=wKnfP2SW9E27yg6owE7tjLAPKOx5GlAhzqMN5BOWC-w',
      "lastSeen": "Last seen 1 hour ago",
      "GHGIndex": 5,
      "lastActivities": [
        {"label": "Took a long flight", "type": "bad"},
        {"label": "Planted a tree", "type": "good"},
        {"label": "Rode a bike", "type": "good"}
      ]
    },
    "Suad": {
      "avatarUrl":
          "https://media.licdn.com/dms/image/v2/D4E03AQHIxVV2KRBqWw/profile-displayphoto-shrink_200_200/B4EZSVG6waHgAg-/0/1737668408302?e=1749081600&v=beta&t=f9lC_Wl9YLTU8Wbi0H2X_nCuFJq54csVo6vDxZZ5vW8",
      "lastSeen": "Last seen 30 minutes ago",
      "GHGIndex": 2,
      "lastActivities": [
        {"label": "Walked to grocery store", "type": "good"},
        {"label": "Drove to friend's house", "type": "bad"},
        {"label": "Used reusable bags", "type": "good"}
      ]
    },
    "Sensor": {
      "GHGIndex": 3,
    }
  };

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

    setState(() {
      data = result
          .map((e) => e as List<dynamic>)
          .map((e) => WeightedLatLng(LatLng(e[0], e[1]), 1))
          .toList();
      sensors = result2
          .map((e) => e as List<dynamic>)
          .map((e) => LatLng(e[0], e[1]))
          .toList();
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
                Marker(
                  point: const LatLng(40.413010, 49.945072),
                  width: 120.0,
                  height: 120.0,
                  child: GestureDetector(
                    onTap: () => _showModal("Me", false),
                    child: const Person(
                      name: "Me",
                      url:
                          'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
                    ),
                  ),
                ),
                Marker(
                  point: const LatLng(40.409264, 49.867092),
                  width: 120.0,
                  height: 120.0,
                  child: GestureDetector(
                    onTap: () => _showModal("Rena", false),
                    child: const Person(
                      name: "Rena",
                      url:
                          'https://media.licdn.com/dms/image/v2/D4E03AQFBIu9J-kB1vg/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1719592835289?e=1749081600&v=beta&t=q0rtR0XkdszZIbllG59gYCvi9HYV65NlYVH0p0yZ990',
                    ),
                  ),
                ),
                Marker(
                  point: const LatLng(40.458456, 49.857582),
                  width: 120.0,
                  height: 120.0,
                  child: GestureDetector(
                    onTap: () => _showModal("Pavel", false),
                    child: const Person(
                      name: "Pavel",
                      url:
                          'https://media.licdn.com/dms/image/v2/C4E03AQGrdlO8sT78ug/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1663355766652?e=1749081600&v=beta&t=wKnfP2SW9E27yg6owE7tjLAPKOx5GlAhzqMN5BOWC-w',
                    ),
                  ),
                ),
                Marker(
                  point: const LatLng(40.388456, 49.821582),
                  width: 120.0,
                  height: 120.0,
                  child: GestureDetector(
                    onTap: () => _showModal("Suad", false),
                    child: const Person(
                      name: "Suad",
                      url:
                          "https://media.licdn.com/dms/image/v2/D4E03AQHIxVV2KRBqWw/profile-displayphoto-shrink_200_200/B4EZSVG6waHgAg-/0/1737668408302?e=1749081600&v=beta&t=f9lC_Wl9YLTU8Wbi0H2X_nCuFJq54csVo6vDxZZ5vW8",
                    ),
                  ),
                ),
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
          const SizedBox(height: 5),
          if (!isSensor)
            Text(
              personDetails[name]?['lastSeen'] ?? '',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
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
