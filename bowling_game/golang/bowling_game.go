package main

import (
  "strconv"
  "strings"
  //"fmt"
)


type Game struct {
  rawScore string
}

type Frame struct {
  rawScore []string
}

func NewGame(scr string) *Game {
  game := new(Game)
  game.rawScore = scr
  return game
}

func (g *Game) Score() int {
  score := 0
  for _, val := range g.getScoreList() {
    score += val
  }

  return score
}

func (g *Game) getScoreList() []int {
  var list []int
  split := g.splitScore()
  for i, frame := range split {
    var val int
    if frame == "/" {
      tmp, _ := strconv.ParseInt(split[i-1], 10, 0)
      val = 10 - int(tmp)
    } else {
      tmp, _ := strconv.ParseInt(frame, 10, 0)
      val = int(tmp)
    }
    list = append(list, val)
  }
  return list
}

func (g *Game) splitScore() []string {
  return strings.Split(g.rawScore, "")
}

// Frames

func NewFrame(scr []string) *Frame {
  fr := new(Frame)
  fr.rawScore = scr
  return fr
}

func (fr *Frame) Score() int {
  sum := 0
  for _, val := range fr.getNormalizedScoreList() {
    sum += val
  }
  return sum
}

func (fr *Frame) getNormalizedScoreList() []int {
  var list []int
  split := fr.rawScore
  for i, frame := range split {
    var val int
    if frame == "/" {
      tmp, _ := strconv.ParseInt(split[i-1], 10, 0)
      val = 10 - int(tmp)
    } else {
      tmp, _ := strconv.ParseInt(frame, 10, 0)
      val = int(tmp)
    }
    list = append(list, val)
  }
  return list
}
