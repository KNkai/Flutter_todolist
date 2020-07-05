import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todolist_sqflite/src/Models/category_model.dart';
import 'package:todolist_sqflite/src/Models/todo_model.dart';
import 'package:todolist_sqflite/src/Services/todo_services.dart';
import 'package:todolist_sqflite/src/components/widgets/appbar.dart';

class TodoDetail extends StatefulWidget {
  final Category category;

  const TodoDetail({Key key, this.category}) : super(key: key);
  @override
  _TodoDetailState createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  var _todo = Todo();

  var _detailEditingController = TextEditingController();
  String _dateCreateEditingController;
  String _dateFakeEditingController;
  String _timeFakeEditingController;
  String _dateRealEditingController;
  String _timeRealEditingController;
  int _isDone;
  String dateTimeNow;
  String _checkDateTimeInput = "";

  _getDateTimeNow() {
    dateTimeNow = TimeOfDay.now().hour.toString() +
        ":" +
        TimeOfDay.now().minute.toString() +
        "  " +
        DateTime.now().day.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().year.toString();
  }

  _formatDatetime(String datetime, int dt) {
    var date;
    if (dt == 0) {
      date = datetime.substring(0, 10).split('-');
      return date[2] + "-" + date[1] + "-" + date[0];
    } else {
      date = datetime.substring(11).split(':');
      return date[0] + ":" + date[1];
    }
  }

  _onRefreshPage() {
    model.clear();
    _getAllTodoByIdCate(widget.category.id);
  }

  var _todoService = TodoService();

  List<Todo> model = List<Todo>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllTodoByIdCate(widget.category.id);
  }

  _getAllTodoByIdCate(int id) async {
    var listTodo = await _todoService.getAllTodo(id);
    listTodo.forEach((todos) {
      setState(() {
        var to = Todo();
        to.id = todos['id'].hashCode;
        to.idCate = todos['idcate'];
        to.detail = todos['detail'];
        to.dateCreate = todos['date_create'];
        to.dateFakeDate = todos['date_fake_finish'];
        to.dateRealDate = todos['date_real_finish'];
        to.isDone = todos['isdone'];

        model.add(to);
      });
    });
  }

  // _insertTodo(Todo todo)async{
  //   var todo = await _todoService.saveTodo(todo);
  // }

  _showPopupTodo(BuildContext context, Todo todo) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          if (todo != null) {}
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Create new todo!"),
                content: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text("Title: " + widget.category.title),
                      TextField(
                        controller: _detailEditingController,
                        decoration: InputDecoration(
                          labelText: "Detail",
                          hintText: "Write detail!",
                        ),
                      ),
                      ListTile(
                        leading: Text("Date Create"),
                        title: Text(dateTimeNow),
                      ),
                      ListTile(
                          leading: Text("Time Finish: "),
                          title: Column(
                            children: <Widget>[
                              FlatButton(
                                child: Text(_dateFakeEditingController == null
                                    ? "date"
                                    : _dateFakeEditingController),
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(1000, 1, 1),
                                      maxTime: DateTime(9999, 12, 20),
                                      theme: DatePickerTheme(
                                        headerColor: Colors.amber,
                                        backgroundColor: Colors.lightBlue,
                                        itemStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        doneStyle: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ), onConfirm: (date) {
                                    setState(() {
                                      _dateFakeEditingController =
                                          _formatDatetime(date.toString(), 0);
                                      print(
                                          _formatDatetime(date.toString(), 0));
                                    });
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.vi);
                                },
                              ),
                              FlatButton(
                                child: Text(_timeFakeEditingController == null
                                    ? "time"
                                    : _timeFakeEditingController),
                                onPressed: () {
                                  DatePicker.showTimePicker(context,
                                      showTitleActions: true,
                                      theme: DatePickerTheme(
                                        headerColor: Colors.amber,
                                        backgroundColor: Colors.lightBlue,
                                        itemStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        doneStyle: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ), onConfirm: (time) {
                                    setState(() {
                                      print(time);
                                      _timeFakeEditingController =
                                          _formatDatetime(time.toString(), 1);
                                    });
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.vi);
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Container(
                    child: Text(
                      ((_timeFakeEditingController == null &&
                              _dateFakeEditingController == null))
                          ? ((_timeFakeEditingController == "time" &&
                                  _dateFakeEditingController == "date")
                              ? _checkDateTimeInput
                              : "")
                          : _checkDateTimeInput,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 50, bottom: 30),
                    child: IconButton(
                      icon: Icon(
                        Icons.check_circle,
                        size: 50,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        print(1);
                        print(_timeFakeEditingController);
                        print(2);
                        print(_dateFakeEditingController);
                        print(3);
                        if (_timeFakeEditingController != null &&
                            _dateFakeEditingController != null) {
                          if (_timeFakeEditingController != "time" &&
                              _dateFakeEditingController != "date") {
                            setState(() async {
                              _todo.idCate = widget.category.id;
                              _todo.dateCreate = dateTimeNow;
                              _todo.dateFakeDate = _dateFakeEditingController +
                                  "/" +
                                  _timeFakeEditingController;
                              _todo.detail = _detailEditingController.text;

                              _todo.dateRealDate = "*";
                              _todo.isDone = 0;
                              _todoService.saveTodo(_todo);
                              Navigator.pop(context);
                              _onRefreshPage();
                              _detailEditingController.clear();
                              _timeFakeEditingController = "time";
                              _dateFakeEditingController = "date";
                            });
                          } else {
                            print(5);
                            setState(() {
                              _checkDateTimeInput =
                                  "Input date and time error!";
                            });
                            print(_checkDateTimeInput);
                          }
                        } else {
                          print(4);
                          setState(() {
                            _checkDateTimeInput = "Input date and time error!";
                          });
                          print(_checkDateTimeInput);
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarCustom(
          openDrawer: () {
            Navigator.pop(context);
          },
          title: "Todo List",
        ),
      ),
      body: ListView(
          scrollDirection: Axis.vertical,
          children: List.generate(model.length, (index) {
            return Column(
              children: <Widget>[
                Container(
                  height: 200,
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading:
                              Text("date create: " + model[index].dateCreate),
                          trailing: model[index].isDone == 0
                              ? Icon(Icons.not_interested, color: Colors.red)
                              : Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                        ),

                        // Text("abcd")
                        ListTile(
                          leading: Text("date finish: " +
                              model[index].dateFakeDate.split('/')[1] +
                              " " +
                              model[index].dateFakeDate.split('/')[0]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              if (model[index].isDone == 0) {
                                return showDialog(
                                    context: context,
                                    builder: (param) {
                                      return AlertDialog(
                                        content: Container(
                                          width: 300,
                                          height: 100,
                                          child: Center(
                                            child: Text(
                                                "job isn't finish!\nCannot delete it! \njust do it!"),
                                          ),
                                        ),
                                      );
                                    });
                              }
                              setState(() {
                                _todoService.deleteTodoById(model[index].id);
                                _onRefreshPage();
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            model[index].detail,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _getDateTimeNow();
            _showPopupTodo(context, null);
          });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
