package pl.edu.agh.se.run.gui;

import pl.edu.agh.se.run.utils.PropertiesReader;

import javax.swing.*;
import java.awt.*;
import java.util.Properties;
import java.util.concurrent.CountDownLatch;


public class DescribeGui extends JFrame {

    private static final Properties descriptionsProperties = PropertiesReader.readProperties("descriptions.properties");
    private static final Properties namesProperties = PropertiesReader.readProperties("names.properties");

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

    public static void describe(String beer) {
        DescribeGui describeGui = new DescribeGui(namesProperties.getProperty(beer), descriptionsProperties.getProperty(beer));
        describeGui.setVisible(true);
        try {
            describeGui.countDownLatch.await();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }


    public static void main(String[] args) {
        describe("ipa");
    }
}