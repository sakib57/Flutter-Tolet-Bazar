import 'dart:convert';
import 'dart:io';

//import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../models/District.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import '../helpers/request_helper.dart';
import '../models/Address.dart';
import '../models/Category.dart';
import '../models/Place.dart';

import '../config_maps.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<File> file;
  String base64Image;
  File tempFile;

  List<Place> placeList = [];
  List<Category> categories = new List<Category>();

  String category;
  DateTime selectedDate;
  String selectedDateText = "Target month";
  String selectedDistrict;
  String location;
  String address;
  String floor;
  String bedroom;
  String squareFit;
  String seat;
  String bathroom;
  String balcony;
  String hasLift;
  String hasGenerator;
  String vehicleType;
  String vehicleQty;
  String rent;
  String contact;

  List<String> vehicleTypes = [
    "Car",
    "Pickup",
    "Bike",
  ];
  List<String> lift = [
    "No",
    "Yes",
  ];
  List<String> generator = [
    "No",
    "Yes",
  ];

  //TextEditingController _districtController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _floorController = TextEditingController();
  TextEditingController _bedroomController = TextEditingController();
  TextEditingController _seatController = TextEditingController();
  TextEditingController _bathroomController = TextEditingController();
  //TextEditingController _liftController = TextEditingController();
  TextEditingController _balconyController = TextEditingController();
  //TextEditingController _generatorController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _squarefitController = TextEditingController();
  TextEditingController _rentController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _vehicleQtyController = TextEditingController();

  @override
  void initState() {
    getCategories();
    selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double rowWidth = MediaQuery.of(context).size.width * 0.42;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Create New Post"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: rowWidth,
                      child: _buildCategoryField(),
                    ),
                    Container(
                      width: rowWidth,
                      child: _buildTargetMonthField(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: rowWidth,
                      child: _buildDstrictField(),
                    ),
                    Container(
                      width: rowWidth,
                      child: _buildLocationField(),
                    ),
                  ],
                ),

                // Show place List
                (placeList.length > 0)
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListView.separated(
                          padding: EdgeInsets.all(0.0),
                          itemBuilder: (context, index) {
                            return FlatButton(
                              onPressed: () {
                                getPlaceDetail(
                                    placeList[index].placeId, context);
                                setState(() {
                                  placeList = [];
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_pin),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          placeList[index].mainText,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16.0),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          placeList[index].secondaryText,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    Divider()
                                  ],
                                ),
                              ),
                            );

                            // PredictionTile(
                            //   place: placeList[index],
                            //   locationController: _locationController,
                            // );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                            height: 5.0,
                            color: Colors.blueGrey,
                            thickness: 1.0,
                          ),
                          itemCount: placeList.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                        ),
                      )
                    : Container(),
                _buildAddressField(),

                category == 'Garage'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: rowWidth,
                            child: _buldVehicleTypeField(),
                          ),
                          Container(
                            width: rowWidth,
                            child: _buldVehicleQtyField(),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: rowWidth,
                            child: _buildFloorField(),
                          ),
                          Container(
                            width: rowWidth,
                            child: category == 'Mess' || category == 'Hostel'
                                ? _buildSeatField()
                                : category == "Shop" ||
                                        category == "Godown" ||
                                        category == "Office"
                                    ? _buildSquareFitField()
                                    : _buildBedField(),
                          ),
                        ],
                      ),

                category == 'Garage' || category == 'Godown'
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: rowWidth,
                            child: _buldBathroomField(),
                          ),
                          Container(
                            width: rowWidth,
                            child: _buldBalconyField(),
                          ),
                        ],
                      ),

                category == 'Garage' || category == 'Godown'
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: rowWidth,
                            child: _buldLiftField(),
                          ),
                          Container(
                            width: rowWidth,
                            child: _buldGeneratorField(),
                          ),
                        ],
                      ),
                _buildDescriptionField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: rowWidth,
                      child: _buildRentField(),
                    ),
                    Container(
                      width: rowWidth,
                      child: _buldContactField(),
                    ),
                  ],
                ),

                // ============  Field for Image Upload ===========
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: choosImageFromCamera,
                                child: Icon(
                                  Icons.photo_camera,
                                  size: 150.0,
                                  color: Colors.grey,
                                ),
                              ),
                              InkWell(
                                onTap: choosImageFromGallery,
                                child: Icon(
                                  Icons.photo,
                                  size: 150.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: showImage(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: accentColor,
                  onPressed: tempFile == null
                      ? withoutImageAlertDialog
                      : uploadPostWithoutImage,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============== Image upload functions ==========

  choosImageFromCamera() {
    Navigator.pop(context);
    setState(() {
      // ignore: deprecated_member_use
      file = ImagePicker.pickImage(source: ImageSource.camera);
    });
  }

  choosImageFromGallery() {
    Navigator.pop(context);
    setState(() {
      // ignore: deprecated_member_use
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  showImage() {
    return FutureBuilder<File>(
        future: file,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            tempFile = snapshot.data;
            base64Image = base64Encode(snapshot.data.readAsBytesSync());
            return Container(
              margin: EdgeInsets.only(left: 60.0, right: 60.0, top: 20.0),
              height: 140.0,
              child: Image.file(
                snapshot.data,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(left: 60.0, right: 60.0, top: 20.0),
              height: 140.0,
              child: Image.asset(
                "assets/demo_image.png",
                fit: BoxFit.cover,
              ),
            );
          }
        });
  }

//============ Function for Upload Post with image
  uploadPostWithImage() {
    if (!_formKey.currentState.validate()) {
      _showAlertDialog(
          'Validation Error', 'Required fields are need to be filled');
      return;
    }

    if (selectedDateText == "Target month") {
      // final snackBar = SnackBar(
      //   content: Text('Can\'t Post Without Target Month'),
      // );
      // _scaffoldKey.currentState.showSnackBar(snackBar);
      _showAlertDialog('Validation Error', "Can't post without target month");
      return;
    }

    Map data = {
      "category": category,
      "target_month": selectedDate,
      "district": selectedDistrict,
      "location": _locationController.text,
      "address": _addressController.text,
      "floor": _floorController.text,
      "square_fit": _squarefitController.text,
      "vehicle_type": vehicleType,
      "vehicle_qty": vehicleQty,
      "bedroom": _bedroomController.text,
      "bathroom": _bathroomController.text,
      "balcony": _balconyController.text,
      "lift": hasLift,
      "generator": hasGenerator,
      "description": _descriptionController.text,
      "rent": _rentController.text,
      "contact": _contactController.text,
    };
    print(data);
  }

  uploadPostWithoutImage() {
    if (!_formKey.currentState.validate()) {
      _showAlertDialog(
          'Validation Error', 'Required fields are need to be filled');
      return;
    }

    if (selectedDateText == "Target month") {
      // final snackBar = SnackBar(
      //   content: Text('Can\'t Post Without Target Month'),
      // );
      // _scaffoldKey.currentState.showSnackBar(snackBar);
      _showAlertDialog('Validation Error', "Can't post without target month");
      return;
    }

    Map data = {
      "category": category,
      "target_month": selectedDate,
      "district": selectedDistrict,
      "location": _locationController.text,
      "address": _addressController.text,
      "floor": _floorController.text,
      "square_fit": _squarefitController.text,
      "vehicle_type": vehicleType,
      "vehicle_qty": vehicleQty,
      "bedroom": _bedroomController.text,
      "bathroom": _bathroomController.text,
      "balcony": _balconyController.text,
      "lift": hasLift,
      "generator": hasGenerator,
      "description": _descriptionController.text,
      "rent": _rentController.text,
      "contact": _contactController.text,
    };
    print(data);
  }

  void getCategories() async {
    try {
      String url = apiUrl + "get-categories";
      final response = await http.get(url);
      if (response.statusCode == 200) {
        categories = loadCategories(response.body);
        print('Users: ${categories.length}');
        setState(() {
          //loading = false;
        });
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  static List<Category> loadCategories(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapApiKey2&sessiontoken=1234567890&components=country:bd";
      var res = await RequestHelper.getRequest(autoCompleteUrl);
      if (res == "failed") {
        return;
      } else {
        // print("Res: ");
        // print(res);
        if (res["status"] == "OK") {
          var predictions = res["predictions"];
          var placeResults =
              (predictions as List).map((e) => Place.fromJson(e)).toList();

          setState(() {
            placeList = placeResults;
          });
        }
      }
    } else {
      setState(() {
        placeList = [];
      });
    }
  }

  void getPlaceDetail(String placeId, context) async {
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) => ProgressDialog(
    //           msg: "setting dropoff...",
    //         ));
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapApiKey2";

    var res = await RequestHelper.getRequest(url);

    //Navigator.pop(context);

    if (res == "failed") {
      return;
    }

    if (res["status"] == "OK") {
      print(res);
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.lat = res["result"]["geometry"]["location"]["lat"];
      address.lng = res["result"]["geometry"]["location"]["lng"];

      // Provider.of<AppData>(context, listen: false)
      //     .updateDropOffAddress(address);
      _locationController.text = address.placeName;

      print("Drop Off Address:");
      print(address.placeName);

      //Navigator.pop(context, "obtainedDirection");
    }
  }

  // ============= Custom Widgets ===============

  Widget _buildFloorField() {
    return TextFormField(
      controller: _floorController,
      decoration: InputDecoration(
          labelText: "Floor",
          hintText: "e. g. 1 for first floor",
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[800]))),
      validator: (String value) {
        if (value.isEmpty) {
          return "Floor is required";
        }
        if (!RegExp(r"^[0-9]*$").hasMatch(value)) {
          return "Only numbers are acceptable";
        }
        return null;
      },
    );
  }

  // =========== For Bed ============
  Widget _buildBedField() {
    return TextFormField(
      controller: _bedroomController,
      decoration:
          InputDecoration(labelText: "Bed Room *", hintText: "No of bedroom"),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Bed Room is required";
        }
        if (!RegExp(r"^[0-9]*$").hasMatch(value)) {
          return "Only numbers are acceptable";
        }
        return null;
      },
    );
  }

  // =========== For Seat ============
  Widget _buildSeatField() {
    return TextFormField(
      controller: _seatController,
      decoration:
          InputDecoration(labelText: "Seat No *", hintText: "No of seat"),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Seat is required";
        }
        if (!RegExp(r"^[0-9]*$").hasMatch(value)) {
          return "Only numbers are acceptable";
        }
        return null;
      },
    );
  }

  // =========== For Square Fit ============
  Widget _buildSquareFitField() {
    return TextFormField(
      controller: _squarefitController,
      decoration:
          InputDecoration(labelText: "Square Fit *", hintText: "e. g. 1400"),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Square Fit is required";
        }
        if (!RegExp(r"^[0-9]*$").hasMatch(value)) {
          return "Only numbers are acceptable";
        }
        return null;
      },
    );
  }

  // =========== For Vehicle Type ============
  Widget _buldVehicleTypeField() {
    return DropdownButtonFormField(
      value: vehicleType,
      items: vehicleTypes
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                ),
                value: value,
              ))
          .toList(),
      onChanged: (selectedType) {
        setState(() {
          vehicleType = selectedType;
        });
      },
      //hint: Text("Vehicle Type"),
      decoration: InputDecoration(
          labelText: "Vehicle Type *",
          floatingLabelBehavior: FloatingLabelBehavior.auto),
      validator: (value) => value == null ? 'Vehicle Type is required' : null,
    );
  }

  // =========== For Rent ============
  Widget _buildRentField() {
    return TextFormField(
      controller: _rentController,
      decoration: InputDecoration(labelText: "Rent *", hintText: "e. g. 14000"),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Rent is required";
        }
        if (!RegExp(r"^[0-9]*$").hasMatch(value)) {
          return "Only numbers are acceptable";
        }
        return null;
      },
    );
  }

  // =========== For Contact ============
  Widget _buldContactField() {
    return TextFormField(
      controller: _contactController,
      decoration: InputDecoration(
          labelText: "Contact *", hintText: "e. g. 01738719951"),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Contact is required";
        }
        if (!RegExp(r"^[0-9]*$").hasMatch(value)) {
          return "Only numbers are acceptable";
        }
        return null;
      },
    );
  }

  // =========== For Description ============
  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 2,
      decoration: InputDecoration(
          labelText: "Description *", hintText: "e. g. terms & conditions"),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Description is required";
        }
        return null;
      },
    );
  }

  // =========== For Bathroom ============
  Widget _buldBathroomField() {
    return TextFormField(
      controller: _bathroomController,
      decoration: InputDecoration(labelText: "Bathroom *", hintText: "e. g. 2"),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Bathroom is required";
        }
        return null;
      },
    );
  }

  // =========== For Balcony ============
  Widget _buldBalconyField() {
    return TextFormField(
      controller: _balconyController,
      decoration: InputDecoration(labelText: "Balcony *", hintText: "e. g. 3"),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Balcony is required";
        }
        return null;
      },
    );
  }

  // =========== For Lift ============
  Widget _buldLiftField() {
    return DropdownButtonFormField(
      items: lift
          .map((value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          hasLift = value;
        });
      },
      //hint: Text("Has Lift?"),
      decoration: InputDecoration(
          labelText: "Lift", floatingLabelBehavior: FloatingLabelBehavior.auto),
      validator: (value) => value == null ? 'Lift is required' : null,
    );
  }

  // =========== For Generator ============
  Widget _buldGeneratorField() {
    return DropdownButtonFormField(
      items: generator
          .map((value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          hasGenerator = value;
        });
      },
      //hint: Text("Has Generator?"),
      decoration: InputDecoration(
          labelText: "Generator",
          floatingLabelBehavior: FloatingLabelBehavior.auto),
      validator: (value) => value == null ? 'Generator is required' : null,
    );
  }

  // =========== For Vehicle Qty ============
  Widget _buldVehicleQtyField() {
    return TextFormField(
      controller: _vehicleQtyController,
      decoration:
          InputDecoration(labelText: "Vehicle Qty *", hintText: "e. g. 2"),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Vehicle Qty is required";
        }
        if (!RegExp(r"^[0-9]*$").hasMatch(value)) {
          return "Only numbers are acceptable";
        }
        return null;
      },
    );
  }

  // =========== For Target Month ============
  Widget _buildTargetMonthField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$selectedDateText",
          style: TextStyle(fontSize: 16.0),
        ),
        IconButton(
          icon: Icon(
            Icons.calendar_today,
            color: accentColor,
          ),
          onPressed: () {
            showMonthPicker(
              context: context,
              firstDate: DateTime(DateTime.now().month - 1),
              lastDate: DateTime(DateTime.now().year + 1, 9),
              initialDate: selectedDate ?? DateTime.now(),
              locale: Locale("en"),
            ).then((date) {
              if (date != null) {
                setState(() {
                  selectedDate = date;
                  selectedDateText = DateFormat('MMMM, yyyy').format(date);
                });
              }
            });
          },
        )
      ],
    );
  }

  // =========== For Location ============
  Widget _buildLocationField() {
    return TextFormField(
      controller: _locationController,
      onChanged: (val) {
        findPlace(val);
      },
      decoration: InputDecoration(
        labelText: "Location",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: "e. g. Malibag, Dhaka",
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[800])),
        //contentPadding: EdgeInsets.all(5.0),
        suffixIcon: placeList.length > 0
            ? IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  _locationController.clear();
                  setState(() {
                    placeList = [];
                  });
                },
              )
            : null,
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "Location is required";
        }
        return null;
      },
    );
  }

  // =========== For District ============
  Widget _buildDstrictField() {
    return DropdownButtonFormField(
      items: districtList
          .map((value) => DropdownMenuItem(
                child: Text(value.name),
                value: value.name,
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedDistrict = value;
        });
      },
      decoration: InputDecoration(
          labelText: "District",
          floatingLabelBehavior: FloatingLabelBehavior.auto),
      validator: (value) => value == null ? 'District is required' : null,
    );

    // AutoCompleteTextField(
    //     controller: _districtController,
    //     itemSubmitted: (item) {
    //       setState(() {
    //         _districtController.text = item;
    //       });
    //     },
    //     key: null,
    //     clearOnSubmit: false,
    //     decoration: InputDecoration(
    //         labelText: "District",
    //         floatingLabelBehavior: FloatingLabelBehavior.auto,
    //         border: UnderlineInputBorder(
    //             borderSide: BorderSide(color: Colors.blueGrey[800]))),
    //     suggestions: districtList,
    //     itemBuilder: (context, item) {
    //       return Container(
    //         padding: EdgeInsets.all(15.0),
    //         child: Row(
    //           children: [
    //             Text(
    //               item,
    //               style: TextStyle(color: Colors.black),
    //             )
    //           ],
    //         ),
    //       );
    //     },
    //     itemSorter: (a, b) {
    //       return a.compareTo(b);
    //     },
    //     itemFilter: (item, query) {
    //       return item.toLowerCase().startsWith(query.toLowerCase());
    //     });
  }

  // =========== For Address ============
  Widget _buildAddressField() {
    return TextFormField(
      controller: _addressController,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: "Address",
          hintText: "e. g. house: #32, road: #08, Shantibag, Malibag, Dhaka",
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[800]))),
      validator: (String value) {
        if (value.isEmpty) {
          return "Address is required";
        }
        return null;
      },
      maxLines: 2,
    );
  }

  // =========== For Category ============
  Widget _buildCategoryField() {
    //category = 'Family';
    return DropdownButtonFormField(
      value: category,
      items: categories
          .map((value) => DropdownMenuItem(
                child: Text(
                  value.categoryName,
                ),
                value: value.categoryName,
              ))
          .toList(),
      onChanged: (selectedCategory) {
        setState(() {
          category = selectedCategory;
        });
      },
      //hint: Text("Select Category"),
      decoration: InputDecoration(
          labelText: "Category",
          floatingLabelBehavior: FloatingLabelBehavior.auto),
      validator: (value) => value == null ? 'Category is required' : null,
    );
  }

  Future<void> _showAlertDialog(String title, String desc) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(desc),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> withoutImageAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No image attached"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Do you want to post without image?"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes I do'),
              onPressed: () {
                Navigator.of(context).pop();
                uploadPostWithoutImage();
              },
            ),
          ],
        );
      },
    );
  }
}
