import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_auth_crudd10/pages/folder_page.dart';
import 'package:user_auth_crudd10/services/providers/storage_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images = [
    'assets/grid/a.png',
    'assets/grid/b.png',
    'assets/grid/c.png',
    'assets/grid/d.png',
    'assets/grid/e.png',
    'assets/grid/f.png',
    'assets/grid/g.png',
    'assets/grid/h.png',
    'assets/grid/i.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home'),
      //   automaticallyImplyLeading: false,
      // ),
      body: FutureBuilder(
        future: Provider.of<StorageProvider>(context, listen: false)
            .fetchItems('files/'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Consumer<StorageProvider>(
            builder: (context, storageProvider, child) {
              return Column(
                children: [
                  // header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Container(
                      height: 200,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 73, 111, 235),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(22),
                          top: Radius.circular(22),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 32, 0, 0),
                            child: Text(
                              "Hello!",
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Image.asset('assets/images/cont1.png'),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Image.asset('assets/images/cont2.png'),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Image.asset('assets/images/cont3.png'),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(22),
                              ),
                              child: Image.asset(
                                'assets/images/home_3d.png',
                                scale: 1.3,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            right: 293,
                            child: Image.asset('assets/images/block.png'),
                          ),
                          Positioned(
                            bottom: 1,
                            left: 330,
                            child: Image.asset('assets/images/box1.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              20,
                              120,
                              20,
                              0,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                // filled: true,
                                // fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                hintText: "Search..",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //grid view
                  Expanded(
                    child: GridView.builder(
                      itemCount: storageProvider.items.length,
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 3.8,
                      ),
                      itemBuilder: (context, index) {
                        final item = storageProvider.items[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FolderPage(path: item.path!),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromARGB(40, 158, 158, 158),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      images[index],
                                      scale: 0.7,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 0,
                                    ),
                                    child: Text(
                                      item.name.toUpperCase(),
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

//  ListView.builder(
//                       padding: EdgeInsets.zero,
//                       itemCount: storageProvider.items.length,
//                       itemBuilder: (context, index) {
//                         final item = storageProvider.items[index];..
//                         return ListTile(
//                           leading: Icon(item.isFolder
//                               ? Icons.folder
//                               : Icons.picture_as_pdf),
//                           title: Text(item.name),..
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     FolderPage(path: item.path!),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
