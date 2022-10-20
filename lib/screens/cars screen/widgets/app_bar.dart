part of '../cars_screen.dart';

class _AppBar extends StatefulWidget with PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  State<_AppBar> createState() => _AppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

List<String> filter = [
  'По годам(по возрастанию)',
  'По годам(по убыванию)',
  'По цене(с дорогих)',
  'По цене(с дешевых)',
  'По алфавиту(с начало)',
  'По алфавиту(с конца)',
];
String? firstValue;

class _AppBarState extends State<_AppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.colorsLightGreen,
      title: SizedBox(
        height: 45,
        child: TextField(
          onChanged: (text) {
            BlocProvider.of<CarBloc>(context)
                .add(SearchCars(text.toLowerCase()));
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.colorFFFFFF,
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              label: Icon(
                Icons.search,
                color: AppColors.colorGreys,
              ),
              fillColor: AppColors.colorFFFFFF,
              filled: true),
        ),
      ),
      actions: [
        const SizedBox(width: 16),
        DropdownButton<String>(
          icon: null,
          alignment: AlignmentDirectional.centerEnd,
          hint: const Text('Сортировка'),
          style: const TextStyle(
            color: Color.fromARGB(255, 61, 61, 61),
            fontSize: 14.5,
          ),
          value: firstValue,
          items: filter
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (v) {
            switch (v) {
              case 'По годам(по возрастанию)':
                {}
                BlocProvider.of<CarBloc>(context)
                    .add(FilterCars(Filter.byYearUp));
                break;
              case 'По годам(по убыванию)':
                {}
                BlocProvider.of<CarBloc>(context)
                    .add(FilterCars(Filter.byYearDown));
                break;
              case 'По цене(с дорогих)':
                BlocProvider.of<CarBloc>(context)
                    .add(FilterCars(Filter.byPriceDown));
                break;
              case 'По цене(с дешевых)':
                BlocProvider.of<CarBloc>(context)
                    .add(FilterCars(Filter.byPriceUp));
                break;
              case 'По алфавиту(с начало)':
                BlocProvider.of<CarBloc>(context)
                    .add(FilterCars(Filter.byNameUp));
                break;
              case 'По алфавиту(с конца)':
                BlocProvider.of<CarBloc>(context)
                    .add(FilterCars(Filter.byNameDown));
            }
            firstValue = v;

            setState(() {});
          },
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
