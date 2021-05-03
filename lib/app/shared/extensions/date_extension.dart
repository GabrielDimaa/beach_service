import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension DatetimeExtension on DateTime {
  String get formatedWithHour {
    initializeDateFormatting('pt_BR', null);

    return DateFormat.yMd('pt_BR').add_Hm().format(this);
  }

  String get formated {
    initializeDateFormatting('pt_BR', null);

    return DateFormat.yMd('pt_BR').format(this);
  }

  String get formatedSql {
    return DateFormat("yyyy-MM-dd").format(this).replaceAll('-', '/');
  }
}