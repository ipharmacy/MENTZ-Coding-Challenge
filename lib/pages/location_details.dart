
import 'package:challenge/models/location_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:challenge/config.dart';


class LocationDetails extends StatefulWidget {
  final Location location;
  const LocationDetails({Key? key, required this.location}) : super(key: key);

  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  int _counter = 1;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text(widget.location.name),
        backgroundColor: Palette.cardColor,
      ),
      body: Stack(children: [
        RefreshIndicator(
          backgroundColor: Palette.backgroundColor,
          color: Palette.primaryColor,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.location.id,
                    style: const TextStyle(
                        fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.black87)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (_counter > 1) {
                                      setState(() => _counter--);
                                    }
                                  },
                                  icon: const Icon(CupertinoIcons.minus)),
                              Text("$_counter"),
                              IconButton(
                                icon: const Icon(CupertinoIcons.add),
                                onPressed: () {
                                  setState(() => _counter++);
                                },
                              ),
                            ]),
                      ),
                      Text(
                        widget.location.disassembledName,
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "A propos de ce livre",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ]),
          ),
        )
      ]),
    );
  }
}
