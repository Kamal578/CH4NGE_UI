import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/features/layers/domain/entities/activity_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_all_users.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_friends.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_friends_activities.dart';
import 'package:ch4nge/features/layers/domain/use_cases/update_friends.dart';
import 'package:ch4nge/features/layers/presentation/screens/map/widgets/friends_activity_sheet.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:ch4nge/features/layers/presentation/screens/map/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
    required this.getFriendsActivitiesUseCase,
    required this.getFriendsUseCase,
    required this.getAllUsersUseCase,
    required this.updateFriendsUseCase,
  });

  final GetFriendsUseCase getFriendsUseCase;
  final GetFriendsActivitiesUseCase getFriendsActivitiesUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;
  final UpdateFriendsUseCase updateFriendsUseCase;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  final String userId = AuthManager.getId();
  List<UserEntity>? users = [];
  List<UserEntity>? friends = [];
  Map<String, List<ActivityEntity>>? activities = {};
  bool isLoading = true;

  // Search functionality
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchExpanded = false;
  List<UserEntity> _filteredUsers = [];
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _loadData();
    _setupAnimations();
    _setupSearchListeners();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void _setupSearchListeners() {
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus && !_isSearchExpanded) {
        _expandSearch();
      }
    });

    _searchController.addListener(() {
      _filterUsers(_searchController.text);
    });
  }

  void _expandSearch() {
    setState(() {
      _isSearchExpanded = true;
      _filteredUsers = users ?? [];
    });
    _animationController.forward();
  }

  void _collapseSearch() {
    _animationController.reverse().then((_) {
      setState(() {
        _isSearchExpanded = false;
        _filteredUsers.clear();
        _loadData();
        _setupAnimations();
        _setupSearchListeners();
      });
    });
    _searchFocusNode.unfocus();
    _searchController.clear();
  }

  void _filterUsers(String query) {
    if (users == null) return;

    setState(() {
      if (query.isEmpty) {
        _filteredUsers = users!;
      } else {
        _filteredUsers = users!
            .where((user) =>
                user.username.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> _toggleFollowStatus(UserEntity user) async {
    try {
      // Optimistically update the UI
      setState(() {
        if (friends!.any((friend) => friend.userId == user.userId)) {
          friends!.removeWhere((friend) => friend.userId == user.userId);
        } else {
          friends!.add(user);
        }
      });

      List<String> friendIds =
          friends!.map((friend) => friend.userId.toString()).toList();

      await widget.updateFriendsUseCase(
        userId,
        friendIds,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${friends!.any((friend) => friend.userId == user.userId) ? 'Followed' : 'Unfollowed'} ${user.username}'),
        ),
      );
    } catch (e) {
      // Revert the optimistic update in case of an error
      setState(() {
        if (friends!.any((friend) => friend.userId == user.userId)) {
          friends!.removeWhere((friend) => friend.userId == user.userId);
        } else {
          friends!.add(user);
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update follow status')),
      );
    }
  }

  Future<void> _loadData() async {
    try {
      final id = AuthManager.getId();

      final friendsList = await widget.getFriendsUseCase(userId);
      final friends = friendsList.right
          .where((user) => user.userId != int.parse(id))
          .toList();
      final allUsers = await widget.getAllUsersUseCase();
      debugPrint(
          'All Users: ${allUsers.right.map((user) => user.username).toList()}');
      debugPrint(
          'Friends: ${friends.map((friend) => friend.username).toList()}');

      final friendIdToUsername = {
        for (final user in friends) user.userId: user.username,
      };

      final friendIds = friendIdToUsername.keys.toList();
      final activities =
          await widget.getFriendsActivitiesUseCase(friendIds.map((e) => e.toString()).toList());

      final Map<String, List<ActivityEntity>> result = {};

      for (final activity in activities) {
        final username = friendIdToUsername[activity.userId] ?? 'Unknown';
        result.putIfAbsent(username, () => []).add(activity);
      }

      setState(() {
        users = allUsers.right.where((element) {
          return element.userId.toString() != id;
        }).toList();

        this.friends = friends;
        this.activities = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Error loading data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load data. Please try again.')),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          if (_isSearchExpanded) {
            _collapseSearch();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildCustomAppbarWidget(),
          bottomNavigationBar: _buildCustomNavbarWidget(),
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              GHGMap(users: friends!, activities: activities!),
              if (_isSearchExpanded)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: _collapseSearch,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: Colors.black54,
                    ),
                  ),
                ),
              _buildExpandableSearchWidget(),
              FriendsActivitySheet(users: friends!, activities: activities!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableSearchWidget() {
    return AnimatedBuilder(
      animation: _expandAnimation,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.fromLTRB(0, 4.h, 0, 12.h),
          height: _isSearchExpanded
              ? 36.h +
                  12.h +
                  (200.h *
                      _expandAnimation.value) // Base height + expanded content
              : 36.h + 12.h, // Just the search bar height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(224),
                blurRadius: 3,
                spreadRadius: 0.5,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  width: double.maxFinite,
                  height: 32.h,
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme: const TextSelectionThemeData(
                        cursorColor: Colors.black54,
                      ),
                    ),
                    child: SearchBar(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      hintText: "Search for your friends",
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      textStyle: WidgetStateProperty.all(
                        TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                      elevation: WidgetStateProperty.all(0.5),
                      overlayColor:
                          WidgetStateProperty.all(Colors.grey.shade100),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(
                              color: Colors.grey.shade300, width: 1.w),
                        ),
                      ),
                      trailing: _isSearchExpanded
                          ? [
                              IconButton(
                                icon: const Icon(Icons.close, size: 20),
                                onPressed: _collapseSearch,
                              )
                            ]
                          : null,
                    ),
                  ),
                ),
              ),

              // Expanded Content
              if (_isSearchExpanded)
                Expanded(
                  child: FadeTransition(
                    opacity: _expandAnimation,
                    child: _buildSearchResults(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    if (_filteredUsers.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(16.w),
        child: Center(
          child: Text(
            _searchController.text.isEmpty
                ? 'Start typing to search for friends'
                : 'No friends found',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: _filteredUsers.length,
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final user = _filteredUsers[index];
        return _buildUserListItem(user);
      },
    );
  }

  Widget _buildUserListItem(UserEntity user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Profile Picture
          CircleAvatar(
            radius: 24.r,
            backgroundColor: const Color(0xFF7DD334).withValues(alpha: .1),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: (user.profilePicUrl.isEmpty)
                  ? Image.asset(
                      'assets/images/user_profile.png',
                      fit: BoxFit.cover,
                      width: 32.r,
                      height: 32.r,
                    )
                  : Image.network(
                      user.profilePicUrl,
                      fit: BoxFit.cover,
                      width: 32.r,
                      height: 32.r,
                    ),
            ),
          ),

          SizedBox(width: 12.w),

          // Username
          Expanded(
            child: Text(
              user.username,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Follow/Unfollow Button
          SizedBox(
            height: 32.h,
            child: ElevatedButton(
              onPressed: () => _toggleFollowStatus(user),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    friends!.any((friend) => friend.userId == user.userId)
                        ? Colors.grey.shade300
                        : const Color(0xFF7DD334),
                foregroundColor:
                    friends!.any((friend) => friend.userId == user.userId)
                        ? Colors.black87
                        : Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
              child: Text(
                friends!.any((friend) => friend.userId == user.userId)
                    ? 'Unfollow'
                    : 'Follow',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CustomBottomNavBar _buildCustomNavbarWidget() {
    return const CustomBottomNavBar(
      selectedIndex: 4,
    );
  }

  CustomAppBar _buildCustomAppbarWidget() {
    return const CustomAppBar(
      backgroundColor: Colors.white,
    );
  }
}
