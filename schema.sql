/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id               INT GENERATED ALWAYS AS IDENTITY,
  name             VARCHAR(250) NOT NULL,
  date_of_birth    DATE NOT NULL,
  escape_attempts  INT NOT NULL,
  neutered         BOOLEAN NOT NULL,
  weight_kg        DECIMAL NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE owners (
  id              SERIAL NOT NULL,
  full_name       VARCHAR(250) NOT NULL,
  age             INT NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE species (
  id             SERIAL NOT NULL,
  name           VARCHAR(250) NOT NULL,
  PRIMARY KEY(id)
);

-- Modify animals table:
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT, 
ADD FOREIGN KEY(species_id) REFERENCES species(id);


ALTER TABLE animals ADD COLUMN owners_id INT, 
ADD FOREIGN KEY(owners_id) REFERENCES owners(id);

-- Create a table named vets with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
-- age: integer
-- date_of_graduation: date
CREATE TABLE vets (
  id                 SERIAL NOT NULL,
  name               VARCHAR(250),
  age                INT,
  date_of_graduation DATE,
  PRIMARY KEY(id)
);

-- There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship.
CREATE TABLE specializations (
  vets_id INT REFERENCES vets(id),
  species_id INT REFERENCES species(id)
);

-- There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.
CREATE TABLE visits (
  vets_id INT REFERENCES vets(id),
  animal_id INT REFERENCES animals(id),
  date_of_visits  DATE
);


