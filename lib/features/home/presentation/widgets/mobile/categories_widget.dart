import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/home/data/models/category.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
    required this.categories,
    this.selectedCategory,
    required this.selectCategory,
  }) : super(key: key);

  final List<Category> categories;
  final Category? selectedCategory;
  final Function(Category category) selectCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: categories
            .map(
              (Category category) => GestureDetector(
                onTap: () {
                  selectCategory(category);
                },
                child: _builderCategoryItem(
                  context,
                  categoryName: category.name,
                  selected: category.id == selectedCategory?.id,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _builderCategoryItem(BuildContext context,
      {required String categoryName, required bool selected}) {
    return Container(
      decoration: BoxDecoration(
        color: selected
            ? Theme.of(context).primaryColor
            : Color.fromARGB(255, 0, 0, 0),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
      child: Text(
        categoryName,
        style: GoogleFonts.cairo(
          textStyle: TextStyle(
            color: selected ? Colors.white : Color.fromARGB(255, 243, 243, 243),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
