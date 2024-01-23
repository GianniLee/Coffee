package MadcampWeek4.Coffee.repository;

import MadcampWeek4.Coffee.entity.Coffee;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CoffeeRepository extends JpaRepository<Coffee, Integer> {
    Optional<Coffee> findByCoffeeName(String coffeeName);
    List<Coffee> findByBrand(String brand);
}
