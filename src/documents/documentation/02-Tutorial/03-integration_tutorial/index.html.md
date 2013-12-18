```
menuTitle: Integration testing with GeoDB and Spring
isNav: true
Title: Automated integration testing of the Hibernate Spatial DAO layer with Spring and GeoDB
tags: ['tutorial', 'documentation']
```

(by [Geodan](http://www.geodan.com/))

At Geodan we recently started to use automated integration tests to test the Hibernate DAO layer of our applications. Open source GIS applications usually use PostGIS as backend, which is not very practical in automated tests. We needed a geospatial database that could be setup in our JUnit tests. GeoDB has enabled us to write such tests. We use the Spring framework to setup the test environment and provide the test data. In this tutorial I'll explain how you set up such automated integration test.

## Setting up the data

The data for the automated integration tests is provided by

* a .sql file that contains the schema (DDL);
* a .sql file that contains inserts statments for all the records (DML).

These data files should be stored somewhere on your classpath (I prefer the resources directory for storage). The SQL statements should follow the [h2 SQL syntax](http://www.h2database.com/html/grammar.html). Table and column names are case-insensitive and geometry must be stored as a blob.

## Setting up the Spring configuration

Spring provides integration testing via the spring-test package. Since we want to use Hibernate and a database we'll also use the spring-orm package and the spring-tx package for transactions (the database state should be rolled back after each test method). If you use Maven it's sufficient to specifiy only the spring-orm package:

		
	<dependency>
		<groupId>org.springframework</groupId>
		<artifactId>spring-orm</artifactId>
		<version>3.0.2.RELEASE</version>
		<scope>test</scope>
	</dependency>
	
		
In the application context file you need to specify a DataSource, a Hibernate SessionFactory and a TransactionManager. If you prefer, you can also specify your DAO classes and let them use the specified DataSource. The DataSource is created with a special class, the GeoDBTestDataSourceFactory. This class implements the FactoryBean interface and sets up a GeoDB in-memory database, creates a schema (based on the specified file), inserts data (using the specified file) and returns a DataSource object that points towards the GeoDB database. This way it's extremely easy to use GeoDB for testing, because all you need is the library on your classpath and two .sql files with the necessary SQL statements.

The Spring application context will look as follows:

		
	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:tx="http://www.springframework.org/schema/tx"
		xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
			http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-3.0.xsd">

		<!-- Creates an in-memory "geodata" database populated with test data for fast testing -->
		<bean id="dataSource" class="com.geodan.util.test.GeoDBTestDataSourceFactory">
			<property name="testDatabaseName" value="geodata" />
			<property name="schemaLocation" value="classpath:schema.sql" />
			<property name="testDataLocation" value="classpath:data.sql" />
		</bean>
		
		<!-- Creates a Hibernate SessionFactory -->
		<bean id="sessionFactory"
			class="org.springframework.orm.hibernate3.annotation.AnnotationSessionFactoryBean">
			<property name="dataSource" ref="dataSource" />
			<property name="hibernateProperties">
				<value>
					hibernate.dialect=org.hibernatespatial.geodb.GeoDBDialect
					hibernate.show_sql=true
					hibernate.format_sql=true			
					hibernate.generate_statistics=true
				</value>
			</property>
			<property name="annotatedClasses">
				<util:list>
					<value>package.Entity</value>
				</util>
			</property>
		</bean>

		<!-- Creates a Hibernate Transaction Manager -->
		<bean id="transactionManager"
			class="org.springframework.orm.hibernate3.HibernateTransactionManager">
			<constructor-arg ref="sessionFactory" />
		</bean>

	 	<tx:annotation-driven/>
	</beans>
		
		
## The JUnit test class

The JUnit test class is quite simple and is tested only on JUnit 4.4 or higher. The most important part is the configuration of the Spring test runner, a special class that is used to use a Spring configuration with a JUnit test. All methods should be annotated with @Test. There should be one private property that holds the Hibernate's SessionFactory.

The class structure look as follows:

		
	@Transactional
	@RunWith(SpringJUnit4ClassRunner.class)
	@ContextConfiguration(locations = { "classpath:/geodb-test-context.xml" })
	class GeoDBTest {
		@Resource
		private SessionFactory sessionFactory;

		@Test
		public void testSpatialQuery() {
			Geometry polygon = new WKTReader(new GeometryFactory(new PrecisionModel(), 4326))
					.read("POLYGON((5.5 52.0, 6.0 52.0, 6.0 53.0, 5.5 53.0, 5.5 52.0))");
			Criteria testCriteria = sessionFactory.openSession().createCriteria(package.Entity.class);
    		testCriteria.add(SpatialRestrictions.within("geom", polygon));
    		List<package.Entity> results = testCriteria.list();

			// Assertions go here...
		}
	}
		
		
Note that I haven't specified the Entity, but it is presumed that the field "geom" contains the spatial data and is represented by a Geometry type in the entity class.

1. If you like to test DAO classes that communicate with PostGIS tables, you can use the following SQL query to make the GeoDB SQL syntax compatible with: @CREATE DOMAIN geometry AS BLOB;@

2. This class can be found in my github repository.

3. If you use Spring 2.5.x, you have to use JUnit 4.4, otherwise the spring-test package will fail. Spring 3.x can be used with the latest JUnit version without known problems.