package pl.edu.agh.se.run.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public final class PropertiesReader {

    private PropertiesReader() {
    }

    public static Properties readProperties(String filename) {

        Properties prop = new Properties();
        try (InputStream input = PropertiesReader.class.getClassLoader().getResourceAsStream(filename)) {

            if (input == null) {
                throw new RuntimeException("Sorry, unable to find " + filename);
            }

            prop.load(input);
            return prop;

        } catch (IOException ex) {
            throw new RuntimeException(ex);
        }
    }
}
