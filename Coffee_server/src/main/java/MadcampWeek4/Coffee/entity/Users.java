package MadcampWeek4.Coffee.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
@Entity
@Getter
@Setter
@Table(name = "users")
public class Users {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_index")
    private int userIndex;

    @Column(name = "id")
    private String id;

    @Column(name = "pwd")
    private String pwd;

    @Column(name = "half_life")
    private int halfLife;

    @Column(name = "threshold")
    private int threshold;

    // 생략된 생성자, getter, setter
}
//package MadcampWeek4.Coffee.entity;
//
//import jakarta.persistence.*;
//import lombok.Getter;
//import lombok.Setter;
//
//
//@Getter
//@Setter
//@Entity
//public class Users {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private int userIndex;
//
//    @Column(name = "id", length = 45)
//    private String id;
//
//    @Column(name = "pwd", length = 45)
//    private String pwd;
//
//    @Column(name = "half_life")
//    private int halfLife;
//
////    // Constructors
////    public User() {
////    }
//
////    // Getters and Setters
////    public int getUserIndex() {
////        return userIndex;
////    }
////
////    public void setUserIndex(int userIndex) {
////        this.userIndex = userIndex;
////    }
////
////    public String getId() {
////        return id;
////    }
////
////    public void setId(String id) {
////        this.id = id;
////    }
////
////    public String getPwd() {
////        return pwd;
////    }
////
////    public void setPwd(String pwd) {
////        this.pwd = pwd;
////    }
////
////    public int getHalfLife() {
////        return halfLife;
////    }
////
////    public void setHalfLife(int halfLife) {
////        this.halfLife = halfLife;
////    }
////
////    // toString method for debugging purposes
////    @Override
////    public String toString() {
////        return "User{" +
////                "userIndex=" + userIndex +
////                ", id='" + id + '\'' +
////                ", pwd='" + pwd + '\'' +
////                ", halfLife=" + halfLife +
////                '}';
////    }
//}