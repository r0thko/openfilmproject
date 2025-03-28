package tmdb

import (
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"os"
)

type PersonSummary struct {
	ID          int    `json:"id"`
	Name        string `json:"name"`
	ProfilePath string `json:"profile_path"`
}

type PersonSearchResult struct {
	Results []PersonSummary `json:"results"`
}

type PersonDetails struct {
	TMDBID      int    `json:"id"`
	IMDbID      string `json:"imdb_id"`
	Name        string `json:"name"`
	Biography   string `json:"biography"`
	ProfilePath string `json:"profile_path"`
}

func FetchPersonDetails(tmdbID int) (*PersonDetails, error) {
	apiKey := os.Getenv("TMDB_API_KEY")
	url := fmt.Sprintf("https://api.themoviedb.org/3/person/%d?api_key=%s&language=en-US", tmdbID, apiKey)

	resp, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var result PersonDetails
	err = json.NewDecoder(resp.Body).Decode(&result)
	if err != nil {
		return nil, err
	}

	return &result, nil
}

func SearchPerson(query string) ([]PersonSummary, error) {
	apiKey := os.Getenv("TMDB_API_KEY")
	escapedQuery := url.QueryEscape(query)
	url := fmt.Sprintf("https://api.themoviedb.org/3/search/person?query=%s&include_adult=false&page=1&api_key=%s", escapedQuery, apiKey)
	
	resp, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var result PersonSearchResult
	err = json.NewDecoder(resp.Body).Decode(&result)
	if err != nil {
		return nil, err
	}

	return result.Results, nil
}

func GetPersonDetails(tmdbID int) (*PersonDetails, error) {
	apiKey := os.Getenv("TMDB_API_KEY")
	url := fmt.Sprintf("https://api.themoviedb.org/3/person/%d?api_key=%s", tmdbID, apiKey)

	resp, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var person PersonDetails
	err = json.NewDecoder(resp.Body).Decode(&person)
	if err != nil {
		return nil, err
	}

	return &person, nil
}
