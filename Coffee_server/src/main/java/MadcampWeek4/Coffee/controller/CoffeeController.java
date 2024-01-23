package MadcampWeek4.Coffee.controller;

import MadcampWeek4.Coffee.entity.Coffee;
import MadcampWeek4.Coffee.service.CoffeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@RestController
@RequestMapping("/coffee")
public class CoffeeController {

    private final Logger logger = LoggerFactory.getLogger(CoffeeController.class);

    @Autowired
    private CoffeeService coffeeService;

    @GetMapping("/{coffeeIndex}")
    public ResponseEntity<Coffee> getCoffeeByIndex(@PathVariable("coffeeIndex") int coffeeIndex) {
        Coffee coffee = coffeeService.getCoffeeByIndex(coffeeIndex);
        if (coffee != null) {
            return ResponseEntity.ok(coffee);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/hot-to-cold/{coffeeIndex}")
    public ResponseEntity<Coffee> hotToCold(@PathVariable("coffeeIndex") int coffeeIndex) {
        Coffee coldCoffee = coffeeService.hotToCold(coffeeIndex);

        if (coldCoffee != null) {
            return ResponseEntity.ok(coldCoffee);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/cold-to-hot/{coffeeIndex}")
    public ResponseEntity<Coffee> coldToHot(@PathVariable("coffeeIndex") int coffeeIndex) {
        Coffee hotCoffee = coffeeService.coldToHot(coffeeIndex);

        if (hotCoffee != null) {
            return ResponseEntity.ok(hotCoffee);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/by-brand/{brand}")
    public ResponseEntity<List<Coffee>> getCoffeeByBrand(@PathVariable("brand") String brand) {
        logger.info("Received request for coffee by brand: {}", brand);
        List<Coffee> coffees = coffeeService.getCoffeeByBrand(brand);

        if (!coffees.isEmpty()) {
            logger.info("Found {} coffees for brand {}", coffees.size(), brand);
            return ResponseEntity.ok(coffees);
        } else {
            logger.warn("No coffees found for brand {}", brand);
            return ResponseEntity.notFound().build();
        }
    }
}
