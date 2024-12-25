import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class CalendarPropertiesList extends ConsumerStatefulWidget {
 const CalendarPropertiesList({super.key});

  @override
  ConsumerState<CalendarPropertiesList> createState() => _CalendarPropertiesListState();
}

class _CalendarPropertiesListState extends ConsumerState<CalendarPropertiesList> {
 DateTime selectedDate = DateTime.now();
  DateTime? fromDate;
  DateTime? toDate;
  DateTime? hoveredDate;
  String selectedOption = 'From';

  void _changeMonth(int delta) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + delta);
    });
  }

  List<DateTime> _generateDaysInMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);

    final days = <DateTime>[];
    for (int i = 0; i < firstDay.weekday - 1; i++) {
      days.add(firstDay.subtract(Duration(days: firstDay.weekday - i - 1)));
    }
    for (int i = 0; i < lastDay.day; i++) {
      days.add(firstDay.add(Duration(days: i)));
    }
    for (int i = 1; days.length % 7 != 0; i++) {
      days.add(lastDay.add(Duration(days: i)));
    }
    return days;
  }

  Future<void> _selectDate(BuildContext context, bool isFrom) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final days = _generateDaysInMonth(selectedDate);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Calendar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Swagat Grand Banquet Hall',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.0),
                    Text('Bachupally, Hyderabad'),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_left),
                    onPressed: () => _changeMonth(-1),
                  ),
                  Text(
                    '${DateFormat.MMMM().format(selectedDate)} ${selectedDate.year}',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right),
                    onPressed: () => _changeMonth(1),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Radio<String>(
                        value: 'From',
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      Text('From', style: TextStyle(fontSize: 16.0)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, true),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.purple, width: 2.0)),
                      ),
                      child: Text(
                        fromDate == null
                            ? 'DD/MM/YYYY'
                            : DateFormat('dd/MM/yyyy').format(fromDate!),
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Radio<String>(
                        value: 'To',
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      Text('To', style: TextStyle(fontSize: 16.0)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, false),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.purple, width: 2.0)),
                      ),
                      child: Text(
                        toDate == null
                            ? 'DD/MM/YYYY'
                            : DateFormat('dd/MM/yyyy').format(toDate!),
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var day in ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'])
                    Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: days.length,
                      itemBuilder: (context, index) {
                        final day = days[index];
                        final isCurrentMonth = day.month == selectedDate.month;
                        final isHovered = hoveredDate != null && hoveredDate == day;
                        final isSelected = (fromDate != null && toDate != null && day.isAfter(fromDate!) && day.isBefore(toDate!));

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedOption == 'From') {
                                fromDate = day;
                              } else {
                                toDate = day;
                              }
                            });
                          },
                          // onHover: (_) {
                          //   setState(() {
                          //     hoveredDate = day;
                          //   });
                          // },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.purple
                                  : isHovered
                                      ? Colors.purple.withOpacity(0.3)
                                      : isCurrentMonth
                                          ? Colors.white
                                          : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              '${day.day}',
                              style: TextStyle(
                                color: isCurrentMonth ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(width: 16, height: 16, color: Colors.grey),
                            SizedBox(height: 4),
                            Text('Blocked'),
                          ],
                        ),
                        Column(
                          children: [
                            Container(width: 16, height: 16, color: Colors.green),
                            SizedBox(height: 4),
                            Text('Available'),
                          ],
                        ),
                        Column(
                          children: [
                            Container(width: 16, height: 16, color: Colors.red),
                            SizedBox(height: 4),
                            Text('Full'),
                          ],
                        ),
                        Column(
                          children: [
                            Container(width: 16, height: 16, color: Colors.purple),
                            SizedBox(height: 4),
                            Text('Selected'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Block selected date range',
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Show events',
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
