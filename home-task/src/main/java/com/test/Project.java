package com.test;

import org.apache.commons.collections.Predicate;
import org.apache.log4j.Logger;

 public String getGreeting() {
        return "Hello, MNT Lab!";
    }

  public static void test() {
    System.out.println("test");
      while(true) {
       System.out.println("bag!");
      }
  }

  public static void main(String[] args) {
    System.out.println(new Project().getGreeting());
  }
}
