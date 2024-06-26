import 'dart:io';

const _packageAppName = 'weather_app';
const _directoryLibDomain = 'lib/domain/';
const _blocSuffix = '_bloc';

const _extensionDart = '.dart';
const _filePathEventsStatesTemplate = 'events_states.template';
const _filePathBlocTemplate = 'bloc.template';
const _fileNameEvensStates = 'events_states$_extensionDart';

const _substitutionTemplateFeatureName = r'$FILE_NAME$';
const _substitutionTemplateFeatureNameVar = r'$FILE_NAME_VAR$';
const _substitutionTemplateImportEventsStates = r'$IMPORT_EVENTS_STATES$';

Future<void> main([final List<String>? args]) async {
  _checkArgs(args);

  final blocNameUndescore = args!.first;
  final nameFeatureUndescore = blocNameUndescore.replaceFirst(_blocSuffix, '');
  final nameFeatureCamelCase = _fromUndescoreToCamelCase(nameFeatureUndescore);

  final dirDomainFeature = await _createDomainFeatureDir(
    '$_directoryLibDomain$nameFeatureUndescore',
  );

  await _createFileByTemplate(
    filePathTemplate: _filePathEventsStatesTemplate,
    filePathOutput: '${dirDomainFeature.path}/$_fileNameEvensStates',
    substitutionData: {
      _substitutionTemplateFeatureName: nameFeatureCamelCase,
    },
  );

  final substitutionImportEventStates =
      '$_packageAppName${_directoryLibDomain.replaceFirst(
    'lib',
    '',
  )}/$nameFeatureUndescore/$_fileNameEvensStates';

  final substitutionVarBloc =
      '${nameFeatureCamelCase.substring(0, 1).toLowerCase()}'
      '${nameFeatureCamelCase.substring(1)}';

  await _createFileByTemplate(
    filePathTemplate: _filePathBlocTemplate,
    filePathOutput: '${dirDomainFeature.path}/$blocNameUndescore$_extensionDart',
    substitutionData:  {
      _substitutionTemplateFeatureName: nameFeatureCamelCase,
      _substitutionTemplateImportEventsStates: substitutionImportEventStates,
      _substitutionTemplateFeatureNameVar: substitutionVarBloc,
    },
  );
}

Future<void> _createFileByTemplate({
  required final String filePathTemplate,
  required final String filePathOutput,
  required final Map<String, String> substitutionData,
}) async {
  final fileEventsStatesTemplate = File(filePathTemplate);
  if (!fileEventsStatesTemplate.existsSync()) {
    throw Exception('$filePathTemplate not founded!');
  }

  final templateDataEventsStates = fileEventsStatesTemplate.readAsLinesSync();

  if (templateDataEventsStates.isEmpty) {
    throw Exception('$filePathTemplate are empty!');
  }

  final enrichedDataEventsStates = _enrichTemplate(
    templateDataEventsStates,
    substitutionData,
  );

  final fileEnrichedEventsStates = File(filePathOutput)..createSync();
  await fileEnrichedEventsStates.writeAsString(enrichedDataEventsStates);
}

String _enrichTemplate(
  final List<String> templateLines,
  final Map<String, String> substitutionData,
) {
  final sb = StringBuffer();
  for (final lineTemplate in templateLines) {
    var lineCandidate = lineTemplate;

    for (final patternValue in substitutionData.entries) {
      lineCandidate = lineCandidate.replaceAll(
        patternValue.key,
        patternValue.value,
      );
    }

    sb.writeln(lineCandidate);
  }
  return sb.toString();
}

void _checkArgs([final List<String>? args]) {
  if (args == null || args.isEmpty) {
    throw Exception('Not valid arguments.'
        ' Use commands "dart bloc_creator.dart name_bloc".');
  }
  if (args.length != 1) {
    throw Exception('Not valid arguments.'
        ' There are demand only one argument.');
  }

  if (!args.first.contains(_blocSuffix)) {
    throw Exception('Not valid arguments.'
        ' Name must contain "bloc" suffix, like auth_bloc.');
  }
}

Future<Directory> _createDomainFeatureDir(final String path) async {
  final dirDomainFeature = Directory(path);

  if (!dirDomainFeature.existsSync()) {
    await dirDomainFeature.create(recursive: true);
  }
  return dirDomainFeature;
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
