package MadcampWeek4.Coffee.service;

import MadcampWeek4.Coffee.data.DrinkedCoffeeDTO;
import MadcampWeek4.Coffee.utils.DTOConverter;
import MadcampWeek4.Coffee.entity.Coffee;
import MadcampWeek4.Coffee.entity.DrinkedCoffee;
import MadcampWeek4.Coffee.entity.Users;
// import MadcampWeek4.Coffee.repository.CalendarRepository;
import MadcampWeek4.Coffee.repository.CoffeeRepository;
import MadcampWeek4.Coffee.repository.DrinkedCoffeeRepository;
import MadcampWeek4.Coffee.repository.UsersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DrinkedCoffeeService {

    @Autowired
    private DrinkedCoffeeRepository drinkedCoffeeRepository;

    @Autowired
    private UsersRepository usersRepository;

    @Autowired
    private CoffeeRepository coffeeRepository;

    // @Autowired
    // private CalendarRepository calendarRepository;

    @Transactional
    public void createDummyDrinkedCoffee() {
        Users user1 = usersRepository.findById(1).orElse(null);
        Users user2 = usersRepository.findById(2).orElse(null);

        Coffee coffee1 = coffeeRepository.findById(1).orElse(null);
        Coffee coffee2 = coffeeRepository.findById(2).orElse(null);

        // Check if the required entities exist
        if (user1 != null && user2 != null && coffee1 != null && coffee2 != null) {
            // Creating dummy DrinkedCoffee entries
            DrinkedCoffee drinkedCoffee1 = new DrinkedCoffee();
            drinkedCoffee1.setUser(user1);
            drinkedCoffee1.setCoffee(coffee1);
            drinkedCoffee1.setDate("2024-01-24");
            drinkedCoffee1.setTime("21:00:00");
            drinkedCoffee1.setSize(1);

            DrinkedCoffee drinkedCoffee2 = new DrinkedCoffee();
            drinkedCoffee2.setUser(user1);
            drinkedCoffee2.setCoffee(coffee2);
            drinkedCoffee2.setDate("2024-01-25");
            drinkedCoffee2.setTime("12:30:00");
            drinkedCoffee1.setSize(2);

            DrinkedCoffee drinkedCoffee3 = new DrinkedCoffee();
            drinkedCoffee3.setUser(user2);
            drinkedCoffee3.setCoffee(coffee1);
            drinkedCoffee3.setDate("2024-01-25");
            drinkedCoffee3.setTime("2:45:00");
            drinkedCoffee1.setSize(0);

            // Save the dummy DrinkedCoffee entries
            drinkedCoffeeRepository.saveAll(Arrays.asList(drinkedCoffee1, drinkedCoffee2, drinkedCoffee3));
        }
    }

    @Transactional
    public DrinkedCoffee createAndSaveDrinkedCoffee(int userIndex, int coffeeIndex, int size, String date,
            String time) {
        // Find user and coffee entities by their indices
        Users user = usersRepository.findById(userIndex).orElse(null);
        Coffee coffee = coffeeRepository.findById(coffeeIndex).orElse(null);

        if (user == null || coffee == null) {
            // Handle the case where user or coffee is not found
            // You might throw an exception or return null based on your design choice
            return null;
        }

        // Create a new DrinkedCoffee object
        DrinkedCoffee drinkedCoffee = new DrinkedCoffee();
        drinkedCoffee.setUser(user);
        drinkedCoffee.setCoffee(coffee);
        drinkedCoffee.setSize(size);
        drinkedCoffee.setDate(date);
        drinkedCoffee.setTime(time);

        // Save the DrinkedCoffee object to the database
        DrinkedCoffee savedDrinkedCoffee = drinkedCoffeeRepository.save(drinkedCoffee);

        // Return the saved object, which includes the generated drinkedCoffeeIndex
        return savedDrinkedCoffee;
    }

    @Transactional
    public List<DrinkedCoffee> getDrinkedCoffeeByUserIndex(int userIndex) {
        Users user = usersRepository.findById(userIndex).orElse(null);

        if (user != null) {
            return drinkedCoffeeRepository.findByUser(user);
        }

        return List.of(); // 사용자가 없으면 빈 목록 반환
    }

    // @Transactional
    // public List<DrinkedCoffee> getDrinkedCoffeeByUserIndex(int userIndex) {
    // Users user = usersRepository.findById(userIndex).orElse(null);
    //
    // if (user != null) {
    // return drinkedCoffeeRepository.findByUser(user);
    // }
    //
    // return List.of(); // 사용자가 없으면 빈 목록 반환
    // }
    // @Transactional
    // public DrinkedCoffee createAndSaveDrinkedCoffee(DrinkedCoffee drinkedCoffee)
    // {
    // DrinkedCoffee savedDrinkedCoffee =
    // drinkedCoffeeRepository.save(drinkedCoffee);

    // // DrinkedCoffee 생성 시 Calendar도 생성
    // Calendar newCalendar = new Calendar();
    // newCalendar.setDrinkedCoffee(savedDrinkedCoffee);
    // newCalendar.setMemo(""); // 초기 메모는 비어있음
    // calendarRepository.save(newCalendar);

    // return savedDrinkedCoffee;
    // }

}
