import 'dart:convert';

import 'package:challenge/models/location_model.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  final Location location;
  const LocationWidget({Key? key, required this.location}) : super(key: key);

  Widget _buildImageWidget(String tpye) {
    switch (tpye) {
      case "poi":
        return Image.asset("assets/poi.png", width: 35, height: 35);
      case "street":
        return Image.asset("assets/street.png", width: 35, height: 35);
      case "stop":
        return Image.asset("assets/stop.png", width: 35, height: 35);
      case "suburb":
        return Image.asset("assets/suburb.png", width: 35, height: 35);
      default:
        return Image.asset("assets/poi.png", width: 35, height: 35);
    }
  }

  String decodeString(String value) {
    return utf8.decode(value.codeUnits);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            color: const Color(0xfff5f5f5),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            _buildImageWidget(location.type),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (location.disassembledName.isEmpty) 
                      ?decodeString(location.name)
                      :decodeString(location.disassembledName),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    decodeString(location.name),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Type : ${location.type}",
                    style: const TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
