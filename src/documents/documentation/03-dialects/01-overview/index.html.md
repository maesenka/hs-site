```
menuTitle: Dialect Overview
Title: Available Dialects
isNav: true
tags: ['tutorial', 'documentation']
```



See the Dialect specific pages for usage notes.

# Features

Hibernate Spatial uses the Java Topology Suite (JTS) as its geometry model. JTS is an implementation of the OpenGIS Simple Features Implementation Specification for SQLv. 1.1 (SFS). This specification is implemented in most RDBMS with spatial data support. It is also a direct precursor to a precursor to SQL/MM Part 3: Spatial (ISO/IEC 13249-3).

The SFS specification defines a set of functions on geometries. Hibernate Spatial makes a subset of these functions available in HQL and in the criteria query API (see the SpatialRestrictions class in the org.hibernatespatial.criterion package).

Not all databases support all the functions defined by Hibernate Spatial. The table below provides an overview of the functions provided by each database

<table align="center" border="1" class="bodyTable">
                <thead>
                    <tr class="a">
                        <th align="left">Function</th><th align="left">Description</th><th align="left">Postgresql</th><th align="left">Oracle 10g/11g</th><th align="left">MySQL</th><th align="left">SQLServer</th><th align="left">GeoDB (H2)</th>
                    </tr>
                    <tr class="b">
                        <th align="left" colspan="7">Basic functions on Geometry</th>
                    </tr>
                </thead>
                <tbody><tr class="a">
                    <td align="left">int dimension(Geometry)</td><td align="left">SFS §2.1.1.1 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td>
                </tr>
                <tr class="b">
                    <td align="left">String geometrytype(Geometry)</td><td align="left">SFS §2.1.1.1 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="a">
                    <td align="left">int srid(Geometry) </td><td align="left">SFS §2.1.1.1 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="b">
                    <td align="left">Geometry envelope(Geometry)</td><td align="left">SFS §2.1.1.1 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="a">
                    <td align="left">String astext(Geometry)</td><td align="left">SFS §2.1.1.1 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="b">
                    <td align="left">byte[] asbinary(Geometry)</td><td align="left">SFS §2.1.1.1 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="a">
                    <td align="left">boolean isempty(Geometry)</td><td align="left">SFS §2.1.1.1 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="b">
                    <td align="left">boolean issimple(Geometry)</td><td align="left">SFS §2.1.1.1 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="a">
                    <td align="left">Geometry boundary(Geometry)</td><td align="left">SFS §2.1.1.1 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td>
                </tr>
                <tr class="b">
                        <th align="left" colspan="7">Functions for testing Spatial Relations between geometric objects</th>
                </tr>
                <tr class="a">
                    <td align="left">boolean equals(Geometry, Geometry)</td><td align="left">SFS §2.1.1.2 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="b">
                    <td align="left">boolean disjoint(Geometry, Geometry)</td><td align="left">SFS §2.1.1.2 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="a">
                    <td align="left">boolean intersects(Geometry, Geometry)</td><td align="left">SFS §2.1.1.2 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="b">
                    <td align="left">boolean touches(Geometry, Geometry)</td><td align="left">SFS §2.1.1.2 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="a">
                    <td align="left">boolean crosses(Geometry, Geometry)</td><td align="left">SFS §2.1.1.2 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="b">
                    <td align="left">boolean within(Geometry, Geometry)</td><td align="left">SFS §2.1.1.2 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="a">
                    <td align="left">boolean contains(Geometry, Geometry)</td><td align="left">SFS §2.1.1.2 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="b">
                    <td align="left">boolean overlaps(Geometry, Geometry)</td><td align="left">SFS §2.1.1.2 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="a">
                    <td align="left">boolean relate(Geometry, Geometry, String) </td><td align="left">SFS §2.1.1.2 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td>
                </tr>
                <tr class="b">
                        <th align="left" colspan="7">Functions that support Spatial Analysis</th>
                </tr>
                <tr class="a">
                    <td align="left">double distance(Geometry, Geometry)</td><td align="left">SFS §2.1.1.3 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td>
                </tr>
                <tr class="b">
                    <td align="left">Geometry buffer(Geometry, double)</td><td align="left">SFS §2.1.1.3 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="a">
                    <td align="left">Geometry convexhull(Geometry)</td><td align="left">SFS §2.1.1.3 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td>
                </tr>
                <tr class="b">
                    <td align="left">Geometry intersection(Geometry, Geometry)</td><td align="left">SFS §2.1.1.3 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td>
                </tr>
                <tr class="a">
                    <td align="left">Geometry geomunion(Geometry, Geometry)</td><td align="left">SFS §2.1.1.3 (renamed from union)</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td>
                </tr>
                <tr class="b">
                    <td align="left">Geometry difference(Geometry, Geometry)</td><td align="left">SFS §2.1.1.3 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td>
                </tr>
                <tr class="a">
                    <td align="left">Geometry symdifference(Geometry, Geometry)</td><td align="left">SFS §2.1.1.3 </td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td>
                </tr>
                <tr class="b">
                        <th align="left" colspan="7">Common non-SFS functions</th>
                </tr>
                <tr class="a">
                    <td align="left">boolean dwithin(Geometry, Geometry, double)</td><td align="left">Returns true if the geometries are within the specified distance of one another</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td>
                </tr>
                <tr class="b">
                    <td align="left">Geometry transform(Geometry, int)</td><td align="left">Returns a new geometry with its coordinates transformed to the SRID referenced by the integer parameter</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td>
                 </tr>
                <tr class="a">
                        <th align="left" colspan="7">Spatial aggregate Functions</th>
                </tr>
                <tr class="b">
                    <td align="left">Geometry extent(Geometry)</td><td align="left">Returns a bounding box that bounds the set of returned geometries</td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-ok-sign"></span></td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td><td align="center"><span class="glyphicon glyphicon-minus-sign"></span>
               	</td>
                 </tr>
            </tbody></table>