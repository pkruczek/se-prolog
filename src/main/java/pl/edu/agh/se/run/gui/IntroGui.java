package pl.edu.agh.se.run.gui;

import javax.swing.*;
import java.awt.*;
import java.util.concurrent.CountDownLatch;


public class IntroGui extends JFrame {

    private CountDownLatch countDownLatch = new CountDownLatch(1);

    public IntroGui() throws HeadlessException {
        super("BeerAdvisor");

        setLayout(new GridLayout(2, 1));

        createIntroArea();
        createOkButton();

        pack();
    }

    private void createIntroArea() {
        JTextArea descriptionArea = new JTextArea("Which beer should I drink today?\nAnswer some questions and you will know!");
        descriptionArea.setEditable(false);
        add(descriptionArea);
    }

    private void createBeerLabel(String beer) {
        add(new JLabel(beer));
    }

    private void createOkButton() {
        JButton okBtn = new JButton("OK");
        okBtn.addActionListener(event -> {
            countDownLatch.countDown();
            dispose();
        });
        add(okBtn);
    }

    public static void intro() {
        IntroGui describeGui = new IntroGui();
        describeGui.setVisible(true);
        try {
            describeGui.countDownLatch.await();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) throws InterruptedException {
        intro();
    }
}