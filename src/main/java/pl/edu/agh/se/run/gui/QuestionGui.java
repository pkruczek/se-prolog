package pl.edu.agh.se.run.gui;

import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.RadioButton;
import javafx.scene.control.Toggle;
import javafx.scene.control.ToggleGroup;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.text.Text;
import javafx.stage.Stage;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;


public class QuestionGui extends Application {

    private static final int QUESTION_INDEX = 0;
    private static final String ANSWER_ID_KEY = "AnswerId";

    private static final AtomicInteger chosenAnswer = new AtomicInteger(-1);

    private final AtomicInteger gridRowCounter = new AtomicInteger(0);

    @Override
    public void start(Stage primaryStage) {
        GridPane grid = new GridPane();
        grid.setAlignment(Pos.CENTER);
        grid.setHgap(10);
        grid.setVgap(10);
        grid.setPadding(new Insets(25, 25, 25, 25));

        Text question = new Text(question());
        grid.addRow(gridRowCounter.getAndIncrement(), question);

        ToggleGroup group = new ToggleGroup();
        for (int answerId = 0; answerId < answers().size(); answerId++) {
            String answer = answers().get(answerId);
            RadioButton radioButton = new RadioButton(answer);
            radioButton.getProperties().put(ANSWER_ID_KEY, answerId);
            radioButton.setToggleGroup(group);
            grid.addRow(gridRowCounter.getAndIncrement(), radioButton);
        }


        Button okBtn = new Button("OK");
        okBtn.setOnAction(event -> {
            Toggle selectedToggle = group.getSelectedToggle();
            if (selectedToggle != null) {
                Integer answerId = (Integer) selectedToggle.getProperties().get(ANSWER_ID_KEY);
                chosenAnswer.set(answerId);
                primaryStage.close();
            }
        });

        HBox hbBtn = new HBox(10);
        hbBtn.setAlignment(Pos.BOTTOM_RIGHT);
        hbBtn.getChildren().add(okBtn);
        grid.addRow(gridRowCounter.getAndIncrement(), hbBtn);

        Scene scene = new Scene(grid);
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    private String question() {
        return getParameters().getRaw().get(QUESTION_INDEX);
    }

    private List<String> answers() {
        List<String> params = getParameters().getRaw();
        return params.subList(QUESTION_INDEX + 1, params.size());
    }

    public static void main(String[] args) {
        askQuestion("What is the question", new String[]{"First answer", "second answer"});
    }

    public static int askQuestion(String question, String[] answers) {
        List<String> args = new ArrayList<>();
        args.add(question);
        args.addAll(Arrays.asList(answers));
        launch(args.toArray(new String[0]));
        return chosenAnswer.get();
    }
}