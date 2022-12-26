import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:transporter/helpers/models/location_model.dart';

import '../../helpers/api_helper.dart';
import '../../helpers/call_backs.dart';

class AutoCompleteLocation extends StatefulWidget {
  locationCallback location;
  TextEditingController controller;
  String helpText;
  AutoCompleteLocation(
      {super.key,
      required this.controller,
      required this.helpText,
      required this.location});

  @override
  State<AutoCompleteLocation> createState() => _AutoCompleteLocationState();
}

class _AutoCompleteLocationState extends State<AutoCompleteLocation> {
  List<String> added = [];

  String currentText = "";

  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  List<String> suggestions = [];
  List<LocationModel> locations = [];

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: true,
        controller: widget.controller,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontStyle: FontStyle.italic),
        decoration: InputDecoration(
            labelText: widget.helpText,
            border: OutlineInputBorder(),
            hintText: widget.helpText),
      ),
      suggestionsCallback: (pattern) async {
        return await getLocationResults(pattern);
      },
      itemBuilder: (context, LocationModel suggestion) {
        return ListTile(
          title: Text(suggestion.location_name),
        );
      },
      onSuggestionSelected: (LocationModel suggestion) {
        // your implementation here
        widget.location(suggestion);
        widget.controller.text = suggestion.location_name;
      },
    );

    /*
     SimpleAutoCompleteTextField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.pin_drop_outlined),
          labelText: widget.helpText,
          hintText: widget.helpText),
      controller: widget.controller,
      suggestions: suggestions,
      textChanged: (text) {
        getLocationResults(text).then((value) {
          print("PLACES API RESPONCE : => ${value!.toJson()}");
          setState(() {
            suggestions.clear();
            locations.clear();
            value.results.forEach((element) {
              suggestions.add(element.formattedAddress);
              locations.add(LocationModel(
                  element.formattedAddress,
                  element.geometry.location.lat,
                  element.geometry.location.lng));
            });
          });
        });
      },
      clearOnSubmit: false,
      textSubmitted: (text) => setState(() {
        if (text != "") {
          print("TEXT SUBMITED $text");
          // getLocationResults();
          widget.controller.text = text;
          var model =
              locations.firstWhere((element) => element.location_name == text);
          if (model != null) {
            widget
                .location(LocationModel(text, model.latitude, model.longitude));
          }
        }
      }),
      key: key,
    );
    */
  }
}
