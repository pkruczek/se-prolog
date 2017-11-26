package pl.edu.agh.se.run;

import org.jpl7.JPL;
import org.jpl7.Query;
import org.jpl7.Term;
import pl.edu.agh.se.client.Answer;
import pl.edu.agh.se.gui.controller.BeerAdvisorController;
import pl.edu.agh.se.gui.view.BeerAdvisorFrame;

public class Main {


    public static void main(String[] args) {

        System.out.println(System.getProperty("java.library.path"));
        Query.hasSolution("use_module(library(jpl))"); // only because we call e.g. jpl_pl_syntax/1 below
        Term swi = Query.oneSolution("current_prolog_flag(version_data,Swi)").get("Swi");
        System.out.println("swipl.version = " + swi.arg(1) + "." + swi.arg(2) + "." + swi.arg(3));
        System.out.println("swipl.syntax = " + Query.oneSolution("jpl_pl_syntax(Syntax)").get("Syntax"));
        System.out.println("swipl.home = " + Query.oneSolution("current_prolog_flag(home,Home)").get("Home").name());
        System.out.println("jpl.jar = " + JPL.version_string());
        System.out.println("jpl.dll = " + org.jpl7.fli.Prolog.get_c_lib_version());
        System.out.println("jpl.pl = " + Query.oneSolution("jpl_pl_lib_version(V)").get("V").name());

        String t1 = "[piwny_doradca]";
        System.out.println(t1 + " " + (Query.hasSolution(t1) ? "succeeded" : "failed"));

        BeerAdvisorController beerAdvisorController = new BeerAdvisorController();
        beerAdvisorController.addAnswer(new Answer("Lager"));
        beerAdvisorController.addAnswer(new Answer("Porter"));
        beerAdvisorController.showWindow();

    }

}
