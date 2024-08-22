import 'package:flutter/material.dart';

class aboutUs extends StatelessWidget {
  const aboutUs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          showBottomSheet(
            enableDrag: true,
            sheetAnimationStyle: AnimationStyle(),
            context: context,
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 300,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: Text(
                          'PrepPdf',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          'PrepPdf offers free access to structured previous year question papers (PYQs) and solutions. Navigate seamlessly through a variety of subjects, supported by Firebase for reliable storage and real-time updates. Empowering students with essential exam resources and community insights, PrepPdf is your trusted companion for academic success.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 64, 64, 64),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Developed By :',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Atharva Girme',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          height: 60,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.supervised_user_circle_rounded,
                  size: 30,
                ),
                Text(
                  "About Us",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 60),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
