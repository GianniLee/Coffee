package MadcampWeek4.Coffee.service;

import MadcampWeek4.Coffee.entity.Coffee;
import MadcampWeek4.Coffee.entity.Users;
import MadcampWeek4.Coffee.repository.CoffeeRepository;
import MadcampWeek4.Coffee.repository.UsersRepository;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
//import org.assertj.core.util.Arrays;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class UsersService {

    @Autowired
    private final UsersRepository usersRepository;

    @Autowired
    private CoffeeRepository coffeeRepository;

    @Transactional
    public void createDummyUsers() {
        Users user1 = new Users();
        user1.setId("user1");
        user1.setPwd("password1");
        user1.setHalfLife(30); // or any other value
        user1.setCoffeeIndexes(List.of(1, 2, 3)); // or any other coffee indexes

        Users user2 = new Users();
        user2.setId("user2");
        user2.setPwd("password2");
        user2.setHalfLife(25); // or any other value
        user2.setCoffeeIndexes(List.of(4, 5, 6)); // or any other coffee indexes

        usersRepository.saveAll(List.of(user1, user2));
    }
    @Autowired
    public UsersService(UsersRepository usersRepository) {
        this.usersRepository = usersRepository;
    }

    public List<Users> getAllUsers() {
        return usersRepository.findAll();
    }

    public Optional<Users> getUserById(int userIndex) {
        return usersRepository.findById(userIndex);
    }

    public Users saveUser(Users user) {
        return usersRepository.save(user);
    }

    public void deleteUser(int userIndex) {
        usersRepository.deleteById(userIndex);
    }

    // You can add more methods based on your requirements
    public List<Coffee> getLikedCoffeeByUserIndex(int userIndex) {
        Optional<Users> optionalUsers = usersRepository.findById(userIndex);

        if (optionalUsers.isPresent()) {
            Users user = optionalUsers.get();
            List<Integer> likedCoffeeIndexes = user.getCoffeeIndexes();

            // 사용자가 좋아하는 커피 목록을 가져오기
            List<Coffee> likedCoffees = coffeeRepository.findAllById(likedCoffeeIndexes);

            return likedCoffees;
        }

        // 사용자를 찾을 수 없을 경우 빈 리스트 반환
        return Collections.emptyList();
    }

    @Transactional
    public Users addLikedCoffeeToUser(int userIndex, int coffeeIndex) {
        Optional<Users> optionalUsers = usersRepository.findById(userIndex);

        if (optionalUsers.isPresent()) {
            Users user = optionalUsers.get();
            List<Integer> likedCoffeeIndexes = user.getCoffeeIndexes();
            // Check if the coffeeIndex is not already in the likedCoffeeIndexes
            if (!likedCoffeeIndexes.contains(coffeeIndex)) {
                likedCoffeeIndexes.add(coffeeIndex);
                user.setCoffeeIndexes(likedCoffeeIndexes);
                for (Integer coffee : likedCoffeeIndexes)
                {
                    log.info("coffeeIndex:{}", coffee);
                }
                // Save the updated user entity to update the liked_coffee table
                Users updatedUser = usersRepository.save(user);

                // Optional: Flush the changes to the database
                usersRepository.flush();

                return updatedUser;
            }
        }

        // Return the original user entity if the user was not found or coffeeIndex was already liked
        return optionalUsers.orElse(null);
    }

    @Transactional
    public Users removeLikedCoffeeFromUser(int userIndex, int coffeeIndex) {
        Optional<Users> optionalUsers = usersRepository.findById(userIndex);

        if (optionalUsers.isPresent()) {
            Users user = optionalUsers.get();
            List<Integer> likedCoffeeIndexes = user.getCoffeeIndexes();

            // Check if the coffeeIndex is in the likedCoffeeIndexes
            if (likedCoffeeIndexes.contains(coffeeIndex)) {
                likedCoffeeIndexes.remove(Integer.valueOf(coffeeIndex)); // Remove by value
                user.setCoffeeIndexes(likedCoffeeIndexes);

                // Save the updated user entity to update the liked_coffee table
                return usersRepository.save(user);
            }
        }

        // Return the original user entity if the user was not found or coffeeIndex was not in liked list
        return optionalUsers.orElse(null);
    }
}

