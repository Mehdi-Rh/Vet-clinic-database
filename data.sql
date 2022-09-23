/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Agumon', TO_DATE('02/3/2015', 'MM/DD/YYYY'), 10.23, TRUE, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Gabumon', TO_DATE('11/15/2018', 'MM/DD/YYYY'), 8, TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Pikachu', TO_DATE('01/7/2021', 'MM/DD/YYYY'), 15.04, FALSE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Devimon', TO_DATE('05/12/2017', 'MM/DD/YYYY'), 11, TRUE, 5);

-- Animal: His name is Charmander. He was born on Feb 8th, 2020, and currently weighs -11kg. He is not neutered and he has never tried to escape.
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Charmander', TO_DATE('02/08/2020', 'MM/DD/YYYY'), -11, FALSE, 0);
-- Animal: Her name is Plantmon. She was born on Nov 15th, 2021, and currently weighs -5.7kg. She is neutered and she has tried to escape 2 times.
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Plantmon', TO_DATE('11/15/2021', 'MM/DD/YYYY'), -5.7, TRUE, 2);
-- Animal: His name is Squirtle. He was born on Apr 2nd, 1993, and currently weighs -12.13kg. He was not neutered and he has tried to escape 3 times.
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Squirtle', TO_DATE('04/02/1993', 'MM/DD/YYYY'), -12.13, FALSE, 3);
-- Animal: His name is Angemon. He was born on Jun 12th, 2005, and currently weighs -45kg. He is neutered and he has tried to escape once.
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Angemon', TO_DATE('06/12/2005', 'MM/DD/YYYY'), -45, TRUE, 1);
-- Animal: His name is Boarmon. He was born on Jun 7th, 2005, and currently weighs 20.4kg. He is neutered and he has tried to escape 7 times.
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Boarmon', TO_DATE('06/07/2005', 'MM/DD/YYYY'), 20.4, TRUE, 7);
-- Animal: Her name is Blossom. She was born on Oct 13th, 1998, and currently weighs 17kg. She is neutered and she has tried to escape 3 times.
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Blossom', TO_DATE('10/13/1998', 'MM/DD/YYYY'), 17, TRUE, 3);
-- Animal: His name is Ditto. He was born on May 14th, 2022, and currently weighs 22kg. He is neutered and he has tried to escape 4 times.
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Ditto', TO_DATE('05/14/2022', 'MM/DD/YYYY'), 22, TRUE, 4);

/* Project_3 query multiple tables*/

-- Insert data into the owners table
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age)
VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age)
VALUES ('Bob', 45);
INSERT INTO owners (full_name, age)
VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age)
VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age)
VALUES ('Jodie Whittaker', 38);

-- Insert data into the species table
INSERT INTO species (name)
VALUES ('Pokemon');
INSERT INTO species (name)
VALUES ('Digimon');

-- Modify the inserted animals so it includes the species_id value
UPDATE animals 
SET species_id = 2
WHERE name LIKE '%mon';

UPDATE animals 
SET species_id = 1
WHERE species_id IS NULL;

-- Modify the inserted animals to include owner information (owner_id)
UPDATE animals 
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name LIKE 'Sam Smith%'
)
WHERE name = 'Agumon';

UPDATE animals 
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Jennifer Orwell'
)
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals 
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Bob'
)
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals 
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Melody Pond'
)
WHERE name = 'Charmander' OR name = 'Squirtle'OR name = 'Blossom';

UPDATE animals 
SET owner_id = (
  SELECT id FROM owners
  WHERE full_name = 'Melody Pond'
)
WHERE name = 'Angemon' OR name = 'Boarmon';
