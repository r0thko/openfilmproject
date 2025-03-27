CREATE TABLE IF NOT EXISTS `filmmakers` (
	`ofp_id` INTEGER NOT NULL,
	`tmdb_id` INTEGER NOT NULL UNIQUE,
	`imdb_id` TEXT NOT NULL,
	`name_en` TEXT NOT NULL,
	`name_original` TEXT NOT NULL,
	`name_translit` TEXT NOT NULL,
	`profile_image_url` TEXT NOT NULL,
	`bio` TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS `books` (
	`ofp_id` INTEGER NOT NULL,
	`openlib_id` TEXT NOT NULL UNIQUE,
	`title` TEXT NOT NULL,
	`authors` TEXT NOT NULL,
	`publish_year` INTEGER NOT NULL,
	`cover_url` TEXT NOT NULL,
	`link_url` TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS `filmmakers2books` (
	`id` INTEGER NOT NULL,
	`filmmaker_id` INTEGER NOT NULL,
	`book_id` INTEGER NOT NULL,
	`relationship_type_id` INTEGER NOT NULL,
	`source` TEXT NOT NULL,
	`notes` TEXT NOT NULL,
	`certainty_score` INTEGER NOT NULL,
FOREIGN KEY(`filmmaker_id`) REFERENCES `filmmakers`(`ofp_id`),
FOREIGN KEY(`book_id`) REFERENCES `books`(`ofp_id`),
FOREIGN KEY(`relationship_type_id`) REFERENCES `filmmakers2books_relationship_types`(`id`)
);
CREATE TABLE IF NOT EXISTS `films` (
	`ofp_id` INTEGER NOT NULL,
	`tmdb_id` INTEGER NOT NULL UNIQUE,
	`imdb_id` TEXT NOT NULL,
	`title_en` TEXT NOT NULL,
	`title_original` TEXT NOT NULL,
	`title_translit` TEXT NOT NULL,
	`release_year` INTEGER NOT NULL,
	`poster_url` TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS `films2books` (
	`id` INTEGER NOT NULL,
	`film_id` INTEGER NOT NULL,
	`book_id` INTEGER NOT NULL,
	`relationship_type_id` INTEGER NOT NULL,
	`source` TEXT NOT NULL,
	`notes` TEXT NOT NULL,
	`certainty_score` INTEGER NOT NULL,
FOREIGN KEY(`film_id`) REFERENCES `films`(`ofp_id`),
FOREIGN KEY(`book_id`) REFERENCES `books`(`ofp_id`),
FOREIGN KEY(`relationship_type_id`) REFERENCES `films2books_relationship_types`(`id`)
);
CREATE TABLE IF NOT EXISTS `awards` (
	`id` INTEGER NOT NULL,
	`name` TEXT NOT NULL,
	`location` TEXT NOT NULL,
	`established_year` INTEGER NOT NULL,
	`official_url` TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS `films2awards` (
	`id` INTEGER NOT NULL,
	`film_id` INTEGER NOT NULL,
	`award_id` INTEGER NOT NULL,
	`award_section_id` INTEGER NOT NULL,
	`qualifier_id` INTEGER NOT NULL,
	`year` INTEGER NOT NULL,
	`notes` TEXT NOT NULL,
FOREIGN KEY(`film_id`) REFERENCES `films`(`ofp_id`),
FOREIGN KEY(`award_id`) REFERENCES `awards`(`id`),
FOREIGN KEY(`award_section_id`) REFERENCES `award_sections`(`id`),
FOREIGN KEY(`qualifier_id`) REFERENCES `selection_qualifiers`(`id`)
);
CREATE TABLE IF NOT EXISTS `documents` (
	`id` INTEGER NOT NULL,
	`title` TEXT NOT NULL,
	`type` TEXT NOT NULL,
	`language` TEXT NOT NULL,
	`file_url` TEXT NOT NULL,
	`description` TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS `document_links` (
	`id` INTEGER NOT NULL,
	`document_id` INTEGER NOT NULL,
	`entity_type` TEXT NOT NULL,
	`entity_id` INTEGER NOT NULL,
FOREIGN KEY(`document_id`) REFERENCES `documents`(`id`)
);
CREATE TABLE IF NOT EXISTS `users` (
	`id` INTEGER NOT NULL,
	`username` TEXT NOT NULL UNIQUE,
	`email` TEXT NOT NULL,
	`is_admin` REAL NOT NULL DEFAULT '0',
	`created_at` REAL NOT NULL DEFAULT 'current_timestamp'
);
CREATE TABLE IF NOT EXISTS `tags` (
	`id` INTEGER NOT NULL,
	`label` TEXT NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS `tag_links` (
	`id` INTEGER NOT NULL,
	`tag_id` INTEGER NOT NULL,
	`entity_type` TEXT NOT NULL,
	`entity_id` INTEGER NOT NULL,
FOREIGN KEY(`tag_id`) REFERENCES `tags`(`id`)
);
CREATE TABLE IF NOT EXISTS `festivals` (
	`id` INTEGER NOT NULL,
	`name` TEXT NOT NULL,
	`location` TEXT NOT NULL,
	`established_year` INTEGER NOT NULL,
	`official_url` TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS `festival_sections` (
	`id` INTEGER NOT NULL,
	`festival_id` INTEGER NOT NULL,
	`name` TEXT NOT NULL,
	`description` TEXT NOT NULL,
	`competitive` REAL NOT NULL DEFAULT '0',
FOREIGN KEY(`festival_id`) REFERENCES `festivals`(`id`)
);
CREATE TABLE IF NOT EXISTS `films2festivals` (
	`id` INTEGER NOT NULL,
	`film_id` INTEGER NOT NULL,
	`festival_id` INTEGER NOT NULL,
	`festival_section_id` INTEGER NOT NULL,
	`qualifier_id` INTEGER NOT NULL,
	`year` INTEGER NOT NULL,
	`certainty_score` INTEGER NOT NULL DEFAULT '100',
FOREIGN KEY(`film_id`) REFERENCES `films`(`ofp_id`),
FOREIGN KEY(`festival_id`) REFERENCES `festivals`(`id`),
FOREIGN KEY(`festival_section_id`) REFERENCES `festival_sections`(`id`),
FOREIGN KEY(`qualifier_id`) REFERENCES `selection_qualifiers`(`id`)
);
CREATE TABLE IF NOT EXISTS `award_sections` (
	`id` INTEGER NOT NULL,
	`award_id` INTEGER NOT NULL,
	`name` TEXT NOT NULL,
	`description` TEXT NOT NULL,
	`competitive` REAL NOT NULL DEFAULT '0',
FOREIGN KEY(`award_id`) REFERENCES `awards`(`id`)
);
CREATE TABLE IF NOT EXISTS `selection_qualifiers` (
	`id` integer primary key NOT NULL UNIQUE,
	`qualifier` TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS `film_roles` (
	`id` integer primary key NOT NULL UNIQUE,
	`department` TEXT NOT NULL,
	`role` TEXT NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS `film_credits` (
	`id` integer primary key NOT NULL UNIQUE,
	`film_id` INTEGER NOT NULL,
	`filmmaker_id` INTEGER NOT NULL,
	`role_id` INTEGER NOT NULL,
	`credited_as` TEXT NOT NULL,
	`notes` TEXT NOT NULL,
FOREIGN KEY(`film_id`) REFERENCES `films`(`ofp_id`),
FOREIGN KEY(`filmmaker_id`) REFERENCES `filmmakers`(`ofp_id`),
FOREIGN KEY(`role_id`) REFERENCES `film_roles`(`id`)
);
CREATE TABLE IF NOT EXISTS `films2books_relationship_types` (
	`id` integer primary key NOT NULL UNIQUE,
	`relationship_type` TEXT NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS `filmmakers2books_relationship_types` (
	`id` integer primary key NOT NULL UNIQUE,
	`relationship_type` TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS `people` (
	`id` integer primary key NOT NULL UNIQUE
);