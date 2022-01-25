# lume Deployment

This is a small guide how to deploy lume-Stack on worker nodes with docker-compose.

The following containers are included in the backend deployment:

| Name                                                         | Description                                                                                        |
| ------------------------------------------------------------ | -------------------------------------------------------------------------------------------------- |
| [REST-API](https://github.com/hsrm-lume/lume-rest-api)       | Accepts app-reportings of new flame passings (tree nodes) and inserts them into the neo4j database |
| [Neo4j](https://hub.docker.com/_/neo4j?tab=description)      | Graph database to store the path of the fire                                                       |
| [Mapview](https://github.com/hsrm-lume/angular-map-frontend) | Angular MapView to show the graph on a map                                                         |
| [Maptiler](https://github.com/hsrm-lume/maptiler-serverf)    | Tiles-Service for the angular app                                                                  |

Remark: The lume-app is not part of this deployment, because the app download link is hosted by github releases.  
For more on this see [the releases section of the app repository](https://github.com/hsrm-lume/react-native-cli-lume/releases) and [the corresponding github-action](https://github.com/hsrm-lume/react-native-cli-lume/actions/workflows/build-android.yml).

## Installation

To prepare your worker node for serving the lume backend stack,
first run the installation script `./install.sh` (only on first time setting up the worker).

## Start services

This guide shows, how to configure and start the services

1. Edit Config [`config.sh`](config.sh)
2. Load Config in env variables: `source config.sh`
3. Run Docker-Compose: `docker-compose up [-d]`
4. Initialize Database (only on first start / fresh installation):
   1. Check for syntactical correctness: `envsubst < seed.cql | less`
   2. Apply Configuration with:  
      `envsubst < seed.cql | docker exec -i neo4j cypher-shell -u neo4j -p changeme --format plain`  
      This substitutes the config variables in the seed file and sends it to the database. Can only be called once because neo4j user's password gets changed.

## Updating services

If there is an update in one of the services, this services image first needs to be pushed to the [ghcr.io-Registry](https://github.com/orgs/hsrm-lume/packages).

As soon as the image is there, follow these steps to update the containers:

1. Shut down the services `docker-compose down`
2. Update all images used `docker-compose pull`
3. Start all services `docker-compose up -d`

---

## Connect via SSH with tunnel for http(s)

This section may be helpful if you have a runner with no direct internet connection.

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

## Mock Data

In case you need some sample data, the neo4j database can be seeded with the mock scipts in this repository.

1.  Create Randomize-Config in mock folder (see [`mock/template.py`](mock/template.py))
2.  Run Randomization: `python3 mock/<file>.py` (Api and Database need to be running for this to work)
