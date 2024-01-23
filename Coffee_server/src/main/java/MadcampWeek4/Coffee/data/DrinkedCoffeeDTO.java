package MadcampWeek4.Coffee.data;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DrinkedCoffeeDTO {

    private int drinkedCoffeeIndex;
    private String date;
    private String time;

    // 생성자, getter, setter 등 필요한 메서드를 추가하세요
    // 기본 생성자, getter, setter 등 생략

    public int getDrinkedCoffeeIndex() {
        return drinkedCoffeeIndex;
    }

    public void setDrinkedCoffeeIndex(int drinkedCoffeeIndex) {
        this.drinkedCoffeeIndex = drinkedCoffeeIndex;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
}
