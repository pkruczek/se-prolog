package pl.edu.agh.se.run.gui;

import javax.swing.*;
import java.awt.*;
import java.util.Set;
import java.util.concurrent.CountDownLatch;


public class IntroGui extends JFrame {

    private CountDownLatch countDownLatch = new CountDownLatch(1);

    public IntroGui() throws HeadlessException {
        super("BeerAdvisor");

        setLocationRelativeTo(null);
        setMinimumSize(Settings.DEFAULT_MIN_DIMENSIONS);
        getRootPane().setBorder(Settings.DEFAULT_BORDER);
        getContentPane().setLayout(new BoxLayout(getContentPane(), BoxLayout.PAGE_AXIS));

        createIntroArea();
        createOkButton();

        pack();
    }

    private void createIntroArea() {
        JTextArea descriptionArea = new JTextArea("Which beer should I drink today?\nAnswer some questions and you will know!");
        descriptionArea.setEditable(false);
        add(descriptionArea);
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