import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_auth_crudd10/pages/others/PdfViewerPage.dart';
import 'package:user_auth_crudd10/services/providers/storage_provider.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

class FolderPage extends StatefulWidget {
  final String path;

  FolderPage({required this.path});

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Fetch items for the previous directory on back navigation
        final previousPath =
            widget.path.substring(0, widget.path.lastIndexOf('/'));
        await Provider.of<StorageProvider>(context, listen: false)
            .fetchItems(previousPath);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Study your favourite subject!'),
        ),
        body: FutureBuilder(
          future: Provider.of<StorageProvider>(context, listen: false)
              .fetchItems(widget.path),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Consumer<StorageProvider>(
              builder: (context, storageProvider, child) {
                return ListView.builder(
                  itemCount: storageProvider.items.length,
                  itemBuilder: (context, index) {
                    final item = storageProvider.items[index];
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
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                          ),
                          onTap: () {
                            if (item.isFolder) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FolderPage(path: item.path!),
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
}
