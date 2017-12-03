package pl.edu.agh.se.run.gui;

import javax.swing.*;
import java.awt.*;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.CountDownLatch;


public class DescribeGui extends JFrame {

    private CountDownLatch countDownLatch = new CountDownLatch(1);

    public DescribeGui(String beer, String description) throws HeadlessException {
        super("BeerAdvisor");

        setLayout(new GridLayout(3, 1));

        createBeerLabel(beer);
        createDescriptionArea(description);
        createOkButton();

        pack();
    }

    private void createDescriptionArea(String description) {
        JTextArea descriptionArea = new JTextArea(description);
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

    public static void describe(String beer, String description) {
        DescribeGui describeGui = new DescribeGui(beer, description);
        describeGui.setVisible(true);
        try {
            describeGui.countDownLatch.await();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) throws InterruptedException {
        String[] answers = {"one", "two"};

        describe("Beer1", "Good beer");
        describe("Beer2", "Good beer");
        describe("Beer3", "Good beer");

    }
}