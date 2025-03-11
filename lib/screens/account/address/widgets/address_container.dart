import 'package:app/models/address.dart';
import 'package:app/providers/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class AddressContainer extends StatelessWidget {
  final Address address;

  const AddressContainer({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          width: address.defaultAddress ? 2 : 1,
          color: address.defaultAddress ? Colors.blue : Colors.grey.shade400,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    LucideIcons.mapPin,
                    color: Colors.grey.shade400,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    address.street,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                  address.defaultAddress
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          child: Text(
                            'افتراضي',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ))
                      : const SizedBox(),
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.pushNamed(context, '/new-address',
                          arguments: address);
                    },
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.pencilLine,
                          color: Colors.black,
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'تعديل',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!address.defaultAddress)
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => buildDeleteDialog(context),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.trash2,
                            color: Colors.black,
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'حذف',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
          const Divider(
            thickness: 0.5,
          ),
          const SizedBox(height: 10),
          buildAddressRow(
            title: 'الإسم',
            value: address.customer.name,
          ),
          const SizedBox(height: 10),
          buildAddressRow(
            title: 'الشارع',
            value: address.street,
          ),
          const SizedBox(height: 10),
          buildAddressRow(
            title: 'المدينة',
            value: address.city,
          ),
          const SizedBox(height: 10),
          buildAddressRow(
            title: 'ملاحظات',
            value: address.landmark,
          ),
          const SizedBox(height: 10),
          buildAddressRow(
            title: 'رقم الهاتف',
            value: address.phone,
          ),
          const Divider(
            thickness: 0.5,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildAddressRow({required String title, required String value}) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget buildDeleteDialog(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    return AlertDialog(
      title: const Text('حذف العنوان'),
      content: const Text('هل تريد حذف العنوان؟'),
      actions: [
        TextButton(
          child: const Text('نعم'),
          onPressed: () async {
            bool deleted = await addressProvider.deleteAddress(address.id);
            if (deleted && context.mounted) {
              addressProvider.fetchAddresses();
              Navigator.pop(context);
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('حدث خطاء'),
                  ),
                );
                Navigator.pop(context);
              }
            }
          },
        ),
        TextButton(
          child: const Text('لا'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
