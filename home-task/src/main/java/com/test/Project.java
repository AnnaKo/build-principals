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
}

public void doSomethingWithFile(String fileName) {
  BufferedReader buffReader = null;
  try {
    buffReader = new BufferedReader(new FileReader(fileName));
    while (buffReader.readLine() != null) {
    }
  } catch (IOException e) {
  }

String ip = "127.0.0.1";
Socket socket = new Socket(ip, 6667);
