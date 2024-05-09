import 'package:crmproyect/models/item_dropdown.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  //que le vamos a pasar a este widget
  final String label;
  final List<ItemDropdown> list;
  const DropdownWidget({super.key, required this.list, required this.label});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  ItemDropdown? _select;
  @override
  Widget build(BuildContext context) {
    return 
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:[
                      Text(widget.label),
                      const SizedBox(height: 5.0),
                      Container(
                        padding: const EdgeInsets.only(left: 5.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: DropdownButton(
                          hint: const Text('Fecha'),
                          isExpanded: true,
                          value: _select,
                          underline: const SizedBox(),//quitar la linea del check box
                          items: widget.list.map((item) {
                            return DropdownMenuItem(child: Text(item.label), value: item);
                          }).toList(),
                          onChanged: (value){
                            setState(() {
                                _select=value;
                          });
                      }),
                    )  
                ],),
              );
  }
}