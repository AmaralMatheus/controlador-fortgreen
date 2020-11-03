import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String label, error, hint;
  final TextEditingController controller;
  final Function function;
  final Color defaultColor;
  final bool hide, enabled;
  final Widget suffix;
  final int maxlines;
  final TextInputType keyboard;
  final TextCapitalization textCapitalization;

  Input(
      {@required this.label,
      @required this.error,
      @required this.controller,
      this.keyboard = TextInputType.text,
      this.hide = false,
      this.function,
      this.enabled = true,
      this.defaultColor = Colors.black,
      this.suffix,
      this.maxlines = 1,
      this.hint = '',
      this.textCapitalization});

  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            maxLines: this.maxlines,
            enabled: this.enabled,
            obscureText: hide != null ? hide : false,
            textCapitalization: textCapitalization != null
                ? textCapitalization
                : TextCapitalization.none,
            keyboardType: keyboard,
            controller: controller,
            onChanged: (value) => function(value),
            decoration: InputDecoration(
              suffix: this.suffix,
              hintText: this.label,
              contentPadding: EdgeInsets.symmetric(horizontal:20.0),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(
                  color: error?.isEmpty ?? true ? Colors.grey : Colors.red,
                ),
              ),
              disabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(
                  color: error?.isEmpty ?? true ? Colors.black12 : Colors.red,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(
                  color: this.defaultColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 2.5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              error?.isNotEmpty ?? false ? error : '',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ],
      );
}