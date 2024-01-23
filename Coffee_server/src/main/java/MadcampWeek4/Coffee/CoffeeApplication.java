package MadcampWeek4.Coffee;

import MadcampWeek4.Coffee.service.CoffeeService;
import MadcampWeek4.Coffee.service.UsersService;
import MadcampWeek4.Coffee.service.DrinkedCoffeeService;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
public class CoffeeApplication {

	public static void main(String[] args) {
		SpringApplication.run(CoffeeApplication.class, args);
	}

	@Autowired
	private UsersService usersService;
	@Autowired
	private CoffeeService coffeeService;
	@Autowired
	private DrinkedCoffeeService drinkedCoffeeService;

	@PostConstruct
	public void init(){
		// Import coffee data
		coffeeService.importCoffeeDataFromJson();

		// Create dummy users
		usersService.createDummyUsers();
		drinkedCoffeeService.createDummyDrinkedCoffee();
	}


}
