import 'package:app/helpers/general_widgets.dart';
import 'package:app/models/offer.dart';
import 'package:flutter/material.dart';

class OfferWidget extends StatelessWidget {
  final List<Offer> offers;

  const OfferWidget({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: offers.length,
      itemBuilder: (BuildContext context, int index) {
        final offer = offers[index];
        return Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 10,
            bottom: 10,
            right: 20,
          ),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).width / 4.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                GeneralWidgets.getNetworkImage(offer.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
