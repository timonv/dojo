package main

import (
  "testing"
  "fmt"
)

func TestTruth(t *testing.T) {
  if false {
    t.Fail()
  }
  fmt.Println("GOGOGO")
}

func TestSimpleScores(t *testing.T) {
  game1 := Game("000")
  if game1.Score() != 0 {
    t.Error("Score was not 0")
  }
  game2 := Game("111")
  if game2.Score() != 3 {
    t.Error("Score was not 3 but ", game2.Score())
  }
  game3 := Game("113")
  if game3.Score() != 5 {
    t.Error("Score was not 5 but ", game3.Score())
  }
}
