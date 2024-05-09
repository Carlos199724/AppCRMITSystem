import 'package:crmproyect/components/errorView.dart';
import 'package:crmproyect/service/httpbd.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import '../HistoriNotification.dart';
import '../models/item_dropdown.dart';
import '../../components/LoadingIndicator.dart';

class OpcionesUser extends StatefulWidget {
  final int userDet;
  //final String assignmentDate;//
  OpcionesUser({required this.userDet});//required this.assignmentDate

  @override
  State<OpcionesUser> createState() => _OpcionesUserState();
}

class _OpcionesUserState extends State<OpcionesUser> {
  String _comentariotipi = '';
  String _fechaRecord = '';
  bool _isSent = false;
  bool _isLoading = false;
  //File? _imageFile;
  String _errorMessage = '';
Future<void> _enviarDatos() async {
  // Verificar que los campos no estén vacíos
  if (_comentariotipi.isEmpty || _fechaRecord.isEmpty) {
    _showSnackBar('Todos los campos son obligatorios', Colors.red);
    return;
  }

  setState(() {
    _isLoading = true;
    _errorMessage = ''; // Limpiar cualquier mensaje de error anterior
  });

  // Obtenemos los datos del comentario y la fecha
  String comentariotipi = _comentariotipi;
  String fechaDate = _fechaRecord;

  // Enviamos los datos al servidor
  dynamic response =
      await HttpService().RegisterTipificacion(comentariotipi, fechaDate, widget.userDet);
  if (response != null && response is Map<String, dynamic>) {
    if (response.containsKey('error')) {
      setState(() {
        _isLoading = false;
        _errorMessage = response['error'];
      });
      _showSnackBar(_errorMessage, Colors.red);
    } else {
      // Mostrar un mensaje de éxito predeterminado
      _showSnackBar('¡Datos enviados con éxito!', Colors.green);
      setState(() {
        _isSent = true; // Establecer _isSent solo si el envío fue exitoso
        _isLoading = false;
      });
    }
  } else {
    setState(() {
      _isLoading = false;
      _errorMessage = 'Ocurrió un error al procesar la respuesta.';
    });
    _showSnackBar(_errorMessage, Colors.red);
  }
}

void _showSnackBar(String message, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ),
  );
}

  final HttpService httpService = HttpService();
  final List<ItemDropdown>listSex =[
    ItemDropdown(label: 'En seguimiento', value: 'es'),
    ItemDropdown(label: 'Pagará', value: 'pg'),
    ItemDropdown(label: 'Pagado', value: 'pd'),
    ItemDropdown(label: 'Caido-Calificado', value: 'cc'),
    ItemDropdown(label: 'Caído-No calificado', value: 'cn'),
  ];
  ItemDropdown? _selectSex;
  final List<ItemDropdown>listEs =[
    ItemDropdown(label: 'Por llamar', value: 'pl'),
    ItemDropdown(label: 'Confirmará', value: 'c'),
  ];
  ItemDropdown? _listEs;
  String? _fechaSeleccionada;
  String? _horaSeleccionada;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: httpService.getDetalleUser(widget.userDet),
          builder: (context, snapshot){
                // Obtén el primer objeto UserDetalle de la lista
              final interesDetalle = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset('assets/Logo-simplificado-negro.png', height: 20, width: 130,),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoriNotification()),);
                    }, 
                    icon: Stack(
                      children: [
                        Icon(Icons.notifications, size: 40, color: Color.fromARGB(255, 149, 155, 160)),
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  constraints: BoxConstraints(
                              minWidth:17,
                              minHeight: 17
                            ),
                            child: Text('0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10
                            ),
                            ),
                          )
                        )
                      ],
                    )
            
                    )
                  ]
                ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.grey,)),
                      Text("Medio WhatsApp | 05/01/2024",
                      style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                           ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(interesDetalle.fullName!,
                          style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                               ),
                          ),
                    ],
                  ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Text("Descripción de Tipificaciones",
                              style:TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                              ],
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      _comentariotipi = value;
                                      });
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          ),
                                          labelText: "Comentario", // Añade un texto descriptivo si es necesario
                                          ),
                                          maxLines: 5,
                                        ),
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                          children: [
                            Text("Añadir Recordatorio",
                              style:TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                              ],
                              ),
                              SizedBox(height: 10,),
                              TextField(
                                readOnly: true,
                                onTap: () {
                                  _mostrarSelectorFecha(context);
                                  },
                                  onChanged: (value) {
                              setState(() {
                                _fechaRecord = value;
                              });
                            },
                                  controller: TextEditingController(text: _fechaSeleccionada ?? ''),
                                  decoration: InputDecoration(
                                    hintText: "Fecha",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none,
                                      ),
                                      fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                                      filled: true,
                                      prefixIcon: Icon(Icons.calendar_today),
                                      ),
                                      ),
                                    /*SizedBox(height: 10,),
                                    TextField(
                                      readOnly: true,
                                      onTap: () {
                                        _mostrarSelectorHora(context);
                                        },
                                        controller: TextEditingController(text: _horaSeleccionada ?? ''),
                                        decoration: InputDecoration(
                                          hintText: "Hora",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(18),
                                            borderSide: BorderSide.none,
                                            ),
                                            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                                            filled: true,
                                            prefixIcon: Icon(Icons.access_time),
                                            ),
                                            ),*/
                                    /*SizedBox(height: 15,),
                                    Row(
                          children: [
                            Text("Estado",
                              style:TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                              ],
                              ),
                              SizedBox(height: 5.0,),
                            Container(
                              padding: EdgeInsets.only(left: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: DropdownButton(
                                hint:Text('Ingrese estado ...'),
                                isExpanded: true,
                                value: _selectSex,
                                underline: const SizedBox(),
                                items: listSex.map((item){
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item.label),
                                    );
                                }).toList(),
                                onChanged: (value){
                                  setState(() {
                                    _selectSex=value;
                                  });
                                }),
                              ),*/
                              /*SizedBox(height: 15,),
                              Row(
                          children: [
                            Text("Sub Estado",
                              style:TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                              ],
                              ),
                              SizedBox(height: 5.0,),
                            Container(
                              padding: EdgeInsets.only(left: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: DropdownButton(
                                hint:Text('Ingrese sub estado ...'),
                                isExpanded: true,
                                value: _listEs,
                                underline: const SizedBox(),
                                items: listEs.map((item){
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item.label),
                                    );
                                }).toList(),
                                onChanged: (value){
                                  setState(() {
                                    _listEs=value;
                                  });
                                }),
                              ),*/
                              SizedBox(height: 15,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child:_isLoading
                                    ? LoadingIndicator()
                                // Ajusta el tamaño del botón
                                : ElevatedButton.icon(
                                  onPressed: _isLoading ? null : () {
                              // Verifica si ya se envió un reporte
                              if (_isSent) {
                                // Muestra el mensaje de error
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Ya enviaste tu reporte'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                // Si no se ha enviado un reporte, llama al método _enviarDatos
                                _enviarDatos();
                              }
                            },
          icon: Icon(Icons.save),
          label: Text("Guardar"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ), backgroundColor: Colors.blue,
            padding: EdgeInsets.all(1.0),
            fixedSize: Size(200, 45),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            elevation: 10,
            shadowColor: Colors.lightBlue[100],
            side: BorderSide(color: Colors.blue, width: 1),
          ),
        ),
            ),
            SizedBox(width: 10), // Espacio entre los botones
            Expanded(
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.error),
          label: Text("No contestó"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ), backgroundColor: Colors.red,
            padding: EdgeInsets.all(1.0),
            fixedSize: Size(200, 45),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            elevation: 10,
            shadowColor: Colors.lightBlue[100],
            side: BorderSide(color: Colors.red, width: 1),
          ),
        ),
            ),
          ],
        ),
                            ],
                          ),
                        );
                        }
      ),
                    );
                  }
  Future<void> _mostrarSelectorFecha(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );
  if (pickedDate != null && pickedDate != _fechaSeleccionada) {
    setState(() {
      _fechaSeleccionada = pickedDate.toString();
      _fechaRecord = pickedDate.toString(); // Actualiza también _fechaRecord
    });
  }
}
  Future<void> _mostrarSelectorHora(BuildContext context) async {
    final TimeOfDay? horaSeleccionada = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horaSeleccionada != null) {
      setState(() {
        _horaSeleccionada = horaSeleccionada.format(context);
      });
    }
  }
}

