import 'package:flutter/material.dart';
import '../theme/app_color.dart';

class AnimatedBanner extends StatefulWidget {
  const AnimatedBanner({super.key});

  @override
  State<AnimatedBanner> createState() => _AnimatedBannerState();
}

class _AnimatedBannerState extends State<AnimatedBanner> {

  final PageController _controller = PageController();
  int currentPage = 0;

  final List<String> images = [
    "https://t4.ftcdn.net/jpg/02/83/46/33/360_F_283463385_mfnrx6RPU3BqObhVuVjYZjeZ5pegE7xq.jpg",
    "https://img.freepik.com/free-vector/app-development-banner_33099-1720.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkykdZktSHtXBLrJA313iDOl6Qn3GsrW5LBQ&s",
  ];

  @override
  void initState() {
    super.initState();
    _autoSlide();
  }

  void _autoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      currentPage++;
      if (currentPage >= images.length) {
        currentPage = 0;
      }

      _controller.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      _autoSlide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Image.network(
              images[index],
              fit: BoxFit.cover,
              width: double.infinity,
            );
          },
        ),
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
                  (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: currentPage == index ? 18 : 8,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? AppColors.primary
                      : Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}