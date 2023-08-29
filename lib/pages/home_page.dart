

import 'package:challenge/components/location_widget.dart';
import 'package:challenge/models/response_model.dart';
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
  List<String> filters = [];

  bool isLoading = false;
  TextEditingController searchFieldController = TextEditingController();


List<String> extractUniqueTypes(List<Location> locations) {
  Set<String> uniqueTypes = Set();
  for (var location in locations) {
    uniqueTypes.add(location.type);
  }
  return uniqueTypes.toList();
}

  searchLocations(String value) async {
    if (value.isNotEmpty) {
      setState(() => isLoading = true);
      ResponseModel? result =
          await LocationController.getLocations(search: value);
      if (result == null) {
        ShowSnackBar().showSnackBar(
          context,
          "Something went wrong",
          duration: const Duration(seconds: 2),
          noAction: true,
        );
      } else {
        // List<String> availableTypes = extractUniqueTypes(result.locations); 
        setState(() {
          // filters = availableTypes;
          isLoading = false;
          locations = result.locations;
        });
      }
    } else {
      setState(() {
        // filters = [];
        locations = [];
      });
    }
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
          child: Column(
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
                            borderSide:
                                BorderSide(color: Colors.grey.shade200, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          floatingLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onEditingComplete: () => searchLocations(searchFieldController.text),
                        // onChanged: searchLocations,
                      ),
                    ),
                    IconButton(onPressed: () => searchLocations(searchFieldController.text),
                    icon: const Icon(Icons.search),)
                  ],
                ),
              ),
              // Row(children: filters.map((filter) => Text(filter)).toList()),
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
