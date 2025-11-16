// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:my_fitness_coach/scr/presentation/app/routes/app_routes.dart';
// import 'package:my_fitness_coach/scr/presentation/theme/style/styles.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../../../../generated/locale_keys.g.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final _first = TextEditingController();
//   final _last = TextEditingController();
//   final _height = TextEditingController();
//   final _weight = TextEditingController();
//   final _goal = TextEditingController();
//   DateTime? _birth;
//   bool _loading = true;

//   Future<void> _load() async {
//     final user = Supabase.instance.client.auth.currentUser;
//     if (user == null) return;
//     final res = await Supabase.instance.client.from('profiles').select().eq('id', user.id).maybeSingle();
//     if (res != null) {
//       _first.text = (res['first_name'] ?? '') as String;
//       _last.text = (res['last_name'] ?? '') as String;
//       _height.text = (res['height_cm']?.toString() ?? '');
//       _weight.text = (res['weight_kg']?.toString() ?? '');
//       _goal.text = (res['goal'] ?? '') as String;
//       final bd = res['birth_date'] as String?;
//       _birth = bd != null ? DateTime.tryParse(bd) : null;
//     }
//     setState(() => _loading = false);
//   }

//   Future<void> _save() async {
//     final user = Supabase.instance.client.auth.currentUser;
//     if (user == null) return;
//     await Supabase.instance.client.from('profiles').upsert({
//       'id': user.id,
//       'first_name': _first.text.trim(),
//       'last_name': _last.text.trim(),
//       'birth_date': _birth?.toIso8601String(),
//       'height_cm': int.tryParse(_height.text),
//       'weight_kg': double.tryParse(_weight.text),
//       'goal': _goal.text.trim(),
//     });
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(LocaleKeys.profile_saved.tr())));
//       Navigator.of(context).canPop()
//           ? Navigator.of(context).pop()
//           : Navigator.of(context).pushReplacementNamed(AppRoutes.home);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _load();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_loading) return const Center(child: CircularProgressIndicator());
//     return Scaffold(
//       appBar: AppBar(title: Text(LocaleKeys.profile_title.tr())),
//       body: ListView(
//         padding: allPadding16,
//         children: [
//           TextField(
//             controller: _first,
//             decoration: InputDecoration(labelText: LocaleKeys.profile_first_name.tr()),
//           ),
//           TextField(
//             controller: _last,
//             decoration: InputDecoration(labelText: LocaleKeys.profile_last_name.tr()),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   _birth == null
//                       ? LocaleKeys.profile_birth_date_choose.tr()
//                       : LocaleKeys.profile_birth_date_label.tr(
//                           namedArgs: {'date': _birth!.toLocal().toIso8601String().substring(0, 10)},
//                         ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   final now = DateTime.now();
//                   final picked = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime(now.year - 20),
//                     firstDate: DateTime(1900),
//                     lastDate: now,
//                   );
//                   if (picked != null) setState(() => _birth = picked);
//                 },
//                 child: Text(LocaleKeys.profile_date_choose.tr()),
//               ),
//             ],
//           ),
//           TextField(
//             controller: _height,
//             decoration: InputDecoration(labelText: LocaleKeys.profile_height.tr()),
//             keyboardType: TextInputType.number,
//           ),
//           TextField(
//             controller: _weight,
//             decoration: InputDecoration(labelText: LocaleKeys.profile_weight.tr()),
//             keyboardType: TextInputType.number,
//           ),
//           TextField(
//             controller: _goal,
//             decoration: InputDecoration(labelText: LocaleKeys.profile_goal.tr()),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(onPressed: _save, child: Text(LocaleKeys.profile_save.tr())),
//         ],
//       ),
//     );
//   }
// }
