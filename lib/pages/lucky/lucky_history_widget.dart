import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'lucky_controller.dart';

class LuckyHistoryWidget extends StatefulWidget {
  @override
  _LuckyHistoryWidgetState createState() => _LuckyHistoryWidgetState();
}

class _LuckyHistoryWidgetState extends State<LuckyHistoryWidget> {
  final LuckyController luckyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return luckyController.getLoading
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: luckyController.getListLuckyHistory,
            child: luckyController.fetchListLuckyHistory.isEmpty
                ? Center(
                    child: Text(
                    'You doesn\'t have any Lucky History!',
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ExpansionPanelList(
                        expandedHeaderPadding: EdgeInsets.zero,
                        expansionCallback: (panelIndex, isExpanded) {
                          setState(() {
                            luckyController.fetchListLuckyHistory[panelIndex]
                                    .isExpanded =
                                !luckyController
                                    .fetchListLuckyHistory[panelIndex]
                                    .isExpanded;
                          });
                        },
                        children:
                            luckyController.fetchListLuckyHistory.map((item) {
                          return ExpansionPanel(
                            canTapOnHeader: true,
                            isExpanded: item.isExpanded,
                            headerBuilder: (context, isExpanded) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  _dateFormat(item.betDate),
                                  style: Theme.of(context).textTheme.headline5,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                            body: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Number',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Text(
                                      'Diamond',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: (35 * item.number.length).toDouble(),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: item.number.length,
                                    itemBuilder: (context, ind) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                item.number[ind],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              ),
                                              Text(
                                                item.diamond[ind],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
          );
  }
}

String _dateFormat(String date) {
  final DateTime tempDate = DateFormat('yyyy-MM-dd').parse(date);
  final DateFormat formatter = DateFormat('EEE, dd MMMM yyyy');
  return formatter.format(tempDate);
}
