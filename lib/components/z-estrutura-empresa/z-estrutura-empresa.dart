import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:z_components/api/z-estrutura-empresa/nivel.dart';
import 'package:z_components/components/utils/icone-voltar.dart';
import 'package:z_components/components/utils/svg.dart';
import 'package:z_components/components/z-estrutura-empresa/bloc/z-estrutura-empresa-cubit-model.dart';
import 'package:z_components/components/z-estrutura-empresa/bloc/z-estrutura-empresa-cubit.dart';
import 'package:z_components/components/z-header.dart';
import 'package:z_components/components/z_loading.dart';
import 'package:z_components/styles/main-style.dart';

class ZEstruturaEmpresa extends StatelessWidget {
  final String token;
  final GlobalKey key;
  final bool headerAtivo;
  final void Function(Nivel) onNodeSelected;
  final void Function() onInfoSelected;
  final String header;
  final ZEstruturaEmpresaCubit bloc;
  final bool exibeIconeVoltar;
  final Widget customDrawer;

  ZEstruturaEmpresa(
      {@required this.token,
      @required this.key,
      this.onNodeSelected,
      this.onInfoSelected,
      this.headerAtivo = false,
      this.header = "",
      this.bloc,
      this.exibeIconeVoltar = true,
      this.customDrawer});

  final TreeViewTheme _treeViewTheme = TreeViewTheme(
    expanderTheme: ExpanderThemeData(
        type: ExpanderType.chevron,
        modifier: ExpanderModifier.none,
        position: ExpanderPosition.start,
        color: MainStyle.APP_THEME,
        size: 20,
        animated: true),
    labelStyle: TextStyle(
      fontSize: 16,
      letterSpacing: 0.3,
    ),
    parentLabelStyle: TextStyle(
      fontSize: 16,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w800,
    ),
    iconTheme: IconThemeData(
      size: 18,
      color: Colors.grey.shade800,
    ),
    colorScheme: ColorScheme.light(),
  );

  @override
  Widget build(BuildContext context) {
    if (!bloc.carregou) {
      bloc.buscarEstruturaEmpresa(token);
    }

    return new BlocProvider.value(
        value: bloc,
        child: new Scaffold(
          appBar: montarAppBarWebOuMobile(context),
          drawer: validarCustomDrawer(),
          body: new BlocBuilder<ZEstruturaEmpresaCubit,
              ZEstruturaEmpresaCubitModel>(builder: (context, state) {
            Widget widget = new SmartRefresher(
              controller: bloc.refreshController,
              onRefresh: () {
                bloc.refresh(token);
              },
              enablePullDown: true,
              header: new ClassicHeader(
                idleText: "Puxe para atualizar",
                releaseText: "Solte para atualizar",
                refreshingText: "Atualizando",
                completeText: "Sua lista está atualizada!",
                iconPos: IconPosition.right,
              ),
              child: new Container(
                padding: const EdgeInsets.all(8.0),
                child: new TreeView(
                    controller: bloc.treeViewController,
                    allowParentSelect: true,
                    theme: _treeViewTheme,
                    onNodeTap: (String key) {
                      var node = bloc.treeViewController.getNode(key);

                      bloc.selecionarNo(node);
                    },
                    nodeBuilder: (context, node) => new Container(
                          padding: const EdgeInsets.all(4.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              new Expanded(
                                child: new Text(node.label),
                                flex: 90,
                              ),
                              new Expanded(
                                child: new IconButton(
                                    icon: new Icon(
                                      Icons.chevron_right,
                                      color: MainStyle.APP_THEME,
                                    ),
                                    onPressed: () {
                                      bloc.selecionarNo(node);

                                      if (onNodeSelected != null)
                                        onNodeSelected(node.data as Nivel);
                                    }),
                                flex: 10,
                              )
                            ],
                          ),
                        )),
              ),
            );

            if (state.isLoading)
              widget = new Center(
                child: new ZLoading(),
              );

            return new Column(
              children: [
                adicionarHeader(),
                new Container(
                  color: Colors.white,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        flex: 85,
                        child: new Container(
                          margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                          child: new Container(
                            margin: EdgeInsets.only(left: 16, right: 2),
                            decoration: BoxDecoration(
                                color: Color(0xfff0f0f0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0))),
                            child: new Row(
                              children: <Widget>[
                                new Container(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: new Icon(
                                      Icons.search,
                                      color: Color(0xff999999),
                                    )),
                                new Expanded(
                                    child: new CupertinoTextField(
                                  placeholderStyle: new TextStyle(
                                      color: Color(0xff999999), fontSize: 17),
                                  keyboardType: TextInputType.text,
                                  controller: bloc.searchTextController,
                                  onChanged: (value) {
                                    bloc.filtrarEstruturaEmpresa(value);
                                  },
                                  placeholder: "Buscar",
                                  decoration: new BoxDecoration(
                                      color: Colors.transparent),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      new Expanded(
                          flex: 15,
                          child: new IconButton(
                            icon: new Icon(
                              Icons.filter_list_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                    ],
                  ),
                ),
                new Expanded(child: widget)
              ],
            );
          }),
        ));
  }

  Widget montarAppBarWebOuMobile(BuildContext context) {
    if (kIsWeb) {
      return new AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: new Text(
                "ESTRUTURA EMPRESA",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            new Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Color(0x99999999),
                    width: 1,
                  ),
                ),
              ),
              height: 24,
            ),
            new Container(
              padding: EdgeInsets.all(8),
              height: 50,
              width: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: SvgPicture.asset(
                  SvgUtils.LOGOZELLAR,
                  semanticsLabel: "zellar-logo.svg",
                  placeholderBuilder: (context) => Icon(Icons.error),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
      );
    } else {
      new AppBar(
        actions: [
          new IconButton(
              icon: new Icon(
                Icons.info,
                size: 28,
              ),
              onPressed: () {
                if (onInfoSelected != null) onInfoSelected();
              }),
        ],
        leading: montarWidgetIconeVoltar(context),
        title: new Text("ESTRUTURA DE EMPRESA"),
        centerTitle: true,
      );
    }
  }

  Widget adicionarHeader() {
    if (headerAtivo == false) {
      return new Container();
    } else {
      return new ZHeader(
        child: new Text(header),
        titulo: header,
        elevation: 4,
      );
    }
  }

  Widget montarWidgetIconeVoltar(BuildContext context) {
    if (exibeIconeVoltar) {
      return new IconeVoltar(
        context: context,
      );
    } else {
      return new Container();
    }
  }

  Widget validarCustomDrawer() {
    if (customDrawer != null) {
      return customDrawer;
    } else {
      return new Container();
    }
  }
}
