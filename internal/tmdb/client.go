package tmdb

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
)

type PersonResult struct {
	ID          int    `json:"id"`
	Name        string `json:"name"`
	ProfilePath string `json:"profile_path"`
}

type PersonDetail struct {
	ID          int    `json:"id"`
	Name        string `json:"name"`
	Biography   string `json:"biography"`
	ProfilePath string `json:"profile_path"`
}

type SearchResponse struct {
	Results []PersonResult `json:"results"`
}

func SearchPerson(query string) ([]PersonResult, error) {
	apiKey := os.Getenv("TMDB_API_KEY")
	url := fmt.Sprintf("https://api.themoviedb.org/3/search/person?api_key=%s&query=%s", apiKey, query)

	resp, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var result SearchResponse
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return nil, err
	}

	return result.Results, nil
}

func GetPersonDetails(id string) (PersonDetail, error) {
	apiKey := os.Getenv("TMDB_API_KEY")
	url := fmt.Sprintf("https://api.themoviedb.org/3/person/%s?api_key=%s", id, apiKey)

	resp, err := http.Get(url)
	if err != nil {
		return PersonDetail{}, err
	}
	defer resp.Body.Close()

	var person PersonDetail
	err = json.NewDecoder(resp.Body).Decode(&person)
	return person, err
}



