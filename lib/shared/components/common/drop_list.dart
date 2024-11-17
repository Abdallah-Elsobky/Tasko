import 'package:tasko/shared/components/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/theme.dart';
import '../components.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final int? selectedValue;
  final ValueChanged<String?>? onChanged;
  final String hint;

  const CustomDropdown({
    Key? key,
    required this.items,
    this.selectedValue,
    this.onChanged,
    required this.hint,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.items[widget.selectedValue!];
  }

  


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: MyTheme.backgroundColor.color.withOpacity(.6),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: DropdownButton<String>(
          isExpanded: true,
          underline: const SizedBox.shrink(),
          dropdownColor: MyTheme.backgroundColor.color.withOpacity(.9),
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ) ,
          value: _selectedValue,
          hint: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              widget.hint,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: MyTheme.foregroundColor,
                fontSize: 16,
              ),
            ),
          ),
          items: widget.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  typeShape(getTypeIndex(item), 15, 3),
                  SizedBox(width: 20,),
                  Text(
                    getName(item),
                    style: const TextStyle(
                      color: MyTheme.foregroundColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
        ),
      ),
    );
  }
}
