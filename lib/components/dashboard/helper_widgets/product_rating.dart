import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(double rating);

class ProductRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback? onChange;
  const ProductRating({Key? key, this.starCount = 5, this.rating = .0, this.onChange}) : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: Theme.of(context).primaryColor,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: Theme.of(context).primaryColor,
      );
    }
    return InkResponse(
      child: icon,
      onTap: onChange == null ? null : () => onChange!(index + 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: List.generate(starCount, (index) => buildStar(context, index)));
  }
}
