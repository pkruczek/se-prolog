package pl.edu.agh.se.run.gui;

import javax.swing.border.Border;
import javax.swing.border.EmptyBorder;
import java.awt.*;

public final class Settings {

    private Settings() {
    }

    public static final Dimension DEFAULT_MIN_DIMENSIONS = new Dimension(400,300);
    public static final Dimension DEFAULT_BUTTON_DIMENSIONS = new Dimension(40,25);
    public static final Border DEFAULT_BORDER = new EmptyBorder(10, 10, 10, 10);
}
