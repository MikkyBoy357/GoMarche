import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        content: Container(
          height: MediaQuery.of(context).size.height / 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showLoadingDialog(BuildContext context) {
  showDialog(context) {
    return LoadingDialog();
  }
}

class ConfirmDialog extends StatelessWidget {
  final String? title;
  final String? body;
  final VoidCallback? onYes;

  const ConfirmDialog({
    super.key,
    this.title = "Title",
    this.body = "Body content",
    this.onYes,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      content: Text(body!),
      actions: [
        ElevatedButton(
          child: Text("NO"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: Text("YES"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: onYes,
        ),
      ],
    );
  }
}
