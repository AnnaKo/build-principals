package com.test;

/*import org.apache.commons.collections.Predicate;*/
import org.apache.log4j.Logger;

class Project {
 
 private static Logger logger = Logger.getLogger(Project.class.getName());

 public String getGreeting() {
        return "Hello, MNT Lab!";
    }

  public static void test() {
    logger.info("test");
  }

  public static void main(String[] args) {
    logger.info(new Project().getGreeting());
  }
}
