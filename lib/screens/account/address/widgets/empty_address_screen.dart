import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';

class EmptyAddressScreen extends StatelessWidget {
  const EmptyAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.7,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(
              'assets/images/mail.webp',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "لم يتم العثور على عناوين",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "أضف عنواناً الآن حتى تتمكن من توصيل طلباتك",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: Button(
              text: 'إضافة عنوان جديد',
              height: 40,
              color: Colors.blueAccent.shade700,
              textColor: Colors.white,
              borderRadius: 0,
              onClick: () async {
                final result =
                    await Navigator.pushNamed(context, '/new-address-map');
                if (result != null) {
                  Navigator.pushNamed(context, '/new-address',
                      arguments: result);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
