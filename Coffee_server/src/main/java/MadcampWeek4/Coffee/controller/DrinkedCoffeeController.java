package MadcampWeek4.Coffee.controller;

import MadcampWeek4.Coffee.data.DrinkedCoffeeDTO;
import MadcampWeek4.Coffee.entity.DrinkedCoffee;
import MadcampWeek4.Coffee.service.DrinkedCoffeeService;
import MadcampWeek4.Coffee.utils.DTOConverter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@Slf4j
@RequestMapping("/drinked-coffees")
public class DrinkedCoffeeController {

    @Autowired
    private DrinkedCoffeeService drinkedCoffeeService;

    // @PostMapping
    // public ResponseEntity<DrinkedCoffee> createDrinkedCoffee(@RequestBody
    // DrinkedCoffee drinkedCoffee) {
    // DrinkedCoffee createdDrinkedCoffee =
    // drinkedCoffeeService.createAndSaveDrinkedCoffee(drinkedCoffee);
    // return ResponseEntity.status(HttpStatus.CREATED).body(createdDrinkedCoffee);
    // }

    @GetMapping("/by-user/{userIndex}")
    public ResponseEntity<List<DrinkedCoffeeDTO>> getDrinkedCoffeeByUserIndex(
            @PathVariable("userIndex") int userIndex) {
        List<DrinkedCoffeeDTO> drinkedCoffeeDtos = drinkedCoffeeService.getDrinkedCoffeeByUserIndex(userIndex)
                .stream()
                .map(DTOConverter::convertToDto) // DrinkedCoffee -> DrinkedCoffeeDTO로 변환
                .sorted(Comparator.comparingInt(DrinkedCoffeeDTO::getDrinkedCoffeeIndex).reversed()) // 역순으로 정렬
                .collect(Collectors.toList());

        return ResponseEntity.ok(drinkedCoffeeDtos);
    }
    // @GetMapping("/by-user/{userIndex}")
    // public ResponseEntity<List<DrinkedCoffee>>
    // getDrinkedCoffeeByUserIndex(@PathVariable("userIndex") int userIndex) {
    // List<DrinkedCoffee> drinkedCoffees =
    // drinkedCoffeeService.getDrinkedCoffeeByUserIndex(userIndex);
    //
    // return ResponseEntity.ok(drinkedCoffees);
    // }

}
