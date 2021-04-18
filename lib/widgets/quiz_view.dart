import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game_bloc.dart';
import '../bloc/grid_bloc.dart';
import '../bloc/selection_bloc.dart';
import '../colours.dart';
import '../core/helpers/iterable_helpers.dart';
import '../model/quiz_item.dart';

final double _viewportFraction = 0.1;
final Axis _scrollDirection = Axis.vertical;

class QuizView extends StatelessWidget {
  final _leftSelectionBloc = SelectionBloc();
  final _rightSelectionBloc = SelectionBloc();
  final _leftController = CarouselControllerImpl();
  final _rightController = CarouselControllerImpl();
  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  Widget _buildWidget(BuildContext context) {
    return BlocBuilder<GridBloc, GridState>(
      builder: (context, state) {
        if (state is DataLoadedState) {
          return Scaffold(
            appBar: AppBar(title: Text('Quizzer')),
            floatingActionButton: Align(
              alignment: Alignment(0.1, 0.17), //ToDo: Align properly.
              child: FloatingActionButton(
                child: const Text(
                  '=',
                  style: TextStyle(fontSize: 32),
                ),
                autofocus: false,
                onPressed: () {
                  BlocProvider.of<GameBloc>(context).add(AttemptAnswerEvent(
                      state.quizData.left[_leftSelectionBloc.selectedIndex],
                      state.quizData.right[_rightSelectionBloc.selectedIndex]));
                },
              ),
            ),
            body: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocProvider(
                    create: (context) => _leftSelectionBloc,
                    child: Flexible(
                      child: buildLeftCarousel(
                        context,
                        _leftController,
                        state.quizData.left,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => _rightSelectionBloc,
                    child: Flexible(
                      child: buildRightCarousel(
                        context,
                        _rightController,
                        state.quizData.right,
                      ),
                    ),
                  ),
                ]),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Widget buildLeftCarousel(
  BuildContext context,
  CarouselController controller,
  List<QuizItem> items,
) {
  return BlocConsumer<SelectionBloc, SelectionState>(
    listener: (context, state) {
      if (state is SelectionChangedState) {
        controller.animateToPage(state.index);
      }
    },
    builder: (context, state) {
      return CarouselSlider(
        carouselController: controller,
        options: CarouselOptions(
            viewportFraction: _viewportFraction,
            scrollDirection: _scrollDirection,
            onPageChanged: (index, reason) {
              BlocProvider.of<SelectionBloc>(context).add(PageChangedEvent(index));
            }),
        items: items.mapIndexed((item, index) {
          return buildItem(context, item, index, state.index == index);
        }).toList(),
      );
    },
  );
}

Widget buildRightCarousel(
  BuildContext context,
  CarouselController controller,
  List<QuizItem> items,
) {
  return BlocConsumer<SelectionBloc, SelectionState>(
    listener: (context, state) {
      if (state is SelectionChangedState) {
        controller.animateToPage(state.index);
      }
    },
    builder: (context, state) {
      return CarouselSlider(
        carouselController: controller,
        options: CarouselOptions(
            viewportFraction: _viewportFraction,
            scrollDirection: _scrollDirection,
            onPageChanged: (index, reason) {
              BlocProvider.of<SelectionBloc>(context).add(PageChangedEvent(index));
            }),
        items: items.mapIndexed((item, index) {
          return buildItem(context, item, index, state.index == index);
        }).toList(),
      );
    },
  );
}

Widget buildItem(BuildContext context, QuizItem item, int index, bool isSelected) {
  return Builder(
    builder: (BuildContext context) {
      return SizedBox(
        height: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: buttonColour(isSelected),
            side: BorderSide(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            BlocProvider.of<SelectionBloc>(context).add(SelectionChangedEvent(index));
          },
          child: Text(
            item.name,
            style: TextStyle(color: textColour(isSelected), fontSize: 17),
          ),
        ),
      );
    },
  );
}

Color buttonColour(bool isSelected) {
  return isSelected ? Colours.buttonSelected : Colours.buttonDeselected;
}

Color textColour(bool isSelected) {
  return isSelected ? Colours.buttonSelectedText : Colours.buttonDeselectedText;
}
