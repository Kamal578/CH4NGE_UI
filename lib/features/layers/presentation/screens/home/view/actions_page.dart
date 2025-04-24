import 'package:ch4nge/features/layers/domain/use_cases/upload_action.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ActionsPage extends StatefulWidget {
  const ActionsPage({
    super.key,
    required this.uploadActivityUseCase,
  });

  final UploadActionUseCase uploadActivityUseCase;

  @override
  State<ActionsPage> createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  String? _selectedTransportMode;
  String? _selectedGreenAction;
  String _selectedDistanceUnit = 'km';
  String _selectedDurationUnit = 'minutes';
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

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
              onRecordAction: () {
                if (_selectedTransportMode == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select a transport mode")),
                  );
                } else {
                  print("""
                    Recorded transport: $_selectedTransportMode
                    Distance: ${_distanceController.text} $_selectedDistanceUnit}
                    Duration: ${_durationController.text} $_selectedDurationUnit}
                  """);
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
                  content: Text("Private Vehicle content"),
                ),
                ExpansionSectionData(
                  title: "Public Transport",
                  content: Text("Public Trasport content"),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            ExpandableActionCard(
              title: "Green Action",
              onRecordAction: () {
                if (_selectedGreenAction == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select an action")),
                  );
                } else {
                  debugPrint("Recorded green action: $_selectedGreenAction");
                }
              },
              sections: [
                ExpansionSectionData(
                  title: "Choose an Action",
                  content: Column(
                    children: [
                      RadioListTile<String>(
                        activeColor: Color.fromARGB(255, 125, 211, 52),
                        title: const Text("Planted a tree"),
                        value: "Planted a tree",
                        groupValue: _selectedGreenAction,
                        onChanged: (value) {
                          setState(() {
                            _selectedGreenAction = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: Color.fromARGB(255, 125, 211, 52),
                        title: const Text("Turned off lights"),
                        value: "Turned off lights",
                        groupValue: _selectedGreenAction,
                        onChanged: (value) {
                          setState(() {
                            _selectedGreenAction = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: Color.fromARGB(255, 125, 211, 52),
                        title: const Text("Recycling"),
                        value: "Recycling",
                        groupValue: _selectedGreenAction,
                        onChanged: (value) {
                          setState(() {
                            _selectedGreenAction = value;
                          });
                        },
                      ),
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
        Divider(
          height: 1.h,
          indent: 40.w,
          endIndent: 8.w,
        ),
        _buildTransportRadio("Bicycle", Icons.pedal_bike_rounded),
        Divider(
          height: 1.h,
          indent: 40.w,
          endIndent: 8.w,
        ),
        _buildTransportRadio("E-Scooter", Icons.electric_scooter_rounded),
      ],
    );
  }

  Widget _buildTransportRadio(String value, IconData icon) {
    return RadioListTile<String>(
      activeColor: Color(0xFF7DD334),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 4.h,
      ),
      title: Row(
        children: [
          Icon(
            icon,
            size: 18.sp,
            color: Colors.grey[700],
          ),
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
      groupValue: _selectedTransportMode,
      onChanged: (newValue) =>
          setState(() => _selectedTransportMode = newValue),
    );
  }

  _buildTitleWidget() {
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

  _buildCustomAppbarWidget(BuildContext context) {
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
  final int toggleThreshold;
  final String? successMessage;
  final String? errorMessage;

  const ExpandableActionCard({
    super.key,
    required this.title,
    required this.sections,
    required this.onRecordAction,
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

  void _handleExpansion(int index) {
    setState(() {
      // Close all sections first
      if (_expandedIndex == index) {
        _expandedIndex = -1; // Close if clicking the same tile
      } else {
        _expandedIndex = index; // Open new tile and close others
      }

      // Clear any existing messages when opening/closing
      _showSuccess = false;
      _showError = false;
    });
  }

  void _recordAction() {
    widget.onRecordAction();
    setState(() {
      _showSuccess = true;
      _showError = false;
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
        key: ValueKey(
            '${section.title}_$isExpanded'), // Force rebuild on state change
        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        title: Text(section.title,
            style: const TextStyle(fontWeight: FontWeight.w500)),
        onExpansionChanged: (expanded) => _handleExpansion(index),
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
}
