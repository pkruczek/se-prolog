package pl.edu.agh.se.client;

import java.util.Optional;

public interface BeerAdvisorClient {

    
    Optional<Question> nextQuestion();
    Optional<String> result();

}
