import 'package:banquetbookz_vendor/Colors/coustcolors.dart';
import 'package:banquetbookz_vendor/Models/bookinglistmodel.dart';
import 'package:banquetbookz_vendor/Widgets/text.dart';
import 'package:flutter/material.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final List<BookingListModel> bookings = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 12; i++) {
      bookings.add(BookingListModel(
          name: "Transaction Id $i",
          date: "Aug 7,2023 4:20 PM",
          address: "Relative Booking Id $i"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoustColors.colrFill,
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 90,
              decoration: const BoxDecoration(
                color: CoustColors.colrHighlightedText,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(25),
                  bottomStart: Radius.circular(25),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 25.0, left: 15),
                child: coustText(
                  sName: "Sales",
                  txtcolor: CoustColors.colrEdtxt4,
                  textsize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 20, right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  coustText(
                    sName: "Wallet",
                    textsize: 18,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: CoustColors.colrHighlightedText,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadiusDirectional.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          coustText(
                            sName: "Total earned from booking",
                            txtcolor: CoustColors.colrEdtxt4,
                          ),
                          SizedBox(height: 10),
                          coustText(
                            sName: "89,000",
                            txtcolor: CoustColors.colrEdtxt4,
                            textsize: 24,
                            fontweight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      coustText(
                        sName: "Transactions",
                      ),
                      TextButton(
                        onPressed: () {Navigator.of(context).pushNamed('/alltransactions');},
                        child: coustText(
                          sName: "All Transactions",
                          txtcolor: CoustColors.colrEdtxt2,
                          decoration: TextDecoration.underline,
                          decorationcolor: CoustColors.colrHighlightedText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  bool isTotal = index.isEven;
                  return _buildBookingItem(bookings[index], isTotal: isTotal);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingItem(BookingListModel booking, {bool isTotal = false}) {
    return Column(
      children: [
        ListTile(
          title: coustText(
            sName: booking.name!,
            fontweight: FontWeight.bold,
            textsize: 18,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coustText(
                sName: booking.date!,
                textsize: 14,
                txtcolor: CoustColors.colrEdtxt4,
              ),
              coustText(
                sName: booking.address!,
                textsize: 14,
                txtcolor: CoustColors.colrEdtxt4,
              ),
            ],
          ),
          trailing: coustText(
            sName: "2300",
            fontweight: FontWeight.bold,
            textsize: 18,
            txtcolor:
                isTotal ? CoustColors.paymenttext : CoustColors.refundtext,
          ),
          onTap: () {
            Navigator.of(context).pushNamed('/bookingdetails');
            print('${booking.name} clicked');
          },
        ),
        const Divider(
          height: 1,
          thickness: 2,
          color: CoustColors.colrEdtxt4,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
