package MadcampWeek4.Coffee.controller;

import MadcampWeek4.Coffee.entity.Coffee;
import MadcampWeek4.Coffee.entity.Users;
import MadcampWeek4.Coffee.service.UsersService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


import java.util.List;

@RestController
@Slf4j
@RequestMapping("/users")
public class UsersController {

    @Autowired
    private UsersService usersService;

    @PostMapping("/create/{id}/{pwd}")
    public ResponseEntity<Users> createUser(@PathVariable("id") String id, @PathVariable("pwd") String pwd) {
        Users newUser = usersService.createUser(id, pwd);
        return ResponseEntity.status(HttpStatus.CREATED).body(newUser);
    }

    @ExceptionHandler(IllegalStateException.class)
    public ResponseEntity<Object> handleIllegalStateException(IllegalStateException e) {
        return ResponseEntity
            .status(HttpStatus.BAD_REQUEST)
            .body(e.getMessage());
    }

    @GetMapping("/{userIndex}/liked-coffees")
    public ResponseEntity<List<Coffee>> getLikedCoffeesByUserIndex(@PathVariable("userIndex") int userIndex) {
        List<Coffee> likedCoffees = usersService.getLikedCoffeeByUserIndex(userIndex);

        // 반환할 데이터가 있을 경우 200 OK 응답과 함께 JSON 형태로 반환
        // 없을 경우 404 Not Found 응답
        return ResponseEntity.ok(likedCoffees);
    }

    @PostMapping("/{userIndex}/add-liked-coffee/{coffeeIndex}")
    public ResponseEntity<Users> addLikedCoffeeToUser(
            @PathVariable("userIndex") int userIndex,
            @PathVariable("coffeeIndex") int coffeeIndex) {
        log.info("addLikedCoffeeToUser");
        Users updatedUser = usersService.addLikedCoffeeToUser(userIndex, coffeeIndex);
        log.info("addLikedCoffeeToUser user:{}", updatedUser);
        if (updatedUser != null) {
            return ResponseEntity.ok(updatedUser);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @PostMapping("/{userIndex}/remove-liked-coffee/{coffeeIndex}")
    public ResponseEntity<Users> removeLikedCoffeeFromUser(
            @PathVariable("userIndex") int userIndex,
            @PathVariable("coffeeIndex") int coffeeIndex) {
        Users updatedUser = usersService.removeLikedCoffeeFromUser(userIndex, coffeeIndex);

        if (updatedUser != null) {
            return ResponseEntity.ok(updatedUser);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @GetMapping("/{userIndex}/half-life")
    public ResponseEntity<Integer> getHalfLife(@PathVariable("userIndex") int userIndex) {
        int halfLife = usersService.getHalfLifeByUserIndex(userIndex);
        return ResponseEntity.ok(halfLife);
    }

    @PutMapping("/{userIndex}/update-half-life/{newHalfLife}")
    public ResponseEntity<Integer> updateHalfLife(
            @PathVariable("userIndex") int userIndex,
            @PathVariable("newHalfLife") int newHalfLife) {

        int updatedHalfLife = usersService.updateHalfLife(userIndex, newHalfLife);
        return ResponseEntity.ok(updatedHalfLife);
    }
}

