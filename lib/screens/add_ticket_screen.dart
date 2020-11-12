import 'package:aktiMVP/providers/ticket_class.dart';
import 'package:aktiMVP/widgets/auth.dart';
import 'package:aktiMVP/widgets/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';
import 'package:aktiMVP/providers/tickets_provider.dart';

class AddTicketForm extends StatefulWidget {
  static const routeName = '/add_ticket';
  @override
  _AddTicketFormState createState() => _AddTicketFormState();
}

class _AddTicketFormState extends State<AddTicketForm> {
  final DatabaseService _cloud = DatabaseService();
  final formKey = GlobalKey<FormState>();
  var newTicket = Ticket(
      id: '',
      title: '',
      companyName:
          'placeholder', // TODO: Denne må kobles med ${user.title} elns
      description: '',
      fullPrice: 0,
      discountPrice: 0,
      numberAvailableTickets: 0,
      imageUrl: '');

  String ticketTitle, ticketDescription;

  File selectedImageFile;

  void pickImage() async {
    PickedFile imagePickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    File imageFile = File(imagePickedFile.path);
    setState(() {
      selectedImageFile = imageFile;
    });
  }

  Widget showImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(
            width: 2,
            color: Colors.white,
          )),
          child: selectedImageFile != null
              ? Image.file(
                  selectedImageFile,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Center(child: Text('No image selected')),
        ),
      ],
    );
  }

  void saveForm() {
    final isValid = formKey.currentState.validate();
    if (isValid) {
      formKey.currentState.save();
      print('Save Succesfull');
      print('title saved as' + newTicket.title);
    } else {
      print('heck no this aint raight');
    }
  }

  void uploadImage() async {
    final _storage = firebase_storage.FirebaseStorage.instance;
    print('bob');
    print(selectedImageFile.toString());
    final firebase_storage.Reference refe =
        _storage.ref().child('${newTicket.companyName}/${newTicket.title}');

    await refe.putFile(selectedImageFile);

    var downloadUrl = await refe.getDownloadURL();

    setState(() {
      print(downloadUrl + 'Står det noe til venstre her?');
      print(newTicket.discountPrice.toString());
      newTicket = Ticket(
        imageUrl: downloadUrl,
        id: newTicket.id,
        title: newTicket.title,
        companyName: newTicket.companyName,
        description: newTicket.description,
        fullPrice: newTicket.fullPrice,
        discountPrice: newTicket.discountPrice,
        numberAvailableTickets: newTicket.numberAvailableTickets,
      );
    });

    // Put this here to make sure imageUrl is properly updated before anything else
    Tickets().addProduct(newTicket);
  }

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> userData = _cloud.getUserData();
    return FutureBuilder(
      future: userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Card(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Color.fromRGBO(129, 168, 121, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'LEGG TIL EN NY EVENT',
                                style: TextStyle(
                                  color: Color.fromRGBO(63, 107, 71, 1),
                                  fontSize: 24,
                                ),
                              ),

                              // Tittel
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Hovedtittel',
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  hintText:
                                      'Hva skal tittelen på billetten være?',
                                ),
                                onSaved: (value) {
                                  newTicket = Ticket(
                                    id: newTicket.id,
                                    title: value,
                                    companyName: snapshot.data['navn'],
                                    description: newTicket.description,
                                    fullPrice: newTicket.fullPrice,
                                    discountPrice: newTicket.discountPrice,
                                    numberAvailableTickets:
                                        newTicket.numberAvailableTickets,
                                  );
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Dette feltet kan ikke være tomt';
                                  }
                                  if (value.length > 25) {
                                    return 'Max 25 karakterer';
                                  }
                                  return null;
                                },
                              ),

                              // Beskrivelse
                              TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 3,
                                decoration: InputDecoration(
                                    labelText: 'Beskrivelse av opplevelsen',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    hintText: 'Hva går opplevelsen ut på?'),
                                onSaved: (value) {
                                  newTicket = Ticket(
                                    id: newTicket.id,
                                    title: newTicket.title,
                                    companyName: newTicket.companyName,
                                    description: value,
                                    fullPrice: newTicket.fullPrice,
                                    discountPrice: newTicket.discountPrice,
                                    numberAvailableTickets:
                                        newTicket.numberAvailableTickets,
                                  );
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Dette feltet kan ikke være tomt';
                                  }
                                  return null;
                                },
                              ),

                              // Fullpris
                              TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      size: 30,
                                      color: Color.fromRGBO(63, 107, 71, 1),
                                    ),
                                    labelText: 'Orginalpris',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    hintText: 'Førprisen'),
                                onSaved: (value) {
                                  newTicket = Ticket(
                                    id: newTicket.id,
                                    title: newTicket.title,
                                    companyName: newTicket.companyName,
                                    description: newTicket.description,
                                    fullPrice: int.parse(value),
                                    discountPrice: newTicket.discountPrice,
                                    numberAvailableTickets:
                                        newTicket.numberAvailableTickets,
                                  );
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Dette feltet kan ikke være tomt';
                                  }
                                  try {
                                    int.parse(value);
                                  } on FormatException {
                                    return 'Kun tall';
                                  }
                                  return null;
                                },
                              ),

                              // Rabattert Pris
                              TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.check_circle_outline,
                                      size: 30,
                                      color: Color.fromRGBO(63, 107, 71, 1),
                                    ),
                                    labelText: 'Rabattert pris',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    hintText: 'Prisen kunden skal betale'),
                                onSaved: (value) {
                                  newTicket = Ticket(
                                    id: newTicket.id,
                                    title: newTicket.title,
                                    companyName: newTicket.companyName,
                                    description: newTicket.description,
                                    fullPrice: newTicket.fullPrice,
                                    discountPrice: int.parse(value),
                                    numberAvailableTickets:
                                        newTicket.numberAvailableTickets,
                                  );
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Dette feltet kan ikke være tomt';
                                  }
                                  try {
                                    int.parse(value);
                                  } on FormatException {
                                    return 'Kun tall';
                                  }
                                  return null;
                                },
                              ),

                              // Antall billetter
                              TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.confirmation_number,
                                      size: 30,
                                      color: Color.fromRGBO(63, 107, 71, 1),
                                    ),
                                    labelText: 'Antall billetter til salgs',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    hintText: 'Hvor mange billetter'),
                                onSaved: (value) {
                                  newTicket = Ticket(
                                    id: newTicket.id,
                                    title: newTicket.title,
                                    companyName: newTicket.companyName,
                                    description: newTicket.description,
                                    fullPrice: newTicket.fullPrice,
                                    discountPrice: newTicket.discountPrice,
                                    numberAvailableTickets: int.parse(value),
                                  );
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Dette feltet kan ikke være tomt';
                                  }
                                  try {
                                    int.parse(value);
                                  } on FormatException {
                                    return 'Kun tall';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: 20),

                              // Image Preview
                              showImage(),

                              SizedBox(height: 20),

                              // Select Image button
                              Container(
                                width: 170,
                                height: 40,
                                child: RaisedButton(
                                  child: Text('Velg et bilde'),
                                  onPressed: () {
                                    pickImage();
                                  },
                                ),
                              ),

                              // Validate/Save form + Upload button
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton.icon(
                                  label: Text(
                                    'Ferdig - Last opp',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  icon: Icon(
                                    Icons.file_upload,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  color: Color.fromRGBO(63, 107, 71, 0.8),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    saveForm();
                                    uploadImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              backgroundColor: Color.fromRGBO(63, 107, 71, 1),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
