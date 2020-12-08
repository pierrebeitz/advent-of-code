package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	content, _ := ioutil.ReadFile("input1.txt")
	strs := strings.Fields(string(content))
	ints := make([]int, len(strs))

	for i, n := range strs {
		parsedInt, _ := strconv.Atoi(n)
		ints[i] = parsedInt
	}

	for _, n := range ints {
		for _, m := range ints {
			if n+m == 2020 {
				fmt.Println("part 1: ", n*m)
			}
		}
	}

	// yes, this obviously does not scale. but for now it works :)
	for _, n := range ints {
		for _, m := range ints {
			for _, o := range ints {
				if n+m+o == 2020 {
					fmt.Println("part 2: ", n*m*o)
					return
				}
			}
		}
	}
}
