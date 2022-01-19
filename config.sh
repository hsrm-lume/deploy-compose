#!/bin/bash

## ============ PASSWORDS ============ ##
export NEO4J_RW_PASSWORD=secret # Neo4j Read & Write User
export NEO4J_ADMIN_PASSWORD=supersecret # Neo4j Admin User

## ============ CONFIG =============== ##
# Stage for REST-API
export STAGE=test # `prod`=production or `test`=allow custom date inputs
export ROOT_UUID=00000000-0000-4000-A000-000000000000 # uuid of root node
export ROOT_LITTIME=1609459200000 # time since root flame is burning
export ROOT_LAT=50.09692895957101 # Latitude  of root flame
export ROOT_LNG=8.21682929992676  # Longitude of root flame
export MBTILES_PATH=/path/to/map.mbtiles

## ============ PORTS ================ ##
export MAPVIEW_PORT=80      # has to match with vhost port in nginx-vhosts.conf
export API_PORT=3000        # has to match with vhost port in nginx-vhosts.conf
export TILESERVER_PORT=3001 # has to match with vhost port in nginx-vhosts.conf
export NEO4J_BROWSER_PORT=7474
export BOLT_PORT=7687
