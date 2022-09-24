/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	id INT,
	name VARCHAR(255), 
	date_of_birth DATE, 
	escape_attempts INT, 
	neutered BOOLEAN, 
	weight_kg DECIMAL)
;

/* Project_2 */

ALTER TABLE animals
ADD species VARCHAR(255);

/* Project_3 query multiple tables */

-- Create a table named owners
CREATE TABLE owners (
	id SERIAL PRIMARY KEY,
	full_name VARCHAR(100),
	age INT
);

-- Create a table named species
CREATE TABLE species (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100)
);

-- Modify animals table:

-- Make sure that id is set as autoincremented PRIMARY KEY

ALTER TABLE animals
DROP COLUMN id;

ALTER TABLE animals
ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE animals
ADD CONSTRAINT animals_pkey PRIMARY KEY (id);

-- Remove column species
ALTER TABLE animals
DROP COLUMN species;


ALTER TABLE animals
DROP COLUMN species_id;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals 
	ADD species_id INT,
	ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);
-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals 
	ADD owner_id INT,
	ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);

/* Project_4 add "join table" for visits */

-- Create a table named vets
CREATE TABLE vets (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	age INT,
	date_of_graduation DATE
);

-- Create a "join table" called specializations to handle the many-to-many relationship between the tables species and vets
CREATE TABLE specializations (
	species_id INT NOT NULL,
	vet_id INT NOT NULL,
	PRIMARY KEY(species_id, vet_id),
	CONSTRAINT fk_specializations_species FOREIGN KEY(species_id) REFERENCES species(id),
	CONSTRAINT fk_specializations_vet FOREIGN KEY(vet_id) REFERENCES vets(id)
);

-- Create a "join table" called visits to handle the many-to-many relationship between the tables animals and vets, it should also keep track of the date of the visit.
CREATE TABLE visits (
	animal_id INT NOT NULL,
	vet_id INT NOT NULL,
	date_of_visit DATE,
	PRIMARY KEY(animal_id, vet_id, date_of_visit),
	CONSTRAINT fk_visits_animals FOREIGN KEY(animal_id) REFERENCES animals(id),
	CONSTRAINT fk_visits_vets FOREIGN KEY(vet_id) REFERENCES vets(id)
);


