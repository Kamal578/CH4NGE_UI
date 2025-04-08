import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ActionsPage extends StatelessWidget {
  const ActionsPage({super.key});

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
          child: Column(
            children: [
              _buildTitleWidget(),
              SizedBox(height: 8.h),
              ExpandableActionCard(
                title: "Transportation",
                onRecordAction: () {
                  // Add validation or submission logic here
                },
                sections: [
                  ExpansionSectionData(
                    title: "Active Commute",
                    content: Column(
                      children: [
                        TextField(
                            decoration: InputDecoration(labelText: "Distance")),
                        TextField(
                            decoration: InputDecoration(labelText: "Duration")),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text("On Foot"),
                                value: "On Foot",
                                groupValue: "On Foot",
                                onChanged: (value) {},
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text("Bicycle"),
                                value: "Bicycle",
                                groupValue: "On Foot",
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ExpansionSectionData(
                    title: "Shared Ride",
                    content: const Text("Shared Ride content"),
                  ),
                  ExpansionSectionData(
                    title: "Public Transport",
                    content: const Text("Public Transport content"),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
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
            "Record a sustainable action to gain points and reach weekly goals. See the list of actions",
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
