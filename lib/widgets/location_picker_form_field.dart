import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_picker.dart';

class LocationPickerFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator? validator;

  const LocationPickerFormField(
      {this.controller, this.validator, super.key});

  @override
  State<LocationPickerFormField> createState() =>
      _LocationPickerFormFieldState();
}

class _LocationPickerFormFieldState extends State<LocationPickerFormField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final location = await showModalBottomSheet<LatLng>(
          context: context,
          builder: (_) => const LocationPicker(),
        );
        if (location != null) {
          widget.controller!.text =
              "${location.latitude}, ${location.longitude}";
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          decoration: const InputDecoration(
            labelText: 'Location',
          ),
          validator: widget.validator,
        ),
      ),
    );
  }
}
