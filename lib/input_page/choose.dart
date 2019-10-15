import 'package:bmi_calculator/input_page/upper_curve_clipper.dart';
import 'package:bmi_calculator/input_page/utils.dart';
import 'package:bmi_calculator/input_page/utils_widget.dart';
import 'package:flutter/material.dart';
import "package:scoped_model/scoped_model.dart";

import "ChatModel.dart" show ChatModel, model;

class SearchPage extends StatelessWidget {
  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return ScopedModel<ChatModel>(
      model: model,
      child: ScopedModelDescendant<ChatModel>(
        builder: (BuildContext context, Widget inChild, ChatModel inModel) {
          return upperPart();
        },
      ),
    );
  }

  Widget upperPart() {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: UpperClipper(),
          child: Container(
            height: size.getWidthPx(240),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorCurve, colorCurveSecondary],
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: size.getWidthPx(36)),
              child: Column(
                children: <Widget>[
                  titleWidget(),
                  SizedBox(height: size.getWidthPx(10)),
                  maleFamaleCard(),
                  chooseAgeCard()
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Text titleWidget() {
    return Text("Пообщаемся?",
        style: TextStyle(
            fontFamily: 'Exo2',
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            color: Colors.white));
  }

  Card maleFamaleCard() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.symmetric(
          horizontal: size.getWidthPx(20), vertical: size.getWidthPx(7)),
      borderOnForeground: true,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(height: size.getWidthPx(125)),
        child: GridView.count(
          physics: new NeverScrollableScrollPhysics(),
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: size.getWidthPx(10),
          mainAxisSpacing: size.getWidthPx(10),
          crossAxisCount: 2,
          children: <Widget>[
            Column(
              children: <Widget>[
                centerAlignText(
                    text: "Мой пол",
                    textColor: textPrimaryColor,
                    fontSize: 14.0),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(8)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.myMaleGenderOn)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.myMaleGenderOn,
                    label: Text('Мужской'),
                    onSelected: (selected) {
                      model.setMyMaleGenderOn(!model.myMaleGenderOn);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(8)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.myFemaleGenderOn)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.myFemaleGenderOn,
                    label: Text('Женский'),
                    onSelected: (selected) {
                      model.setMyFemaleGenderOn(!model.myFemaleGenderOn);
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                centerAlignText(
                    text: 'Пол собеседника',
                    textColor: textPrimaryColor,
                    fontSize: 14.0),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(8)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.conversationalistMaleGenderOn)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.conversationalistMaleGenderOn,
                    label: Text('Мужской'),
                    onSelected: (selected) {
                      model.setConversationalistMaleGenderOn(
                          !model.conversationalistMaleGenderOn);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(8)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.conversationalistFemaleGenderOn)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.conversationalistFemaleGenderOn,
                    label: Text('Женский'),
                    onSelected: (selected) {
                      model.setConversationalistFemaleGenderOn(
                          !model.conversationalistFemaleGenderOn);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card chooseAgeCard() {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.symmetric(
          horizontal: size.getWidthPx(20), vertical: size.getWidthPx(18)),
      borderOnForeground: true,
      child: new ListTile(
        onTap: null,
        title: Row(children: <Widget>[
          new Expanded(
            child: Column(
              children: <Widget>[
                centerAlignText(
                    text: "Мой возраст",
                    textColor: textPrimaryColor,
                    fontSize: 14.0),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(7)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.myBelow16)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.myBelow16,
                    label: Text('Меньше 17'),
                    onSelected: (selected) {
                      model.setMyBelow16(!model.myBelow16);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(7)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.myFrom17To19)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.myFrom17To19,
                    label: Text('      17-19      '),
                    onSelected: (selected) {
                      model.setMyFrom17To19(!model.myFrom17To19);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(7)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.myFrom20To24)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.myFrom20To24,
                    label: Text('      20-24      '),
                    onSelected: (selected) {
                      model.setMyFrom20To24(!model.myFrom20To24);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(7)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.myFrom25To29)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.myFrom25To29,
                    label: Text('      25-29      '),
                    onSelected: (selected) {
                      model.setMyFrom25To29(!model.myFrom25To29);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(7)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.myFrom30To36)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.myFrom30To36,
                    label: Text('      30-36      '),
                    onSelected: (selected) {
                      model.setMyFrom30To36(!model.myFrom30To36);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(7)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.myMoreThen37)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.myMoreThen37,
                    label: Text('Больше 36'),
                    onSelected: (selected) {
                      model.setMyMoreThen37(!model.myMoreThen37);
                    },
                  ),
                ),
              ],
            ),
          ),
          new Expanded(
            child: Column(
              children: <Widget>[
                centerAlignText(
                    text: "Мой возраст",
                    textColor: textPrimaryColor,
                    fontSize: 14.0),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(7)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.conversationalistBelow16)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.conversationalistBelow16,
                    label: Text('Меньше 17'),
                    onSelected: (selected) {
                      model.setConversationalistBelow16(
                          !model.conversationalistBelow16);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(7)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.conversationalistFrom17To19)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.conversationalistFrom17To19,
                    label: Text('      17-19      '),
                    onSelected: (selected) {
                      model.setConversationalistFrom17To19(
                          !model.conversationalistFrom17To19);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(7)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.conversationalistFrom20To24)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.conversationalistFrom20To24,
                    label: Text('      20-24      '),
                    onSelected: (selected) {
                      model.setConversationalistFrom20To24(
                          !model.conversationalistFrom20To24);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(7)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.conversationalistFrom25To29)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.conversationalistFrom25To29,
                    label: Text('      25-29      '),
                    onSelected: (selected) {
                      model.setConversationalistFrom25To29(
                          !model.conversationalistFrom25To29);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(7)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.conversationalistFrom30To36)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.conversationalistFrom30To36,
                    label: Text('      30-36      '),
                    onSelected: (selected) {
                      model.setConversationalistFrom30To36(
                          !model.conversationalistFrom30To36);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.getWidthPx(7)),
                  child: ChoiceChip(
                    backgroundColor: backgroundColor,
                    selectedColor: colorCurve,
                    labelStyle: TextStyle(
                        fontFamily: 'Exo2',
                        color: (model.conversationalistMoreThen37)
                            ? backgroundColor
                            : textPrimaryColor),
                    elevation: 4.0,
                    padding: EdgeInsets.symmetric(
                        vertical: size.getWidthPx(4),
                        horizontal: size.getWidthPx(22)),
                    selected: model.conversationalistMoreThen37,
                    label: Text('Больше 36'),
                    onSelected: (selected) {
                      model.setConversationalistMoreThen37(
                          !model.conversationalistMoreThen37);
                    },
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
