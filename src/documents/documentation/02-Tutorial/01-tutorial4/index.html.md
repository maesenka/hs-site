```
menuTitle: Tutorial (v4.x)
isNav: true
Title: Tutorial (Hibernate Spatial 4)
tags: ['tutorial', 'documentation']
```
This tutorial gives a quick overview of how to get Hibernate Spatial 4.x working. We will develop a simple application that stores, and retrieves some simple data objects. The data objects are "special" in that they have a property of type Geometry.

This tutorial assumes that you are familiar with Hibernate and the basic concepts of working with geographic data.

For this tutorial We require a postgis database. For information on how to create a postgis database, you should consult the postgis documentation. 

For this tutorial we used Postgresql 8.4 and Postgis 1.5, but any version of Postgresql later than 8.1 or Postgis later than 1.4 should work equally well.

## Setup

We first need to set up our development environment. We will use the Maven build tool in this tutorial.

Maven can generate the basic structure of our simple application using themvn archetype:generate. For this example, we specify type (the default) and set groupId to org.hibernate.spatial.tutorials, artifactId to event-tutorial and package to event.

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

    .......

    Define value for groupId: : org.hibernate.spatial.tutorials
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

                
We now need to edit the pom to add the required dependencies and repositories (see also the Maven Quick Start.).
                    

    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>

        <groupId>org.hibernate.spatial.tutorials</groupId>
        <artifactId>event-tutorial</artifactId>
        <version>1.0-SNAPSHOT</version>
        <packaging>jar</packaging>

        <name>event-tutorial</name>
        <url>http://maven.apache.org</url>

        <properties>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
            <hibernate.version>4.0.0.Final</hibernate.version>
        </properties>

        <build>
            <finalName>${artifactId}</finalName>
            <plugins>
                <plugin>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <configuration>
                        <source>1.6</source>
                        <target>1.6</target>
                        <encoding>UTF-8</encoding>
                    </configuration>
                </plugin>
            </plugins>
        </build>
        <dependencies>

            <!-- Hibernate Spatial -->
            <dependency>
                <groupId>org.hibernate</groupId>
                <artifactId>hibernate-spatial</artifactId>
                <version>4.0</version>
            </dependency>

            <dependency>
                <groupId>org.hibernate</groupId>
                <artifactId>hibernate-entitymanager</artifactId>
                <version>${hibernate.version}</version>
            </dependency>

            <!-- the postgresql driver -->
            <dependency>
                <groupId>postgresql</groupId>
                <artifactId>postgresql</artifactId>
                <version>8.4-701.jdbc3</version>
            </dependency>

            <dependency>
                <groupId>org.slf4j</groupId>
                <artifactId>slf4j-log4j12</artifactId>
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

    $ mvn dependency:list
        ....
    [INFO] The following files have been resolved:
    [INFO]    antlr:antlr:jar:2.7.7:compile
    [INFO]    com.fasterxml:classmate:jar:0.5.4:compile
    [INFO]    com.vividsolutions:jts:jar:1.12:compile
    [INFO]    commons-collections:commons-collections:jar:3.2.1:compile
    [INFO]    dom4j:dom4j:jar:1.6.1:compile
    [INFO]    javassist:javassist:jar:3.12.1.GA:compile
    [INFO]    log4j:log4j:jar:1.2.14:compile
    [INFO]    org.hibernate:hibernate-core:jar:4.0.0.Final:compile
    [INFO]    org.hibernate:hibernate-entitymanager:jar:4.0.0.Final:compile
    [INFO]    org.hibernate:hibernate-spatial:jar:4.0:compile
    [INFO]    org.hibernate.common:hibernate-commons-annotations:jar:4.0.1.Final:compile
    [INFO]    org.hibernate.javax.persistence:hibernate-jpa-2.0-api:jar:1.0.1.Final:compile
    [INFO]    org.jboss:jandex:jar:1.0.3.Final:compile
    [INFO]    org.jboss.logging:jboss-logging:jar:3.1.0.CR2:compile
    [INFO]    org.jboss.spec.javax.transaction:jboss-transaction-api_1.1_spec:jar:1.0.0.Final:compile
    [INFO]    org.postgis:postgis-jdbc:jar:1.5.3:compile
    [INFO]    org.slf4j:slf4j-api:jar:1.5.11:compile
    [INFO]    org.slf4j:slf4j-log4j12:jar:1.5.11:compile
    [INFO]    postgresql:postgresql:jar:8.4-701.jdbc3:compile
    [INFO]    xerces:xercesImpl:jar:2.4.0:compile
    [INFO]    xml-apis:xml-apis:jar:1.0.b2:compile



                
Hibernate Spatial works with a wide range of versions of these libraries, so don't be too concerned if you see either more recent or slightly older versions.

## The Event Class

Our persistent class is the Event class. Since this class contains a geometry-valued property (a property of type Geometry), its instances are geographic objects, or features.

 
    package event;

    import com.vividsolutions.jts.geom.Point;
    import org.hibernate.annotations.GenericGenerator;
    import org.hibernate.annotations.Type;

    import javax.persistence.*;
    import java.util.Date;

    @Entity
    public class Event {

            @Id
            @GeneratedValue(generator="increment")
            @GenericGenerator(name="increment", strategy = "increment")
            private Long id;

            private String title;

            private Date date;

            @Type(type="org.hibernate.spatial.GeometryType")
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

Note the @Type annotation. This informs Hibernate that the location attribute is of type Geometry. The @Type annotation is Hibernate specific, and the only non-JPA annotation that is required. (In future versions of Hibernate (version 5 and later) it will no longer be necessary to explicitly declare the Type of Geometry-valued attributes.)

## The Hibernate/JPA Configuration

We proceed with the hibernate configuration file. The only difference w.r.t. the usual Hibernate/JPA configurations is the dialect property. Hibernate Spatial extends the Hibernate Dialects so that the spatial functions of the database are available within HQL and JPQL. So instead of using the (in our case) PostgreSQLDialect, we use Hibernate Spatial's extension of that dialect which is the PostGISDialect. Our persistence.xml looks like this:

                        
    <persistence xmlns="http://java.sun.com/xml/ns/persistence"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://java.sun.com/xml/ns/persistence http://java.sun.com/xml/ns/persistence/persistence_2_0.xsd"
            version="2.0">
        <persistence-unit name="org.hibernate.events.jpa" transaction-type="RESOURCE_LOCAL">
           <properties>
               <property name="hibernate.dialect" value="org.hibernate.spatial.dialect.postgis.PostgisDialect"/>

               <property name="hibernate.connection.driver_class" value="org.postgresql.Driver"/>
               <property name="hibernate.connection.url" value="jdbc:postgresql://localhost:5432:hstutorial"/>
               <property name="hibernate.connection.username" value="hstutorial"/>
               <property name="hibernate.connection.password" value="hstutorial"/>
               <property name="hibernate.connection.pool_size" value="5"/>

               <property name="hibernate.show_sql" value="true"/>
               <property name="hibernate.format_sql" value="true"/>

               <property name="hibernate.max_fetch_depth" value="5"/>

               <property name="hibernate.hbm2ddl.auto" value="update"/>

           </properties>
        </persistence-unit>
    </persistence>

As is usual when building with maven, we store this file in the src/main/resources/META-INF directory.

Note that this configuration file means that Hibernate will connect to the "events" database on localhost, with username "hstutorial" and password "hstutorial". You may need to change these values to reflect your set-up.

We set the "hbm2dll.auto" property to 'update', so that Hibernate will create the necessary table(s) when the application is run for the first time.

### The JPAUtil helper

The JPAUtil class creates the EntityManagerFactory for the application, and provides a method to create EntityManager instances.
 
    package util;

    import javax.persistence.EntityManager;
    import javax.persistence.EntityManagerFactory;
    import javax.persistence.Persistence;

    public class JPAUtil {

        private static final EntityManagerFactory emFactory;

        static {
            try {
                emFactory = Persistence.createEntityManagerFactory("org.hibernate.events.jpa");
            }catch(Throwable ex){
                System.err.println("Cannot create EntityManagerFactory.");
                throw new ExceptionInInitializerError(ex);
            }
        }

        public static EntityManager createEntityManager() {
            return emFactory.createEntityManager();
        }

        public static void close(){
            emFactory.close();
        }
    }

            
## The EventManager

We are now ready to write a first version of the main application classEventManager.

  
    package event;

    import com.vividsolutions.jts.geom.Geometry;
    import com.vividsolutions.jts.geom.Point;
    import com.vividsolutions.jts.io.ParseException;
    import com.vividsolutions.jts.io.WKTReader;
    import util.JPAUtil;

    import javax.persistence.EntityManager;
    import javax.persistence.Query;
    import java.util.Date;
    import java.util.List;

    public class EventManager {

        public static void main(String[] args) {
            EventManager mgr = new EventManager();

            if (args[0].equals("store")) {
                mgr.createAndStoreEvent("My Event", new Date(), assemble(args));
            }
            JPAUtil.close();
        }

        private void createAndStoreEvent(String title, Date theDate, String wktPoint) {
            Geometry geom = wktToGeometry(wktPoint);

            if (!geom.getGeometryType().equals("Point")) {
                throw new RuntimeException("Geometry must be a point. Got a " + geom.getGeometryType());
            }

            EntityManager em = JPAUtil.createEntityManager();

            em.getTransaction().begin();

            Event theEvent = new Event();
            theEvent.setTitle(title);
            theEvent.setDate(theDate);
            theEvent.setLocation((Point) geom);
            em.persist(theEvent);
            em.getTransaction().commit();
            em.close();
        }

        private Geometry wktToGeometry(String wktPoint) {
            WKTReader fromText = new WKTReader();
            Geometry geom = null;
            try {
                geom = fromText.read(wktPoint);
            } catch (ParseException e) {
                throw new RuntimeException("Not a WKT string:" + wktPoint);
            }
            return geom;
        }

        /**
         * Utility method to assemble all arguments save the first into a String
         */
        private static String assemble(String[] args) {
            StringBuilder builder = new StringBuilder();
            for (int i = 1; i < args.length; i++) {
                builder.append(args[i]).append(" ");
            }
            return builder.toString();
        }

    }
                
The EventManger stores a point that represents the location for the event. The point is given as a String in the Well-Known Text (WKT) format. See the JTS WTKReader JavaDoc for more information about the WTK format. (The assemble() method is necessary because the Maven exec plugin parses string with spaces as a list of command-line arguments.)

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
            |   |       `-- JPAUtil.java
            |   `-- resources
            |       `-- META-INF
            |           `-- persistence.xml
            |
            `-- test
                `-- java
                    `-- event

                
We can now build this program using maven:

     $ mvn compile 
                
We can now execute the program using maven as follows:

    $ mvn exec:java -Dexec.mainClass="event.EventManager" -Dexec.args="store POINT(10 5)"

                
This will create the events table, add a new event with the date set to today, the title to "My Title", and the point to coordinates (10,15).

We can check the content of the events table using the Postgis `astext()` function that converts the geometries to their WKT representation.

    

    events=# select title, astext(location) from events;

    title | astext
    ----------+--------------
    My Event | POINT(10 15)
    (1 row) 
        
## Spatial Queries

We will now modify the EventManager by adding an action to list all events within a certain area. This will show how to use Hibernate Spatial for spatial querying.

Here is the addition to the main method in the EventManager that implements the "find" action.

                    
    ...
    if (args[0].equals("store")) {
        mgr.createAndStoreEvent("My Event", new Date(), assemble(args));
    } else if (args[0].equals("find")) {
        List events = mgr.find(args[1]);
        for (int i = 0; i < events.size(); i++) {
            Event event = (Event) events.get(i);
            System.out.println("Event: " + event.getTitle() +
                    ", Time: " + event.getDate() +
                    ", Location: " + event.getLocation());
        }
    }
    ...

                
We also need to implement the `find(String filter)` method.
The find method takes a WKT string that represents a polygon, and searches the events table for all events that are located within this polygon. Here is the code.

                    
    ...
    private List find(String wktFilter) {
        Geometry filter = wktToGeometry(wktFilter);
        EntityManager em = JPAUtil.createEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("select e from Event e where within(e.location, :filter) = true", Event.class);
        query.setParameter("filter", filter);
        return query.getResultList();
    }
    ...

              
The `st_within()` function is registered in the Dialect PostgisDialect method. It takes two parameters: the first is the name of the Geometry-valued property on which the filter is applied; the second is the filter geometry.

If now run:

    $ mvn exec:java -Dexec.mainClass="event.EventManager" -Dexec.args="find POLYGON((1\ 1,20\ 1,20\ 20,1\ 20,1\ 1))" 
                
We get
                    
    ...
    Hibernate:
        select
            event0_.id as id0_,
            event0_.date as date0_,
            event0_.location as location0_,
            event0_.title as title0_
        from
            Event event0_
        where
            st_within(event0_.location, ?)=true
    Event: My Event, Time: 2012-06-19 15:20:06.049, Location: POINT (10 5)

    ...

                
The first lines show the SQL generated by Hibernate (with a little help of Hibernate Spatial). It is shown because the show_sql property is set in the configuration file. The last line is the output generated by the find action.

## But I use Oracle/MySQL/SQLServer/... so what do I do?

If you need to run Hibernate Spatial on a different database, you need to change the JDBC driver (obviously) and set the appropriate spatial dialect. For more information see the [Dialect Overview](../03-dialects/01-overview).