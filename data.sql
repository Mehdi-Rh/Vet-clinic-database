/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Agumon', TO_DATE('02/3/2015', 'MM/DD/YYYY'), 10.23, TRUE, 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Gabumon', TO_DATE('11/15/2018', 'MM/DD/YYYY'), 8, TRUE, 2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Pikachu', TO_DATE('01/7/2021', 'MM/DD/YYYY'), 15.04, FALSE, 1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Devimon', TO_DATE('05/12/2017', 'MM/DD/YYYY'), 11, TRUE, 5);

