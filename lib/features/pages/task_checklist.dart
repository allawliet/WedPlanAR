import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../wedding_checklist/read_data/wedChecklist.dart';

class TaskChecklistScreen extends StatefulWidget {
  const TaskChecklistScreen({Key? key});

  @override
  State<TaskChecklistScreen> createState() => _TaskChecklistScreenState();
}

class _TaskChecklistScreenState extends State<TaskChecklistScreen> {
  String inputNewItems = "";
  final TextEditingController _textFieldController = TextEditingController();
  List<String> listId = [];
  List<WedChecklist> listItems = [];
  List<bool> checkboxValue = [];

  getChecklist() async {
    var data = await FirebaseFirestore.instance.collection('wed_checklist').get();
    mapData(data);
  }

  mapData(QuerySnapshot<Map<String, dynamic>> data) {
    var _listdata = data.docs.map((item) => WedChecklist(
        id: item.id,
        title: item['title'],
        isChecked:item['isChecked'],
    ),
    ).toList();

    _listdata.forEach((element) {
      checkboxValue.add(element.isChecked);
    });

    setState(() {
      listItems = _listdata;
    });
  }

  Future addNewChecklist(id,title,isChecked) async {
    final newId = id + 1;
    await FirebaseFirestore.instance.collection('wed_checklist').add({
      'id': newId.toString(),
      'title': title,
      'isChecked': isChecked,
    });
  }

  @override
  void initState() {
    getChecklist();
    FirebaseFirestore.instance.collection('wed_checklist').snapshots().listen((data) {
      mapData(data);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Checklist"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Checklist',
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Add New Checklist'),
                content: TextField(
                  onChanged: (value) {
                    setState(() {
                      inputNewItems = value;
                    });
                  },
                  controller: _textFieldController,
                  decoration: const InputDecoration(
                      hintText: "Describe your checklist"),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      // listItems.add(inputNewItems);
                      addNewChecklist(listItems.length,inputNewItems,false);

                      Navigator.pop(context, 'OK');
                    }),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getChecklist(),
          builder: (context, snapshot) {
        return ListView.builder(
          // shrinkWrap: true,
          itemCount: listItems.length,
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                      onPressed: (c) {
                        deleteItem(listItems[index].id);
                      },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  spacing: 8,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: CheckboxListTile(
                  value: checkboxValue[index], //listItems[index].isChecked,
                  onChanged: (bool? value) {
                    print('apa ni 2' + checkboxValue[index].toString() + listItems[index].isChecked.toString());
                    setState(() {
                      listItems[index].isChecked = value!;
                      checkboxValue[index] = value!;
                    });
                    print('apa ni 2' + value.toString() + listItems[index].isChecked.toString());
                  },
                  title: Text(listItems[index].title),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: MaterialButton(
        onPressed: () {
          callToUpdate();
        },
        color: Colors.deepPurple,
        textColor: Colors.white,
        child: Text('Update'),
      ),
    );
  }

  void callToUpdate() {
    for(var i = 0; i < listItems.length; i++) {
      listItems[i].isChecked = checkboxValue[i];
    }
    listItems.forEach((ele) {
      updateChecklist(ele.id,ele.title,ele.isChecked);
    });

  }

  Future<void> updateChecklist(id,title,isChecked) async {
    await FirebaseFirestore.instance.collection('wed_checklist').doc(id).update(
      {
        'id': id,
        'title': title,
        'isChecked': isChecked
      });
  }

  void deleteItem(id) async {
    await FirebaseFirestore.instance.collection('wed_checklist').doc(id).delete();
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}