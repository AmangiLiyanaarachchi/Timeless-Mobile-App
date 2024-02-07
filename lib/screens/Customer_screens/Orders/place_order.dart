import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/controllers/call_controllers.dart';
import 'package:timeless/fatora_payment/Payments.dart';
import 'package:timeless/models/CartModel.dart';
import '../../../Constants/color_constants.dart';
import '../../../constants/font_styles.dart';
import '../../../utils/space_values.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/multiline_text_field.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key, required this.cartItems, required this.total});
  final List<CartModel> cartItems;
  final int total;

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  PhoneNumber number = PhoneNumber(isoCode: "PK");
  final _addrFormKey = GlobalKey<FormState>();
  int selectedIndex = 0;
  int selectedColorIndex = 0;
  String? checkoutUrl;

  Future<void> makePayment() async {
    // API endpoint and key
    String apiUrl = 'https://api.fatora.io/v1/payments/checkout';
    String apiKey =
        '225072cb-56a5-4fcd-adc9-30c28fa44ef7'; // Replace with your Fatora API key

    // Prepare payment request data
    Map<String, dynamic> requestData = {
      'amount': widget.total,
      'currency': 'QAR',
      'order_id':
          Random.secure().nextInt(1000000), // Customize order ID as needed
      'client': {
        'name': orderController.nameController.text,
        'phone': "+123344",
        'email': FirebaseAuth.instance.currentUser?.email,
      },
      'language': 'en',
      'success_url': '',
      'failure_url': '',
      'fcm_token': '',
      'save_token': true,
      'note': 'Payment for order',
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'api_key': apiKey,
        },
        body: jsonEncode(requestData),
      );
      if (response.statusCode == 200) {
        checkoutUrl = jsonDecode(response.body)["result"]["checkout_url"];

        Uri uri = Uri.parse(checkoutUrl!);
        // ignore: unnecessary_null_comparison
        if (uri != null) {
          _launchURL(uri); // Open the payment URL with the app
        } else {
          print('CheckOut URL is null');
        }
      } else {
        // Handle payment failure
        print('Payment failed: ${response.body}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error occurred: $error');
    }
  }

  Future<void> _launchURL(Uri url) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewContainer(url)),
    ).then((value) {
      orderController.placeOrder(widget.cartItems, widget.total);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: ColorConstants.primaryColor),
        title: Text(
          "Place Order",
          style: FontStyles.appBarStylePC,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _addrFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomMultilineTextField(
                controller: orderController.nameController,
                onTextChange: (val) {},
                capitalization: TextCapitalization.words,
                hint: "Name",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required".tr;
                  }
                  return null;
                },
              ),
              Spaces.y1,
              CustomMultilineTextField(
                capitalization: TextCapitalization.words,
                controller: orderController.addressController,
                onTextChange: (val) {},
                hint: "Address",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required".tr;
                  }
                  return null;
                },
              ),
              Spaces.y1,

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomMultilineTextField(
                      capitalization: TextCapitalization.words,
                      controller: orderController.cityController,
                      onTextChange: (val) {},
                      hint: "City",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "required".tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomMultilineTextField(
                      capitalization: TextCapitalization.words,
                      controller: orderController.stateController,
                      onTextChange: (val) {},
                      hint: "State",
                      // width: ,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "required".tr;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              Spaces.y5,

              ///phone
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
                child: Theme(
                  data: Theme.of(context).copyWith(
                      dialogTheme: const DialogTheme(
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white)),
                  child: InternationalPhoneNumberInput(
                    initialValue: number,
                    onInputChanged: (PhoneNumber number) {
                      setState(() {
                        orderController.phoneNo = number.phoneNumber.toString();
                      });
                    },
                    onInputValidated: (bool value) {},
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    spaceBetweenSelectorAndTextField: 0.0,
                    formatInput: true,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputDecoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      errorMaxLines: 2,
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      hintText: "Phone no.",
                      hintStyle: FontStyles.smallBlackBodyText,
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ),
                    onSaved: (PhoneNumber number) {},
                  ),
                ),
              ),

              Spaces.y1,
              CustomMultilineTextField(
                controller: orderController.zipcodeController,
                onTextChange: (val) {},
                capitalization: TextCapitalization.words,
                hint: "Zip code",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required".tr;
                  }
                  return null;
                },
              ),

              Spaces.y5,

              CustomElevatedButton(
                title: "PAY & PLACE ORDER",
                width: 80.w,
                height: 7.h,
                bgColor: Color.fromARGB(255, 224, 169, 6),
                onPress: () async {
                  await makePayment();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
