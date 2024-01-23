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

    @Column(name = "coffee_name")
    private String coffee_name;

    @Column(name = "hot")

    private int hot;

    @Column(name = "tall")
    private int tall;

    @Column(name = "grande")
    private int grande;

    @Column(name = "venti")
    private int venti;

    public Coffee() {
    }

    public Coffee(String brand, String coffee_name, int hot, int tall, int grande, int venti) {
        this.brand = brand;
        this.coffee_name = coffee_name;
        this.hot = hot;
        this.tall = tall;
        this.grande = grande;
        this.venti = venti;
    }

    @Override
    public String toString() {
        return "Coffee{" +
                "coffeeIndex=" + coffeeIndex +
                ", brand='" + brand + '\'' +
                ", coffee_name='" + coffee_name + '\'' +
                ", hot=" + hot +
                ", tall=" + tall +
                ", grande=" + grande +
                ", venti=" + venti +
                '}';
    }

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

