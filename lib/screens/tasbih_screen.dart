import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int number = 0;
  int incrementLimit = 33;
  int total = 0;

  void incrementCounter() {
    setState(() {
      if (number >= incrementLimit) {
        number = 1;
      } else {
        number++;
      }
      total++;
      saveTotal();
    });
  }

  void reset() {
    setState(() {
      number = 0;
    });
  }

  void resetTotal() async {
    setState(() {
      total = 0;
      number = 0;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('Jami');
  }

  void saveTotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('jami', total);
  }

  @override
  void initState() {
    super.initState();
    loadTotal();
  }

  void loadTotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      total = prefs.getInt('jami') ?? 0;
    });
  }

  void changeTarget() {
    setState(() {
      incrementLimit = (incrementLimit == 33) ? 99 : 33;
      number = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "TASBIH SANOG'I",
              style: TextStyle(
                  letterSpacing: 1,
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              changeTarget();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber[700],
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: FittedBox(
                    child: Text(
                      '$incrementLimit',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const FittedBox(
                          child: Text(
                            "Umumiy Hisob",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 1),
                        FittedBox(
                          child: Text(
                            maxLines: 1,
                            total.toString(),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const FittedBox(
                                      child: Text(
                                        "Qayta o'rnatishni tasdiqlang",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    content: const Text(
                                      "Tasbehning umumiy hisobini qayta o'rnatmoqchimisiz?",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Bekor qilish",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          resetTotal();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Qayta o'rnatish",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: Colors.orange[600],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: FittedBox(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "Umumiy hisobni qayta o'rnatish",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      reset();
                    },
                    child: const Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: FittedBox(
                          child: Text(
                            "QAYTA O'RNATISH",
                            style: TextStyle(
                              letterSpacing: 2,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: width * 0.25,
            height: width * 0.25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.amber,
              border: Border.all(width: 5, color: Colors.green.shade800),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: FittedBox(
                  child: Text(
                    number.toString(),
                    style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: height * 0.07),
            child: Container(
              width: width * 0.45,
              height: width * 0.45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 5, color: Colors.green.shade800),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: () {
                      incrementCounter();
                    },
                    child: Container(
                      width: width * 0.45 * 0.91,
                      height: width * 0.45 * 0.91,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
