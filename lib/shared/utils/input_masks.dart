import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var cpfMask = MaskTextInputFormatter(
  mask: "###.###.###-##",
  filter: {"#": RegExp(r'[0-9]')},
);

var phoneMask = MaskTextInputFormatter(
  mask: "(##) #####-####",
  filter: {"#": RegExp(r'[0-9]')},
);
