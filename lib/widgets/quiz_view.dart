import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/data_bloc.dart';
import '../bloc/selection_bloc.dart';
import '../core/helpers/iterable_helpers.dart';
import '../model/quiz_item.dart';

final double _viewportFraction = 0.1;
final Axis _scrollDirection = Axis.vertical;

class QuizView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        log('QuizView.build($state)');
        if (state is DataLoadedState) {
          return Scaffold(
            appBar: AppBar(title: Text('Quizzer')),
            floatingActionButton: Align(
              alignment: Alignment(0.1, 0.16),
              child: FloatingActionButton(
                child: const Text(
                  '=',
                  style: TextStyle(fontSize: 32),
                ),
                autofocus: false,
                onPressed: () {},
              ),
            ),
            body: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocProvider(
                    create: (context) => SelectionBloc(),
                    child: Flexible(
                      child: buildLeftCarousel(
                        context,
                        state.leftList,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => SelectionBloc(),
                    child: Flexible(
                      child: buildRightCarousel(
                        context,
                        state.rightList,
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
  List<QuizItem> items,
) {
  final CarouselController _controller = CarouselController();
  return BlocConsumer<SelectionBloc, SelectionState>(
    listener: (context, state) {
      if (state is SelectionChangedState) {
        _controller.animateToPage(state.index);
      }
    },
    builder: (context, state) {
      return CarouselSlider(
        carouselController: _controller,
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
  List<QuizItem> items,
) {
  final CarouselController _controller = CarouselController();
  return BlocConsumer<SelectionBloc, SelectionState>(
    listener: (context, state) {
      if (state is SelectionChangedState) {
        _controller.animateToPage(state.index);
      }
    },
    builder: (context, state) {
      return CarouselSlider(
        carouselController: _controller,
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
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: isSelected ? Colors.green : Colors.grey,
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
        ),
      );
    },
  );
}
