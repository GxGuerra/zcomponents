import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:z_components/api/contas/contas-service.dart';
import 'package:z_components/api/contas/i-contas-service.dart';
import 'package:z_components/components/filtro/filter-expression.dart';
import 'package:z_components/components/filtro/z-searchbar.dart';
import 'package:z_components/components/fluxo-admin/modulos.dart';
import 'package:z_components/i-view.dart';
import 'package:z_components/view-model/modulo-conta-viewmodel.dart';

class ModulosView extends IView<Modulos>{
  ModulosView(State<Modulos> state) : super(state);

  List<ModuloContaViewModel> listaModulos = [];
  GlobalKey<ZSearchBarState> keySearchBar = new GlobalKey();
  SearchOptions searchOptions = new SearchOptions();
  PaginationMetaData paginationMetaData = new PaginationMetaData();
  ScrollController scrollController;
  IContasService contasService;

  @override
  Future<void> initView() async{
    contasService = new ContasService(
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjdmNWRhNTcwNzBmZTJhZjEyZmM5ZDNhMDAyNDM0ODgwIiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MjI1OTY3NDksImV4cCI6MTYyMjYwMDM0OSwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIiLCJhdWQiOlsiaHR0cHM6Ly9pZGVudGl0eS1zZXJ2ZXItZGV2LnplbGxhci5jb20uYnIvcmVzb3VyY2VzIiwibW9sdHJlcy5hY2Vzc28uYXBpIl0sImNsaWVudF9pZCI6IlpHZXN0b3IiLCJzdWIiOiIwMjFmOTE4Mi0zZjQxLTRmMGEtYWFkYy00MDc3NmU2MGQwNGMiLCJhdXRoX3RpbWUiOjE2MjI1OTY3NDcsImlkcCI6ImxvY2FsIiwiQXNwTmV0LklkZW50aXR5LlNlY3VyaXR5U3RhbXAiOiIzS0U2RUNEUlRIR0dYQURBTUNXR1pHQUVEWDJEM1lPTCIsImFjY291bnQiOiJaZWxsYXIyIiwiaWRBY2NvdW50IjoiM2YyYmRjYmItNzY0Zi00OGM3LTBjMzMtMDhkN2NmNjNlNDViIiwiaWRDb2xhYm9yYWRvciI6IjE1ODQyQzJFLUM3RDctNERENS04RkE5LUZFMzNDQkQ2NENFQyIsInByZWZlcnJlZF91c2VybmFtZSI6IjQyNi45MTAuMjU4LTYxIiwiZW1haWwiOiJsdWl6Lmx1Y2lhQHplbGxhci5jb20uYnIiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlcl92ZXJpZmllZCI6ZmFsc2UsIm5hbWUiOiJMdWl6IEx1Y2lhIE5ldG8iLCJwaG9uZV9udW1iZXIiOiIxMTk0ODQ4NDEyMCIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIm1vbHRyZXMuYWNlc3NvLmFwaS5mdWxsIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdfQ.nkGOpq8fEe3Db2wXxn8z4UAfP6uYkP7esKcJnNvw0250iSXj1TPQ4oYHCpL7TFCLQSmixyVRN1BRB6XcQKJrHQz5gbfU0f1KXBoNwIpy88fE5OkPiy6_5xYruaEYJvbykG2Eq-QiQ2RnJMbop2rxTzKW2Eyosdub9DmCUJ5nXbTgR9OwwlyRG22y6hznRcpAwfJHmyYLzKKrmDUE92-kQNTTl-EsPmo8bvma9MR6iTxbkENCaA7Wxc-BTwcmADDl5AhzUjF5i_Dg2A4W1H4qOvtOCkG_p96bf1iTpV1ZillwCMeerNNzuyXf0INfBv5qYocmgf0RRebg5lc1WzPZNQ");

    await buscarListaModulos(searchOptions);

    scrollController = new ScrollController();
    scrollController.addListener(onScroll);
  }

  @override
  Future<void> afterBuild() {
  }

  Future<void> buscarListaModulos(SearchOptions searchOptions,
      {bool scrollPage}) async {
    var res = await contasService.listarModulosConta(searchOptions);

    if (res != null) {
      if (scrollPage != null) {
        listaModulos = listaModulos + res.body;
        print(listaModulos);
      } else {
        listaModulos = res.body;
      }
      if (state.mounted) {
        state.setState(() {
          paginationMetaData = res.paginationMetaData;
          this.searchOptions = searchOptions;
        });
      }
    }
  }

  Future<void> onScroll() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (this.paginationMetaData.hasNext) {
        this.searchOptions.pagination.pageNumber++;

        await buscarListaModulos(this.searchOptions, scrollPage: true);
      }
    }
  }


}