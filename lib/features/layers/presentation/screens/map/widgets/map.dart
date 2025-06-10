import 'dart:async';
import 'dart:convert';
import 'package:ch4nge/features/layers/domain/entities/activity_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_heatmap/flutter_map_heatmap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  // Static cache with proper initialization tracking
  static List<WeightedLatLng>? _cachedData;
  static List<LatLng>? _cachedSensors;
  static bool _isInitialized = false;
  static Future<void>? _initializationFuture;

  List<WeightedLatLng> data = [];
  List<LatLng> sensors = [];
  List<Map<double, MaterialColor>> gradients = [
    HeatMapOptions.defaultGradient,
    {0.2: Colors.green, 0.4: Colors.yellow, 0.6: Colors.orange, 0.8: Colors.red}
  ];

  var index = 0;
  String? currentModalName;
  bool isModalSensor = false;
  Map<String, Map<String, dynamic>> personDetails = {};
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initializeMapData();
  }

  @override
  void didUpdateWidget(GHGMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Rebuild person details when activities change
    if (oldWidget.activities != widget.activities ||
        oldWidget.users != widget.users) {
      _buildPersonDetails();
      // Force rebuild of the map
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _rebuildStream.close();
    super.dispose();
  }

  Future<void> _initializeMapData() async {
    // If already initialized, use cached data immediately
    if (_isInitialized && _cachedData != null && _cachedSensors != null) {
      _setDataFromCache();
      return;
    }

    // If initialization is in progress, wait for it
    if (_initializationFuture != null) {
      await _initializationFuture;
      _setDataFromCache();
      return;
    }

    // Start initialization
    _initializationFuture = _loadStaticData();
    await _initializationFuture;
    _setDataFromCache();
  }

  void _setDataFromCache() {
    if (mounted) {
      setState(() {
        data = _cachedData ?? [];
        sensors = _cachedSensors ?? [];
        _buildPersonDetails();
        _isReady = true;
      });
    }
  }

  static Future<void> _loadStaticData() async {
    if (_isInitialized) return;

    try {
      // Load both JSON files
      final pointsJson =
          await rootBundle.loadString('assets/json_data/points.json');
      final sensorsJson =
          await rootBundle.loadString('assets/json_data/sensors.json');

      final pointsData = jsonDecode(pointsJson) as List<dynamic>;
      final sensorsData = jsonDecode(sensorsJson) as List<dynamic>;

      // Process and cache the data
      _cachedData = pointsData
          .cast<List<dynamic>>()
          .map((e) =>
              WeightedLatLng(LatLng(e[0] as double, e[1] as double), 1.0))
          .toList();

      _cachedSensors = sensorsData
          .cast<List<dynamic>>()
          .map((e) => LatLng(e[0] as double, e[1] as double))
          .toList();

      _isInitialized = true;
    } catch (e) {
      debugPrint('Error loading map data: $e');
      // Initialize with empty data on error
      _cachedData = <WeightedLatLng>[];
      _cachedSensors = <LatLng>[];
      _isInitialized = true;
    }
  }

  void _buildPersonDetails() {
    debugPrint('Building person details for ${widget.users.length} users');
    debugPrint('Activities available for: ${widget.activities.keys.toList()}');

    personDetails = {
      for (var user in widget.users)
        user.username: {
          "avatarUrl": user.profilePicUrl,
          "GHGIndex": user.ghgIndex,
          "lastActivities": widget.activities[user.username]?.map((activity) {
                debugPrint(
                    'Activity for ${user.username}: ${activity.title}, value: ${activity.value}');
                return {
                  "label": activity.title,
                  "type": activity.value > 0 ? "good" : "bad",
                };
              }).toList() ??
              <Map<String, dynamic>>[],
        }
    };

    // Debug print the final person details
    for (var entry in personDetails.entries) {
      debugPrint(
          '${entry.key}: ${entry.value["lastActivities"]?.length ?? 0} activities');
    }
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
        key: ValueKey(
            'modal_${name}_${personDetails[name]?["lastActivities"]?.length ?? 0}'),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {
          currentModalName = null;
          isModalSensor = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show loading until everything is ready
    if (!_isReady) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Build markers
    final sensorMarkers = sensors
        .asMap()
        .entries
        .map((entry) => Marker(
              key: ValueKey('sensor_${entry.key}'),
              point: entry.value,
              child: GestureDetector(
                onTap: () => _showModal("Sensor", true),
                child: const Icon(Icons.sensors, color: Colors.red, size: 50),
              ),
            ))
        .toList();

    final userMarkers = widget.users
        .map((user) => Marker(
              key: ValueKey(
                  'user_${user.username}_${widget.activities[user.username]?.length ?? 0}'),
              point: user.location,
              width: 120.0,
              height: 120.0,
              child: GestureDetector(
                onTap: () => _showModal(user.username, false),
                child: Person(
                  key: ValueKey('person_${user.username}'),
                  name: user.username,
                  url: user.profilePicUrl,
                ),
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
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
            if (data.isNotEmpty)
              HeatMapLayer(
                heatMapDataSource: InMemoryHeatMapDataSource(data: data),
                heatMapOptions: HeatMapOptions(
                  gradient: gradients[index],
                  minOpacity: 0.1,
                ),
                reset: _rebuildStream.stream,
              ),
            MarkerLayer(
              markers: [...sensorMarkers, ...userMarkers],
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
  final Map<String, Map<String, dynamic>> personDetails;

  const _ModalContent({
    super.key,
    required this.name,
    required this.isSensor,
    required this.personDetails,
  });

  @override
  Widget build(BuildContext context) {
    // Debug print for modal content
    debugPrint('Modal opening for $name');
    debugPrint('Person details available: ${personDetails.containsKey(name)}');
    if (personDetails.containsKey(name)) {
      debugPrint(
          'Activities count: ${personDetails[name]?["lastActivities"]?.length ?? 0}');
    }

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
              key: ValueKey('modal_avatar_$name'),
              radius: 40,
              backgroundImage: personDetails[name]?['avatarUrl'] == null ||
                      personDetails[name]?['avatarUrl'].isEmpty ||  personDetails[name]?['avatarUrl'] == "http://localhost:8080"
                  ? const AssetImage('assets/images/user_profile.png')
                      as ImageProvider<Object>?
                  : NetworkImage(personDetails[name]?['avatarUrl'] ?? ''),
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
          if (!isSensor) ...[
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
                          color: index <
                                  ((personDetails[name]?['GHGIndex'] != null
                                      ? (personDetails[name]?['GHGIndex'] /
                                              25 ??
                                          0)
                                      : 0))
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
                  itemCount:
                      personDetails[name]?['lastActivities']?.length ?? 0,
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
                        Text(activity['label'] ?? ''),
                      ],
                    );
                  },
                ),
              ),
          ],
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
        color: Colors.blueAccent.withAlpha(50),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: _buildAvatar(),
          ),
          const SizedBox(height: 4),
          SizedBox(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      key: ValueKey('avatar_$name'),
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: url.isNotEmpty
            ? Image.network(
                url,
                fit: BoxFit.cover,
                width: 80,
                height: 80,
                errorBuilder: (context, error, stackTrace) => _defaultAvatar(),
              )
            : _defaultAvatar(),
      ),
    );
  }

  Widget _defaultAvatar() {
    return Container(
      color: const Color(0xFF7DD334).withValues(alpha: 0.5),
      child: Image.asset(
        'assets/images/user_profile.png',
        fit: BoxFit.cover,
        width: 80,
        height: 80,
      ),
    );
  }
}
