// Expert request filters
filterSelection("all")
function filterSelection(c) {
  var x, i;
  x = document.getElementsByClassName("filterDiv");
  if (c == "all") c = "";
  // Add the "show" class (display:block) to the filtered elements, and remove the "show" class from the elements that are not selected
  for (i = 0; i < x.length; i++) {
    RemoveClass(x[i], "show");
    if (x[i].className.indexOf(c) > -1) AddClass(x[i], "show");
  }
}

// Show filtered elements
function AddClass(element, name) {
  var i, arr1, arr2;
  arr1 = element.className.split(" ");
  arr2 = name.split(" ");
  for (i = 0; i < arr2.length; i++) {
    if (arr1.indexOf(arr2[i]) == -1) {
      element.className += " " + arr2[i];
    }
  }
}

// Hide elements that are not selected
function RemoveClass(element, name) {
  var i, arr1, arr2;
  arr1 = element.className.split(" ");
  arr2 = name.split(" ");
  for (i = 0; i < arr2.length; i++) {
    while (arr1.indexOf(arr2[i]) > -1) {
      arr1.splice(arr1.indexOf(arr2[i]), 1);
    }
  }
  element.className = arr1.join(" ");
}

// Add activeBtn class to the current control button (highlight it)
var btnContainer = document.getElementById("myBtnContainer");
// var btns = btnContainer.getElementsByClassName("btnFilter");
// for (var i = 0; i < btns.length; i++) {
//   btns[i].addEventListener("click", function(){
//     var current = document.getElementsByClassName("activeBtn");
//     current[0].className = current[0].className.replace(" activeBtn", "");
//     this.className += " activeBtn";
//   });
// }

// jQuery(document).ready(function($) {
//   //CALENDAR scripts
//   var currentMonth = moment().format('YYYY-MM');
//   var nextMonth    = moment().add(1,'month').format('YYYY-MM');
//   var events = [
//   { date: currentMonth + '-' + '10', title: 'Persian Kitten Auction', location: 'Center for Beautiful Cats' },
//   { date: currentMonth + '-' + '19', title: 'Cat Frisbee', location: 'Jefferson Park' },
//   { date: currentMonth + '-' + '23', title: 'Kitten Demonstration', location: 'Center for Beautiful Cats' },
//   { date: nextMonth + '-' + '07',    title: 'Small Cat Photo Session', location: 'Center for Cat Photography' }
//   ];

//   $('#calendar').clndr({
//     template: $('#calendar-template').html(),
//     events: events,
//     clickEvents: {
//       click: function(target) {
//         if(target.events.length) {
//           var daysContainer = $('#calendar').find('.days-container');
//           daysContainer.toggleClass('show-events', true);
//           $('#calendar').find('.x-button').click( function() {
//             daysContainer.toggleClass('show-events', false);
//           });
//         }
//       }
//     },
//     adjacentDaysChangeMonth: true
//   });

//   //Charts controls
//   $(".data-attributes span").peity("donut");
// });
