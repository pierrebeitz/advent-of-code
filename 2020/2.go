package main

import (
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	content, _ := ioutil.ReadFile("input2.txt")

	validRanges := 0
	validPositions := 0
	for _, line := range strings.Split(strings.Trim(string(content), "\n"), "\n") {
		min, max, char, password := sliceAndDice(line)
		// PART 1
		count := strings.Count(password, char)
		if count >= min && count <= max {
			validRanges++
		}

		// PART 2
		if (password[min-1:min] == char) != (password[max-1:max] == char) {
			validPositions++
		}
	}

	println("part 1: ", validRanges)
	println("part 2: ", validPositions)
}

func sliceAndDice(str string) (min int, max int, char string, password string) {
	line := strings.Fields(str)
	rangeArr := strings.Split(line[0], "-")
	min, _ = strconv.Atoi(rangeArr[0])
	max, _ = strconv.Atoi(rangeArr[1])
	char = line[1][0:1]
	password = line[2]
	return
}
