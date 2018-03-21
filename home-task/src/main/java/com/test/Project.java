package com.test;

import org.apache.commons.collections.Predicate;
import org.apache.log4j.Logger;

class Project {

 public String getGreeting() {
        return "Hello, MNT Lab!";
    }

  public static void test() {
    System.out.println("test");
  }

  public static void main(String[] args) {
    System.out.println(new Project().getGreeting());
  }
 
  private int x;
  private int y;

  public void setX(int val) { // Noncompliant: field 'x' is not updated
    this.y = val;
  }

  public int getY() { // Noncompliant: field 'y' is not used in the return value
    return this.x;
  }
}
