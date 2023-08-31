import 'package:challenge/components/filter_widget.dart';
import 'package:challenge/components/location_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:challenge/controllers/locations_controller.dart';

import 'package:challenge/helpers/snackbar.dart';
import 'package:challenge/models/location_model.dart';
import 'package:challenge/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? backButtonPressTime;
  List<Location> locations = [];
  List<Location> allLocations = [];
  List<String> filters = [];

  bool isLoading = false;
  TextEditingController searchFieldController = TextEditingController();

  List<String> extractUniqueTypes(List<Location> locations) {
    Set<String> uniqueTypes = {};
    uniqueTypes.add("all");
    for (var location in locations) {
      uniqueTypes.add(location.type);
    }
    return uniqueTypes.toList();
  }

  searchLocations(String value) {
    if (value.isEmpty) {
      ShowSnackBar().showSnackBar(
        context,
        "please enter a text into a search field",
        duration: const Duration(seconds: 2),
        noAction: true,
      );
      return;
    }

    setState(() {
      isLoading = true;
      locations = [];
      allLocations = [];
      filters = [];
    });
    LocationController.getLocations(search: value).then((result) {
      if (result == null) {
        ShowSnackBar().showSnackBar(
          context,
          "Something went wrong",
          duration: const Duration(seconds: 2),
          noAction: true,
        );
        return;
      }
      if (result.locations.isEmpty) {
        ShowSnackBar().showSnackBar(
          context,
          "No data found",
          duration: const Duration(seconds: 5),
          noAction: true,
        );
      }
      final availableFilters = extractUniqueTypes(result.locations);
      setState(() {
        filters = availableFilters;
        isLoading = false;
        locations = result.locations;
        allLocations = result.locations;
      });
    }).onError((error, stackTrace) {
      logger.e(error);
      logger.d(stackTrace);
      setState(() {
        isLoading = false;
        filters = [];
        locations = [];
        allLocations = [];
      });
      ShowSnackBar().showSnackBar(
        context,
        "No data found",
        duration: const Duration(seconds: 5),
        noAction: true,
      );
    });
  }

  Future<bool> handleWillPop(BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            now.difference(backButtonPressTime!) > const Duration(seconds: 3);

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      ShowSnackBar().showSnackBar(
        context,
        "Press Back Again to Exit App",
        duration: const Duration(seconds: 2),
        noAction: true,
      );
      return false;
    }
    return true;
  }

  void handleFilter(filter) {
    if(filter == "all"){
      setState(() => locations = allLocations );
      return;
    }

    setState(() {
      locations = allLocations.where((element) => element.type == filter).toList();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xffecebe7),
        title: const Text(
          "Hello 👋",
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        toolbarHeight: 70,
        elevation: 0,
      ),
      body: WillPopScope(
        onWillPop: () => handleWillPop(context),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchFieldController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0.0),
                          labelText: 'Search',
                          hintText: 'Search for location...',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                          prefixIcon: const Icon(
                            CupertinoIcons.search,
                            color: Colors.black,
                            size: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade200, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          floatingLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onEditingComplete: () =>
                            searchLocations(searchFieldController.text),
                        // onChanged: searchLocations,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          searchLocations(searchFieldController.text),
                      icon: const Icon(Icons.search),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: filters
                        .map((filter) =>
                            FilterWidget(filter, handleFilter: handleFilter))
                        .toList()),
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Palette.primaryColor,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: locations
                          .map((location) => LocationWidget(location: location))
                          .toList(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
