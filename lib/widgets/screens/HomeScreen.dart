import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nearby_hospitals/model/nearbyhospitals.dart';
import 'package:nearby_hospitals/services/auth_service.dart';
import 'package:nearby_hospitals/services/location_api.dart';
import 'package:nearby_hospitals/widgets/components/custom_text_widget.dart';
import 'package:nearby_hospitals/utils/dialog_box.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Nearbyhospitals> _nearbyhospitals = [];
  late double lat, lng;
  String? errorMessage;
  late User? user;

  @override
  void initState() {
    super.initState();
    fetchAllData();
    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> fetchAllData() async {
    List<double>? latLng = await LocationApi().getCurrentLocation(
      context: context,
    );
    if (latLng == null) {
      setState(() {
        errorMessage =
            "Something went wrong! Make sure turn on location permission";
      });
      return;
    }

    lat = latLng[0];
    lng = latLng[1];

    List<Nearbyhospitals>? data = await LocationApi().getNearbyhospitals(
      lat: lat,
      lng: lng,
    );

    if (data == null) {
      setState(() {
        errorMessage = "Something went wrong! please try again.";
      });
      return;
    }

    setState(() {
      _nearbyhospitals = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            user!.photoURL != null
                ? Container(
                  margin: EdgeInsets.only(left: 16),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user!.photoURL!),
                  ),
                )
                : SizedBox(),
        title: CustomTextWidget(text: "Welcome! ${user!.displayName}"),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed:
                () => showDialogBox(
                  context: context,
                  title: "Logout",
                  content: "Do you really want to logout out?",
                  onPressed: () => AuthService().signOut(),
                ),
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
      body:
          _nearbyhospitals.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 30,
                  children: [
                    if (errorMessage == null)
                      CircularProgressIndicator(color: Colors.amber),
                    CustomTextWidget(
                      text:
                          errorMessage ??
                          "Loading nearby hospitals, please wait...",
                      fontSize: 12,
                    ),
                  ],
                ),
              )
              : Container(
                margin: EdgeInsets.only(top: 12),
                child: ListView.builder(
                  itemCount: _nearbyhospitals.length,
                  itemBuilder: (context, index) {
                    final nearbyhospital = _nearbyhospitals[index];
                    return nearbyhospital.name != null &&
                            nearbyhospital.name!.isNotEmpty
                        ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(252, 249, 194, 28),
                                  const Color.fromARGB(255, 255, 209, 71),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading:
                                    nearbyhospital.icon != null
                                        ? CircleAvatar(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Image.network(
                                              nearbyhospital.icon!,
                                            ),
                                          ),
                                        )
                                        : null,

                                title:
                                    nearbyhospital.name != null
                                        ? CustomTextWidget(
                                          text: nearbyhospital.name!,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        )
                                        : null,
                                subtitle:
                                    nearbyhospital.vicinity != null
                                        ? CustomTextWidget(
                                          text: nearbyhospital.vicinity!,
                                          fontSize: 10,

                                          color: const Color.fromARGB(
                                            255,
                                            121,
                                            121,
                                            121,
                                          ),
                                        )
                                        : null,

                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (nearbyhospital.rating != null)
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomTextWidget(
                                            text: "${nearbyhospital.rating} ",
                                            fontSize: 12,
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 12,
                                            color: const Color.fromARGB(
                                              255,
                                              10,
                                              93,
                                              13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (nearbyhospital.openNow != null)
                                      CustomTextWidget(
                                        text:
                                            nearbyhospital.openNow!
                                                ? "Opened"
                                                : "Closed",
                                        fontSize: 12,
                                        color: Colors.green,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        : null;
                  },
                ),
              ),
    );
  }
}
