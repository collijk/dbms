/* Entities */

DROP TABLE  IF EXISTS magician;
DROP TABLE  IF EXISTS team;
DROP TABLE  IF EXISTS trick;
DROP TABLE  IF EXISTS duel;

CREATE TABLE magician(
  magician_id INT PRIMARY KEY,
  name TEXT NOT NULL,
  stage_name TEXT NOT NULL
);

CREATE TABLE team(
  team_name TEXT PRIMARY KEY,
  established DATE
);

CREATE TABLE trick(
  trick_id INT PRIMARY KEY,
  trick_name TEXT NOT NULL,
  points_awarded INT
);

CREATE TABLE duel(
  duel_id INT PRIMARY KEY,
  duel_date DATE NOT NULL,
  team_1 TEXT NOT NULL,
  team_2 TEXT NOT NULL,
  winner TEXT NOT NULL,
  points_team_1 INT,
  points_team_2 INT,
    FOREIGN KEY (winner) REFERENCES team(team_name),
    FOREIGN KEY (team_1) REFERENCES team(team_name),
    FOREIGN KEY (team_2) REFERENCES team(team_name),
    CHECK (team_1 != team_2),
    CHECK (winner = team_1 OR winner = team_2)
);

/* Relationships */

DROP TABLE IF EXISTS member_of;
DROP TABLE IF EXISTS featured_in;
DROP TABLE IF EXISTS flair;
DROP TABLE IF EXISTS flourish;
DROP TABLE IF EXISTS prestige;

CREATE TABLE member_of(
  magician_id INT,
  team_name TEXT,
  membership_start DATE,
  membership_end DATE,
    PRIMARY KEY (magician_id, team_name),
    FOREIGN KEY (magician_id) REFERENCES magician(magician_id),
    FOREIGN KEY (team_name) REFERENCES team(team_name)
);

CREATE TABLE featured_in(
  duel_id INT,
  trick_id INT,
  trick_number INT,
    PRIMARY KEY (duel_id, trick_id),
    FOREIGN KEY (duel_id) REFERENCES duel(duel_id),
    FOREIGN KEY (trick_id) REFERENCES trick(trick_id)
);

CREATE TABLE flair(
  trick_id INT,
  magician_id INT,
    PRIMARY KEY (trick_id, magician_id),
    FOREIGN KEY (trick_id) REFERENCES trick(trick_id),
    FOREIGN KEY (magician_id) REFERENCES magician(magician_id)
);

CREATE TABLE flourish(
  trick_id INT,
  magician_1_id INT,
  magician_2_id INT,
    PRIMARY KEY (trick_id, magician_1_id, magician_2_id),
    FOREIGN KEY (trick_id) REFERENCES trick(trick_id),
    FOREIGN KEY (magician_1_id) REFERENCES magician(magician_id),
    FOREIGN KEY (magician_2_id) REFERENCES magician(magician_id),
    CHECK (magician_1_id != magician_2_id)
);

CREATE TABLE prestige(
  trick_id INT,
  team_name TEXT,
    PRIMARY KEY (trick_id, team_name),
    FOREIGN KEY (trick_id) REFERENCES trick(trick_id),
    FOREIGN KEY (team_name) REFERENCES team(team_name)
);
