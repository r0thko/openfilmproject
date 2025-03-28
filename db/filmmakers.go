package db

import (
	"database/sql"
	"github.com/r0thko/openfilmproject/internal/tmdb"
)

// Local representation of a filmmaker from DB
type Filmmaker struct {
	OFPID        int
	TMDBID       int
	IMDbID       string
	NameEn       string
	NameOriginal string
	NameTranslit string
	ProfileImage string
	Bio          string
}

// GetOrFetchFilmmakerByTMDBID checks local DB and fetches from TMDB if needed
func GetOrFetchFilmmakerByTMDBID(db *sql.DB, tmdbID int) (*Filmmaker, error) {
	var fm Filmmaker

	// 1. Check if already exists in DB
	err := db.QueryRow(`
        SELECT ofp_id, tmdb_id, imdb_id, name_en, name_original, name_translit, profile_image_url, bio
        FROM filmmakers WHERE tmdb_id = ?`, tmdbID).
		Scan(&fm.OFPID, &fm.TMDBID, &fm.IMDbID, &fm.NameEn, &fm.NameOriginal, &fm.NameTranslit, &fm.ProfileImage, &fm.Bio)

	if err == nil {
		return &fm, nil // Found in DB
	}

	if err != sql.ErrNoRows {
		return nil, err // Some other DB error
	}

	// 2. Not found — fetch from TMDB
	person, err := tmdb.GetPersonDetails(tmdbID)
	if err != nil {
		return nil, err
	}

	// 3. Insert into DB
	result, err := db.Exec(`
        INSERT INTO filmmakers (tmdb_id, imdb_id, name_en, profile_image_url, bio)
        VALUES (?, ?, ?, ?, ?)`,
		person.ID, person.IMDbID, person.Name, person.ProfilePath, person.Biography)

	if err != nil {
		return nil, err
	}

	// Get the new ofp_id
	ofpID, err := result.LastInsertId()
	if err != nil {
		return nil, err
	}

	// Return the new struct
	return &Filmmaker{
		OFPID:        int(ofpID),
		TMDBID:       person.ID,
		IMDbID:       person.IMDbID,
		NameEn:       person.Name,
		ProfileImage: person.ProfilePath,
		Bio:          person.Biography,
	}, nil
}
