package openlib

import (
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
)

type Book struct {
	Title  string `json:"title"`
	AuthorName []string `json:"author_name"`
	Key    string `json:"key"` // /works/OL1234W
}

type SearchResult struct {
	Docs []Book `json:"docs"`
}

func SearchBooksByAuthor(name string) ([]Book, error) {
	apiURL := fmt.Sprintf("https://openlibrary.org/search.json?author=%s", url.QueryEscape(name))

	resp, err := http.Get(apiURL)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var result SearchResult
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return nil, err
	}

	return result.Docs, nil
}

