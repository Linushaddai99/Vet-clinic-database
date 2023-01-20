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