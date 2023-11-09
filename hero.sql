CREATE DATABASE hero;
CREATE TABLE IF NOT EXISTS public.class
(
    class_id integer NOT NULL,
    class_name character varying(255) NOT NULL,
    class_description text,
    PRIMARY KEY (class_id)
);

CREATE TABLE IF NOT EXISTS public.item
(
    item_id integer NOT NULL,
    item_name character varying(255) NOT NULL,
    item_description text,
    item_type character varying(50),
    PRIMARY KEY (item_id)
);

CREATE TABLE IF NOT EXISTS public.hero
(
    hero_id integer NOT NULL,
    hero_name character varying(255) NOT NULL,
    class_id integer,
    is_active boolean,
    PRIMARY KEY (hero_id),
    FOREIGN KEY (class_id) REFERENCES class(class_id)
);

CREATE TABLE IF NOT EXISTS public.heroitem
(
    hero_item_id integer NOT NULL,
    hero_id integer,
    item_id integer,
    PRIMARY KEY (hero_item_id),
    FOREIGN KEY (hero_id) REFERENCES hero(hero_id),
    FOREIGN KEY (item_id) REFERENCES item(item_id)
);

CREATE TABLE IF NOT EXISTS public.player
(
    player_id integer NOT NULL,
    player_name character varying(255) NOT NULL,
    player_level integer,
    player_experience integer,
    hero_id integer,
    PRIMARY KEY (player_id),
    FOREIGN KEY (hero_id) REFERENCES hero(hero_id)
);

CREATE TABLE IF NOT EXISTS public.skills
(
    skill_id integer NOT NULL,
    skill_name character varying(255) NOT NULL,
    skill_description text,
    class_id integer,
    PRIMARY KEY (skill_id),
	FOREIGN KEY (class_id) REFERENCES class(class_id)
);

CREATE TABLE IF NOT EXISTS public.HeroItem 
(
    hero_item_id INT PRIMARY KEY,
    hero_id INT,
    item_id INT,
    FOREIGN KEY (hero_id) REFERENCES Hero(hero_id),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

--Select add column price 
ALTER TABLE public.item
ADD COLUMN item_price DECIMAL(10, 2);

-- Update hero 1 to inactive
UPDATE public.hero
SET is_active = false
WHERE hero_id = 1;

-- Delete the item associated with hero 1
DELETE FROM public.heroitem
WHERE hero_id = 1;

--Select active player
SELECT p.player_name, h.hero_name
FROM public.player p
INNER JOIN public.hero h ON p.hero_id = h.hero_id
WHERE h.is_active = true;

--Select avg player level per class
SELECT c.class_name, AVG(p.player_level) AS average_level
FROM public.class c
LEFT JOIN public.hero h ON c.class_id = h.class_id
LEFT JOIN public.player p ON h.hero_id = p.hero_id
GROUP BY c.class_name
ORDER BY average_level DESC;
