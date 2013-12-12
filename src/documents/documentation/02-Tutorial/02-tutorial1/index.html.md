```
menuTitle: Tutorial (v1.x)
isNav: true
Title: Tutorial (Hibernate Spatial 1)
tags: ['tutorial', 'documentation']
```
This tutorial gives a quick overview of how to get Hibernate Spatial 1.x working. We will develop a simple application that stores, and retrieves some simple data objects. The data objects are "special" in that they have a property of type Geometry.

This tutorial assumes that you are familiar with Hibernate, and the basic concepts of working with geographic data. It is also based on the Hibernate Tutorialand uses the same example. If you haven't read the Hibernate Tutorial, and are new to Hibernate, then please read it before proceeding here.

The Hibernate Tutorial uses the H2 in-memory database. Although Hibernate Spatial supports GeoDB, the spatial extension of H2, we require a postgis database for this tutorial. For information on how to create a postgis database, you should consult the postgis documentation.

## Setup

We first need to set up our development environment. We will use the Maven build tool in this tutorial (as this is also used in the Hibernate Tutorial).

Maven can generate the basic structure of our simple application using themvn archetype:generate. For this example, we specify type (the default) and set groupId to org.hibernatespatial.tutorials, artifactId to event-tutorial and package toevent.

    mvn archetype:generate
    [INFO] Scanning for projects...
    [INFO] Searching repository for plugin with prefix: 'archetype'.
    [INFO] ------------------------------------------------------------------------
    [INFO] Building Maven Default Project
    [INFO] task-segment: [archetype:generate] (aggregator-style)
    [INFO] ------------------------------------------------------------------------
    [INFO] Preparing archetype:generate
    [INFO] No goals needed for project - skipping
    [INFO] Setting property: classpath.resource.loader.class =>
    'org.codehaus.plexus.velocity.ContextClassLoaderResourceLoader'.
    [INFO] Setting property: velocimacro.messages.on => 'false'.
    [INFO] Setting property: resource.loader => 'classpath'.
    [INFO] Setting property: resource.manager.logwhenfound => 'false'.
    [INFO] [archetype:generate {execution: default-cli}]
    Choose archetype:
    1: internal -> appfuse-basic-jsf (AppFuse archetype for creating a web application with Hibernate,

    ......

    36: internal -> wicket-archetype-quickstart (A simple Apache Wicket project)
    Choose a number:
    (1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36)
    15: :

    ......

    Define value for groupId: : org.hibernatespatial.tutorials
    Define value for artifactId: : event-tutorial
    Define value for version: 1.0-SNAPSHOT: :
    Define value for package: : event
    Confirm properties configuration:
    groupId: org.hibernatespatial.tutorials
    artifactId: event-tutorial
    version: 1.0-SNAPSHOT
    package: event
    Y: : Y

    ......


    http://repo1.maven.org/maven2/org/apache/maven/archetypes/maven-archetype-quickstart/1.0/maven-archetype-quickstart-1.0.jar
    [INFO] ----------------------------------------------------------------------------
    [INFO] Using following parameters for creating OldArchetype: maven-archetype-quickstart:1.0
    [INFO] ----------------------------------------------------------------------------
    [INFO] Parameter: groupId, Value: org.hibernatespatial.tutorials
    [INFO] Parameter: packageName, Value: event
    [INFO] Parameter: package, Value: event
    [INFO] Parameter: artifactId, Value: event-tutorial
    [INFO] Parameter: basedir, Value: /home/test
    [INFO] Parameter: version, Value: 1.0-SNAPSHOT
    [INFO] ********************* End of debug info from resources from generated POM
    ***********************
    [INFO] OldArchetype created in dir: /home/test/event-tutorial
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESSFUL
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time: 36 seconds
    [INFO] Finished at: Mon Apr 05 17:23:22 CEST 2010
    [INFO] Final Memory: 15M/158M
    [INFO] ------------------------------------------------------------------------


                
This results in the following directory structure.

 
    .
    |-- pom.xml
    `-- src
        |-- main
        |   |-- java
        |   |   |-- event
        |   |      `-- App.java
        `-- test
            `-- java
                `-- event

                
We now need to edit the pom to add the required dependencies and repositories (see also the Maven Quick Start.). The versions of the Postgis and Postgresql drivers don't matter too much. This tutorial should work with any version of the Postgis driver later than 1.3.3, and any Postgresql JDBC driver that agrees with your database.

                    
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
        <modelVersion>4.0.0</modelVersion>
        <groupId>org.hibernatespatial.tutorials</groupId>
        <artifactId>event-tutorial</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>event-tutorial</name>
        <url>http://maven.apache.org</url>

        <build>
             <!-- we dont want the version to be part of the generated war file name -->
             <finalName>${artifactId}</finalName>
             <plugins>
                   <plugin>
                        <artifactId>maven-compiler-plugin</artifactId>
                        <configuration>
                            <source>1.5</source>
                            <target>1.5</target>
                            <encoding>UTF-8</encoding>
                        </configuration>
                    </plugin>
             </plugins>
        </build>


        <dependencies>

            <!-- Hibernate Spatial for postgis. This will include Hibernate Spatial Core and JTS -->
            <dependency>
                <groupId>org.hibernatespatial</groupId>
                <artifactId>hibernate-spatial-postgis</artifactId>
                <version>1.1</version>
            </dependency>

            <!-- the Postgis JDBC driver -->
            <dependency>
                <groupId>org.postgis</groupId>
                <artifactId>postgis-jdbc</artifactId>
                <version>1.3.3</version>
            </dependency>

            <!-- the postgresql driver -->
            <dependency>
                <groupId>postgresql</groupId>
                <artifactId>postgresql</artifactId>
                <version>8.4-701.jdbc3</version>
            </dependency>

            <!-- Hibernate uses slf4j for logging, for our purposes here use the simple backend -->
                   <dependency>
                       <groupId>org.slf4j</groupId>
                       <artifactId>slf4j-simple</artifactId>
                       <version>1.5.11</version>
                   </dependency>

        </dependencies>


        <!-- add repositories for JTS and Hibernate Spatial and Hibernate (JBoss) -->
        <repositories>
            <repository>
                <id>OSGEO GeoTools repo</id>
                <url>http://download.osgeo.org/webdav/geotools</url>
            </repository>
            <repository>
                <id>Hibernate Spatial repo</id>
                <url>http://www.hibernatespatial.org/repository</url>
            </repository>
            <!-- add JBOSS repository for easy access to Hibernate libraries -->
            <repository>
                <id>JBOSS</id>
                <url>https://repository.jboss.org/nexus/content/repositories/releases/</url>
            </repository>
        </repositories>
    </project>

                
With the command mvn dependency:list we can see which libraries are required for our minimal Hibernate Spatial application.

    mvn dependency:list
    ....
    [INFO]    antlr:antlr:jar:2.7.6:compile
    [INFO]    com.vividsolutions:jts:jar:1.11:compile
    [INFO]    commons-collections:commons-collections:jar:3.1:compile
    [INFO]    dom4j:dom4j:jar:1.6.1:compile
    [INFO]    javassist:javassist:jar:3.11.0.GA:compile
    [INFO]    javax.transaction:jta:jar:1.1:compile
    [INFO]    org.hibernate:hibernate-commons-annotations:jar:3.2.0.Final:compile
    [INFO]    org.hibernate:hibernate-core:jar:3.6.0.Final:compile
    [INFO]    org.hibernate.javax.persistence:hibernate-jpa-2.0-api:jar:1.0.0.Final:compile
    [INFO]    org.hibernatespatial:hibernate-spatial:jar:1.1:compile
    [INFO]    org.hibernatespatial:hibernate-spatial-postgis:jar:1.1:compile
    [INFO]    org.postgis:postgis-jdbc:jar:1.3.3:compile
    [INFO]    org.postgis:postgis-stubs:jar:1.3.3:compile
    [INFO]    org.slf4j:slf4j-api:jar:1.5.11:compile
    [INFO]    org.slf4j:slf4j-simple:jar:1.5.11:compile
    [INFO]    postgresql:postgresql:jar:8.4-701.jdbc3:compile
    [INFO]    xerces:xercesImpl:jar:2.4.0:compile


                
Hibernate Spatial works with a wide range of versions of these libraries, so don't be too concerned if you see either more recent or slightly older versions.

## The Event Class

Our persistent class is the Event class. Since this class contains a geometry-valued property (a property of type Geometry), its instances are geographic objects, or features.

 
    package event;

    import java.util.Date;

    import com.vividsolutions.jts.geom.Point;

    public class Event {
        private Long id;
        private String title;
        private Date date;
        private Point location;

        public Event() {
        }

        public Long getId() {
            return id;
        }

        private void setId(Long id) {
            this.id = id;
        }

        public Date getDate() {
            return date;
        }

        public void setDate(Date date) {
            this.date = date;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public Point getLocation() {
            return this.location;
        }

        public void setLocation(Point location) {
            this.location = location;
        }
    }

                
We put this file in the ./src/main/java/event directory of the development directory.

## The Mapping file

To map this class to the database table, we create the following Hibernate Mapping file:

                    
    <!DOCTYPE hibernate-mapping PUBLIC "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
            "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">

    <hibernate-mapping package="event">
    	<class name="Event" table="EVENTS">

            <id name="id" column="EVENT_ID">
    			<generator class="native"/>
    		</id>

            <property name="date" type="timestamp" column="EVENT_DATE"/>

            <property name="title" type="string"/>

            <property name="location" type="org.hibernatespatial.GeometryUserType"  column="LOC"/>
    	</class>
    </hibernate-mapping>
	
                
Hibernate Spatial provides the GeometryUserType that enables Hibernate to store the location property properly.

We save this mapping file in ./src/main/resources/event/Event.hbm.xml along-side the java source file.

## The Hibernate Configuration

We proceed with the hibernate configuration file. The only difference w.r.t. normal Hibernate configurations files is in the dialect property. Hibernate Spatial extends the HibernateDialects so that the spatial features of the database are available within HQL and the SpatialCriteria (see below). So instead of using the (in our case) PostgreSQLDialect, we use Hibernate Spatial's extension of that dialect which is the PostGISDialect. Our hibernate.cfg.xml looks like this:

                        
    <?xml version='1.0' encoding='utf-8'?>
    <!DOCTYPE hibernate-configuration PUBLIC
            "-//Hibernate/Hibernate Configuration DTD 3.0//EN"
            "http://www.hibernate.org/dtd/hibernate-configuration-3.0.dtd">

    <hibernate-configuration>

        <session-factory>

            <!-- Database connection settings -->
            <property name="connection.driver_class">org.postgresql.Driver</property>
            <property name="connection.url">jdbc:postgresql://localhost:5432/events</property>
            <property name="connection.username">postgres</property>
            <property name="connection.password"></property>

            <!-- JDBC connection pool (use the built-in) -->
            <property name="connection.pool_size">1</property>

            <!-- SPATIAL SQL dialect -->
            <property name="dialect">org.hibernatespatial.postgis.PostgisDialect</property>

            <!-- Enable Hibernate's automatic session context management -->
            <property name="current_session_context_class">thread</property>

            <!-- Disable the second-level cache  -->
            <property name="cache.provider_class">org.hibernate.cache.NoCacheProvider</property>

            <!-- Echo all executed SQL to stdout -->
            <property name="show_sql">true</property>

            <!-- Drop and re-create the database schema on startup -->
            <property name="hbm2ddl.auto">create</property>

            <mapping resource="event/Event.hbm.xml"/>

        </session-factory>

    </hibernate-configuration>		


As is usual when building with maven, we store this file in the ./src/main/resources directory.
Note that this configuration file means that Hibernate will connect to the "events" database on localhost, with username "postgres" and no password. (on the test system used, postgres requires no password). You may need to change these values depending on your set-up.

Also notice that the "hbm2dll.auto" property is activated. This will re-create the database everytime the application is run (more precisely when the Hibernate SessionFactory is run).

## The HibernateUtil helper

The HibernatUtil class creates the Hibernate SessionFactory for the application, and provides a getter to it. (The code below is copied from the Hibernate Tutorial without change).

 
    package util;


    import org.hibernate.*;
    import org.hibernate.cfg.*;

    public class HibernateUtil {

        private static final SessionFactory sessionFactory;

        static {
            try {
                // Create the SessionFactory from hibernate.cfg.xml
                sessionFactory = new Configuration().configure().buildSessionFactory();
            } catch (Throwable ex) {
                // Make sure you log the exception, as it might be swallowed
                System.err.println("Initial SessionFactory creation failed." + ex);
                throw new ExceptionInInitializerError(ex);
            }
        }

        public static SessionFactory getSessionFactory() {
            return sessionFactory;
        }

    }


            
## The EventManager

We are now ready to write a first version of the main application classEventManager.


  
    package event;

    import org.hibernate.Session;

    import java.util.Date;

    import com.vividsolutions.jts.geom.Point;
    import com.vividsolutions.jts.geom.Geometry;
    import com.vividsolutions.jts.io.WKTReader;
    import com.vividsolutions.jts.io.ParseException;

    import util.HibernateUtil;

    public class EventManager {

        public static void main(String[] args) {
            EventManager mgr = new EventManager();

            if (args[0].equals("store")) {
                mgr.createAndStoreEvent("My Event", new Date(),  assemble(args));
            }

            HibernateUtil.getSessionFactory().close();
        }

        private void createAndStoreEvent(String title, Date theDate, String wktPoint) {

            //First interpret the WKT string to a point
            WKTReader fromText = new WKTReader();
            Geometry geom = null;
            try {
                geom = fromText.read(wktPoint);
            } catch (ParseException e) {
                throw new RuntimeException("Not a WKT string:" + wktPoint);
            }
            if (!geom.getGeometryType().equals("Point")) {
                throw new RuntimeException("Geometry must be a point. Got a " + geom.getGeometryType());
            }

            Session session = HibernateUtil.getSessionFactory().getCurrentSession();

            session.beginTransaction();

            Event theEvent = new Event();
            theEvent.setTitle(title);
            theEvent.setDate(theDate);
            theEvent.setLocation((Point) geom);
            session.save(theEvent);

            session.getTransaction().commit();
        }

        /**
        * Utility method to assemble all arguments save the first into a String
        */
        private static String assemble(String[] args){
                StringBuilder builder = new StringBuilder();
                for(int i = 1; i<args.length;i++){
                        builder.append(args[i]).append(" ");
                }
                return builder.toString();
        }

    }

                
We modified the EventManger implementation of the Hibernate Tutorial so that it stores a point for the event. The point is given as a String in the Well-Known Text (WKT) format. See the JTS WTKReader JavaDoc for more information about the WTK format. (The assemble() method is necessary because the Maven exec plugin parses string with spaces as a list of command-line arguments.)

The development directory now looks like this.

 
        .
        |-- pom.xml
        `-- src
            |-- main
            |   |-- java
            |   |   |-- event
            |   |   |   |-- Event.java
            |   |   |   `-- EventManager.java
            |   |   `-- util
            |   |       `-- HibernateUtil.java
            |   `-- resources
            |       |-- event
            |       |   `-- Event.hbm.xml
            |       `-- hibernate.cfg.xml
            `-- test
                `-- java
                    `-- event

                
We can now build this program using maven:

     $ mvn compile 
                
We can now execute the program using maven as follows:
   
    $ mvn exec:java -Dexec.mainClass="event.EventManager" -Dexec.args="store POINT(10 5)"
                
This will create the events table, add a new event with the date set to today, the title to "My Title", and the point to coordinates (10,15).

We can check the content of the events table using the astext() function that converts the geometries to their WKT representation.

       events=# select title, astext(loc) from events;

        title | astext
        ----------+--------------
        My Event | POINT(10 15)
        (1 row) 
            
## Spatial Queries

We will now modify the EventManager by adding an action to list all events within a certain area. This will show how to use Hibernate Spatial for spatial querying.

_Important: comment out the hbm2ddl.auto property in the hibernate.cfg.xml so that the event table is not deleted each time we run the EventManager_.

Here is the addition to the main method in the EventManager that implements the "find" action.

                    
    ...
        if (args[0].equals("store")) {
            mgr.createAndStoreEvent("My Event", new Date(), assemble(args));
        }else if (args[0].equals("find")){
            List events = mgr.find(args[1]);
            for (int i = 0; i < events.size(); i++ ){
	            Event event = (Event)events.get(i);
                System.out.println("Event: " + event.getTitle() +
                                ", Time: " + event.getDate() +
                                ", Location: " + event.getLocation());
            }
        }	
    ...

                
We also need to implement the find(String filter) method.
The find method takes a WKT string that represents a polygon, and searches the events table for all events that are located within this polygon.

Here is the code.

                    
    ...
    //New imports
    import org.hibernate.Criteria;
    import java.util.List;
    import org.hibernatespatial.criterion.SpatialRestrictions;
    ...


    private List find(String wktFilter){
        WKTReader fromText = new WKTReader();
        Geometry filter = null;
        try{
                filter = fromText.read(wktFilter);
        } catch(ParseException e){
                throw new RuntimeException("Not a WKT String:" + wktFilter);
        }
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        session.beginTransaction();
        System.out.println("Filter is : " + filter);
        Criteria testCriteria = session.createCriteria(Event.class);
        testCriteria.add(SpatialRestrictions.within("location", filter));
        List results = testCriteria.list();
        session.getTransaction().commit();
        return results;
    }
    ...



                
The SpatialRestrictions class provides utility methods to create Criterion instances for spatial queries. In our example the WITHIN spatial operator is used to query all events with a location within a specified filter geometry.

The within method (as most other methods of SpatialRestrictions) takes two parameters. The first is the name of the Geometry-valued property on which the filter is applied; the second is the filter geometry.

If now run:

    $ mvn exec:java -Dexec.mainClass="event.EventManager" -Dexec.args="find POLYGON((1\ 1,20\ 1,20\20,1\ 20,1\ 1))" 
                
We get
                    
    ...
    Filter is : POLYGON ((1 1, 20 1, 20 20, 1 20, 1 1))
    Hibernate: select this_.EVENT_ID as EVENT1_0_0_, this_.EVENT_DATE as EVENT2_0_0_, this_.title as title0_0_, this_.LOC as LOC0_0_ from EVENTS this_ where (this_.LOC && ?  AND   within(this_.LOC, ?))
    Event: My Event, Time: 2010-04-05 19:58:36.896, Location: POINT (10 5)
    ...

                
The first line is the Filter that is echoed toSystem.out, the second line is the SQL generated by Hibernate (with the help of Hibernate Spatial). This is shown because the show_sql property is set in the configuration file. The last line is the output generated by the find action.
An alternative approach is using HQL. The Postgis Dialect registers functions and operators specified in the the Simple Features for SQL specification. So we could write.

            ...
            Query q = session
            .createQuery("from Event where within(location, ?) = true");
            Type geometryType = GeometryUserType.TYPE;
            q.setParameter(0, filter, geometryType);
            List result = q.list();
            ...
                
This is pretty much like any other HQL query in Hibernate, with the (slightly annoying) complication of having to explicitly specify the Type for the GeometryUserType in thesetParameter-method.

## But I use Oracle, so what do I do?

Suppose we want to implement the EventManager on top of Oracle, how do we proceed? We need to change the following items

Replace the hibernate-spatial-postgis-*.jar provider with the hibernate-spatial-oracle-*.jar provider.
Replace the Postgresql Driver with the Oracle JDBC Driver.
Remove the postgis.jar
Modify the hibernate.cfg.xml configuration file so that it points to a suitable Oracle database, uses the Oracle JDBC driver, and has OracleSpatial10gDialect as dialect.
... and your done!

## .. and what about MySQL?

Recent versions of MySQL have (limited) support for spatial types. To get Hibernate Spatial to work with MySQL, change the following items:

Replace the hibernate-spatial-postgis-*.jar provider with the hibernate-spatial-mysql-*.jar provider.
Replace the Postgresql Driver with the MySQL JDBC Driver.
Remove the postgis.jar
Modify the hibernate.cfg.xml configuration file so that it points to a suitable MySQL database, uses the MySQL JDBC driver, and has MySQLSpatialDialect as dialect.
Please note that MySQL's implementation of the spatial types is incomplete at this time. Certain functions of Hibernate Spatial will fail at this time.

The MySQLSpatialDialect extends the vanilla MySQLDialect and therefore only supports the MyISAM tables.

## .. and what about Microsoft SQL Server 2008?

Starting with SQL Server 2008, Microsoft has added full support for OGC Simple Features for SQL. To use this database with Hibernate Spatial, change the following items:

Replace the hibernate-spatial-postgis-*.jar provider with the hibernate-spatial-sqlserver-*.jar provider.
Replace the Postgresql Driver with the Microsoft SQL Server JDBC Driver.
Remove the postgis.jar
Modify the hibernate.cfg.xml configuration file so that it points to a suitable SQL Server database, uses the SQL Server JDBC driver, and has SQLServerSpatialDialect as dialect.

## Can I Use JPA Annotations with Hibernate Spatial?

In stead of using *.hbm.xml mapping files, you can also use JPA annotations. Well almost: JPA doesn't support spatial objects, and doesn't have an extension mechanism to add new types. So using only JPA annotations won't work. Fortunately, the Hibernate Annotations implementation of JPA does have a means for mapping UserTypes.

Let's modify the code to use annotations. We change the source code of the Events class so that it looks like this

 
    package event;

    import java.util.Date;

    import javax.persistence.*;

    import org.hibernate.annotations.Type;

    import com.vividsolutions.jts.geom.Point;

    @Entity
    @Table(name = "EVENTS")
    public class Event {

        @Id
        @GeneratedValue
        @Column(name = "EVENT_ID")
        private Long id;

        @Column(name = "TITLE")
        private String title;

        @Column(name = "EVENT_DATE")
        private Date date;


        @Column(name = "LOC")
        @Type(type = "org.hibernatespatial.GeometryUserType")
        private Point location;

        public Event() {
        }

        public Long getId() {
            return id;
        }

        private void setId(Long id) {
            this.id = id;
        }

        public Date getDate() {
            return date;
        }

        public void setDate(Date date) {
            this.date = date;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public Point getLocation() {
            return this.location;
        }

        public void setLocation(Point location) {
            this.location = location;
        }
    }

Note that for the Geometry field we needed to use the Hibernate-specific @Type annotation.

Next, we replace the mapping resource by replacing the following line from the hibernate.cfg.xml

    <mapping resource="event/Event.hbm.xml"/>
            
with a declaration of mapped classes.

    <mapping class="event.Event">
            
Finally, we change the HibernateUtil so it uses an AnnotationConfiguration object. Change the line:

    ...
    sessionFactory = new Configuration().configure().buildSessionFactory();
    ...
            
needs to change to

    ...
    sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
    ...
            
Now the operations should work as before.