import 'package:flutter/material.dart';

class CustomLocationTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onFetchLocation;
  final VoidCallback onFieldSubmitted;
  final VoidCallback onRemoveLocation;

  const CustomLocationTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onFetchLocation,
    required this.onFieldSubmitted,
    required this.onRemoveLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        hintText: 'Enter your location',
        hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
        contentPadding: const EdgeInsets.all(15),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        prefixIconConstraints: BoxConstraints(maxHeight: 40, maxWidth: 50),
        prefixIcon: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 14.6),
              child: SizedBox(
                width: 20,
                height: 20,
                child: GestureDetector(
                  onTap: onFetchLocation,
                  child: Icon(Icons.location_on, color: Colors.red),
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
        suffixIconConstraints: BoxConstraints(minHeight: 18, minWidth: 18),
        suffixIcon: GestureDetector(
          onTap: onRemoveLocation,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.clear, color: Colors.red, size: 22),
          ),
        ),
      ),
      focusNode: focusNode,
      maxLines: 1,
      onSubmitted: (String value) {
        onFieldSubmitted();
      },
    );
  }
}
