package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

type hand int

const (
	R hand = iota + 1
	P
	S
)

func main() {
	input, _ := ioutil.ReadFile("input.txt")
	lines := strings.Split(string(input), "\r\n")
	myScore := 0
	for _, pair := range lines {
		myScore += evaluateRound(pair, score)
	}
	fmt.Println("part1: ", myScore)
	myScore = 0
	for _, pair := range lines {
		myScore += evaluateRound(pair, score2)
	}
	fmt.Println("part2: ", myScore)
}
func evaluateRound(pair string, scoreF func([]string) int) int {
	return scoreF(strings.Split(pair, " "))
}

func setType(str string) hand {
	switch str {
	case "A", "X":
		return R
	case "B", "Y":
		return P
	case "C", "Z":
		return S
	default:
		return R
	}
}
func score(pair []string) int {
	elf := setType(pair[0])
	me := setType(pair[1])
	iWon := int(me) + 6
	looser := int(me)
	draw := int(elf) + 3
	if elf == me {
		return draw
	} else if me == S && elf == P || me == R && elf == S || me == P && elf == R {
		return iWon
	} else {
		return looser
	}
}

//part 2 X(R) lose, Y(P) draw, Z(S) win
func score2(pair []string) int {
	elf := setType(pair[0])
	me := setType(pair[1])
	draw := int(elf) + 3
	if me == R { //lose
		if elf == R {
			return int(S)
		} else if elf == P {
			return int(R)
		}
		return int(P)
	} else if me == S { //win
		if elf == R {
			return int(P) + 6
		} else if elf == P {
			return int(S) + 6
		}
		return int(R) + 6
	} else {
		return draw

	}

}
