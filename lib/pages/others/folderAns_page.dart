import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_auth_crudd10/pages/others/PdfViewerPage.dart';
import 'package:user_auth_crudd10/services/providers/storage_ans_provider.dart';

class FolderAnsPage extends StatefulWidget {
  final String anspath;
  const FolderAnsPage({super.key, required this.anspath});

  @override
  State<FolderAnsPage> createState() => _FolderAnsPageState();
}

class _FolderAnsPageState extends State<FolderAnsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final previousPath =
            widget.anspath.substring(0, widget.anspath.lastIndexOf('/'));
        await Provider.of<StorageAnsProvider>(context, listen: false)
            .fetchAnsItems(previousPath);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Get All Correct Solutions"),
        ),
        body: FutureBuilder(
          future: Provider.of<StorageAnsProvider>(context, listen: false)
              .fetchAnsItems(widget.anspath),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<StorageAnsProvider>(
              builder: (context, StorageAnsProvider, child) {
                return ListView.builder(
                  itemCount: StorageAnsProvider.ansItem.length,
                  itemBuilder: (context, index) {
                    final item = StorageAnsProvider.ansItem[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Card(
                        child: ListTile(
                          leading: Icon(item.isFolder
                              ? Icons.folder
                              : Icons.picture_as_pdf),
                          title: Text(
                            item.name.toUpperCase(),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                          ),
                          onTap: () {
                            if (item.isFolder) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FolderAnsPage(anspath: item.path!),
                                ),
                              );
                            } else {
                              _openPdf(context, item.path!);
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

void _openPdf(BuildContext context, String path) async {
  final pdfUrl = await FirebaseStorage.instance.ref(path).getDownloadURL();
  final document = await PDFDocument.fromURL(pdfUrl);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PdfViewerPage(
        document: document,
      ),
    ),
  );
}
