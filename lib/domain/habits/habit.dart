import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class Habit extends Equatable {
  final String id;
  final String title;
  final List<bool> doneDays;

  Habit({
    String id,
    @required this.title,
    List<bool> doneDays,
  })  : this.id = id ?? Uuid().v4(),
        this.doneDays =
            doneDays ?? [false, false, false, false, false, false, false],
        assert(doneDays == null || doneDays?.length == 7);

  factory Habit.doneToday(Habit habit) {
    int weekday = DateTime.now().weekday;
    List<bool> doneDays = List.from(habit.doneDays);
    doneDays[weekday - 1] = true;
    return Habit(
      id: habit.id,
      title: habit.title,
      doneDays: doneDays,
    );
  }

  factory Habit.notDoneToday(Habit habit) {
    int weekday = DateTime.now().weekday;
    List<bool> doneDays = List.from(habit.doneDays);
    doneDays[weekday - 1] = false;
    return Habit(
      id: habit.id,
      title: habit.title,
      doneDays: doneDays,
    );
  }

  @override
  List<Object> get props => [id, title, doneDays];
}
