import 'package:achiever_app/domain/habits/habit.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {});
  test(
    'Habit() constructor generates id when none is supplied',
    () {
      // arrange
      final testTitle = 'test title';
      final testDoneDays = [false, false, false, false, false, false, false];
      // act
      final testHabit = Habit(
        title: testTitle,
        doneDays: testDoneDays,
      );
      // assert
      assert(testHabit.id != null);
      assert(testHabit.id.length > 0);
    },
  );

  test('Habit() constructor does not change id when id is supplied', () {
    // arrange
    final testId = 'testid';
    final testTitle = 'test title';
    // act
    final testHabit = Habit(id: testId, title: testTitle);
    // assert
    assert(0 == testHabit.id.compareTo(testId));
  });

  test(
      'Habit.doneToday() factory generates habit which is marked done for the current day of the week',
      () {
    // arrange
    final weekday = DateTime.now().weekday;
    final testHabit = Habit(title: "test title");
    // act
    final testHabit2 = Habit.doneToday(testHabit);
    // assert
    assert(testHabit.id == testHabit2.id);
    assert(testHabit.title == testHabit2.title);
    for (int i = 0; i < 7; i++) {
      if (weekday - 1 == i) {
        assert(testHabit2.doneDays[i] == true);
      } else {
        assert(testHabit.doneDays[i] == testHabit2.doneDays[i]);
      }
    }
  });

  test(
      'Habit.notDoneToday() factory generates habit which is marked not done for the current day of the week',
      () {
    // arrange
    final weekday = DateTime.now().weekday;
    final testHabit = Habit(title: "test title");
    // act
    final testHabit2 = Habit.notDoneToday(testHabit);
    // assert
    assert(testHabit.id == testHabit2.id);
    assert(testHabit.title == testHabit2.title);
    for (int i = 0; i < 7; i++) {
      if (weekday - 1 == i) {
        assert(testHabit2.doneDays[weekday - 1] == false);
      } else {
        assert(testHabit.doneDays[i] == testHabit2.doneDays[i]);
      }
    }
  });

  test("Habit.compareTo() sorts habits that are not done before done.", () {
    // arrange
    final doneHabit = Habit.doneToday(Habit(title: "test title 1"));
    final notDoneHabit = Habit.notDoneToday(Habit(title: "test title 2"));
    // act
    int compareDoneToNot = doneHabit.compareTo(notDoneHabit);
    // assert
    assert(compareDoneToNot > 0);
  });

  test(
      "Habit.compareTo() sorts tasks with the same done status alphabetically by title",
      () {
    // arrange
    final habitA = Habit(title: "aa");
    final habitB = Habit(title: "ab");
    // act
    int compareAToB = habitA.compareTo(habitB);
    // assert
    assert(compareAToB < 0);
  });

  test("Habit.isDoneToday returns true if completed today, false otherwise",
      () {
    // arrange
    final doneToday = Habit.doneToday(Habit(
      title: "done today",
      doneDays: [false, false, false, false, false, false, false],
    ));
    final notDoneToday = Habit.notDoneToday(Habit(
      title: "not done today",
      doneDays: [true, true, true, true, true, true, true],
    ));
    // act
    // assert
    assert(true == doneToday.isDoneToday);
    assert(false == notDoneToday.isDoneToday);
  });
}
