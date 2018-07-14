# Capstone project
Leticia Lee       
Geraldine Klarenberg        
Amanda Schwantes       

## Research question

Could waveform LiDAR give us extra information on vegetation structure, specifically understory and/or complexity, compared to discrete LiDAR?

We used waveform LiDAR data from a relocatable site in Puerto Rico: Rio Guilarte (GUIL).
This is an aquatic site - which is not ideal, since it wold be good to also have vegetation structure data from terrestrial.

It was difficult to access the coordinates of the waveform LiDAR data, as this would still involved accessing millions of data points, which would take too long.
We eventually accessed a random number of pulses, and determined the area it covered.

|       | Easting    | Northing   | Lat       | lon         |  
|-------|------------|------------|-----------|-------------|
|  min  |  733720    |  2011741   | 18.182115 | -66.790397  |
|  max  |  734414    |  2011846   | 18.182988 | -66.783828 |

We extracted x, y and z coordinates for all the pulse returns.

We also obtained the discrete LiDAR data for this trajectory, using LAStools to unzip, and FUSION to calculate a DTM.
We calculated forest density from the discrete LiDAR (vegetation > 1m).
