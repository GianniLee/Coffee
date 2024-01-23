package MadcampWeek4.Coffee.controller;

import MadcampWeek4.Coffee.entity.Coffee;
import MadcampWeek4.Coffee.service.CoffeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
