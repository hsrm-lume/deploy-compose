MERGE (b:User { uuid: "$ROOT_UUID", litTime: $ROOT_LITTIME, lat: $ROOT_LAT, lng: $ROOT_LNG });
CREATE CONSTRAINT uuid_unique FOR (u:User) REQUIRE u.uuid IS UNIQUE;

CREATE USER readonly IF NOT EXISTS SET PASSWORD 'well-known' CHANGE NOT REQUIRED;
CREATE USER readwrite IF NOT EXISTS SET PASSWORD '$NEO4J_RW_PASSWORD' CHANGE NOT REQUIRED;

GRANT ROLE reader TO readonly;
GRANT ROLE publisher TO readwrite;

ALTER CURRENT USER SET PASSWORD FROM 'changeme' TO '$NEO4J_ADMIN_PASSWORD'
