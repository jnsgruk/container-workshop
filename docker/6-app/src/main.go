package main

import (
	"fmt"
	"log"
	"math/rand"
	"net/http"
)

func hello(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "<h1>Hello, World!</h1>")
}

func dice(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "<h1>%d</h1>", rand.Intn(7-1)+1)
}

func main() {
	http.HandleFunc("/", hello)
	http.HandleFunc("/dice", dice)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
