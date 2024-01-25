package MadcampWeek4.Coffee.repository;

import MadcampWeek4.Coffee.entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;


public interface UsersRepository extends JpaRepository<Users, Integer> {
    // You can add custom query methods if needed
    Optional<Users> findById(String id);
}

