package MadcampWeek4.Coffee.entity;

import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.Setter;

import jakarta.persistence.*;


@Getter
@Setter
@Entity
@Table(name = "coffee")
public class Coffee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "coffee_index")
    private int coffeeIndex;

    @Column(name = "brand")
    private String brand;

    @Column(name = "caffeine")
    private int caffeine;

    @Column(name = "hot")
    private boolean hot;

    // 생략된 생성자, getter, setter
}
//@Entity
//public class Coffee {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    @Column(name = "coffee_index")
//    private int coffeeIndex;
//
//    @Column(name = "brand")
//    private String brand;
//
//    @Column(name = "caffeine")
//    private int caffeine;
//
//    @Column(name = "is_hot")
//    private boolean hot;
//
//    // Constructors
//    public Coffee() {
//    }

//    // Getters and Setters
//    public int getCoffeeIndex() {
//        return coffeeIndex;
//    }
//
//    public void setCoffeeIndex(int coffeeIndex) {
//        this.coffeeIndex = coffeeIndex;
//    }
//
//    public String getBrand() {
//        return brand;
//    }
//
//    public void setBrand(String brand) {
//        this.brand = brand;
//    }
//
//    public int getCaffeine() {
//        return caffeine;
//    }
//
//    public void setCaffeine(int caffeine) {
//        this.caffeine = caffeine;
//    }
//
//    public boolean isHot() {
//        return hot;
//    }
//
//    public void setHot(boolean hot) {
//        this.hot = hot;
//    }
//
//    // toString method for debugging purposes
//    @Override
//    public String toString() {
//        return "Coffee{" +
//                "coffeeIndex=" + coffeeIndex +
//                ", brand='" + brand + '\'' +
//                ", caffeine=" + caffeine +
//                ", hot=" + hot +
//                '}';
//    }

