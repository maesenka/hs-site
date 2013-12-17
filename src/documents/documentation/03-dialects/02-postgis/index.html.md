```
menuTitle: Postgresql/Postgis Dialects
Title: Postgis Usage Notes
isNav: true
```
* For Postgis from versions 1.3 and later, the best dialect to use is `org.hibernate.spatial.dialect.postgis.PostgisDialect`. This translates the HQL spatial functions to the Postgis SQL/MM-compliant functions.
* For older, pre v1.3 versions of Postgis, which are not SQL/MM compliant, the dialect `PostgisNoSQLMM` is provided.
* This dialect depends on the JDBC extensions in postgis.jar (see the [Postgis documentation](http://postgis.net/docs/postgis_installation.html#id336398)).
* Beware of classpath problems in a J2EE container where the JDBC drivers live in a different classpath than the Postgis JDBC extensions and/or Hibernate Spatial. For JBoss, some users found this post helpful: [https://gist.github.com/bjornharrtell/3054462](https://gist.github.com/bjornharrtell/3054462).
