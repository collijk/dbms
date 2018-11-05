import csv
import sqlite3


def generate_magicians():
    with open('raw_data/magicians.csv', 'r') as f:
        magician_list = list(csv.reader(f, delimiter='\t'))
    return magician_list

def generate_teams():
    return [
    ('Hermetic Order of the Golden Dawn', 1887),
    ('Ordo Templi Orientis', 1895),
    ('Ordo Aurum Solis', 1897),
    ('Builders of Adytum', 1922),
    ('Servants of the Light', 1978),
    ('Gryffindor', 984),
    ('Hufflepuff', 984),
    ('Slytherin', 984),
    ('Ravenclaw', 984),
    ]

if __name__ == "__main__":
    db_connection = sqlite3.connect('magic.db')
    c = db_connection.cursor()

    for stage_name, name in generate_magicians():
        update = f"""
        INSERT INTO magician (stage_name, name)
        VALUES
          ("{stage_name}", "{name}");
        """
        c.execute(update)

    for name, year_founded in generate_teams():
        update = f"""
        INSERT INTO team (team_name, established)
        VALUES
          ("{name}", "{year_founded}");
        """
        c.execute(update)

    db_connection.commit()
