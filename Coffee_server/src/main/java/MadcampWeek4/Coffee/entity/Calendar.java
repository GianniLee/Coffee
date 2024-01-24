package MadcampWeek4.Coffee.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "calendar")
public class Calendar {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int calendarIndex;

    @ManyToOne
    @JoinColumn(name = "drinkedCoffeeIndex", referencedColumnName = "drinkedCoffeeIndex", unique = true)
    private DrinkedCoffee drinkedCoffee;

    @Column(name = "memo", columnDefinition = "TEXT")
    private String memo;

    // 생략된 생성자, getter, setter
}
