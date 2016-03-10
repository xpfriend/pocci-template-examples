package com.example;

import org.junit.Test;

import com.example.GreetingApp;

import static org.junit.Assert.*;

public class GreetingAppTest {

    @Test
    public void testMain() {
        // expect
        GreetingApp.main("Shoichi");
    }
}