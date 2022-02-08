import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:z_components/components/z-item-tile-convite.dart';
import 'package:z_components/components/z-selection/z-selection-item.dart';
import 'package:z_components/components/z-collection/z-collection-item.dart';
import 'package:z_components/components/z-collection/z-collection.dart';
import 'package:z_components/components/z-inputs/z-input-data-padrao.dart';
import 'package:z_components/components/z-item-tile-pergunta-adicional.dart';
import 'package:z_components/components/z-inputs/z-input-data-expiracao.dart';
import 'package:z_components/components/z-form/presenter/z-form.dart';
import 'package:z_components/components/z-form/view/z-form-viewmodel.dart';
import 'package:z_components/components/z-documentos/presenter/lista-documentos.dart';
import 'package:z_components/view-model/colaborador-documento-viewmodel.dart';
import 'package:z_components/view-model/documento-campo.dart';
import 'package:z_components/components/z-endereco/z-input-endereco.dart';
import 'package:z_components/components/z-tile.dart';

class TelaTesteCard extends StatefulWidget {
  @override
  _TelaTesteCardState createState() => _TelaTesteCardState();
}

class _TelaTesteCardState extends State<TelaTesteCard> {
  List<ZSelectionItem> listaSelecao = [];
  List<ZSelectionItem> listaSelecaoRespostas = [];

  final zEstrutura = new GlobalKey();

  TextEditingController cep = new TextEditingController();
  TextEditingController logradouro = new TextEditingController();
  TextEditingController numero = new TextEditingController();
  TextEditingController cidade = new TextEditingController();
  TextEditingController bairro = new TextEditingController();
  TextEditingController complemento = new TextEditingController();
  TextEditingController estado = new TextEditingController();
  List<ZCollectionItem> lista = [];

  GlobalKey<ZCollectionState> keyPorte = new GlobalKey<ZCollectionState>();

  List<ZCollectionItem> listaPorte = [
    ZCollectionItem(
        valor:
            "Instalador de isolantes térmicos de caldeira e tubulações de teste 123 testando overflow",
        chave:
            "Instalador de isolantes térmicos de caldeira e tubulações de teste 123 testando overflow",
        titulo:
            "Instalador de isolantes térmicos de caldeira e tubulações de teste 123 testando overflow"),
    ZCollectionItem(valor: "Teste2", chave: "Teste2", titulo: "Teste2"),
    ZCollectionItem(valor: "Teste3", chave: "Teste3", titulo: "Teste3"),
    ZCollectionItem(valor: "Teste4", chave: "Teste4", titulo: "Teste4"),
    ZCollectionItem(valor: "Teste5", chave: "Teste5", titulo: "Teste5"),
  ];

  List<ZFormViewModel> listaForm = [
    ZFormViewModel(
        nomeCampo: "Nome Completo",
        obrigatorio: true,
        enabled: true,
        tipoValorCampo: "text",
        controller: TextEditingController()),
    ZFormViewModel(
        nomeCampo: "Data Nascimento",
        obrigatorio: false,
        enabled: true,
        maxLength: 10,
        tipoValorCampo: "date",
        controller: TextEditingController()),
    ZFormViewModel(
        nomeCampo: "Escolaridade",
        obrigatorio: false,
        enabled: true,
        tipoValorCampo: "text",
        controller: TextEditingController()),
    ZFormViewModel(
        nomeCampo: "Email",
        obrigatorio: true,
        enabled: true,
        tipoValorCampo: "text",
        controller: TextEditingController()),
    ZFormViewModel(
        nomeCampo: "Celular",
        obrigatorio: true,
        enabled: true,
        tipoValorCampo: "celular",
        controller: TextEditingController()),
  ];

  List<ColaboradorDocumentoViewModel> _listaDocumentosTemporario = [
    new ColaboradorDocumentoViewModel(
        nomeDocumento: "RG",
        campos: [],
        status: "",
        horizontalOuVertical: "",
        idColaborador: "",
        idDocumento: "",
        idImagemDocumento: "",
        qtdePaginaUpload: "0"
    ),
    new ColaboradorDocumentoViewModel(
        nomeDocumento: "Teste",
        campos: [],
        status: "",
        horizontalOuVertical: "",
        idColaborador: "",
        idDocumento: "",
        idImagemDocumento: "",
        qtdePaginaUpload: "0"
    ),
    new ColaboradorDocumentoViewModel(
        nomeDocumento: "Outro",
        campos: [],
        status: "",
        horizontalOuVertical: "",
        idColaborador: "",
        idDocumento: "",
        idImagemDocumento: "",
        qtdePaginaUpload: "0"
    ),
  ];

  @override
  void initState() {
    listaSelecao = [
      new ZSelectionItem(
          chave: "Universidade", titulo: "Universidade", valor: "Universidade"),
      new ZSelectionItem(
          chave: "1",
          titulo:
              "Instalador de isolantes térmicos de caldeira e tubulações de teste 123 testando overflow",
          valor: "Instalador de isolantes térmicos de caldeira e tubulações"),
      new ZSelectionItem(chave: "2", titulo: "2", valor: "2"),
      new ZSelectionItem(chave: "3", titulo: "3", valor: "3"),
      new ZSelectionItem(chave: "4", titulo: "4", valor: "4"),
      new ZSelectionItem(chave: "5", titulo: "5", valor: "5"),
      new ZSelectionItem(chave: "6", titulo: "6", valor: "6"),
      new ZSelectionItem(chave: "7", titulo: "7", valor: "7"),
      new ZSelectionItem(chave: "8", titulo: "8", valor: "8"),
      new ZSelectionItem(chave: "9", titulo: "9", valor: "9"),
      new ZSelectionItem(chave: "10", titulo: "10", valor: "10"),
      new ZSelectionItem(chave: "11", titulo: "11", valor: "11"),
      new ZSelectionItem(chave: "12", titulo: "12", valor: "12"),
      new ZSelectionItem(chave: "13", titulo: "13", valor: "13"),
      new ZSelectionItem(chave: "14", titulo: "14", valor: "14"),
      new ZSelectionItem(chave: "15", titulo: "15", valor: "15"),
      new ZSelectionItem(chave: "16", titulo: "16", valor: "16"),
      new ZSelectionItem(chave: "17", titulo: "17", valor: "17"),
      new ZSelectionItem(chave: "18", titulo: "18", valor: "18"),
      new ZSelectionItem(chave: "19", titulo: "19", valor: "19"),
      new ZSelectionItem(chave: "20", titulo: "20", valor: "20"),
    ];
    listaSelecaoRespostas = [
      new ZSelectionItem(chave: "2", titulo: "2", valor: "2"),
      new ZSelectionItem(chave: "3", titulo: "3", valor: "3"),
      new ZSelectionItem(chave: "4", titulo: "4", valor: "4"),
    ];
    setState(() {});
    super.initState();
  }

  bool editado = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            editado = !editado;
          });
        },
      ),
      appBar: AppBar(
        leading: new Text("TESTE"),
      ),
      body: new Container(
        child: new ListView(
          children: [
            new ZInputDataPadrao(
              themeData: Theme.of(context),
              controllerData: TextEditingController(),
              dataFocus: FocusNode(),
              legenda: "Data de inicio",
              validacao: (validacaoDataInicio) {},
            ),
            new ZInputDataPadrao(
              themeData: Theme.of(context),
              controllerData: TextEditingController(),
              dataFocus: FocusNode(),
              legenda: "Data final",
              validacao: (validacaoDataFinal) {},
            ),
            new ZInputDataExpiracao(
              themeData: Theme.of(context),
              controllerData: numero,
              onChange: (textoDataExpiracao) {},
              dataFocus: FocusNode(),
              legenda: "Prazo Preenchimento",
              validacao: (validacaoDataFinal) {
                if (validacaoDataFinal) {
                  print("valido");
                } else {
                  print("não valido");
                }
              },
            ),
            new ZInputEndereco(
              themeData: Theme.of(context),
              campoObrigatorio: true,
              cepController: cep,
              logradouroController: logradouro,
              numeroController: numero,
              complementoController: complemento,
              bairroController: bairro,
              cidadeController: cidade,
              estadoController: estado,
              validacao: (validarEndereco){},
            ),
            new ZTile(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ListaDocumentos(
                          iconeInformativo: true,
                          textoInformativo: "Será necessário que nos encaminhe uma foto /imagem dos documentos solicitados assim como  o preenchimento de dados requisitados",
                          tituloTextoInformativo: "Informação de Documento",
                          colaboradorDocumentoViewModel: _listaDocumentosTemporario
                              .map((e) => new ColaboradorDocumentoViewModel(
                            nomeDocumento: e.nomeDocumento,
                            campos: e.campos,
                            idDocumento: e.idDocumento,
                            idImagemDocumento: e.idDocumento,
                            qtdePaginaUpload: "0/${e.qtdePaginaUpload}",
                            imagemObrigatoria: true,
                          ))
                              .toList(),
                          retornarListaDocumentos: (documento) {},
                        )));
              },
              leading: new Row(
                children: [
                  new Icon(
                    Icons.wysiwyg,
                    color: Colors.grey,
                  ),
                  new Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    child: new Text("Documentos"),
                  )
                ],
              ),
              trailing: new Container(
                child: new Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectIcon(SelectStatus selectStatus) {
    switch (selectStatus) {
      case SelectStatus.EM_ANDAMENTO:
        return new Container(
            child: new Icon(
          Icons.article_outlined,
          size: 14,
          color: new Color(0xff2BBAB4),
        ));

      case SelectStatus.FINALIZADO:
        return new Container(
            child: new Icon(
          Icons.sd_card_outlined,
          size: 14,
          color: new Color(0xff2BBAB4),
        ));
      case SelectStatus.APROVADO:
        return new Container(
            child: new Icon(
          Icons.check_circle_outline,
          size: 14,
          color: new Color(0xff2BBAB4),
        ));

      case SelectStatus.NAO_LIDO:
        return new Container(
            child: new Icon(
          Icons.remove_red_eye_outlined,
          size: 14,
          color: Colors.red,
        ));
      case SelectStatus.LIDO:
        return new Container(
            child: new Icon(
          Icons.remove_red_eye_outlined,
          size: 14,
          color: new Color(0xff2BBAB4),
        ));

      case SelectStatus.VENCIDO:
        return new Container(
          child: new Icon(
            Icons.circle,
            color: Colors.red,
            size: 8,
          ),
        );
    }
  }
}
