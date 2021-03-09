package sandbox.frelli.someservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import sandbox.frelli.somelibrary.SomeUtility;

@SpringBootApplication
public class SomeServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(SomeServiceApplication.class, args);
	}

}
