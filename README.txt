DB
--
CREATE SCHEMA `mvc` ;


$ mvn archetype:generate

Define value for property 'groupId': com.websystique.springmvc
Define value for property 'artifactId': SpringMVCSecurity
Define value for property 'version' 1.0
Define value for property 'package' com.test.springboot.jpa: : war


$ mvn eclipse:eclipse

$ mvn clean package -Dmaven.test.skip=true


Add below (if you refer the maven build directly from tomcat 8.5).../tomcat_home/conf/server.xml
-----------------------------------------------------------------------------------------------
<Context docBase="{your basedir path}/SpringMVCSecurity/target/springmvcsecurity" path="/mvcs" reloadable="true"/>
