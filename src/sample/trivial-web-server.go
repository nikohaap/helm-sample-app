package main

import (
	"fmt"
	"math/rand"
	"net/http"
	"time"
)

func indexHandler(w http.ResponseWriter, r *http.Request) {
	n := rand.Intn(200) // n will be between 0 and 200
	if n%2 == 0 {
		fmt.Printf("Sleeping %d s...\n", (n / 2))
		time.Sleep(time.Duration(n/2) * time.Second)
	} else {
		fmt.Printf("Sleeping %d ms...\n", n)
		time.Sleep(time.Duration(n) * time.Millisecond)
	}
	fmt.Fprintf(w, "I am a GO application running inside Docker.")
}

func main() {
	rand.Seed(time.Now().UnixNano())
	fmt.Println("Basic web server is starting on port 8080...")

	mux := http.NewServeMux()

	mux.Handle("/", http.HandlerFunc(indexHandler))
	http.ListenAndServe(":8080", mux)
}
