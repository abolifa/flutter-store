import 'package:app/providers/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class HomeScreeDeliveryWidget extends StatefulWidget {
  final Color? textColor;

  const HomeScreeDeliveryWidget({super.key, this.textColor});

  @override
  State<HomeScreeDeliveryWidget> createState() =>
      _HomeScreeDeliveryWidgetState();
}

class _HomeScreeDeliveryWidgetState extends State<HomeScreeDeliveryWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressProvider>().fetchAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, addressProvider, child) {
        if (addressProvider.isLoading) {
          return SizedBox();
        }
        if (addressProvider.addresses.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  'لا توجد عناوين',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: widget.textColor ?? Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                Icons.location_pin,
                color: widget.textColor ?? Colors.grey.shade600,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                'تسليم إلى',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: widget.textColor ?? Colors.black,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'إختر العنوان',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: SizedBox(
                            width: 500,
                            child: SingleChildScrollView(
                              child: Column(
                                children:
                                    addressProvider.addresses.map((address) {
                                  return ListTile(
                                    title: Text(
                                      '${address.street}, ${address.city}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    trailing: address.defaultAddress
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                            size: 20,
                                          )
                                        : null,
                                    onTap: () {
                                      addressProvider
                                          .setDefaultAddress(address.id);
                                      Navigator.pop(context);
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        addressProvider.defaultAddress?.street ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: widget.textColor ?? Colors.black,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        LucideIcons.chevronDown,
                        size: 18,
                        color: widget.textColor ?? Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
