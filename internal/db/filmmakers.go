package db

import (
	"database/sql"
	"github.com/r0thko/openfilmproject/internal/tmdb"
)

type Filmmaker struct {
	TMDBID       int
	IMDbID       string
	NameEn       string
	NameOriginal string
	NameTranslit string
	ProfileImage string
	Bio          string
}

func GetOrFetchFilmmakerByTMDBID(db *sql.DB, tmdbID int) (*Filmmaker, error) {
	// Check if already in local DB
	var fm Filmmaker
	err := db.QueryRow(`SELECT tmdb_id, imdb_id, name_en, profile_image_url, bio FROM filmmakers WHERE tmdb_id = ?`, tmdbID).
		Scan(&fm.TMDBID, &fm.IMDbID, &fm.NameEn, &fm.ProfileImage, &fm.Bio)

	if err == nil {
		return &fm, nil
	}

	if err != sql.ErrNoRows {
		return nil, err
	}

	// Not found — fetch from TMDB
	apiResult, err := tmdb.FetchPersonDetails(tmdbID)
	if err != nil {
		return nil, err
	}

	// Insert into DB
	_, err = db.Exec(`
        INSERT INTO filmmakers (tmdb_id, imdb_id, name_en, profile_image_url, bio)
        VALUES (?, ?, ?, ?, ?)`,
		apiResult.TMDBID, apiResult.IMDbID, apiResult.Name, apiResult.ProfilePath, apiResult.Biography)

	if err != nil {
		return nil, err
	}

	return &Filmmaker{
		TMDBID:       apiResult.TMDBID,
		IMDbID:       apiResult.IMDbID,
		NameEn:       apiResult.Name,
		ProfileImage: apiResult.ProfilePath,
		Bio:          apiResult.Biography,
	}, nil
}
