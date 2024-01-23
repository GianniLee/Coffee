package MadcampWeek4.Coffee.utils;

import MadcampWeek4.Coffee.data.DrinkedCoffeeDTO;
import MadcampWeek4.Coffee.entity.DrinkedCoffee;

public class DTOConverter {
    public static DrinkedCoffeeDTO convertToDto(DrinkedCoffee drinkedCoffee) {
        DrinkedCoffeeDTO dto = new DrinkedCoffeeDTO();
        dto.setDrinkedCoffeeIndex(drinkedCoffee.getDrinkedCoffeeIndex());
        dto.setDate(drinkedCoffee.getDate());
        dto.setTime(drinkedCoffee.getTime());
        dto.setCoffee(drinkedCoffee.getCoffee()); // Coffee 객체 설정
        dto.setSize(drinkedCoffee.getSize());
        return dto;
    }
}
