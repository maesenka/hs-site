```
menuTitle: MySQL
Title: MySQL Usage Notes
isNav: true
```

There are several dialects for MySQL:
* `MySQLSpatialDialect`: a spatially-extended version of Hibernate's `MySQLDialect`
* `MySQLSpatialInnoDBDialect`: a spatially-extended version of Hibernate's `MySQLInnoDBDialect`
* `MySQLSpatial56Dialect`: a spatially-extended version of Hibernate's `MySQL5DBDialect`.
* `MySQLSpatial5InnoDBDialect`: the same as `MySQLSpatial56Dialect`, but with support for the InnoDB storage engine. 

Note that MySQL versions before 5.6.1 had only limited support for spatial operators. Most operators only took account of the mimimum bounding rectangles (MBR's) of the geometries, and not the geometries themselves. This changed in version 5.6.1 were MySQL introduced ST_* spatial operators. The dialects `MySQLSpatial56Dialect` and `MySQLSpatial5InnoDBDialect` use these newer, more precise operators. These dialects may therefore produce results that differ from that of the other spatial dialects. For  more information see [this page in the MySQL reference guide (esp. the section '12.18.5.4.2. Functions That Test Spatial Relationships Between Geometries')](http://dev.mysql.com/doc/refman/5.6/en/functions-for-testing-spatial-relations-between-geometric-objects.html)