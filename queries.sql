/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;

/* update transaction */

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

/* Start transaction */

BEGIN;

/* update transaction */

UPDATE animals
SET species = 'digimon' WHERE name LIKE '%mon';

SELECT * FROM animals;

UPDATE animals 
SET species = 'pokemon' WHERE species IS NULL;

SELECT * FROM animals;

/* Commit the transaction */
COMMIT;
SELECT * FROM animals;

/* Start transaction */

BEGIN;
/* Delete a transaction */
DELETE FROM animals;
/* Return to previuse state of transation */
ROLLBACK;
SELECT * FROM animals;

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

/* CREATE A SAVEPOINT FOR WEIGHT_KG COLUMN */

SAVEPOINT weight_kg;

UPDATE animals
SET weight_kg = weight_kg * -1;
SELECT * FROM animals;

/* Return back to savepoint */
ROLLBACK TO weight_kg;
SELECT * FROM animals;

UPDATE animals
SET weight_kg = weight_kg * -1 
WHERE weight_kg < 0;
SELECT * FROM animals;

/* Commit the transaction */
COMMIT;
SELECT * FROM animals;

/* COUNT NUMBER OF ANIMALS */
SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species; 

SELECT * FROM animals;

SELECT animals.name 
FROM animals JOIN owners 
ON animals.owners_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.id
FROM animals JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT  owners.full_name, animals.name
FROM owners FULL JOIN animals
ON animals.owners_id = owners.id;

SELECT COUNT(animals.name), species.name 
FROM animals
JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name FROM animals
LEFT JOIN owners ON owners.id = animals.owners_id
LEFT JOIN species ON species.id = animals.species_id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT * FROM animals
FULL JOIN owners ON owners.id = animals.owners_id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT owner FROM (
  SELECT COUNT(animals.name) as count, full_name as owner FROM animals
  JOIN owners ON owners.id = animals.owners_id
  GROUP BY owner
) AS animals_per_owner
WHERE count = (SELECT MAX(count) FROM (
  SELECT COUNT(animals.name) as count, full_name as owner FROM animals
  JOIN owners ON owners.id = animals.owners_id
  GROUP BY owner
) AS animals_per_owner);