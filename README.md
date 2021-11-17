# LUME Deployment

This is a small guide how to deploy LUME-Stack with docker-compose.

## How to Deploy

1. Edit Config `config.sh`
2. Load Config in env variables: `source config.sh`
3. Run Docker-Compose: `docker-compose up [-d]`
4. Initialize Database (only after first start):
    1. Check for syntactical correctness: `envsubst < seed.cql | less`
    2. Apply Configuration with:  
    `envsubst < seed.cql | docker exec -i neo4j cypher-shell -u neo4j -p changeme --format plain`  
    This substitutes the config variables in the seed file and sends it to the database. Can only be called once because neo4j user's password gets changed.