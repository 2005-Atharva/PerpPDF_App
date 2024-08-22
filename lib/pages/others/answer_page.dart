import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:user_auth_crudd10/pages/others/folderAns_page.dart';
import 'package:user_auth_crudd10/services/providers/storage_ans_provider.dart';

class AnswerPage extends StatefulWidget {
  AnswerPage({super.key});

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  late Razorpay _razorpay;
  String? _selectedPath;

  List<String> answerImages = [
    'assets/grid/a.png',
    'assets/grid/b.png',
    'assets/grid/c.png',
    'assets/grid/d.png',
    'assets/grid/e.png',
    'assets/grid/f.png',
    'assets/grid/g.png',
    'assets/grid/h.png',
    'assets/grid/i.png',
  ];

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Success: ${response.paymentId}");
    print("Selected Path: $_selectedPath");

    if (_selectedPath != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FolderAnsPage(anspath: _selectedPath!),
        ),
      );
    } else {
      print("Error: Selected path is null");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("External wallet selected: ${response.walletName}")),
    );
  }

  void openCheckout(String path) {
    _selectedPath = path; // Save the selected path
    var options = {
      'key': 'rzp_test_XNUcJDcFq7HlUt',
      'amount': 1000, // Amount in paise (i.e., 10 INR)
      'name': 'PerpPDf',
      'description': 'Buy Solutions of PYQ',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<StorageAnsProvider>(context, listen: false)
            .fetchAnsItems('answer/'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<StorageAnsProvider>(
              builder: (context, storageAnsProvider, child) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Container(
                        height: 200,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 73, 111, 235),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                              child: Text(
                                "Hey!",
                                style: GoogleFonts.inter(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Image.asset('assets/images/cont1.png'),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Image.asset('assets/images/cont2.png'),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Image.asset('assets/images/cont3.png'),
                            ),
                            Positioned(
                              top: 16,
                              right: 0,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(22),
                                ),
                                child: Image.asset(
                                  'assets/images/ansav.png',
                                  scale: 1.3,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 26,
                              right: 125,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/lock.png',
                                  scale: 0.8,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              right: 293,
                              child: Image.asset('assets/images/block.png'),
                            ),
                            Positioned(
                              bottom: 1,
                              left: 330,
                              child: Image.asset('assets/images/box1.png'),
                            ),
                            Positioned(
                              top: 60,
                              left: 14,
                              child: Text(
                                "Get your Solutions \njust for 10₹",
                                style: GoogleFonts.inter(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: GridView.builder(
                        itemCount: storageAnsProvider.ansItem.length,
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) {
                          final item = storageAnsProvider.ansItem[index];
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                if (item.path != null) {
                                  openCheckout(item.path!);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Item path is null")),
                                  );
                                }
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color:
                                      const Color.fromARGB(40, 158, 158, 158),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        answerImages[index],
                                        scale: 0.7,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        item.name.toUpperCase(),
                                        style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
