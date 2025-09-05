package main

import (
	"fmt"
	"net/http"
	"os"
)

func handler(w http.ResponseWriter, r *http.Request) {
	version := os.Getenv("VERSION")
	if version == "" {
		version = "v1" // default
	}

	fmt.Fprintf(w, "Hello from API %s 🚀", version)
}

func main() {
	http.HandleFunc("/", handler)

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	fmt.Printf("Starting server (VERSION=%s) on port %s\n", os.Getenv("VERSION"), port)
	if err := http.ListenAndServe(":"+port, nil); err != nil {
		panic(err)
	}
}
