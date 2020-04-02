import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/utils/dialog-utils.dart';
import 'package:z_components/styles/main-style.dart';

class ZInputCEP extends StatefulWidget {

  final Key key;
  FocusNode cepFocus;
  var controllerCep = new TextEditingController();
  FocusNode proximoFocus;
  ValueChanged<String> onChange;

  ZInputCEP(
      {this.key,
        @required this.cepFocus,
        @required this.controllerCep,
        this.onChange,
        this.proximoFocus,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ZInputCEPState();
}

class ZInputCEPState extends State<ZInputCEP> {

  DialogUtils _dialogUtils;
  String cep = "";

  @override
  void initState() {
    _dialogUtils = new DialogUtils(context);
    initCep();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainStyle.styleTextInput(
        context,
        "CEP:",
        TextInputType.number,
            () {
          FocusScope.of(context).requestFocus(widget.cepFocus);
        },
        widget.cepFocus,
        widget.controllerCep,
        widget.proximoFocus,
            (text) {
              if (widget.onChange != null) widget.onChange(text);

              cep = text;
          if (cep.length == 9) {

            _fieldFocusChange(context, widget.cepFocus,
                widget.proximoFocus);
          }
        },true,
        textMask: "XXXXX-XXX",
        hintText: "XXXXX-XXX");
  }

  void initCep() {
    widget.cepFocus.addListener(() {
      if (!widget.cepFocus.hasFocus && cep != "") {
        _validarCEP();
      }
    });
  }
  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    if (nextFocus != null) {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
  void _validarCEP() {
    if (cep.length < 9 && cep != "") {
      _dialogUtils.showAlertDialogNewAviso(
          "CEP Inválido!", "Por Favor, Termine de digitar o seu cep.");
    }
  }
}
