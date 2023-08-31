import 'package:challenge/config.dart';
import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  final String filter;
  final Function(String value) handleFilter;
  const FilterWidget(
    this.filter, 
    {super.key,required this.handleFilter});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 10, bottom: 4),
      child: InkWell(
        onTap: () => handleFilter(filter),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            capitalize(filter),
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
      ),
    );
    ;
  }
}
