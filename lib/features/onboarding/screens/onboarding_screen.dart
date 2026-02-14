import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/screens/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: "Get Your Coffee -\nAnytime, Anywhere",
      description:
          "Choose the way you want to enjoy your coffee with Caffely. Just a few taps on the app, and your coffee is ready for you.",
      imagePlaceholderColor: Colors.grey.shade300,
    ),
    OnboardingContent(
      title: "Seamless Payments with\nOur Secure Wallet",
      description:
          "Say goodbye to hassle and hello to seamless transactions with Caffely.s secure wallet. Making payments has never been easier.",
      imagePlaceholderColor: Colors.grey.shade300,
    ),
    OnboardingContent(
      title: "Explore the World of\nCoffee Right Now",
      description:
          "Dive into the fascinating world of coffee with Caffely. Discover unique and delightful coffee flavors, one sip at a time.",
      imagePlaceholderColor: Colors.grey.shade300,
    ),
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);

    if (!mounted) return;

    // Navigate to the welcome screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  void _nextPage() {
    if (_currentPage < _contents.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skip() {
    _completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    // Define the primary green color used in the design
    const Color primaryGreen = Color(0xFF00B14F);

    return Scaffold(
      body: Column(
        children: [
          // Top Section with Curve and Image Placeholder
          Expanded(
            flex: 6, // Takes up more space
            child: Stack(
              children: [
                // Green Background with Curved Bottom
                ClipPath(
                  clipper: BottomConcaveClipper(),
                  child: Container(
                    color: primaryGreen,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                // Image Placeholder
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 40.0,
                    ), // Adjust as needed
                    child: Container(
                      width: 250,
                      height: 450, // Phone screen ratio
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(
                          alpha: 0.2,
                        ), // Semi-transparent placeholder
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Center(
                        child: Text(
                          "Image Placeholder",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Section with Text and Controls
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (value) {
                        setState(() {
                          _currentPage = value;
                        });
                      },
                      itemCount: _contents.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(
                              _contents[index].title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _contents[index].description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                                height: 1.5,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  // Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _contents.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 6,
                        width: _currentPage == index ? 24 : 6,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? primaryGreen
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Buttons
                  if (_currentPage == _contents.length - 1)
                    // Get Started Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _completeOnboarding,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  else
                    // Skip and Continue Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _skip,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFFE8F5E9,
                                ), // Light green
                                textStyle: const TextStyle(color: primaryGreen),
                                foregroundColor: primaryGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "Skip",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _nextPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "Continue",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingContent {
  final String title;
  final String description;
  final Color imagePlaceholderColor;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.imagePlaceholderColor,
  });
}

class BottomConcaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60); // Start slightly above the bottom left

    // Draw a quadratic bezier curve for the concave shape
    // Control point is at the center bottom, end point is at the bottom right
    var firstControlPoint = Offset(size.width / 2, size.height + 40);
    var firstEndPoint = Offset(size.width, size.height - 60);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    path.lineTo(size.width, 0); // Line to top right
    path.lineTo(0, 0); // Line to top left
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
