package com.example;

public class GreetingApp {

    public static void main(String... name) {
        String message = new Greeting().hello(name[0]);
        System.out.println(message);
    }
}
