package MadcampWeek4.Coffee.repository;

import MadcampWeek4.Coffee.entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsersRepository extends JpaRepository<Users, Integer> {
    // You can add custom query methods if needed
}

