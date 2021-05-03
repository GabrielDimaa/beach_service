import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() => runApp(ModularApp(module: AppModule(), child: AppWidget()));

// SQFLiteHelper sql = SQFLiteHelper();
// sql.getDb();
// final path = await sql.getPath();
// final origFile = File(path);
// var destFileName = 'beach_service_db.db';
// final tempDir = await getTemporaryDirectory();
// final tempFile = File('${tempDir.path}/$destFileName');
// tempFile.writeAsBytesSync(origFile.readAsBytesSync());
// ShareExtend.share(tempFile.path, "file");