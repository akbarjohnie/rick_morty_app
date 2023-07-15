import 'package:flutter/material.dart';

typedef IntID = Function(int);

// это одна часть костыля для меньшего количества ошибок
// в том числе связанная с тем, что я
// пока что обрабатываю только page 1
var chIDs = List.generate(20, (index) => index + 1);

class CallBackFieldWidget extends StatefulWidget {
  const CallBackFieldWidget({
    super.key,
    this.id,
  });

  final IntID? id;

  @override
  State<CallBackFieldWidget> createState() => _CallBackFieldWidgetState();
}

class _CallBackFieldWidgetState extends State<CallBackFieldWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Введите число от 1 до 20',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            controller: _controller,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              var intId = int.tryParse(_controller.text);
              var callBack = widget.id;
              if (intId != 0 &&
                  callBack != null &&
                  _controller.text.splitMapJoin(' ').splitMapJoin('') != '' &&
                  intId != null) {
                callBack(intId);
              }
            },
            child: const Text(
              'Показать персонажа',
            ),
          ),
        ],
      ),
    );
  }
}
