package main

import (
	"database/sql"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	_ "github.com/mattn/go-sqlite3"
	"github.com/r0thko/openfilmproject/internal/handlers"
	"html/template"
	"log"
	"net/http"

	"github.com/r0thko/openfilmproject/internal/tmdb"
)

func main() {
	godotenv.Load()

	router := gin.Default()

	db, err := sql.Open("sqlite3", "./openfilmproject.db")
	if err != nil {
		log.Fatal("Failed to connect to database:", err)
	}
	defer db.Close()

	router.Use(func(c *gin.Context) {
		c.Set("db", db)
		c.Next()
	})

	// Load templates
	tmpl := template.Must(template.ParseGlob("web/templates/*.html"))
	router.SetHTMLTemplate(tmpl)

	// Show search form
	router.GET("/", func(c *gin.Context) {
		c.HTML(http.StatusOK, "layout.html", nil)
	})

	// HTMX target for search
	router.GET("/search", func(c *gin.Context) {
		query := c.Query("q")
		results, err := tmdb.SearchPerson(query)
		if err != nil {
			log.Println("Search error:", err)
			c.String(http.StatusInternalServerError, "Error fetching results")
			return
		}
		c.HTML(http.StatusOK, "results.html", results)
	})

	router.GET("/filmmaker/:id", handlers.ShowFilmmaker)

	log.Fatal(router.Run(":8080"))
}
