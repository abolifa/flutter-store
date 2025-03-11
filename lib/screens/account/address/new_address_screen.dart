import 'package:app/models/address.dart';
import 'package:app/models/percation.dart';
import 'package:app/providers/address_provider.dart';
import 'package:app/screens/account/address/map_screen.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/input.dart';
import 'package:app/widgets/navbar.dart';
import 'package:app/widgets/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class NewAddressScreen extends StatefulWidget {
  final Percation? selectedLocation;
  final bool isEdit;
  final Address? address;

  const NewAddressScreen({
    super.key,
    this.selectedLocation,
    this.isEdit = false,
    this.address,
  });

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final countryController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();
  final landMarkController = TextEditingController();
  bool isDefault = false;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.address != null) {
      cityController.text = widget.address!.city;
      addressController.text = widget.address!.address;
      countryController.text = '+218';
      phoneController.text = widget.address!.phone;
      streetController.text = widget.address!.street;
      landMarkController.text = widget.address!.landmark ?? '';
      isDefault = widget.address!.defaultAddress;
    } else if (widget.selectedLocation != null) {
      cityController.text = widget.selectedLocation!.city;
      addressController.text = widget.selectedLocation!.address;
      countryController.text = '+218';
      streetController.text = widget.selectedLocation!.street;
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(
        title: widget.isEdit ? 'تعديل العنوان' : 'اضافة عنوان جديد',
        closable: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            if (widget.isEdit || widget.selectedLocation != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isEdit
                            ? widget.address!.city
                            : widget.selectedLocation!.city,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.isEdit
                            ? widget.address!.address
                            : widget.selectedLocation!.address,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () async {
                      // if (widget.isEdit) {
                      //   Navigator.pushNamed(context, '/map-screen');
                      // } else {
                      //   Navigator.pop(context);
                      // }
                      final Percation? newLocation =
                          await Navigator.push<Percation>(
                        context,
                        MaterialPageRoute(builder: (context) => MapScreen()),
                      );

                      if (newLocation != null) {
                        setState(() {
                          cityController.text = newLocation.city;
                          addressController.text = newLocation.address;
                          streetController.text = newLocation.street;
                        });
                      }
                    },
                    icon: const Icon(
                      LucideIcons.pencilLine,
                      size: 24,
                    ),
                  ),
                ],
              ),
            const Divider(thickness: 0.5),
            const SizedBox(height: 20),
            Column(
              spacing: 20,
              children: [
                Input(controller: addressController, label: "العنوان"),
                Input(controller: cityController, label: "المدينة"),
                PhoneInput(
                  label: 'رقم الجوال',
                  countryCodeController: countryController,
                  phoneController: phoneController,
                ),
                Input(controller: streetController, label: "الشارع"),
                Input(controller: landMarkController, label: "نقطة دالة"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'تعيين كإفتراضي',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Switch(
                      value: isDefault,
                      onChanged: (value) {
                        setState(() {
                          isDefault = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Button(
                text: widget.isEdit ? 'تعديل' : 'حفظ',
                isLoading: addressProvider.isLoading,
                color: Colors.black,
                textColor: Colors.white,
                height: 50,
                borderRadius: 50,
                onClick: () async {
                  if (widget.isEdit) {
                    final isUpdated = await addressProvider.editAddress(
                      id: widget.address!.id,
                      address: addressController.text,
                      city: cityController.text,
                      phone: phoneController.text,
                      street: streetController.text,
                      landmark: landMarkController.text,
                      latitude: widget.address!.latitude,
                      longitude: widget.address!.longitude,
                      defaultAddress: isDefault,
                    );

                    if (isUpdated == true && context.mounted) {
                      addressProvider.fetchAddresses();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم تعديل العنوان بنجاح')),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text(addressProvider.message ?? 'حدث خطأ ما'),
                        ),
                      );
                    }
                  } else {
                    // Add new address
                    final isAdded = await addressProvider.addAddress(
                      address: addressController.text,
                      city: cityController.text,
                      phone: phoneController.text,
                      street: streetController.text,
                      landmark: landMarkController.text,
                      latitude: widget.selectedLocation!.latitude,
                      longitude: widget.selectedLocation!.longitude,
                      defaultAddress: isDefault,
                    );

                    if (isAdded == true && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم اضافة العنوان بنجاح')),
                      );
                      addressProvider.fetchAddresses();
                      if (widget.isEdit) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text(addressProvider.message ?? 'حدث خطأ ما'),
                          ),
                        );
                      }
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
