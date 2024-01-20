package MadcampWeek4.Coffee.entity;

import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.Setter;
import jakarta.persistence.*;

@Getter
@Setter
@Entity
@Table(name = "drinked_coffee")
public class DrinkedCoffee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int drinkedCoffeeIndex;

    @ManyToOne
    @JoinColumn(name = "user_index", referencedColumnName = "user_index")
    private Users user;

    @ManyToOne
    @JoinColumn(name = "coffee_index", referencedColumnName = "coffee_index")
    private Coffee coffee;

    @Column(name = "date")
    private String date;

    @Column(name = "time")
    private String time;

    // 생략된 생성자, getter, setter


//    // Getters and Setters
//    public User getUser() {
//        return user;
//    }
//
//    public void setUser(User user) {
//        this.user = user;
//    }
//
//    public Coffee getCoffee() {
//        return coffee;
//    }
//
//    public void setCoffee(Coffee coffee) {
//        this.coffee = coffee;
//    }
//
//    public String getDate() {
//        return date;
//    }
//
//    public void setDate(String date) {
//        this.date = date;
//    }
//
//    public String getTime() {
//        return time;
//    }
//
//    public void setTime(String time) {
//        this.time = time;
//    }
//
//    // toString method for debugging purposes
//    @Override
//    public String toString() {
//        return "DrinkedCoffee{" +
//                "user=" + user +
//                ", coffee=" + coffee +
//                ", date='" + date + '\'' +
//                ", time='" + time + '\'' +
//                '}';
//    }
}
