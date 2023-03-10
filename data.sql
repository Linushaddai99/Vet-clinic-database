/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES 
('Agumon', '2022-02-03', 0, 'TRUE', 10.23),
('Gabumon', '2018-11-15', 2, 'TRUE', 8),
('Pikachu', '2021-01-07', 1, 'FALSE', 15.04),
('Devimon', '2017-05-12', 5, 'TRUE', 11)
('Charmander', '2022-02-08', 0, 'FALSE', -11),
('Plantmon', '2021-11-15', 2, 'TRUE', -5.7),
('Squirtle', '1993-04-02', 3, 'FALSE', -12.13),
('Angemon', '2005-06-12', 1, 'TRUE', -45),
('Boarmon', '2005-06-07', 7, 'TRUE', 20.4),
('Blossom', '1998-08-13', 3, 'TRUE', 17),
('Ditto', '2022-05-14', 4, 'TRUE', 22);

INSERT INTO owners (full_name, age)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES
('Pokemon'),
('Digimon');

UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';

UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

UPDATE animals SET owners_id = 1
WHERE name = 'Agumon';

UPDATE animals SET owners_id = 2
WHERE name = 'Gabumon';

UPDATE animals SET owners_id = 2
WHERE name = 'Pikachu';

UPDATE animals SET owners_id = 3
WHERE name = 'Devimon';

UPDATE animals SET owners_id = 3
WHERE name = 'Plantmon';

UPDATE animals SET owners_id = 4
WHERE name = 'Charmander';

UPDATE animals SET owners_id = 4
WHERE name = 'Squirtle';

UPDATE animals SET owners_id = 4
WHERE name = 'Blossom';

UPDATE animals SET owners_id = 5
WHERE name IN ('Boarmon', 'Angemon');


-- Insert the following data for vets:
-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
INSERT INTO vets (name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
(' Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

-- Insert the following data for specialties:
-- Vet William Tatcher is specialized in Pokemon.
-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
-- Vet Jack Harkness is specialized in Digimon.
INSERT INTO specializations (vets_id, species_id) VALUES 
(1, 1),
(2, 2),
(3, 1),
(4, 2);

-- Insert the following data for visits
-- Agumon visited William Tatcher on May 24th, 2020. 
-- Agumon visited Stephanie Mendez on Jul 22th, 2020. 
-- Gabumon visited Jack Harkness on Feb 2nd, 2021. 
-- Pikachu visited Maisy Smith on Jan 5th, 2020. 
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
-- Pikachu visited Maisy Smith on May 14th, 2020.
-- Devimon visited Stephanie Mendez on May 4th, 2021.
-- Charmander visited Jack Harkness on Feb 24th, 2021.
-- Plantmon visited Maisy Smith on Dec 21st, 2019. 
-- Plantmon visited William Tatcher on Aug 10th, 2020. 
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019. 
-- Angemon visited Jack Harkness on Oct 3rd, 2020. 
-- Angemon visited Jack Harkness on Nov 4th, 2020. 
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
-- Boarmon visited Maisy Smith on May 15th, 2019.
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
-- Boarmon visited Maisy Smith on Aug 3rd, 2020. 
-- Blossom visited Stephanie Mendez on May 24th, 2020.
-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits (animal_id, vets_id, date_of_visits) VALUES
(12, 1, '2020-05-24'),
(12, 3, '2020-07-22'),
(2, 4, '2021-02-02'),
(3, 2, '2020-01-05'),
(3, 2, '2020-03-08'),
(3, 2, '2020-05-14'),
(4, 3, '2021-05-04'),
(13, 4, '2021-02-14'),
(6, 2, '2019-12-21'),
(6, 1, '2020-08-10'),
(6, 2, '2021-04-21'),
(7, 3, '2019-09-29'),
(8, 4, '2020-10-03'),
(8, 4, '2020-11-04'),
(9, 2, '2019-01-24'), 
(9, 2, '2019-05-15'),
(9, 2, '2020-02-27'),
(9, 2, '2020-08-03'),
(10, 3, '2020-05-24'),
(10, 1, '2021-01-11');