# Capstone project
Leticia Lee       
Geraldine Klarenberg        
Amanda Schwantes       

## Research project

Could waveform LiDAR give us extra information on vegetation structure, specifically understory and/or complexity, compared to discrete LiDAR?
(differentiate different types of trees?) 

Pick 2/3 sites at Ordway Swisher – maybe with understory.
Get waveform LiDAR and discrete LiDAR that covers those 2/3 sites.
Find locations of trees in the vegetation structure file?

-	Got the shapefiles for the distributed plots: vegetation structure
-	Shapefile for flightlines
-	Location 6, 11

|   | Easting   | Northing   | Lat       | lon        |  
|---|-----------|------------|-----------|------------|
|6  | 404893.06 | 3284464    | 29.686609 | -81.983    |
|11 | 404534.98 | 3288334.43 | 29.721507 | -81.987042 |

Bottom left = naming for tifs etc

Process one flightline: find a few plots that are in the same flightline. Flightline 14.

For the whole flightline, process the signals and get 3d coordinates that we can plot as a pointcloud – filter for a few locations.

Discrete LiDAR: 
tile 404000_3284000 for 6              
tile 404000_3288000 for 11
