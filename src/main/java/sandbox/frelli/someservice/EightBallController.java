package sandbox.frelli.someservice;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import sandbox.frelli.somelibrary.SomeUtility;

@RestController
public class EightBallController {

    private final SomeUtility someUtility = new SomeUtility();

    @GetMapping("/9ball")
    public String eightBall() {
        return someUtility.magicEightBall();
    }
}
