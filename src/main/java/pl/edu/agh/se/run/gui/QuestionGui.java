package pl.edu.agh.se.run.gui;

import pl.edu.agh.se.run.utils.PropertiesReader;

import javax.swing.*;
import java.awt.*;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.CountDownLatch;


public class QuestionGui extends JFrame {

    private static final Properties questionProperties = PropertiesReader.readProperties("questions.properties");
    private static final Properties answersProperties = PropertiesReader.readProperties("answers.properties");
    private List<String> answers;
    private ButtonGroup buttonGroup = new ButtonGroup();
    private CountDownLatch countDownLatch = new CountDownLatch(1);
    private int answered = -1;

    public QuestionGui(String question, String[] answers) throws HeadlessException {
        super("BeerAdvisor");
        this.answers = Arrays.asList(answers);

        setLocationRelativeTo(null);
        setMinimumSize(Settings.DEFAULT_MIN_DIMENSIONS);
        getRootPane().setBorder(Settings.DEFAULT_BORDER);
        setLayout(new GridLayout(answers.length + 2, 1, 2, 2));

        createQuestionLabel(question);
        createRadios();
        createOkButton();

        pack();
    }

    public int getAnswered() throws InterruptedException {
        countDownLatch.await();
        return answered;
    }

    private void createQuestionLabel(String question) {
        add(new JLabel(questionProperties.getProperty(question)));
    }

    private void createRadios() {
        for (String answer : answers) {
            JRadioButton radioButton = new JRadioButton(answersProperties.getProperty(answer));
            radioButton.setActionCommand(answer);
            add(radioButton);
            buttonGroup.add(radioButton);
        }
    }

    private void createOkButton() {
        JButton okBtn = new JButton("OK");
        okBtn.addActionListener(event -> {
            ButtonModel selection = buttonGroup.getSelection();
            if (selection != null) {
                String answer = selection.getActionCommand();
                answered = answers.indexOf(answer);
                System.out.println(answer + " at index " + answered);
                countDownLatch.countDown();
                dispose();
            }
        });
        add(okBtn);
    }

    public static int askQuestion(String question, String[] answers) {
        QuestionGui questionGui = new QuestionGui(question, answers);
        questionGui.setVisible(true);
        try {
            return questionGui.getAnswered();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) throws InterruptedException {
        String[] answers = {"one", "two"};

        System.out.println(askQuestion("Question1", answers));
        System.out.println(askQuestion("Question2", answers));
        System.out.println(askQuestion("Question3", answers));
        System.out.println(askQuestion("Question4", answers));

    }
}