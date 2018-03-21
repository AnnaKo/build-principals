package com.test;

import org.apache.commons.collections.Predicate;
import org.apache.log4j.Logger;

class Project {

 public String getGreeting() {
        return "Hello, MNT Lab!";
    }

  public static void test() {
    Logger logger = Logger.getLogger(LoggingJul.class.getName());
    logger.log("test");
  }

  public static void main(String[] args) {
    Logger logger = Logger.getLogger(LoggingJul.class.getName());
    logger.log(new Project().getGreeting());
  }
}
