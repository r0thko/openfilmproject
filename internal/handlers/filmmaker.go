package handlers

import (
	"database/sql"
	"log"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	dbpkg "github.com/r0thko/openfilmproject/internal/db"
)

func ShowFilmmaker(c *gin.Context) {
	tmdbIDStr := c.Param("id")
	tmdbID, err := strconv.Atoi(tmdbIDStr)
	if err != nil {
		c.String(http.StatusBadRequest, "Invalid TMDB ID")
		return
	}

	db := c.MustGet("db").(*sql.DB)

	filmmaker, err := dbpkg.GetOrFetchFilmmakerByTMDBID(db, tmdbID)
	if err != nil {
		log.Println("Error fetching filmmaker:", err)
		c.String(http.StatusInternalServerError, "Error fetching filmmaker")
		return
	}

	c.HTML(http.StatusOK, "filmmaker.html", gin.H{
		"NameEn":       filmmaker.NameEn,
		"Bio":          filmmaker.Bio,
		"ProfileImage": filmmaker.ProfileImage,
	})

}
