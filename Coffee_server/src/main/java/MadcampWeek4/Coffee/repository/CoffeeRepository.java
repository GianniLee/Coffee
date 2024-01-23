package MadcampWeek4.Coffee.repository;

import MadcampWeek4.Coffee.entity.Coffee;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CoffeeRepository extends JpaRepository<Coffee, Integer> {
}
