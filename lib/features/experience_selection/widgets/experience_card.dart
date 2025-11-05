import 'package:flutter/material.dart';
import '../../../core/models/experience_model.dart';

class ExperienceCard extends StatelessWidget {
  final Experience experience;
  final bool isSelected;
  final VoidCallback onTap;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(experience.imageUrl),
                fit: BoxFit.cover,
                colorFilter: isSelected
                    ? null
                    : const ColorFilter.mode(Colors.grey, BlendMode.saturation),
              ),
            ),
          ),
          if (isSelected)
            Positioned(
              top: 8,
              right: 8,
              child: Icon(Icons.check_circle, color: Colors.greenAccent, size: 28),
            ),
          Positioned(
            bottom: 12,
            left: 12,
            child: Text(
              experience.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 4, color: Colors.black)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
