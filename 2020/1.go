package main

import (
    "fmt"
    "io/ioutil"
    "log"
		"strings"
		"strconv"
)

func main() {
    content, err := ioutil.ReadFile("input1.txt")
     if err != nil {
          log.Fatal(err)
     }

		strs := strings.Fields(string(content))


		ints := make([]int, len(strs))
    for i, n := range strs {
			parsedInt, err := strconv.Atoi(n)
			if (err != nil) {
				log.Fatal(err)
			}
			ints[i] = parsedInt
		}

    for _, n := range ints {
			for _, m := range ints {
			  for _, o := range ints {
					if n + m + o == 2020 {
						fmt.Printf("%d, %d, %d\n", n, m, o)
						fmt.Println(n * m * o)
						return
					}
				}
			}
    }
}
