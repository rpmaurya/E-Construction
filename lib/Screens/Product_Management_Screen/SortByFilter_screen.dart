import 'package:e_basket/Providers/WalletProvider.dart';
import 'package:e_basket/Screens/Product_Management_Screen/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortbyfilterScreen extends StatefulWidget {
  const SortbyfilterScreen({
    super.key,
  });

  @override
  State<SortbyfilterScreen> createState() => _SortbyfilterScreenState();
}

class _SortbyfilterScreenState extends State<SortbyfilterScreen> {
  // Walletprovider walletprovider = Walletprovider();

  Map<String, bool> checkboxStates = {
    'Relevance': true,
    'Price - Low to High': false,
    'Price - High to Low': false,
  };

  void _onCheckboxChanged(String key, bool? value) {
    setState(() {
      // Set all checkboxes to false
      checkboxStates.updateAll((key, value) => false);
      // Set the selected checkbox to true
      checkboxStates[key] = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final walletprovider = Provider.of<Walletprovider>(context, listen: false);
    return Container(
      child: ListView(
        children: checkboxStates.keys.map((String key) {
          return CheckboxListTile(
            title: Text(key),
            value: checkboxStates[key],
            onChanged: (bool? value) {
              setState(() {
                walletprovider.selectedItem = key;
                _onCheckboxChanged(key, value);

                print({
                  'walletprovider.selectedItem': walletprovider.selectedItem
                });
              });
            },
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(
                color: Colors.blue,
                width: 2,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
