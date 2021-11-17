from _util import Point, Tree, iso_to_date

## Helper points to define tree roots
cBuilding = dict(lat=  50.096928, lng=   8.216829)
bBuilding = dict(lat=  50.096098, lng=   8.216001)
mainz     = dict(lat=  49.992863, lng=   8.247253)
berlin    = dict(lat=  52.516295, lng=  13.378150)
newyork   = dict(lat=  40.730610, lng= -73.935242)
sydney    = dict(lat= -33.867487, lng= 151.206990)

## DEFINE MOCK TREES BELOW

Tree(
    Point(
        50.09692895957101,
        8.21682929992676,
        iso_to_date("2021-01-01"),
        "00000000-0000-4000-A000-000000000000"
    )
).randomize(10).save()

print("ok")
