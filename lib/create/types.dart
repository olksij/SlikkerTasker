class CreateType {
  final String backPath;
  final List<CreatePageProps> props;

  CreateType({
    required this.backPath,
    required this.props,
  });
}

class CreatePageProps {
  final String title;
  final String description;
  final String value;
  final Function input;

  CreatePageProps({
    required this.title,
    required this.description,
    required this.value,
    required this.input,
  });
}
