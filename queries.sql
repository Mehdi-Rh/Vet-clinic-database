/*Queries that provide answers to the questions from all projects.*/

-- *** For the below queries check querie_11.png & querie_11.png querie_12.png ***

-- Find all animals whose name ends in "mon".
SELECT * FROM animals 
WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals 
WHERE date_of_birth BETWEEN '01/01/2016' AND '12/31/2019';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals 
WHERE neutered = TRUE AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals 
WHERE name = 'Agumon' OR name = 'Pikachu';


-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals 
WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals 
WHERE neutered = TRUE;

-- Find all animals not named Gabumon.
SELECT * FROM animals 
WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals 
WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- *** Project_2 ***

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.

-- *** For the below queries check querie_21.png ***
BEGIN;
SELECT * FROM animals;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- *** For the below queries check querie_22.png ***

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;
UPDATE animals SET species = 'digimon'
WHERE name LIKE '%mon';
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon'
WHERE species IS NULL;
-- Commit the transaction.
COMMIT;
-- Verify that change was made and persists after commit.
SELECT * FROM animals;

-- *** For the below queries check querie_23.png ***

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
-- After the rollback verify if all records in the animals table still exists. 
SELECT * FROM animals;

-- *** For the below queries check querie_24.png & querie_25.png ***

-- Inside a transaction:
BEGIN;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals 
WHERE date_of_birth > '01/01/2022';
SELECT date_of_birth FROM animals;
-- Create a savepoint for the transaction.
SAVEPOINt delete_new;
-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * (-1);
SELECT weight_kg FROM animals;
-- Rollback to the savepoint
ROLLBACK TO SAVEPOINT delete_new;
SELECT weight_kg FROM animals;
-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * (-1)
WHERE weight_kg < 0;
SELECT weight_kg FROM animals;
-- Commit transaction
COMMIT;
SELECT * FROM animals;


-- Write queries to answer the following questions:

-- *** For the below queries check querie_26.png & querie_27.png ***

-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT a.name, a.escape_attempts, a.neutered FROM animals a
JOIN (
  SELECT neutered, MAX(escape_attempts) max
  FROM animals
  GROUP BY neutered
  ) b 
ON a.escape_attempts = b.max AND a.neutered = b.neutered;
-- What is the minimum and maximum weight of each type of animal?

SELECT species, MAX(weight_kg) max_weight, MIN(weight_kg) min_weight
FROM animals
GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT neutered, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '01/01/1990' AND '12/31/1999'
GROUP BY neutered;

/* Project_3 query multiple tables */

-- What animals belong to Melody Pond?
SELECT a.name animal_name, o.full_name owner_name
FROM animals a
JOIN owners o
ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name Pokemons
FROM animals a
JOIN species s
ON a.species_id = s.id
WHERE s.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT a.name animal_name, o.full_name owner_name
FROM animals a
RIGHT JOIN owners o
ON a.owner_id = o.id;
-- How many animals are there per species?
SELECT s.name, COUNT(*) number_of_animal
FROM animals a
JOIN species s
ON a.species_id = s.id
GROUP BY s.name;
-- List all Digimon owned by Jennifer Orwell.
SELECT a.name, o.full_name, s.name
FROM animals a
JOIN owners o
ON a.owner_id = o.id
JOIN species s
ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name, a.escape_attempts, o.id, a.owner_id, o.full_name
FROM owners o
JOIN animals a
ON a.owner_id = o.id
WHERE a.escape_attempts = 0 AND o.full_name = 'Dean Winchester';
-- Who owns the most animals?
SELECT o.full_name, COUNT(*) number_of_animals
FROM animals a
JOIN owners o
ON a.owner_id = o.id
GROUP BY o.full_name
ORDER BY number_of_animals DESC;

/* Project_4 add "join table" for visits */

-- Who was the last animal seen by William Tatcher?
SELECT a.name, ve.name, vi.date_of_visit date_of_visit
FROM animals a
JOIN visits vi
ON a.id = vi.animal_id
JOIN vets ve
ON vi.vet_id = ve.id
WHERE ve.name = 'William Tatcher'
ORDER BY date_of_visit DESC;
-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*), ve.name vet_name
FROM animals a
JOIN visits vi
ON a.id = vi.animal_id
JOIN vets ve
ON vi.vet_id = ve.id
WHERE ve.name = 'Stephanie Mendez'
GROUP BY vet_name;
-- List all vets and their specialties, including vets with no specialties.
SELECT v.name vet_name, species.name specie 
FROM vets v
LEFT JOIN specializations s
ON v.id = s.species_id
LEFT JOIN species 
ON species.id = s.species_id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name animal_name, ve.name vet_name, vi.date_of_visit
FROM animals a
JOIN visits vi
ON a.id = vi.animal_id
JOIN vets ve
ON vi.vet_id = ve.id
WHERE ve.name = 'Stephanie Mendez' AND vi.date_of_visit BETWEEN '04/01/2020' AND '08/30/2020';
-- What animal has the most visits to vets?
SELECT COUNT(*) number_vet_visit, a.name
FROM animals a
JOIN visits vi
ON a.id = vi.animal_id
JOIN vets ve
ON vi.vet_id = ve.id
GROUP BY a.name
ORDER BY number_vet_visit DESC;
-- Who was Maisy Smith's first visit?
SELECT a.name animal_name, ve.name vet_name, vi.date_of_visit
FROM animals a
JOIN visits vi
ON a.id = vi.animal_id
JOIN vets ve
ON vi.vet_id = ve.id
WHERE ve.name = 'Maisy Smith'
ORDER BY vi.date_of_visit;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name animal_name, a.escape_attempts, a.neutered, a.weight_kg, ve.name vet_name, ve.age vet_age, ve.date_of_graduation, vi.date_of_visit
FROM animals a
JOIN visits vi
ON a.id = vi.animal_id
JOIN vets ve
ON vi.vet_id = ve.id
ORDER BY vi.date_of_visit DESC;
-- How many visits were with a vet that did not specialize in that animal's species?
WITH redundance_visit AS (
  SELECT COUNT(*) count, a.name animal_name, a.species_id animal_species,sp.species_id vet_specie, ve.name vet_name, ve.id vet_id
  FROM animals a
  JOIN visits vi
  ON a.id = vi.animal_id
  JOIN vets ve
  ON vi.vet_id = ve.id
  LEFT JOIN specializations sp
  On ve.id = sp.vet_id
  GROUP BY animal_name,animal_species,sp.species_id, vet_name, ve.id
)
SELECT SUM(rv.count)
FROM redundance_visit rv
WHERE (rv.count = 1 AND rv.animal_species != rv.vet_specie) OR rv.vet_specie IS NULL
;
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
WITH maisy_smith AS (
  SELECT DISTINCT ve.name vet_name, ve.id vet_id, a.name animal_name, species.name animal_species, vi.date_of_visit
  FROM animals a
  JOIN visits vi
  ON a.id = vi.animal_id
  JOIN vets ve
  ON vi.vet_id = ve.id
  LEFT JOIN specializations sp
  On ve.id = sp.vet_id
  JOIN species
  ON a.species_id = species.id
  WHERE ve.name = 'Maisy Smith'
)

SELECT ms.animal_species, COUNT(*) number_of_visits
FROM maisy_smith ms
GROUP BY ms.animal_species;

