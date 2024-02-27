class QuestionModel{

  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctOption;
  bool answered;

  QuestionModel({
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctOption,
    required this.answered
  });
}