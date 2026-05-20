import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class SudokuPage extends StatefulWidget {
  const SudokuPage({super.key});
  static const name = 'sudoku';

  @override
  State<StatefulWidget> createState() => SudokuPageState();
}

class SudokuPageState extends State<SudokuPage> {
  String? solvedSudoku;
  String? unsolvedSudoku;
  String? currentSudoku;
  int? selected;

  @override
  void initState() {
    super.initState();
    loadAsset();
  }

  Future<void> loadAsset() async {
    solvedSudoku = await rootBundle.loadString('assets/sudoku/solved.txt');
    unsolvedSudoku = await rootBundle.loadString('assets/sudoku/sudoku.txt');
    currentSudoku = unsolvedSudoku;
    setState(() {});
  }

  void setCall(int nb) {
    if (selected == null) return;
    if (currentSudoku![selected!] == '0') {
      setState(() => currentSudoku =
          currentSudoku!.replaceRange(selected!, selected! + 1, nb.toString()));
    }
  }

  BoxBorder getBorder(int index) {
    const BorderSide ok = BorderSide(color: Colors.grey, width: 0.4);
    const BorderSide nok = BorderSide(color: Colors.black, width: 0.2);

    final bool right = index % 3 == 2;
    final bool left = index % 9 == 0;
    final bool top = (index % 27) < 9;
    final bool bottom = index > 71;
    return Border(
      top: top ? ok : nok,
      bottom: bottom ? ok : nok,
      left: left ? ok : nok,
      right: right ? ok : nok,
    );
  }

  int getCol(int index) {
    return index % 9;
  }

  int getRow(int index) {
    return index ~/ 9;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku'),
      ),
      body: unsolvedSudoku != null
          ? Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () =>
                            setState(() => currentSudoku = unsolvedSudoku),
                        icon: const Icon(Icons.refresh)),
                    AspectRatio(
                        aspectRatio: 1,
                        child: GridView.count(
                          crossAxisCount: 9,
                          children: List.generate(
                            81,
                            (index) => getCell(index),
                          ),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: List.generate(
                          9,
                          (index) => InkWell(
                              onTap: () => setCall(index + 1),
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 9,
                                  height: MediaQuery.of(context).size.width / 9,
                                  decoration: BoxDecoration(
                                      border: getBorder(index),
                                      color: Colors.grey.withOpacity(0.2)),
                                  child: Align(child: Text('${index + 1}')))),
                        ),
                      ),
                    ),
                  ]))
          : const Text('loading'));

  Widget getCell(int index) => InkWell(
        onTap: () =>
            setState(() => selected = selected == index ? null : index),
        child: Container(
            decoration: BoxDecoration(
                border: getBorder(index),
                color: selected == null
                    ? null
                    : selected == index
                        ? Colors.red.withOpacity(0.1)
                        : getRow(index) == getRow(selected!) ||
                                getCol(index) == getCol(selected!)
                            ? Colors.blue.withOpacity(0.2)
                            : currentSudoku![index] != '0' &&
                                    currentSudoku![index] ==
                                        currentSudoku![selected!]
                                ? Colors.green.withOpacity(0.1)
                                : null),
            child: Align(
                child: Text(currentSudoku![index] == '0'
                    ? ''
                    : currentSudoku![index]))),
      );
}
