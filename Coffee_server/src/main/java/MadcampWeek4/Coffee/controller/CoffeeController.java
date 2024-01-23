package MadcampWeek4.Coffee.controller;

import MadcampWeek4.Coffee.entity.Coffee;
import MadcampWeek4.Coffee.service.CoffeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/coffee")
public class CoffeeController {

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

    @GetMapping("/by-brand/{brand}")
    public ResponseEntity<List<Coffee>> getCoffeeByBrand(@PathVariable("brand") String brand) {
        List<Coffee> coffees = coffeeService.getCoffeeByBrand(brand);
        if (!coffees.isEmpty()) {
            return ResponseEntity.ok(coffees);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
