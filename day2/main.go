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
		myScore += evaluateRound(pair)
	}
	fmt.Println(myScore)
}
func evaluateRound(pair string) int {
	return score(strings.Split(pair, " "))
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
	if elf == me {
		return int(me) + 3
	} else if me == S {
		if elf == P {
			return iWon
		} else {
			return looser
		}
	} else if me == R {
		if elf == S {
			return iWon
		} else {
			return looser
		}

	} else if me == P {
		if elf == R {
			return iWon
		} else {
			return looser
		}
	}
	return int(me)
	/*

	 */
}
