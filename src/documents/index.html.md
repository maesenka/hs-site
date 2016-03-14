```
title: Overview
menuTitle: Overview
isMain: true
showH5Jumbo: true
layout: no-sidebar
pageOrder: 1
tags: ['intro','page']
```

            
Hibernate Spatial is a generic extension to Hibernate for handling geographic data. Hibernate Spatial is open source and licensed, like Hibernate, under the LGPL license.

Hibernate Spatial allows you to deal with geographic data in a standardized way. It abstracts away from the specific way your database supports geographic data, and provides a standardized, cross-database interface to geographic data storage and query functions.

Hibernate Spatial supports most of the functions of the OGC Simple Feature Specification. Supporteddatabases are: Oracle 10g/11g, Postgresql/Postgis, MySQL, Microsoft SQL Server and H2/GeoDB.

There is a similar project for NHibernate: [NHibernate.Spatial](http://nhforge.org/wikis/spatial/default.aspx)


# Compatibility with Hibernate ORM

* Hibernate Spatial version 4.3 is compatible with Hibernate 4.3.x only
* Hibernate Spatial version 4.0 is compatible with Hibernate 4.x only
* Hibernate Spatial version 1.1.x is compatible with Hibernate 3.6.x
* Hibernate Spatial version 1.0 is compatible with Hibernate 3.2.x - 3.5.x

# Features

Hibernate Spatial uses the [Java Topology Suite (JTS)](http://tsusiatsoftware.net/jts/main.html) as its geometry model. JTS is an implementation of the OpenGIS Simple Features Implementation Specification for SQLv. 1.1 (SFS). This specification is implemented in most RDBMS with spatial data support. It is also a direct precursor to a precursor to SQL/MM Part 3: Spatial (ISO/IEC 13249-3).

The SFS specification defines a set of functions on geometries. Hibernate Spatial makes a subset of these functions available in HQL and in the criteria query API (see the [`SpatialRestrictions`](/javadoc/4.0/index.html) class in the org.hibernatespatial.criterion package).

Not all databases support all the functions defined by Hibernate Spatial. The [Spatial Dialect Overview page](/documentation/03-dialects/01-overview) has a table that provides an overview of the available HQL functions, and what databases support them.

# Getting started

There is a [Quick Start guide](/documentation/documentation) and a more comprehensive [Tutorial](/documentation/02-Tutorial/01-tutorial4) to help you get started. 

# Hibernate Spatial moving to Hibernate ORM

We are currently working on migrating Hibernate Spatial to a module of the Hibernate ORM project. The move will be complete by the time of the Hibernate 5 release.

The Hibernate Spatial Release 4 will be therefore be the last release that is made independently of Hibernate.

We decided to base the release for Hibernate 4 on the new code for Hibernate 5. This code is quite differently organised as the code for Hibernate spatial 1.x. The most visible differences are:

* package org.hibernatespatial is now org.hibernate.spatial
* only one jar needed: all dialects are now included in the base package
* GeometryUserType is replaced by GeometryType



