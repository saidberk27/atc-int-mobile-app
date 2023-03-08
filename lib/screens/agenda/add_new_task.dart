import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewTask extends StatefulWidget {
  AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  @override
  void initState() {
    super.initState();
    _dateController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Görev Ekle"),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                textFormField(),
                const SizedBox(height: 40),
                textArea(),
                const SizedBox(height: 40),
                datePicker(context),
                const SizedBox(height: 40),
                elevatedButton(),
              ]))),
    );
  }

  TextFormField textFormField() {
    return TextFormField(
        controller: _taskNameController,
        decoration: InputDecoration(
          hintText: 'Görev Adı',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
          prefixIcon: const Icon(Icons.abc),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Görev Adı Boş Olamaz';
          }
          return null;
        });
  }

  TextFormField textArea() {
    return TextFormField(
        controller: _taskDescriptionController,
        textAlign: TextAlign.center,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Görev Açıklaması',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
          prefixIcon: const Icon(Icons.abc),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Görev Açıklaması Boş Olamaz';
          }
          return null;
        });
  }

  TextFormField datePicker(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat("dd.MM.yyyy").format(pickedDate);

          setState(() {
            _dateController.text = formattedDate.toString();
          });
        } else {
          print("Not selected");
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Tarih Seçmediniz!';
        }
        return null;
      },
    );
  }

  ElevatedButton elevatedButton() {
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            const snackBar = SnackBar(content: Text('Processing Data'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: const SizedBox(
          height: 100,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Yeni Görev Ekle",
            ),
          ),
        ));
  }
}
