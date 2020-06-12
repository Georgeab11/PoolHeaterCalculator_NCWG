import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poolheatercalculator/ui/shared/constants.dart';

class MobiLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class MobiButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final Color textColor;
  final EdgeInsetsGeometry padding;

  MobiButton(
      {@required this.text,
      @required this.onPressed,
      this.padding,
      this.color,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: double.infinity,
        color: color ?? Colors.redAccent,
        child: Center(
          child: Padding(
            padding: padding ?? EdgeInsets.all(0),
            child: Text(
              text,
              style: Theme.of(context)
                  .primaryTextTheme
                  .button
                  .copyWith(color: textColor ?? Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class MobiTextFormField extends StatelessWidget {
  final Function onChanged;
  final Function onTap;
  final String label;
  final Widget prefixIcon;
  final String initialValue;
  final bool readOnly;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLength;
  final String suffixText;
  final Icon suffixIcon;
  final bool isEnabled;
  final int minLines;
  final Function validator;

  const MobiTextFormField(
      {this.label,
      this.onChanged,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      this.initialValue,
      this.readOnly,
      this.controller,
      this.keyboardType,
      this.maxLength,
      this.suffixText,
      this.minLines = 1,
      this.validator,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.white,
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        onChanged: onChanged,
        minLines: minLines,
        maxLines: minLines,
        onTap: onTap,
        enabled: isEnabled,
        maxLength: maxLength,
        keyboardType: keyboardType ?? TextInputType.text,
        initialValue: initialValue,
        controller: controller,
        readOnly: readOnly ?? false,
        validator: validator ??
            (value) {
              if (value.isEmpty) {
                return 'This field is Mandatory';
              }
              return null;
            },
        decoration: InputDecoration(
          fillColor: Colors.grey[900],
          filled: true,
          enabledBorder: OutlineInputBorder(),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: kAccentColor)),
          labelText: label,
          prefixIcon: prefixIcon,
          suffixIcon: suffixText != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SizedBox(
                    child: Center(
                      widthFactor: 0.0,
                      child: Text(
                        suffixText,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                )
              : null,
          labelStyle: TextStyle(color: kAccentColor),
        ),
      ),
    );
  }
}

class MobiTextFormFieldLight extends StatelessWidget {
  final Function onChanged;
  final Function onTap;
  final String label;
  final Widget prefixIcon;
  final String initialValue;
  final bool readOnly;
  final TextEditingController controller;
  final TextAlign textAlign;
  final TextInputType keyboardType;

  const MobiTextFormFieldLight(
      {this.label,
      this.onChanged,
      this.prefixIcon,
      this.onTap,
      this.initialValue,
      this.readOnly,
      this.controller,
      this.textAlign,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.white,
      ),
      child: TextFormField(
        textAlign: textAlign ?? TextAlign.left,
        style: TextStyle(color: Colors.white, fontSize: 20),
        onChanged: onChanged,
        onTap: onTap,
        initialValue: initialValue,
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon,
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class MobiText extends StatelessWidget {
  final String text;
  final Widget prefixIcon;
  final TextStyle textStyle;
  final TextOverflow textOverflow;
  final double iconGapWidth;
  final Function onTap;
  final bool border;
  final Widget suffixIcon;

  const MobiText(
      {@required this.text,
      this.prefixIcon,
      this.suffixIcon,
      this.textStyle,
      this.iconGapWidth = 40,
      this.textOverflow = TextOverflow.visible,
      this.border = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List<Widget>();
    if (prefixIcon != null) {
      children.add(prefixIcon);
      children.add(SizedBox(
        width: iconGapWidth,
      ));
    }

    children.add(Flexible(
      fit: FlexFit.loose,
      child: Text(
        text,
        overflow: textOverflow,
        softWrap: true,
        style: this.textStyle ?? TextStyle(fontSize: 20),
      ),
    ));
    if (suffixIcon != null) {
      children.add(SizedBox(
        width: iconGapWidth,
      ));
      children.add(suffixIcon);
    }
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.black,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: border ? Border.all(color: Colors.red) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ),
        ),
      ),
    );
  }
}

class MobiDropDown extends StatelessWidget {
  final String hint;
  final Function onChanged;
  final List<Widget> items;
  final Object value;
  final Icon prefixIcon;
  final bool isDense;

  MobiDropDown(
      {this.hint,
      @required this.onChanged,
      @required this.items,
      @required this.value,
      this.isDense = true,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Theme(
        child: DropdownButtonFormField(
          isExpanded: true,
          isDense: isDense,
          value: value,
          decoration: InputDecoration(
            fillColor: Colors.grey[900],
            filled: true,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellowAccent)),
          ),
          onChanged: onChanged,
          items: items,
          hint: Text(hint ?? ""),
        ),
        data: ThemeData(canvasColor: Colors.grey[900]));
  }
}

//  TextStyle kMyStyle = TextStyle(fontSize: textSize, color: color);
//  return kMyStyle;
