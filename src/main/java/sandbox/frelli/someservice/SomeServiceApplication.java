package sandbox.frelli.someservice;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class SomeServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(SomeServiceApplication.class, args);
    }

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
                .info(new Info()
                        .version("v0.0.1")
                        .title("Some Service API")
                        .description("Some service API used for testing " +
                                "a bunch of microservice related proof of concepts.")
                );
    }

}
