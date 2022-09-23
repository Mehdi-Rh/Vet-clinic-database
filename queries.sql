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