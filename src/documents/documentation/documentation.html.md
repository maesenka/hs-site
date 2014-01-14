```
title: Documentation
menuTitle: Documentation
isMain: true
isNav: true
layout: default
pageOrder: 2
tags: ['intro','page']
```

# Quick Start

This guide applies to the current version of Hibernate Spatial (4.0). For older versions, Check out the [Tutorial for Hibernate Spatial 1](02-Tutorial/02-tutorial1).

You will need to have the following libraries in your classpath: hibernate, a JDBC driver and hibernate-spatial.jar, plus all transitive dependencies.

Geographic objects (or features) are characterized by having a geometry attribute: an attribute that describes the location and geometry of the object by means of a set of coordinates. Hibernate Spatial uses the Geometry package of the [Java Topology Suite](http://tsusiatsoftware.net/jts/main.html) to represent the geometries in Java.

If you are using maven you should first add the Hibernate Spatial and GeoTools repositories to you pom.xml

        ...
        <repositories>
                <repository>
                        <id>OSGEO GeoTools repo</id>
                        <url>http://download.osgeo.org/webdav/geotools</url>
                </repository>
                <repository>
                        <id>Hibernate Spatial repo</id>
                        <url>http://www.hibernatespatial.org/repository</url>
                </repository>

        </repositories>
        ...

            
And then add Hibernate Spatial as a dependency.
        
        ...
        <dependencies>
                ...
                <dependency>
                        <groupId>org.hibernate</groupId>
                        <artifactId>hibernate-spatial</artifactId>
                        <version>4.0</version>
                </dependency>
                ...
        </dependencies>
        ...
           

### Configuring a spatial dialect

If you want to use the geographic data support, you will need to configure Hibernate with the appropriate Spatial Dialect. For example, to use the postgis spatial data support in Postgresql, you need to add the following line in your hibernate.cfg.xml.

        ...
        <property name="hibernate.dialect">org.hibernate.spatial.dialect.postgis.PostgisDialect</property>
        ...
            
The property value is here the class name of the dialect that extends the Hibernate Postgresql dialect to include support for spatial data.

### Mapping Geometries

Geographic objects can now be represented in Java by means of POJO's that have a Geometry-valued property. Since we use the Java Topology Suite to represent geometries, this looks like:

        import com.vividsolutions.jts.geom.Geometry;
        ...
        public Class SomeGeographicClass {
        ...
        private Geometry geometry;
        ...
        public Geometry getGeometry(){
                return this.geom;
        }

        public void setGeometry(Geometry geometry){
                this.geometry = geometry;
        }
        ...
        }
            
The geometry property can be mapped by Hibernate by means of the special type org.hibernatespatial.GeometryUserType, like this

        ...
        <property name="geometry" type="org.hibernate.spatial.GeometryType">
                <column name="geom" />
        </property>
        ...
            
Working with geographic data (geometry-valued properties) is now exactly the same as working with any other Hibernate-supported type.

For more information, see the [Tutorial for Hibernate Spatial 4](/documentation/02-Tutorial/01-tutorial4).
 
