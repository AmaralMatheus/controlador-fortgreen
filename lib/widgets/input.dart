import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          Container(
            padding: EdgeInsets.fromLTRB(
                20.0, MediaQuery.of(context).size.height * 0.025, 20.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: this.defaultColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.5),
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
              suffix: this.suffix != null ? suffix : SizedBox(),
              hintText: this.hint,
              contentPadding: EdgeInsets.fromLTRB(
                  20.0,
                  MediaQuery.of(context).size.height * 0.0375 - 10,
                  MediaQuery.of(context).size.height * 0.0375 - 10,
                  20.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(
                  color: error?.isEmpty ?? true ? Colors.grey : Colors.red,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(
                  color: error?.isEmpty ?? true ? Colors.black12 : Colors.red,
                ),
              ),
              focusedBorder: OutlineInputBorder(
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
