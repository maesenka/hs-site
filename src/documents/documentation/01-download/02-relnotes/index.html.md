```
menuTitle: "Release Notes"
isNav: true
tags: []
```
## Release 4.0 (2013-12-13)

### Bug

* [HIBSPA-95](http://www.hibernatespatial.org/jira/browse/HIBSPA-95) - OGC_STRICT property in org.hibernate.spatial.oracle.OracleSpatial10gDialect.properties is not read/set.

### Improvement

* [HIBSPA-94](http://www.hibernatespatial.org/jira/browse/HIPBSP-94) - hibernate-spatial needs updating in order to work with hibernate4
* [HIBSPA-99](http://www.hibernatespatial.org/jira/browse/HIPBSP-99) - Support dwithin for Oracle dialect
* [HIBSPA-100](http://www.hibernatespatial.org/jira/browse/HIPBSP-100) - Connection-Finder should be configurable using hibernate properties
* [HIBSPA-101](http://www.hibernatespatial.org/jira/browse/HIPBSP-101) - Expand GeoDB supported functions
* [HIBSPA-102](http://www.hibernatespatial.org/jira/browse/HIPBSP-102) - MySQL 5.6 ST_CONTAINS support for hibernate spatial


## Release 1.1.1 (2011-1-27)

### Bug

* [HIBSPA-83](http://www.hibernatespatial.org/jira/browse/HIBSPA-83) - Divide-by-zero in getCoordinateAtM() method
* [HIBSPA-84](http://www.hibernatespatial.org/jira/browse/HIBSPA-84) - StackOverflowError during Circle.linearizeArc
* [HIBSPA-86](http://www.hibernatespatial.org/jira/browse/HIBSPA-86) - ClassCastException when saving geometries
* [HIBSPA-87](http://www.hibernatespatial.org/jira/browse/HIBSPA-87) - Exception using connection pool in Jboss 6.0 and Oracle 10g
* [HIBSPA-91](http://www.hibernatespatial.org/jira/browse/HIBSPA-91) - Can't convert object of type org.postgresql.util.PGobject - SpatialProjections.extent()

## Release 1.1 (2011-05-20)

### Bug

* [HIBSPA-52](http://www.hibernatespatial.org/jira/browse/HIBSPA-52) - import oracle.jdbc.driver.OracleConnection; need to change to import oracle.jdbc.OracleConnection;
* [HIBSPA-53](http://www.hibernatespatial.org/jira/browse/HIBSPA-53) - EventLocator doesn't properly copy SRID
* [HIBSPA-55](http://www.hibernatespatial.org/jira/browse/HIBSPA-55) - Hibernate Spatial does not retrieve SRID on empty collections
* [HIBSPA-56](http://www.hibernatespatial.org/jira/browse/HIBSPA-56) - Unit tests for MLineString fail
* [HIBSPA-58](http://www.hibernatespatial.org/jira/browse/HIBSPA-58) - SQLServer DialectProvider does not check correct dialect
* [HIBSPA-62](http://www.hibernatespatial.org/jira/browse/HIBSPA-62) - Schema information not taken into account by the automapper
* [HIBSPA-63](http://www.hibernatespatial.org/jira/browse/HIBSPA-63) - Automapper creates invalid mapping when primary key is defined on multiple columns
* [HIBSPA-65](http://www.hibernatespatial.org/jira/browse/HIBSPA-65) - AutoMapper throw NPE when a field type is not known
* [HIBSPA-68](http://www.hibernatespatial.org/jira/browse/HIBSPA-68) - Couldn't get at the OracleSpatial Connection object from the PreparedStatement.
* [HIBSPA-70](http://www.hibernatespatial.org/jira/browse/HIBSPA-70) - The 1.0 release is not compatible with Hibernate 3.6
* [HIBSPA-71](http://www.hibernatespatial.org/jira/browse/HIBSPA-71) - Trunk is not buildable
* [HIBSPA-73](http://www.hibernatespatial.org/jira/browse/HIBSPA-73) - DefaultConnectionFinder can't find the original OracleConnection when using pools

### Improvement

* [HIBSPA-57](http://www.hibernatespatial.org/jira/browse/HIBSPA-57) - Test tables should be empty after running unit tests
* [HIBSPA-60](http://www.hibernatespatial.org/jira/browse/HIBSPA-60) - The Automapper should expose metadata about the geometry- and id properties
* [HIBSPA-61](http://www.hibernatespatial.org/jira/browse/HIBSPA-61) - The AutoMapper should be able to handle cases where there are no primary keys defined on the table
* [HIBSPA-69](http://www.hibernatespatial.org/jira/browse/HIBSPA-69) - PostGIS spatial indices
* [HIBSPA-72](http://www.hibernatespatial.org/jira/browse/HIBSPA-72) - Move default dialect to conform to SQL/MM function name (Postgis 1.3 and later)
* [HIBSPA-74](http://www.hibernatespatial.org/jira/browse/HIBSPA-74) - Make org.hibernatespatial.postgis.PostgisDialect Serializable
* [HIBSPA-75](http://www.hibernatespatial.org/jira/browse/HIBSPA-75) - Remove Filter as a SpatialFunction
* [HIBSPA-80](http://www.hibernatespatial.org/jira/browse/HIBSPA-80) - SQL Server provider should accept blob geometries
* [HIBSPA-81](http://www.hibernatespatial.org/jira/browse/HIBSPA-81) - Change custom geometry types in SQL Server and Oracle provider dialects to protected static final to allow dialect extention

### New Feature

* [HIBSPA-6](http://www.hibernatespatial.org/jira/browse/HIBSPA-6) - New MySQLInnoDBSpatialDialect needed
* [HIBSPA-13](http://www.hibernatespatial.org/jira/browse/HIBSPA-13) - Create H2 spatial dialect
* [HIBSPA-49](http://www.hibernatespatial.org/jira/browse/HIBSPA-49) - Add Common methods to SpatialRestrictions/HQL
* [HIBSPA-66](http://www.hibernatespatial.org/jira/browse/HIBSPA-66) - Dialects should report which spatial functions they support

## Release 1.0 (2010-04-05)

### Bug

* [HIBSPA-25](http://www.hibernatespatial.org/jira/browse/HIBSPA-25) - Storing valid MultiPolygon with holes leads to invalid Geometry in Database
* [HIBSPA-26](http://www.hibernatespatial.org/jira/browse/HIBSPA-26) - Change warning message to info when no configuration file is found.
* [HIBSPA-29](http://www.hibernatespatial.org/jira/browse/HIBSPA-29) - Invalid connection exceptions in SDO_GEOMETRY class when using OCI driver
* [HIBSPA-31](http://www.hibernatespatial.org/jira/browse/HIBSPA-31) - String Geometry collection fails with ORA-29875: failed in the execution of the ODCIINDEXINSERT routine; ORA-13365: layer SRID does not match geometry SRID
* [HIBSPA-33](http://www.hibernatespatial.org/jira/browse/HIBSPA-33) - GeometryUserType implement Serializable
* [HIBSPA-34](http://www.hibernatespatial.org/jira/browse/HIBSPA-34) - SDOGeometryType and OracleSpatial10gDialect implement Serializable
* [HIBSPA-35](http://www.hibernatespatial.org/jira/browse/HIBSPA-35) - Nullpointer exception thrown by EventLocator
* [HIBSPA-36](http://www.hibernatespatial.org/jira/browse/HIBSPA-36) - EventLocator doesn't set SRID on result
* [HIBSPA-37](http://www.hibernatespatial.org/jira/browse/HIBSPA-37) - Parse Exception when trying to store empty geometries
* [HIBSPA-38](http://www.hibernatespatial.org/jira/browse/HIBSPA-38) - Thread-safety issue in WKBReader
* [HIBSPA-40](http://www.hibernatespatial.org/jira/browse/HIBSPA-40) - Change scope of database drives to provided in hibernate-spatial-* modules
* [HIBSPA-42](http://www.hibernatespatial.org/jira/browse/HIBSPA-42) - getMaxM() returns -Infinity on a valid MultiMLineString object
* [HIBSPA-43](http://www.hibernatespatial.org/jira/browse/HIBSPA-43) - documentation on parametrized type is incorrect
* [HIBSPA-45](http://www.hibernatespatial.org/jira/browse/HIBSPA-45) - NPE in GeometryUserType.java ; dialect not picked up
* [HIBSPA-51](http://www.hibernatespatial.org/jira/browse/HIBSPA-51) - Typo in GeometryType function

### Improvement

* [HIBSPA-5](http://www.hibernatespatial.org/jira/browse/HIBSPA-5) - Oracle provider generates slow SQL queries.
* [HIBSPA-17](http://www.hibernatespatial.org/jira/browse/HIBSPA-17) - Restructure unit testing framework
* [HIBSPA-20](http://www.hibernatespatial.org/jira/browse/HIBSPA-20) - Create source code artifacts for easy reference from IDEs
* [HIBSPA-27](http://www.hibernatespatial.org/jira/browse/HIBSPA-27) - Do not assume the JDBC Resultset contains oracle STRUCTS for geometry objects
* [HIBSPA-28](http://www.hibernatespatial.org/jira/browse/HIBSPA-28) - Switch to slf4j so HS uses same logging approach as Hibernate
* [HIBSPA-30](http://www.hibernatespatial.org/jira/browse/HIBSPA-30) - Dialect extends depracated dialect
* [HIBSPA-41](http://www.hibernatespatial.org/jira/browse/HIBSPA-41) - The repositories tag structure given at the link http://www.hibernatespatial.org/mavenquick.html has a bug.
* [HIBSPA-48](http://www.hibernatespatial.org/jira/browse/HIBSPA-48) - Better dependency management

### New Feature

* [HIBSPA-22](http://www.hibernatespatial.org/jira/browse/HIBSPA-22) - Hibernate Spatial needs to provide a Type object for the GeometryUserType class.
* [HIBSPA-44](http://www.hibernatespatial.org/jira/browse/HIBSPA-44) - Create provider for Sqlserver 2008 geometry type

## Task

* [HIBSPA-47](http://www.hibernatespatial.org/jira/browse/HIBSPA-47) - update all dependencies to latest stable version