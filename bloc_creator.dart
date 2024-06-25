import 'dart:io';

const _extensionDart = '.dart';
const _filePathEventsStatesTemplate = 'events_states.template';
const _filePathBlocTemplate = 'bloc.template';
const _fileNameEvensStates = 'events_states$_extensionDart';

const _packageApp = 'weather_app';
const _directoryDomain = 'lib/domain/';

const _substitutionTemplateFeatureName = r'$FILE_NAME$';
const _substitutionTemplateFeatureNameVar = r'$FILE_NAME_VAR$';
const _substitutionTemplateImportEventsStates = r'$IMPORT_EVENTS_STATES$';

Future<void> main([final List<String>? args]) async {
  if (args == null || args.isEmpty) {
    throw Exception('Not valid arguments.'
        ' Use commands "dart bloc_creator.dart name_bloc".');
  }
  if (args.length != 1) {
    throw Exception('Not valid arguments.'
        ' There are demand only one argument.');
  }

  final blocNameUndescore = args.first;
  final nameFeatureUndescore = blocNameUndescore.replaceFirst('_bloc', '');
  final dirBloc = Directory('$_directoryDomain$nameFeatureUndescore');

  if (!dirBloc.existsSync()) {
    dirBloc.createSync(recursive: true);
  }

  final fileEventsStatesTemplate = File(_filePathEventsStatesTemplate);
  if (!fileEventsStatesTemplate.existsSync()) {
    throw Exception('$_filePathEventsStatesTemplate not founded!');
  }

  final templateDataEventsStates = fileEventsStatesTemplate.readAsLinesSync();

  if (templateDataEventsStates.isEmpty) {
    throw Exception('$_filePathEventsStatesTemplate are empty!');
  }

  final nameFeatureCamelCase = _fromUndescoreToCamelCase(nameFeatureUndescore);

  final enrichedDataEventsStates = templateDataEventsStates
      .map(
        (final line) => line.replaceAll(
          _substitutionTemplateFeatureName,
          nameFeatureCamelCase,
        ),
      )
      .join('\n');

  final filePathEnrichedEventsStates = '${dirBloc.path}/$_fileNameEvensStates';
  final fileEnrichedEventsStates = File(filePathEnrichedEventsStates)
    ..createSync();
  await fileEnrichedEventsStates.writeAsString(enrichedDataEventsStates);

  final fileBlocTemplate = File(_filePathBlocTemplate);

  if (!fileBlocTemplate.existsSync()) {
    throw Exception('$_filePathBlocTemplate not founded!');
  }

  final templateDataBloc = fileBlocTemplate.readAsLinesSync();
  if (templateDataBloc.isEmpty) {
    throw Exception('$_filePathBlocTemplate are empty!');
  }

  final substitutionImportEventStates =
      '$_packageApp${filePathEnrichedEventsStates.replaceFirst(
    'lib',
    '',
  )}';

  final substitutionVarBloc =
      '${nameFeatureCamelCase.substring(0, 1).toLowerCase()}'
      '${nameFeatureCamelCase.substring(1)}';

  final enrichedDataBloc = templateDataBloc
      .map<String>(
        (final line) => line.replaceAll(
          _substitutionTemplateFeatureName,
          nameFeatureCamelCase,
        ),
      )
      .map<String>(
        (final line) => line.replaceFirst(
          _substitutionTemplateImportEventsStates,
          substitutionImportEventStates,
        ),
      )
      .map<String>(
        (final line) => line.replaceFirst(
          _substitutionTemplateFeatureNameVar,
          substitutionVarBloc,
        ),
      )
      .join('\n');

  final fileEnrichedBloc =
      File('${dirBloc.path}/$blocNameUndescore$_extensionDart')..createSync();
  await fileEnrichedBloc.writeAsString(enrichedDataBloc);

  //final fileBloc = File('${dirBloc.path}/$blocNameUndescore$_extension').createSync();
}

String _fromUndescoreToCamelCase(final String undescore) {
  if (!undescore.contains('_')) {
    return '${undescore.substring(0, 1).toUpperCase()}${undescore.substring(1)}';
  }

  final words = undescore.split('_');
  final sb = StringBuffer();

  for (final word in words) {
    final firstSymbol = word.substring(0, 1);
    sb.write('${firstSymbol.toUpperCase()}${word.substring(1)}');
  }
  return sb.toString();
}
