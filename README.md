# LUME Deployment

This is a small guide how to deploy LUME-Stack on cs.hs-rm VMs with docker-compose.

## Connect via SSH with tunnel for http(s)

- Save the id files in your .ssh directory
- add the id file to the ssh agent  
  or  
  create a ~/.ssh/config with:
  ```config
  Host *lume*
    User root
    IdentityFile <Absolute path to id_ed25519 file>
  ```
- establish a ssh connection with http proxy tunnel  
  Use guide [on Stackexchange](https://unix.stackexchange.com/a/490641)

## Installation

Run the installation script `./install.sh` (only on fresh install)

## Start services

1. Edit Config [`config.sh`](config.sh)
2. Load Config in env variables: `source config.sh`
3. Run Docker-Compose: `docker-compose up [-d]`
4. Initialize Database (only on first start / fresh installation):
    1. Check for syntactical correctness: `envsubst < seed.cql | less`
    2. Apply Configuration with:  
    `envsubst < seed.cql | docker exec -i neo4j cypher-shell -u neo4j -p changeme --format plain`  
    This substitutes the config variables in the seed file and sends it to the database. Can only be called once because neo4j user's password gets changed.
5. Optional: Mock data
    1. Create Randomize-Config in mock folder (see [`mock/template.py`](mock/template.py))
    2. Run Randomization: `python3 mock/<file>.py`



