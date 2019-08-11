$(document).ready(function () {

  // $(".week-day, .no-week-day").on("click", function () {
  //   if ($(this).attr('class') === 'week-day') {
  //     $(this).removeClass("week-day");
  //     $(this).addClass("no-week-day");
  //     var checkBoxSelector = $(this).find('input');
  //     checkBoxSelector.attr('checked', true);
  //     document.getElementById($(this).attr('id')).style.backgroundColor = "#c3deb7";
  //   } else {
  //     $(this).removeClass("no-week-day");
  //     $(this).addClass("week-day");
  //     var checkBoxSelector = $(this ).find('input');
  //     checkBoxSelector.attr('checked', false);
  //     document.getElementById($(this).attr('id')).style.backgroundColor = "#ffffff";
  //   }
  // });

  $(".destory_user_skill").on("click", function () {
    $("#user_skill_label_" + $(this).attr('id')).fadeOut('fast');
    $.ajax({
      url: '/ajax_calls/destory_user_skill?user_skill_id=' + $(this).attr('id')
    });
  });

  $(".destory_user_language").on("click", function () {
    $("#user_language_label_" + $(this).attr('id')).fadeOut('fast');
    $.ajax({
      url: '/ajax_calls/destory_user_language?user_language_id=' + $(this).attr('id')
    });
  });
});
