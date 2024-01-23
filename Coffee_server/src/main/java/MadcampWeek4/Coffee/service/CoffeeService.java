package MadcampWeek4.Coffee.service;


import MadcampWeek4.Coffee.entity.Coffee;
import MadcampWeek4.Coffee.repository.CoffeeRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Service
@Slf4j
public class CoffeeService {

    private final CoffeeRepository coffeeRepository;

    public CoffeeService(CoffeeRepository coffeeRepository) {
        this.coffeeRepository = coffeeRepository;
    }

    @Transactional
    public void importCoffeeDataFromJson() {
        try {
            // JSON 파일 경로
            String jsonFilePath = "src/main/resources/data/coffee.json";

            // JSON 데이터 읽기
            List<Object[]> coffeeDataList = readJsonData(jsonFilePath);

            // 데이터베이스에 저장
            saveToDatabase(coffeeDataList);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private List<Object[]> readJsonData(String jsonFilePath) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        // JSON 파일을 읽어 List<Object[]> 형태로 변환
        return Arrays.asList(objectMapper.readValue(new File(jsonFilePath), Object[][].class));
    }

    private void saveToDatabase(List<Object[]> coffeeDataList) {
        for (Object[] coffeeData : coffeeDataList) {
            Coffee coffee = new Coffee();
            coffee.setBrand((String) coffeeData[1]);
            coffee.setCoffeeName((String) coffeeData[2]);
            coffee.setHot((int) coffeeData[3]);
            coffee.setTall((int) coffeeData[4]);
            coffee.setGrande((int) coffeeData[5]);
            coffee.setVenti((int) coffeeData[6]);
            log.info("saveToDatabase :{}", coffee.toString());
            coffeeRepository.save(coffee);
        }
    }
    @Transactional(readOnly = true)
    public Coffee getCoffeeByIndex(int coffeeIndex) {
        return coffeeRepository.findById(coffeeIndex).orElse(null);
    }

    @Transactional(readOnly = true)
    public Coffee hotToCold(int coffeeIndex) {
        Coffee hotCoffee = coffeeRepository.findById(coffeeIndex).orElse(null);

        if (hotCoffee != null) {
            String coldCoffeeName = "아이스 " + hotCoffee.getCoffeeName();
            return coffeeRepository.findByCoffeeName(coldCoffeeName).orElse(null);
        }

        return null;
    }

    public List<Coffee> getCoffeeByBrand(String brand) {
        return coffeeRepository.findByBrand(brand);
    }
}

