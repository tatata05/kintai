//インストールしたファイルたちを呼び出す
import { Calendar} from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
import timeGridPlugin from '@fullcalendar/timegrid';

//<div id='calendar'></div>のidからオブジェクトを定義してカレンダーを作る
document.addEventListener('turbolinks:load', function() {
    var calendarEl = document.getElementById('calendar');

    //カレンダーの中身を設定
    var calendar = new Calendar(calendarEl, {
        plugins: [ timeGridPlugin, interactionPlugin ],
        //細かな表示設定
        locale: 'ja',
        timeZone: 'Asia/Tokyo',
        firstDay: 1,
        headerToolbar: {
          start: '',
          center: 'title',
          end: 'today prev,next' 
        },
        expandRows: true,
        stickyHeaderDates: true,
        allDaySlot: false,
        slotEventOverlap: false,
        buttonText: {
           today: '今日'
        }, 
        height: "auto",
        events: '/employee/shifts.json'
    });
    //カレンダー表示
    calendar.render();
});
