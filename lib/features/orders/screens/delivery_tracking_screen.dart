import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// --- Searching Driver Screen ---

class SearchingDriverScreen extends StatefulWidget {
  const SearchingDriverScreen({super.key});

  @override
  State<SearchingDriverScreen> createState() => _SearchingDriverScreenState();
}

class _SearchingDriverScreenState extends State<SearchingDriverScreen>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late Animation<double> _rippleAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    // Simulate finding a driver after 5 seconds
    _navigationTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DeliveryTrackingScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00B14F);

    return Scaffold(
      body: Stack(
        children: [
          // 1. Map Background
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(40.7128, -74.0060), // New York
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName:
                    'com.caffely.app', // Replace with your app package
              ),
              // Grey Overlay
              PolygonLayer(
                polygons: [
                  Polygon(
                    points: [
                      const LatLng(90, -180),
                      const LatLng(90, 180),
                      const LatLng(-90, 180),
                      const LatLng(-90, -180),
                    ],
                    color: Colors.white.withOpacity(0.8),
                  ),
                ],
              ),
            ],
          ),

          // 2. Main Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Expanded(
                        child: Text(
                          "Searching Driver",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Balance for back button
                    ],
                  ),
                ),

                const Spacer(),

                // Searching Graphic
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.electric_scooter,
                      size: 48,
                      color: primaryGreen,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Finding you a nearby driver...",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "This may take a few seconds...",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 80), // Space for ripple
                    // Ripple Effect with User Image
                    AnimatedBuilder(
                      animation: _rippleAnimation,
                      builder: (context, child) {
                        return SizedBox(
                          height: 200,
                          width: 200,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer ripple
                              Container(
                                width: 200 * _rippleAnimation.value,
                                height: 200 * _rippleAnimation.value,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryGreen.withOpacity(
                                    0.15 * (1 - _rippleAnimation.value),
                                  ),
                                ),
                              ),
                              // Middle ripple
                              Container(
                                width: 150 * _rippleAnimation.value,
                                height: 150 * _rippleAnimation.value,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryGreen.withOpacity(
                                    0.2 * (1 - _rippleAnimation.value),
                                  ),
                                ),
                              ),
                              // Inner ripple
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryGreen.withOpacity(0.2),
                                ),
                              ),
                              // Profile Image
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  image: const DecorationImage(
                                    // Placeholder image logic
                                    image: NetworkImage(
                                      'https://i.pravatar.cc/150?img=11',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const Spacer(),

                // Slide to Cancel
                Container(
                  margin: const EdgeInsets.all(24),
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      const Center(
                        child: Text(
                          ">> Slide to Cancel",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Simple draggable simulation or actual Dismissible
                      Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          Navigator.pop(context);
                        },
                        background: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color:
                                Colors.red, // Match the screenshot red button
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Delivery Tracking Screen ---

class DeliveryTrackingScreen extends StatelessWidget {
  const DeliveryTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00B14F);

    // Mock coordinates
    final LatLng driverPos = const LatLng(40.7128, -74.0060);
    final LatLng shopPos = const LatLng(40.7150, -74.0080);
    final LatLng destinationPos = const LatLng(
      40.7100,
      -74.0040,
    ); // Not shown on map but implied

    return Scaffold(
      body: Stack(
        children: [
          // 1. Map
          FlutterMap(
            options: MapOptions(initialCenter: driverPos, initialZoom: 16),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.caffely.app',
              ),
              // Route Line
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      shopPos,
                      const LatLng(40.7140, -74.0070),
                      driverPos,
                    ],
                    color: primaryGreen,
                    strokeWidth: 4,
                  ),
                ],
              ),
              // Markers
              MarkerLayer(
                markers: [
                  // Driver Marker
                  Marker(
                    point: driverPos,
                    width: 50,
                    height: 50,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(blurRadius: 4, color: Colors.black26),
                        ],
                      ),
                      padding: const EdgeInsets.all(2),
                      child: CircleAvatar(
                        backgroundColor: primaryGreen,
                        child: const Icon(
                          Icons.electric_scooter,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  // Shop/Start Marker
                  Marker(
                    point: shopPos,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.storefront,
                      color: primaryGreen,
                      size: 40,
                    ),
                  ),
                  // Destination Marker (optional context: simulated route end)
                  Marker(
                    point: destinationPos,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: primaryGreen,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 2. UI Overlays

          // Back Button
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE0F7EA), // Light green bg
                ),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),

          // Location Target Button
          Positioned(
            bottom: 250, // Approx above sheet
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: primaryGreen,
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
              ),
              child: const Icon(Icons.my_location, color: Colors.white),
            ),
          ),

          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Driver is heading to the Coffee Shop...",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Driver Profile
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?img=12',
                          ), // Mock driver image
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rayford Chenail",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Yamaha MX King",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "4.8",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "HSW 4736 XK",
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: Icons.close,
                        color: Colors.red,
                        onTap: () => Navigator.pop(context),
                        isOutlined: true,
                      ),
                      _buildActionButton(
                        icon: Icons.chat_bubble_outline,
                        color: primaryGreen,
                        onTap: () {},
                        isOutlined: true,
                      ),
                      _buildActionButton(
                        icon: Icons.phone,
                        color: primaryGreen,
                        onTap: () {},
                        isOutlined: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required bool isOutlined,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 1.5),
          color: Colors.white,
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}
