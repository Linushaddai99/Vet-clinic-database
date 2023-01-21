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


-- Write queries to answer the following:

-- Who was the last animal seen by William Tatcher?
SELECT a.name, a.species_id, v.date_of_visits FROM animals a 
JOIN visits v ON a.id = v.animal_id
JOIN vets ve ON v.vets_id = ve.id
WHERE ve.name = 'William Tatcher'
ORDER BY v.date_of_visits DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animal_id) FROM visits WHERE vets_id = 3;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id WHERE visits.vets_id = 3 AND visits.date_of_visits BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
select animal_id, count(*) from visits group by animal_id order by count(animal_id) desc limit 1;

-- Who was Maisy Smith's first visit?
SELECT vets.name FROM vets JOIN visits ON vets.id = visits.vets_id WHERE visits.animal_id = 2 ORDER BY visits.date_of_visits LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, vets.name, visits.date_of_visits FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vets_id = vets.id ORDER BY visits.date_of_visits DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.animal_id) FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vets_id = vets.id LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON specializations.species_id = species.id WHERE species.id != animals.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species_id from animals where id = (select animal_id from visits where vets_id = 2 group by animal_id order by count(animal_id) desc limit 1);