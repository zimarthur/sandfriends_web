import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/viewport_offset.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Calendar/View/Mobile/CalendarDatePickerMobile.dart';
import 'package:sandfriends_web/Features/Calendar/View/Mobile/CalendarHeader.dart';
import 'package:sandfriends_web/Features/Calendar/View/Mobile/CalendarWidgetMobile.dart';
import 'package:sandfriends_web/Features/Menu/View/Mobile/SFStandardHeader.dart';
import 'package:sandfriends_web/Utils/TypesExtensions.dart';
import '../../../../Utils/Constants.dart';
import '../../../../Utils/SFDateTime.dart';
import '../../ViewModel/CalendarViewModel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarViewModel viewModel = CalendarViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.initCalendarViewModel(context, true);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalendarViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<CalendarViewModel>(
        builder: (context, viewModel, _) {
          return Container(
            color: secondaryBack,
            child: Column(
              children: [
                CalendarHeader(),
                Expanded(
                    child: Column(
                  children: [
                    CalendarDatePickerMobile(),
                    Expanded(
                      child: CalendarWidgetMobile(
                        viewModel: viewModel,
                      ),
                    ),
                  ],
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}

//  Widget _buildCell(BuildContext context, TableVicinity vicinity) {
//     return Center(
//       child: Text('Tile c: ${vicinity.column}, r: ${vicinity.row}'),
//     );
//   }

//   TableSpan _buildColumnSpan(int index) {
//     const TableSpanDecoration decoration = TableSpanDecoration(
//       border: TableSpanBorder(
//         trailing: BorderSide(),
//       ),
//     );

//     switch (index % 5) {
//       case 0:
//         return TableSpan(
//           foregroundDecoration: decoration,
//           extent: const FixedTableSpanExtent(100),
//           onEnter: (_) => print('Entered column $index'),
//           recognizerFactories: <Type, GestureRecognizerFactory>{
//             TapGestureRecognizer:
//                 GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
//               () => TapGestureRecognizer(),
//               (TapGestureRecognizer t) =>
//                   t.onTap = () => print('Tap column $index'),
//             ),
//           },
//         );
//       case 1:
//         return TableSpan(
//           foregroundDecoration: decoration,
//           extent: const FractionalTableSpanExtent(0.5),
//           onEnter: (_) => print('Entered column $index'),
//           cursor: SystemMouseCursors.contextMenu,
//         );
//       case 2:
//         return TableSpan(
//           foregroundDecoration: decoration,
//           extent: const FixedTableSpanExtent(120),
//           onEnter: (_) => print('Entered column $index'),
//         );
//       case 3:
//         return TableSpan(
//           foregroundDecoration: decoration,
//           extent: const FixedTableSpanExtent(145),
//           onEnter: (_) => print('Entered column $index'),
//         );
//       case 4:
//         return TableSpan(
//           foregroundDecoration: decoration,
//           extent: const FixedTableSpanExtent(200),
//           onEnter: (_) => print('Entered column $index'),
//         );
//     }
//     throw AssertionError(
//         'This should be unreachable, as every index is accounted for in the switch clauses.');
//   }

//   TableSpan _buildRowSpan(int index) {
//     final TableSpanDecoration decoration = TableSpanDecoration(
//       color: index.isEven ? Colors.purple[100] : null,
//       border: const TableSpanBorder(
//         trailing: BorderSide(
//           width: 3,
//         ),
//       ),
//     );

//     switch (index % 3) {
//       case 0:
//         return TableSpan(
//           backgroundDecoration: decoration,
//           extent: const FixedTableSpanExtent(50),
//           recognizerFactories: <Type, GestureRecognizerFactory>{
//             TapGestureRecognizer:
//                 GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
//               () => TapGestureRecognizer(),
//               (TapGestureRecognizer t) =>
//                   t.onTap = () => print('Tap row $index'),
//             ),
//           },
//         );
//       case 1:
//         return TableSpan(
//           backgroundDecoration: decoration,
//           extent: const FixedTableSpanExtent(65),
//           cursor: SystemMouseCursors.click,
//         );
//       case 2:
//         return TableSpan(
//           backgroundDecoration: decoration,
//           extent: const FractionalTableSpanExtent(0.15),
//         );
//     }
//     throw AssertionError(
//         'This should be unreachable, as every index is accounted for in the switch clauses.');
//   }