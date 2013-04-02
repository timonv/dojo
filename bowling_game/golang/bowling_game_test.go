package main

import (
  "testing"
  //"fmt"
)

func assertScore(t *testing.T, score string, expected int) {
  game := NewGame(score)
  if game.Score() != expected {
    t.Errorf("Game score was not %d, but %d", expected, game.Score())
  }
}

func assertFrame(t *testing.T, score []string, expected int) {
  fr := NewFrame(score)
  if fr.Score() != expected {
    t.Errorf("Frame score was not %d, but %d", expected, fr.Score())
  }
}

// Integration

func TestSimpleScores(t *testing.T) {
  assertScore(t, "000", 0)
  assertScore(t, "111", 3)
  assertScore(t, "113", 5)
}

func TestMiss(t *testing.T) {
  assertScore(t, "--1", 1)
}

func TestSpare(t *testing.T) {
  assertScore(t, "1/00", 10)
  //assertScore(t, "1/10", 12)
}

// Frame
func TestFrameSimpleScore(t *testing.T) {
  assertFrame(t, []string {"1", "0"}, 1)
  assertFrame(t, []string {"5", "4"}, 9)
}
