import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_detail.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite,
  });
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  _selectMealItem(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealDetailScreen(
              meal: meal,
              onToggleFavorite: onToggleFavorite,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget mainContent =
        meals.isEmpty
            ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Uh oh noting here',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Try selecting a different category',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            )
            : ListView.builder(
              itemCount: meals.length,
              itemBuilder:
                  (ctx, index) => MealItem(
                    meal: meals[index], //
                    onSelectMealItem: () {
                      _selectMealItem(context, meals[index]);
                    },
                  ),
            );
    if (title == null) {
      return mainContent;
    }

    return Scaffold(appBar: AppBar(title: Text(title!)), body: mainContent);
  }
}
