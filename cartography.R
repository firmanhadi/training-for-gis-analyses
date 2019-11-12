library(sf)
library(cartography)
# path to the geopackage file embedded in cartography
path_to_gpkg <- system.file("gpkg/mtq.gpkg", package="cartography")
# import to an sf object
mtq <- st_read(dsn = path_to_gpkg, quiet = TRUE)
# download osm tiles
mtq.osm <- getTiles(
  x = mtq, 
  type = "osm", 
  zoom = 11, 
  crop = TRUE
)
## Data and map tiles sources:
## © OpenStreetMap contributors. Tiles style under CC BY-SA, www.openstreetmap.org/copyright.
# plot osm tiles
tilesLayer(x = mtq.osm)
# plot municipalities (only borders are plotted)
plot(st_geometry(mtq), col = NA, border = "grey", add=TRUE)
# plot population
propSymbolsLayer(
  x = mtq, 
  var = "POP", 
  inches = 0.4, 
  col = "brown4",
  legend.pos = "topright",  
  legend.title.txt = "Total population"
)
# layout
layoutLayer(title = "Population Distribution in Martinique",
            sources = "Sources: Insee and IGN, 2018\n© OpenStreetMap contributors.\nTiles style under CC BY-SA, www.openstreetmap.org/copyright.",
            author = paste0("cartography ", packageVersion("cartography")),
            frame = FALSE, north = FALSE, tabtitle = TRUE)
# north arrow
north(pos = "topleft")
