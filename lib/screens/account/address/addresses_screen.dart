import 'package:app/helpers/colors.dart';
import 'package:app/providers/address_provider.dart';
import 'package:app/screens/account/address/widgets/address_container.dart';
import 'package:app/screens/account/address/widgets/empty_address_screen.dart';
import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AddressProvider>(context, listen: false).fetchAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("العناوين"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              LucideIcons.x,
            ),
          ),
        ],
      ),
      body: addressProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : addressProvider.addresses.isEmpty
              ? EmptyAddressScreen()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 5,
                      children: [
                        Button(
                          text: 'اضافة عنوان جديد',
                          fontWeight: FontWeight.w600,
                          onClick: () async {
                            final result = await Navigator.pushNamed(
                                context, '/new-address-map');
                            if (result != null) {
                              Navigator.pushNamed(context, '/new-address',
                                  arguments: result);
                            }
                          },
                          color: ColorsPallete.scaffoldColor,
                          textColor: Colors.blue,
                          borderRadius: 10,
                          borderColor: Colors.blue,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: addressProvider.addresses.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final address = addressProvider.addresses[index];
                              return AddressContainer(address: address);
                            }),
                      ],
                    ),
                  ),
                ),
    );
  }
}
