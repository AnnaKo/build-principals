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
   int massive[];
        massive = new int[10];
        massive[10] = 10;
        System.out.println(Integer.toString(massive[10]));
   int a = 1;
   while(1 == 1) {
    a *= 5;
   }
    System.out.println(new Project().getGreeting());
  }

}
