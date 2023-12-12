import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AppImportFile extends StatefulWidget {
  final String? url;
  final Function(FilePickerResult?) setFilePickerResult;

  const AppImportFile({
    Key? key,
    this.url,
    required this.setFilePickerResult,
  }) : super(key: key);

  @override
  State<AppImportFile> createState() => _AppImportFileState();
}

class _AppImportFileState extends State<AppImportFile> {
  // final FilePickerResult _picker = FilePickerResult();
  FilePickerResult? _filePickerResult;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: _filePickerResult != null
            ? Row(
                children: [
                  const Icon(Icons.file_present),
                  Flexible(
                    child: Text(
                      'Nome: ${_filePickerResult?.files.single.name}',
                      overflow: TextOverflow.ellipsis,
                      // softWrap: true,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.setFilePickerResult(null);
                          _filePickerResult = null;
                        });
                      },
                      icon: const Icon(Icons.delete))
                ],
              )
            : Row(
                children: [
                  const Icon(Icons.file_present),
                  Flexible(
                    child: Text(
                      widget.url ?? 'Sem arquivo',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
        onTap: () async {
          final FilePickerResult? pickedFile =
              await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['mp3'],
            withData: true,
          );
          if (pickedFile != null) {
            widget.setFilePickerResult(pickedFile);
            setState(() {
              _filePickerResult = pickedFile;
            });
          }
        },
      ),
    );
  }
}
