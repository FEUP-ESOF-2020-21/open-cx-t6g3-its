class Poll {
  String title;
  String description;
  List<Question> questions;

  Poll(this.title, this.description, this.questions);

  //get functions
  String getTitle() {
    return this.title;
  }

  String getDescription() {
    return this.description;
  }

  List<Question> getQuestions() {
    return this.questions;
  }

  // set functions
  void addQuestions(Question question) {
    questions.add(question);
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setDescription(String description) {
    this.description = description;
  }
}

class Question {
  String title;

  List<Option> options;

  Question({this.title, this.options});

  String getTitle() {
    return this.title;
  }

  List<Option> getOptions() {
    return this.options;
  }
}

class Option {
  String text;

  Option({this.text});

  String getOption() {
    return text;
  }

  void setOption(String option) {
    this.text = option;
  }
}
