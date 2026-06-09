import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.rating,
    this.onRatingChanged,
    this.size = 32,
  });

  final int rating;
  final ValueChanged<int>? onRatingChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final star = index + 1;
        final filled = star <= rating;

        return IconButton(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          constraints: BoxConstraints(minWidth: size, minHeight: size),
          onPressed:
              onRatingChanged != null ? () => onRatingChanged!(star) : null,
          icon: Icon(
            filled ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: size,
          ),
        );
      }),
    );
  }
}
