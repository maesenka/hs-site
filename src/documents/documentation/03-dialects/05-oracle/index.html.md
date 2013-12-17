```
menuTitle: Oracle
Title: Oracle10g/11g Usage Notes
isNav: true
```
There is currently only one Oracle spatial dialect: `OracleSpatial10gDialect` which extends the Hibernate dialect `Oracle10gDialect`. This dialect has been tested on both Oracle 10g and Oracle 11g with the SDO_GEOMETRY spatial database type.

This dialect is the only dialect that can be configured using these Hibernate properties:
* `hibernate.spatial.connection_finder` : the fully-qualified classname for the Connection finder for this Dialect (see below).
* `hibernate.spatial.ogc_strict`: true to use the OGC-compliant functions on SDO_GEOMETRY (see below)

## The ConnectionFinder Interface

The SDOGeometryType requires access to an `OracleConnection` object when converting a geometry to SDO_GEOMETRY. In some environments, however, the `OracleConnection` is not available (e.g. because a J2EE container or connection pool proxy or wrap the connection object in its own Connection implementation). A `ConnectionFinder` knows how to retrieve the OracleConnection from the wrapper or proxy Connection object that is passed into prepared statements.

The default implementation will, when the passed object is not already an `OracleConnection`, attempt to retrieve the OracleConnection by recursive reflection. It will search for methods that return Connection objects, execute these methods and check the result. If the result is of type OracleConnection the object is returned, otherwise it recurses on it. In may cases this strategy will suffice. If not, you can provide your own implementation of this interface on the class path, and configure it in the `hibernate.spatial.connection_finder` property. Note that implementations must be thread-safe and have a default no-args constructor.
                
## OGC Compliance Setting

The Oracle Spatial dialect can be configured to run in either OGC strict or non-strict mode. In OGC strict mode, the Open Geospatial compliant functions of Oracle Spatial are used in spatial operations (they exists in Oracle 10g, but are not documented). In non-strict mode the usual Oracle Spatial functions are used directly, and mimic the OGC semantics.The default is OGC strict mode. You can change this to non-strict mode by setting the `hibernate.spatial.ogc_strict` property to false.
                
Note that changing from strict to non-strict mode changes the semantics of the spatial operation. We have attempted to implement the OGC semantics as well we could using the standard Oracle Spatial operators, but this was not possible in all cases. On the plus side, non-strict mode should be faster in most cases.
