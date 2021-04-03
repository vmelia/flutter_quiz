import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/data_bloc.dart';
import '../bloc/selection_bloc.dart';
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
              alignment: Alignment(0, 0),
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
                  Flexible(
                    child: buildLeftCarousel(
                      context,
                      state.leftList,
                    ),
                  ),
                  Flexible(
                    child: buildRightCarousel(
                      context,
                      state.rightList,
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

CarouselSlider buildLeftCarousel(
  BuildContext context,
  List<QuizItem> items,
) {
  return CarouselSlider(
    options: CarouselOptions(
        viewportFraction: _viewportFraction,
        scrollDirection: _scrollDirection,
        onPageChanged: (index, reason) {
          BlocProvider.of<SelectionBloc>(context).add(LeftPageChangedEvent(index));
        }),
    items: items.map((item) {
      return buildLeftItem(context, item);
    }).toList(),
  );
}

Builder buildLeftItem(BuildContext context, QuizItem item) {
  final isSelected = false; //ToDo: Fix
  return Builder(
    builder: (BuildContext context) {
      return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: isSelected ? Colors.red : Colors.white),
          child: Text(
            item.name,
            style: const TextStyle(fontSize: 24),
          ));
    },
  );
}

CarouselSlider buildRightCarousel(
  BuildContext context,
  List<QuizItem> items,
) {
  return CarouselSlider(
    options: CarouselOptions(
        viewportFraction: _viewportFraction,
        scrollDirection: _scrollDirection,
        onPageChanged: (index, reason) {
          BlocProvider.of<SelectionBloc>(context).add(RightPageChangedEvent(index));
        }),
    items: items.map((item) {
      return buildRightItem(context, item);
    }).toList(),
  );
}

Builder buildRightItem(BuildContext context, QuizItem item) {
  final isSelected = false; //ToDo: Fix
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
        onPressed: () {},
        child: Text(
          item.name,
        ),
      );
    },
  );
}
