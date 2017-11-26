package pl.edu.agh.se.gui.controller;

import pl.edu.agh.se.client.Answer;
import pl.edu.agh.se.gui.view.BeerAdvisorFrame;

import javax.swing.*;

public class BeerAdvisorController {

    private BeerAdvisorFrame beerAdvisorFrame;
    private JButton okButton;
    private JButton cancelButton;

    public BeerAdvisorController() {
        initComponents();
        initListeners();
    }

    public void showWindow() {
        beerAdvisorFrame.setVisible(true);
    }

    public void addAnswer(Answer answer) {
        JRadioButton radioButton = new JRadioButton(answer.getContent());
        radioButton.addActionListener(actionEvent -> {
            System.out.println("Answer: " + answer + " clicked");
        });
    }

    private void initComponents() {
        this.beerAdvisorFrame = new BeerAdvisorFrame();
        this.okButton = beerAdvisorFrame.getOkButton();
        this.cancelButton = beerAdvisorFrame.getCancelButton();
    }

    private void initListeners() {
        cancelButton.addActionListener(actionEvent -> {
            System.out.println("Cancel");
        });

        okButton.addActionListener(actionEvent -> {
            System.out.println("OK");
        });
    }
}
