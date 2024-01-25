// package MadcampWeek4.Coffee.controller;

// import MadcampWeek4.Coffee.entity.Calendar;
// import MadcampWeek4.Coffee.service.CalendarService;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.http.ResponseEntity;
// import org.springframework.web.bind.annotation.*;

// import java.util.List;

// @RestController
// @RequestMapping("/calendar")
// public class CalendarController {

// private final CalendarService calendarService;

// @Autowired
// public CalendarController(CalendarService calendarService) {
// this.calendarService = calendarService;
// }

// @GetMapping
// public List<Calendar> getAllCalendars() {
// return calendarService.findAll();
// }

// @GetMapping("/by-drinked-coffee/{drinkedCoffeeIndex}")
// public ResponseEntity<Calendar>
// getCalendarByDrinkedCoffeeIndex(@PathVariable("drinkedCoffeeIndex") int
// drinkedCoffeeIndex) {
// List<Calendar> calendars =
// calendarService.findByDrinkedCoffeeIndex(drinkedCoffeeIndex);
// if (calendars.isEmpty()) {
// return ResponseEntity.notFound().build();
// }
// // calendars 리스트의 첫 번째 요소를 반환합니다.
// return ResponseEntity.ok(calendars.get(0));
// }

// // @GetMapping("/{id}")
// // public ResponseEntity<Calendar> getCalendarById(@PathVariable int id) {
// // return calendarService.findById(id)
// // .map(ResponseEntity::ok)
// // .orElseGet(() -> ResponseEntity.notFound().build());
// // }
// //
// // @PostMapping
// // public Calendar createCalendar(@RequestBody Calendar calendar) {
// // return calendarService.save(calendar);
// // }
// //
// // @DeleteMapping("/{id}")
// // public void deleteCalendar(@PathVariable int id) {
// // calendarService.deleteById(id);
// // }

// // 여기에 필요한 추가적인 엔드포인트를 구현할 수 있습니다.
// @PutMapping("/{id}")
// public ResponseEntity<Calendar> updateMemo(@PathVariable("id") int id,
// @RequestBody String memo) {
// Calendar updatedCalendar = calendarService.updateMemo(id, memo);
// return ResponseEntity.ok(updatedCalendar);
// }

// @PatchMapping("/clear-memo/{id}")
// public ResponseEntity<Void> clearMemo(@PathVariable("id") int id) {
// Calendar updatedCalendar = calendarService.clearMemo(id);
// return ResponseEntity.ok(updatedCalendar);
// }

// @GetMapping("/is-memo-empty/{id}")
// public ResponseEntity<Boolean> isMemoEmpty(@PathVariable("id") int id) {
// boolean isMemoEmpty = calendarService.isMemoEmpty(id);
// return ResponseEntity.ok(isMemoEmpty);
// }

// }