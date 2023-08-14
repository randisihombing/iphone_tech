// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../model/iphone_model.dart';
// import '../provider/iphone_provider.dart';
//
// class DataItem extends StatelessWidget {
//
//   final DataModel data;
//
//   const DataItem(this.data, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final dataProvider = Provider.of<DataProvider>(context, listen: false);
//
//     return ListTile(
//       title: Text(data.name),
//       trailing: Checkbox(
//         value: data.isChecked,
//         onChanged: (newValue) {
//           dataProvider.toggleCheckbox(data.id);
//         },
//       ),
//     );
//   }
// }
