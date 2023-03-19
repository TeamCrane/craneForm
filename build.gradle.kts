plugins {
    java
    war
    id("org.springframework.boot") version "3.0.4"
    id("io.spring.dependency-management") version "1.1.0"
}

group = "com.cafe24"
version = "0.0.1-SNAPSHOT"
java.sourceCompatibility = JavaVersion.VERSION_17

configurations {
    compileOnly {
        extendsFrom(configurations.annotationProcessor.get())
    }
}

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.mybatis.spring.boot:mybatis-spring-boot-starter:3.0.0")
    compileOnly("org.projectlombok:lombok")
    developmentOnly("org.springframework.boot:spring-boot-devtools")
    runtimeOnly("org.mariadb.jdbc:mariadb-java-client")
    annotationProcessor("org.projectlombok:lombok")
    providedRuntime("org.springframework.boot:spring-boot-starter-tomcat")
    testImplementation("org.springframework.boot:spring-boot-starter-test")

    // jsp
    implementation("org.apache.tomcat.embed:tomcat-embed-jasper")

    // jstl (스프링부트 3.0부터 아래의 방식으로 바뀌었다)
    // implementation("javax.servlet:jstl:1.2")
    implementation("jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api:3.0.0")
    implementation("org.glassfish.web:jakarta.servlet.jsp.jstl:3.0.1")

}

tasks.withType<Test> {
    useJUnitPlatform()
}
