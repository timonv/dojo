package main

import (
  "strconv"
  "strings"
  "fmt"
)


type Game string

func (g *Game) Score() int {
  arr := strings.Split(string(*g), "")
  fmt.Println(arr)
  score := 0
  for _, frame := range arr {
    tmp, _ := strconv.ParseInt(frame, 10, 0)
    score = score + int(tmp)
  }

  return score
}
