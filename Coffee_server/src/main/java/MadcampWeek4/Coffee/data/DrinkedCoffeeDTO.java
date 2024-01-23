package MadcampWeek4.Coffee.data;

import MadcampWeek4.Coffee.entity.Coffee;

public class DrinkedCoffeeDTO {

    private int drinkedCoffeeIndex;
    private String date;
    private String time;
    private Coffee coffee;
    private int size;

    // 기본 생성자
    public DrinkedCoffeeDTO() {
    }

    // 모든 필드를 매개변수로 받는 생성자
    public DrinkedCoffeeDTO(int drinkedCoffeeIndex, String date, String time, Coffee coffee, int size) {
        this.drinkedCoffeeIndex = drinkedCoffeeIndex;
        this.date = date;
        this.time = time;
        this.coffee = coffee;
        this.size = size;
    }

    // Getter 메소드들
    public int getDrinkedCoffeeIndex() {
        return drinkedCoffeeIndex;
    }

    public String getDate() {
        return date;
    }

    public String getTime() {
        return time;
    }

    public Coffee getCoffee() {
        return coffee;
    }

    public int getSize() {
        return size;
    }

    // Setter 메소드들
    public void setDrinkedCoffeeIndex(int drinkedCoffeeIndex) {
        this.drinkedCoffeeIndex = drinkedCoffeeIndex;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public void setCoffee(Coffee coffee) {
        this.coffee = coffee;
    }

    public void setSize(int size) {
        this.size = size;
    }

    @Override
    public String toString() {
        return "DrinkedCoffeeDTO{" +
                "date='" + date + '\'' +
                ", time='" + time + '\'' +
                ", coffee=" + coffee +
                ", size=" + size +
                '}';
    }
}

