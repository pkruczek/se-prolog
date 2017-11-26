package pl.edu.agh.se.client;

import java.util.List;

public class Question {

    private final String content;
    private final List<Answer> answers;

    public Question(String content, List<Answer> answers) {
        this.content = content;
        this.answers = answers;
    }

    public String getContent() {
        return content;
    }

    public List<Answer> getAnswers() {
        return answers;
    }
}
