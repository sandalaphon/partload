
DROP TABLE IF EXISTS detours;
DROP TABLE IF EXISTS trucks;
DROP TABLE IF EXISTS partloads;


CREATE TABLE trucks (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  depot_x INT4,
  depot_y INT4,
  capacity INT4,
  anchor_volume INT4,
  collection_date TIMESTAMP,
  delivery_date TIMESTAMP,
  collect_x INT4,
  collect_y INT4,
  deliver_x INT4,
  deliver_y INT4,
  has_part_load BOOLEAN DEFAULT FALSE
);

CREATE TABLE partloads (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  pvolume INT4,
  pcollect_x INT4,
  pcollect_y INT4,
  pdeliver_x INT4,
  pdeliver_y INT4,
  allocated BOOLEAN DEFAULT FALSE,
  flex BOOLEAN DEFAULT TRUE
);

CREATE TABLE detours (
  id SERIAL4 PRIMARY KEY,
  partload_id INT4 REFERENCES partloads(id),
  truck_id INT4 REFERENCES trucks(id),
  detour_distance INT4,
  detour_type VARCHAR(255),
  detour_time INT4
)



