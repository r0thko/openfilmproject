package main

import (
	"html/template"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"

	"github.com/r0thko/openfilmproject/internal/tmdb"
	"github.com/r0thko/openfilmproject/internal/openlib"
)

func main() {
	godotenv.Load()

	router := gin.Default()

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

	router.GET("/filmmaker/:id", func(c *gin.Context) {
		tmdbID := c.Param("id")

		// Get TMDB person details
		person, err := tmdb.GetPersonDetails(tmdbID)
		if err != nil {
			log.Println("TMDB error:", err)
			c.String(500, "Failed to get filmmaker")
			return
		}
	
		// Search books from Open Library
		books, err := openlib.SearchBooksByAuthor(person.Name)
		if err != nil {
			log.Println("Open Library error:", err)
			c.String(500, "Failed to get books")
			return
		}
	
		c.HTML(http.StatusOK, "filmmaker", gin.H{
			"Person": person,
			"Books":  books,
		})
	})

	log.Fatal(router.Run(":8080"))
}

