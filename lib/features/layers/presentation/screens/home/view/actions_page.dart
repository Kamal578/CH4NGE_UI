import 'package:ch4nge/features/layers/data/datasources/achievement_datasource.dart';
import 'package:ch4nge/features/layers/data/datasources/activity_datasource.dart';
import 'package:ch4nge/features/layers/data/datasources/mini_challenge_datasource.dart';
import 'package:ch4nge/features/layers/data/datasources/user_datasource.dart';
import 'package:ch4nge/features/layers/data/datasources/weekly_challenge_datasource.dart';
import 'package:ch4nge/features/layers/domain/entities/action/green_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/action/transportation_entity.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_current_location.dart';
import 'package:ch4nge/features/layers/domain/use_cases/upload_action.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ActionsPage extends StatefulWidget {
  const ActionsPage({
    super.key,
    required this.uploadActionUseCase,
    required this.getCurrentLocationUseCase,
  });

  final UploadActionUseCase uploadActionUseCase;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;

  @override
  State<ActionsPage> createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  String? _selectedTransportMode;
  String? _selectedVehicle;
  String? _selectedGreenAction;
  String _selectedDistanceUnit = 'km';
  String _selectedDurationUnit = 'minutes';
  String _selectedFuelType = 'Gasoline';
  String _selectedPublicTransport = 'Bus';
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _fuelConsumptionController =
      TextEditingController();
  final TextEditingController _passengersController = TextEditingController();

  void _resetFormFields() {
    setState(() {
      _selectedTransportMode = null;
      _selectedVehicle = null;
      _selectedGreenAction = null;
      _selectedDistanceUnit = 'km';
      _selectedDurationUnit = 'minutes';
      _selectedFuelType = 'Gasoline';
      _selectedPublicTransport = 'Bus';
    });

    // Clear all text controllers
    _distanceController.clear();
    _durationController.clear();
    _fuelConsumptionController.clear();
    _passengersController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildCustomAppbarWidget(context),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16.h,
            right: 16.h,
          ),
          child: Column(children: [
            _buildTitleWidget(),
            SizedBox(height: 8.h),
            ExpandableActionCard(
              title: "Transportation",
              onSectionTap: (section) {
                setState(() {
                  _selectedTransportMode =
                      section.title.isNotEmpty ? section.title : null;
                });
              },
              onRecordAction: () async {
                if (_selectedTransportMode == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select a transport mode")),
                  );
                } else {
                  final locationService = GetCurrentLocationUseCase();
                  final result = await locationService.call();
                  final location = [result.latitude!, result.longitude!];

                  if (result.isSuccess) {
                    debugPrint(
                        'Location: ${result.latitude}, ${result.longitude}');
                  } else {
                    debugPrint('Error: ${result.error!.message}');
                    if (result.error!.requiresSettingsAction) {}
                  }
                  final distance =
                      double.tryParse(_distanceController.text) ?? 0.0;
                  final duration =
                      double.tryParse(_durationController.text) ?? 0.0;

                  TransportationEntity action;

                  switch (_selectedTransportMode) {
                    case "Active Commute":
                      if (_selectedVehicle == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Please select a transport mode")),
                        );
                        return;
                      }
                      action = TransportationEntity.activeCommute(
                        vehicle: _selectedVehicle!,
                        location: location,
                        distance: distance,
                        duration: duration,
                        distanceUnit: _selectedDistanceUnit,
                        durationUnit: _selectedDurationUnit,
                      );
                      break;
                    case "Private Vehicle":
                      action = TransportationEntity.privateVehicle(
                        location: location,
                        distance: distance,
                        duration: duration,
                        distanceUnit: _selectedDistanceUnit,
                        durationUnit: _selectedDurationUnit,
                        fuelType: _selectedFuelType,
                        fuelConsumption:
                            double.tryParse(_fuelConsumptionController.text),
                        fuelConsumptionUnit: "L/100km",
                        numberOfPassengers:
                            int.tryParse(_passengersController.text),
                      );
                      break;
                    case "Public Transport":
                      action = TransportationEntity.publicTransport(
                        publicTransportType: _selectedPublicTransport,
                        location: location,
                        distance: distance,
                        duration: duration,
                        distanceUnit: _selectedDistanceUnit,
                        durationUnit: _selectedDurationUnit,
                      );
                      break;
                    default:
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Invalid transport mode selected")),
                      );
                      return;
                  }

                  widget.uploadActionUseCase(action);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Transport action recorded successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );

                  _resetFormFields();

                  debugPrint("Recorded transport action: ${action.toString()}");
                }
              },
              sections: [
                ExpansionSectionData(
                  title: "Active Commute",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      _buildUnitInputField(
                        controller: _distanceController,
                        label: "Distance",
                        selectedUnit: _selectedDistanceUnit,
                        units: const ['km', 'm'],
                        onUnitChanged: (unit) =>
                            setState(() => _selectedDistanceUnit = unit!),
                      ),
                      SizedBox(height: 16.h),
                      _buildUnitInputField(
                        controller: _durationController,
                        label: "Duration",
                        selectedUnit: _selectedDurationUnit,
                        units: const ['minutes', 'hours'],
                        onUnitChanged: (unit) =>
                            setState(() => _selectedDurationUnit = unit!),
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          "Select Transport Mode",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildTransportRadioTiles(),
                    ],
                  ),
                ),
                ExpansionSectionData(
                  title: "Private Vehicle",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      _buildUnitInputField(
                        controller: _distanceController,
                        label: "Distance",
                        selectedUnit: _selectedDistanceUnit,
                        units: const ['km', 'm'],
                        onUnitChanged: (unit) =>
                            setState(() => _selectedDistanceUnit = unit!),
                      ),
                      SizedBox(height: 16.h),
                      _buildUnitInputField(
                        controller: _durationController,
                        label: "Duration",
                        selectedUnit: _selectedDurationUnit,
                        units: const ['minutes', 'hours'],
                        onUnitChanged: (unit) =>
                            setState(() => _selectedDurationUnit = unit!),
                      ),
                      SizedBox(height: 16.h),
                      _buildUnitInputField(
                        controller: _fuelConsumptionController,
                        label: "Fuel Consumption",
                        selectedUnit: "L/100km",
                        units: const ['L/100km', 'mpg'],
                        onUnitChanged: (unit) => {},
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: _passengersController,
                        decoration: InputDecoration(
                          labelText: "Number of Passengers",
                          labelStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: const Color(0xFF9098B1),
                              width: 1.5,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          "Select Fuel Type",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildFuelTypeRadioTiles(),
                    ],
                  ),
                ),
                ExpansionSectionData(
                  title: "Public Transport",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      _buildUnitInputField(
                        controller: _distanceController,
                        label: "Distance",
                        selectedUnit: _selectedDistanceUnit,
                        units: const ['km', 'm'],
                        onUnitChanged: (unit) =>
                            setState(() => _selectedDistanceUnit = unit!),
                      ),
                      SizedBox(height: 16.h),
                      _buildUnitInputField(
                        controller: _durationController,
                        label: "Duration",
                        selectedUnit: _selectedDurationUnit,
                        units: const ['minutes', 'hours'],
                        onUnitChanged: (unit) =>
                            setState(() => _selectedDurationUnit = unit!),
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          "Select Transport Type",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildPublicTransportRadioTiles(),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            ExpandableActionCard(
              title: "Green Action",
              onSectionTap: (section) {},
              onRecordAction: () async {
                if (_selectedGreenAction == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select an action")),
                  );
                } else {
                  final locationService = GetCurrentLocationUseCase();
                  final result = await locationService.call();
                  final location = [result.latitude!, result.longitude!];

                  if (result.isSuccess) {
                    debugPrint(
                        'Location: ${result.latitude}, ${result.longitude}');
                  } else {
                    debugPrint('Error: ${result.error!.message}');
                    if (result.error!.requiresSettingsAction) {}
                  }

                  final action = GreenEntity(
                    option: _selectedGreenAction!,
                    location: location,
                  );
                  widget.uploadActionUseCase(action);
                  _resetFormFields();

                  debugPrint("Recorded green action: $_selectedGreenAction");
                }
              },
              sections: [
                ExpansionSectionData(
                  title: "Energy Conservation",
                  content: Column(
                    children: [
                      _buildGreenActionRadio(
                          "Turned off lights", Icons.lightbulb_outline),
                      _buildGreenActionRadio(
                          "Unplugged electronics", Icons.power_off),
                      _buildGreenActionRadio("Used LED bulbs", Icons.lightbulb),
                      _buildGreenActionRadio(
                          "Adjusted thermostat", Icons.thermostat),
                      _buildGreenActionRadio(
                          "Air-dried clothes", Icons.dry_cleaning),
                    ],
                  ),
                ),
                ExpansionSectionData(
                  title: "Waste Reduction",
                  content: Column(
                    children: [
                      _buildGreenActionRadio("Recycling", Icons.recycling),
                      _buildGreenActionRadio("Composting", Icons.compost),
                      _buildGreenActionRadio(
                          "Used reusable bags", Icons.shopping_bag),
                      _buildGreenActionRadio(
                          "Reduced plastic use", Icons.no_drinks),
                      _buildGreenActionRadio(
                          "Repaired instead of replacing", Icons.build),
                    ],
                  ),
                ),
                ExpansionSectionData(
                  title: "Water Conservation",
                  content: Column(
                    children: [
                      _buildGreenActionRadio("Shorter shower", Icons.shower),
                      _buildGreenActionRadio(
                          "Fixed water leak", Icons.plumbing),
                      _buildGreenActionRadio(
                          "Used rainwater", Icons.water_drop),
                      _buildGreenActionRadio(
                          "Full dishwasher load", Icons.kitchen),
                      _buildGreenActionRadio(
                          "Turned off tap while brushing", Icons.water),
                    ],
                  ),
                ),
                ExpansionSectionData(
                  title: "Environmental Action",
                  content: Column(
                    children: [
                      _buildGreenActionRadio("Planted a tree", Icons.park),
                      _buildGreenActionRadio(
                          "Cleaned up litter", Icons.cleaning_services),
                      _buildGreenActionRadio(
                          "Participated in beach cleanup", Icons.waves),
                      _buildGreenActionRadio(
                          "Created pollinator garden", Icons.local_florist),
                      _buildGreenActionRadio(
                          "Joined environmental group", Icons.groups),
                    ],
                  ),
                ),
                ExpansionSectionData(
                  title: "Sustainable Consumption",
                  content: Column(
                    children: [
                      _buildGreenActionRadio(
                          "Bought local produce", Icons.store),
                      _buildGreenActionRadio("Chose organic food", Icons.eco),
                      _buildGreenActionRadio(
                          "Reduced meat consumption", Icons.restaurant),
                      _buildGreenActionRadio(
                          "Bought second-hand", Icons.handshake),
                      _buildGreenActionRadio(
                          "Used public library", Icons.library_books),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ]),
        ),
      ),
    );
  }

  Widget _buildUnitInputField({
    required TextEditingController controller,
    required String label,
    required String selectedUnit,
    required List<String> units,
    required ValueChanged<String?> onUnitChanged,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xFF9098B1),
                  width: 1.5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          flex: 2,
          child: DropdownButtonFormField<String>(
            dropdownColor: Colors.white,
            value: selectedUnit,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xFF9098B1),
                  width: 1.5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 2.h,
              ),
            ),
            items: units
                .map((unit) => DropdownMenuItem(
                      value: unit,
                      child: Text(
                        unit,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[800],
                        ),
                      ),
                    ))
                .toList(),
            onChanged: onUnitChanged,
            elevation: 1,
            icon: Icon(Icons.arrow_drop_down, size: 20.sp),
            isDense: true,
          ),
        ),
      ],
    );
  }

  Widget _buildTransportRadioTiles() {
    return Column(
      children: [
        _buildTransportRadio("On Foot", Icons.directions_walk_rounded),
        Divider(height: 1.h, indent: 40.w, endIndent: 8.w),
        _buildTransportRadio("Bicycle", Icons.pedal_bike_rounded),
        Divider(height: 1.h, indent: 40.w, endIndent: 8.w),
        _buildTransportRadio("E-Scooter", Icons.electric_scooter_rounded),
      ],
    );
  }

  Widget _buildFuelTypeRadioTiles() {
    return Column(
      children: [
        _buildFuelTypeRadio("Gasoline", Icons.local_gas_station),
        Divider(height: 1.h, indent: 40.w, endIndent: 8.w),
        _buildFuelTypeRadio("Diesel", Icons.local_gas_station_outlined),
        Divider(height: 1.h, indent: 40.w, endIndent: 8.w),
        _buildFuelTypeRadio("Electric", Icons.electric_car),
        Divider(height: 1.h, indent: 40.w, endIndent: 8.w),
        _buildFuelTypeRadio("Hybrid", Icons.eco),
      ],
    );
  }

  Widget _buildPublicTransportRadioTiles() {
    return Column(
      children: [
        _buildPublicTransportRadio("Bus", Icons.directions_bus),
        Divider(height: 1.h, indent: 40.w, endIndent: 8.w),
        _buildPublicTransportRadio("Metro/Subway", Icons.subway),
        Divider(height: 1.h, indent: 40.w, endIndent: 8.w),
        _buildPublicTransportRadio("Train", Icons.train),
        Divider(height: 1.h, indent: 40.w, endIndent: 8.w),
        _buildPublicTransportRadio("Tram", Icons.tram),
      ],
    );
  }

  Widget _buildTransportRadio(String value, IconData icon) {
    return RadioListTile<String>(
      activeColor: Color(0xFF7DD334),
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      title: Row(
        children: [
          Icon(icon, size: 18.sp, color: Colors.grey[700]),
          SizedBox(width: 12.w),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      value: value,
      groupValue: _selectedVehicle,
      onChanged: (newValue) => setState(() => _selectedVehicle = newValue),
    );
  }

  Widget _buildFuelTypeRadio(String value, IconData icon) {
    return RadioListTile<String>(
      activeColor: Color(0xFF7DD334),
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      title: Row(
        children: [
          Icon(icon, size: 18.sp, color: Colors.grey[700]),
          SizedBox(width: 12.w),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      value: value,
      groupValue: _selectedFuelType,
      onChanged: (newValue) => setState(() => _selectedFuelType = newValue!),
    );
  }

  Widget _buildPublicTransportRadio(String value, IconData icon) {
    return RadioListTile<String>(
      activeColor: Color(0xFF7DD334),
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      title: Row(
        children: [
          Icon(icon, size: 18.sp, color: Colors.grey[700]),
          SizedBox(width: 12.w),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      value: value,
      groupValue: _selectedPublicTransport,
      onChanged: (newValue) =>
          setState(() => _selectedPublicTransport = newValue!),
    );
  }

  Widget _buildGreenActionRadio(String value, IconData icon) {
    return RadioListTile<String>(
      activeColor: Color.fromARGB(255, 125, 211, 52),
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      title: Row(
        children: [
          Icon(icon, size: 18.sp, color: Colors.grey[700]),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
      value: value,
      groupValue: _selectedGreenAction,
      onChanged: (newValue) => setState(() => _selectedGreenAction = newValue),
    );
  }

  Container _buildTitleWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Make a step to Greener Future!",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            "Record an action to gain points and reach weekly goals. See the list of actions",
            style: TextStyle(
              fontSize: 10.sp,
              color: Color.fromARGB(128, 144, 152, 177),
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  CustomAppBar _buildCustomAppbarWidget(BuildContext context) {
    return CustomAppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          context.go('/');
        },
        child: Icon(
          Icons.arrow_back_rounded,
          size: 24.sp,
          weight: 54,
        ),
      ),
    );
  }
}

class ExpansionSectionData {
  final String title;
  final Widget content;

  ExpansionSectionData({required this.title, required this.content});
}

class ExpandableActionCard extends StatefulWidget {
  final String title;
  final List<ExpansionSectionData> sections;
  final VoidCallback onRecordAction;
  final ValueChanged<ExpansionSectionData>? onSectionTap;
  final int toggleThreshold;
  final String? successMessage;
  final String? errorMessage;

  const ExpandableActionCard({
    super.key,
    required this.title,
    required this.sections,
    required this.onRecordAction,
    required this.onSectionTap,
    this.toggleThreshold = 5,
    this.successMessage = "Action Recorded Successfully",
    this.errorMessage = "Please complete the required fields.",
  });

  @override
  State<ExpandableActionCard> createState() => _ExpandableActionCardState();
}

class _ExpandableActionCardState extends State<ExpandableActionCard> {
  int _expandedIndex = -1;
  bool _showSuccess = false;
  bool _showError = false;

  void _handleExpansion(int index, bool expanded) {
    setState(
      () {
        if (_expandedIndex == index) {
          _expandedIndex = -1;
        } else {
          _expandedIndex = index;
        }
        _showSuccess = false;
        _showError = false;
      },
    );

    if (widget.onSectionTap != null) {
      final section = widget.sections[index];
      widget.onSectionTap!(
        _expandedIndex == index
            ? section
            : ExpansionSectionData(title: '', content: const SizedBox()),
      );
    }
  }

  void _recordAction() {
    widget.onRecordAction();
    _forceDataRefresh();
    setState(() {
      _showSuccess = true;
      _showError = false;
      _expandedIndex = -1;
    });
  }

  Widget _buildTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 68, 184, 85),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildExpansionTile(int index, double maxWidth) {
    final section = widget.sections[index];
    final isExpanded = _expandedIndex == index;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        key: ValueKey('${section.title}_$isExpanded'),
        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        title: Text(section.title,
            style: const TextStyle(fontWeight: FontWeight.w500)),
        onExpansionChanged: (expanded) => _handleExpansion(index, expanded),
        initiallyExpanded: isExpanded,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: section.content,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionContainer(double maxWidth) {
    return Container(
      width: maxWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: List.generate(widget.sections.length, (index) {
          return _buildExpansionTile(index, maxWidth);
        }),
      ),
    );
  }

  Widget _buildActionButton() {
    return ElevatedButton(
      onPressed: _recordAction,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 5, 149, 186),
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        "Record Action",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildActionStatus({
    required String message,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 125, 211, 52),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            _buildTitle(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildExpansionContainer(constraints.maxWidth),
                  const SizedBox(height: 16),
                  _buildActionButton(),
                  if (_showSuccess)
                    _buildActionStatus(
                      message: widget.successMessage!,
                      color: Colors.green[600]!,
                      icon: Icons.check_circle,
                    ),
                  if (_showError)
                    _buildActionStatus(
                      message: widget.errorMessage!,
                      color: Colors.red[600]!,
                      icon: Icons.error,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _forceDataRefresh() async {
    final userDatasource = UserRemoteDatasource();
    await userDatasource.clearCache();

    final achievementDatasource = AchievementsRemote();
    await achievementDatasource.clearCache();

    final miniChallengeDatasource = MiniChallengeRemote();
    await miniChallengeDatasource.clearCache();

    final weeklyChallengeDatasource = WeeklyChallengeRemote();
    await weeklyChallengeDatasource.clearCache();

    final activityDatasource = ActivityRemote();
    await activityDatasource.clearCache();
  }
}
