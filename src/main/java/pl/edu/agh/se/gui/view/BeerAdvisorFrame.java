package pl.edu.agh.se.gui.view;

import javax.swing.*;
import java.util.ArrayList;
import java.util.List;

public class BeerAdvisorFrame extends JFrame {

    private static final int WIDTH = 500;
    private static final int HEIGHT = 500;

    private JPanel mainPanel;
    private JButton okButton;
    private JButton cancelButton;
    private List<JRadioButton> radioButtons = new ArrayList<>();

    public BeerAdvisorFrame()  {
        setSize(WIDTH, HEIGHT);
        setContentPane(mainPanel);
    }

    public JButton getOkButton() {
        return okButton;
    }

    public JButton getCancelButton() {
        return cancelButton;
    }

    public void addButton(JRadioButton radioButton) {
        radioButtons.add(radioButton);
        mainPanel.add(radioButton);
    }

}
