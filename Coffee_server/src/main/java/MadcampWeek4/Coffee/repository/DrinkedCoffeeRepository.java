package MadcampWeek4.Coffee.repository;

import MadcampWeek4.Coffee.entity.DrinkedCoffee;
import MadcampWeek4.Coffee.entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DrinkedCoffeeRepository extends JpaRepository<DrinkedCoffee, Integer> {
    // You can add custom query methods if needed
    List<DrinkedCoffee> findByUser(Users user);
}

