package MadcampWeek4.Coffee.service;

import MadcampWeek4.Coffee.entity.Calendar;
import MadcampWeek4.Coffee.repository.CalendarRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CalendarService {

    private final CalendarRepository calendarRepository;

    @Autowired
    public CalendarService(CalendarRepository calendarRepository) {
        this.calendarRepository = calendarRepository;
    }

    public List<Calendar> findAll() {
        return calendarRepository.findAll();
    }

    public List<Calendar> findByDrinkedCoffeeIndex(int drinkedCoffeeIndex) {
        return calendarRepository.findByDrinkedCoffee_DrinkedCoffeeIndex(drinkedCoffeeIndex);
    }

//    public Optional<Calendar> findById(int id) {
//        return calendarRepository.findById(id);
//    }
//
//    public Calendar save(Calendar calendar) {
//        // drinkedCoffeeIndex에 대한 중복 체크
//        Optional<Calendar> existingCalendar = calendarRepository.findByDrinkedCoffee_DrinkedCoffeeIndex(calendar.getDrinkedCoffee().getDrinkedCoffeeIndex());
//        if (existingCalendar.isPresent()) {
//            // 중복된 경우, 예외 처리 또는 오류 메시지 반환
//            throw new IllegalStateException("Calendar entry with this drinkedCoffeeIndex already exists.");
//        }
//        return calendarRepository.save(calendar);
//    }
//
//    public void deleteById(int id) {
//        calendarRepository.deleteById(id);
//    }

    // 여기에 필요한 추가적인 비즈니스 로직을 구현할 수 있습니다.
    public Calendar updateMemo(int calendarId, String newMemo) {
        Calendar calendar = calendarRepository.findById(calendarId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid calendar Id: " + calendarId));
        calendar.setMemo(newMemo);
        return calendarRepository.save(calendar);
    }

    public void clearMemo(int calendarId) {
        Calendar calendar = calendarRepository.findById(calendarId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid calendar Id: " + calendarId));
        calendar.setMemo("");
        calendarRepository.save(calendar);
    }

    public boolean isMemoEmpty(int calendarId) {
        Calendar calendar = calendarRepository.findById(calendarId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid calendar Id: " + calendarId));
        return calendar.getMemo() == null || calendar.getMemo().isEmpty();
    }
}
