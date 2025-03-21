# 🎬 OpenFilmProject

![Status](https://img.shields.io/badge/status-pre--alpha-orange)
![Go](https://img.shields.io/badge/Go-1.24.1-blue)
![HTMX](https://img.shields.io/badge/HTMX-enabled-purple)
![TMDB](https://img.shields.io/badge/TMDB-API-green)
[![Open Library](https://img.shields.io/badge/OpenLibrary-API-blueviolet)](https://openlibrary.org/developers/api)

## An open knowledge platform for film scholars, filmmakers, film professionals, film lovers and everyone else.

### 💡 Implemented features
- 🔍 Search filmmakers (via TMDB)
- 📚 Discover books (via Open Library)
- 🔗 Link books to filmmakers

## 🗺️ Roadmap

### ✅ **MVP 1: Filmmaker Discovery**
> Core idea: search for filmmakers and view useful profiles.

- [x] TMDB integration
- [x] Live search with HTMX
- [x] Display filmmaker bio and profile image
- [x] Clickable search results → profile pages

---

### 🔄 **MVP 2: Book Discovery**
> Core idea: show books relevant to a filmmaker using Open Library.

- [x] Integrate Open Library API
- [x] Display book list per filmmaker
- [x] Show title, author, and Open Library links
- [ ] Filter out irrelevant results (e.g. Herman Melville from Jean-Pierre Melville search 🤦‍♂️)
- [ ] Add basic relationship types (biography, authored, interviews)

---

### 🔜 **MVP 3: Local Curation**
> Start storing your own knowledge layer.

- [ ] Set up PostgreSQL database
- [ ] Save filmmaker to local library
- [ ] Add/link books to saved filmmakers
- [ ] Build basic `/library` route (show saved filmmakers)
- [ ] Add book tagging and relationship types

---

### 🔜 **MVP 4: Admin Interface**
> Start building a curator-friendly internal tool.

- [ ] HTMX-powered dashboard
- [ ] "Pair book to filmmaker" flow
- [ ] Manual book entry form
- [ ] Edit or delete pairs/tags

---

### 🎯 **Future Plans**

- [ ] Integrate festival archives & programming data
- [ ] Build curated film history timelines
- [ ] Add user accounts (for scholars, curators, etc.)
- [ ] Create citation/export tools (for research)
- [ ] Add AI-powered suggestions / auto-tagging
- [ ] Open public beta
- [ ] Custom domain + deployment

---

### 🧪 **Experimental Ideas (in the far future)**

- [ ] Influence trees (filmmaker → books → other filmmakers)
- [ ] Vector search for concept-matching books
- [ ] Visual timelines (films, books, movements)
- [ ] Collaborative annotations
