// $(document).ready(function () {

//   if (controller_name === 'experts_onboarding' && action_name === 'services') {
//     $.ajax({
//       url: '/ajax_calls/get_my_services',
//       dataType: 'jsonp',
//       error: function (xhr, status, error) {
//         console.log(error);
//       },
//       success: function (my_services) {
//         for (var y = 0; y < my_services.services.length; ++y) {
//           document.getElementById(my_services.services[y]).checked = true;
//         }
//         if ($(".check-expert-type:checkbox:checked").length > 0) {
//           $("#submit-three").fadeIn('fast');
//         } else {
//           $("#submit-three").fadeOut('fast');
//         }
//       }
//     });

//     $(".check-expert-type").on("click", function () {
//       if (this.checked) {
//         $.ajax({
//           method: 'POST',
//           beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
//           url: '/ajax_calls/save_service?expert_type_id=' + $(this).attr('id')
//         });
//       } else {
//         $.ajax({
//           url: '/ajax_calls/destory_expert_expert_type?expert_expert_type_id=' + $(this).attr('id')
//         });
//       }
//       if ($(".check-expert-type:checkbox:checked").length > 0) {
//         $("#submit-three").fadeIn('fast');
//       } else {
//         $("#submit-three").fadeOut('fast');
//       }
//     });
//   }

//   if (controller_name === 'experts_onboarding' && action_name === 'languages') {
//     $.ajax({
//       url: '/ajax_calls/get_my_languages',
//       dataType: 'jsonp',
//       error: function (xhr, status, error) {
//         console.log(error);
//       },
//       success: function (my_services) {
//         for (var y = 0; y < my_services.services.length; ++y) {
//           document.getElementById(my_services.services[y]).checked = true;
//         }
//         if ($(".check-language:checkbox:checked").length > 0) {
//           $("#submit-four").fadeIn('fast');
//         } else {
//           $("#submit-four").fadeOut('fast');
//         }
//       }
//     });

//     $(".check-language").on("click", function () {
//       if (this.checked) {
//         $.ajax({
//           method: 'POST',
//           beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
//           url: '/ajax_calls/save_language?language_id=' + $(this).attr('id')
//         });
//       } else {
//         $.ajax({
//           url: '/ajax_calls/destroy_expert_language?language_id=' + $(this).attr('id')
//         });
//       }
//       if ($(".check-language:checkbox:checked").length > 0) {
//         $("#submit-four").fadeIn('fast');
//       } else {
//         $("#submit-four").fadeOut('fast');
//       }
//     });
//   }


//   if (controller_name === 'experts_onboarding' && action_name === 'last_positions') {
//     $.ajax({
//       url: '/ajax_calls/get_my_last_positions',
//       dataType: 'jsonp',
//       error: function (xhr, status, error) {
//         console.log(error);
//       },
//       success: function (my_services) {
//         for (var y = 0; y < my_services.services.length; ++y) {
//           document.getElementById(my_services.services[y]).checked = true;
//         }
//         if ($(".check-last_position:checkbox:checked").length > 0) {
//           $("#submit-four").fadeIn('fast');
//         } else {
//           $("#submit-four").fadeOut('fast');
//         }
//       }
//     });

//     $(".check-last_position").on("click", function () {
//       if (this.checked) {
//         $.ajax({
//           method: 'POST',
//           beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
//           url: '/ajax_calls/save_last_position?last_position_id=' + $(this).attr('id')
//         });
//       } else {
//         $.ajax({
//           url: '/ajax_calls/destroy_expert_last_position?last_position_id=' + $(this).attr('id')
//         });
//       }
//       if ($(".check-last_position:checkbox:checked").length > 0) {
//         $("#submit-four").fadeIn('fast');
//       } else {
//         $("#submit-four").fadeOut('fast');
//       }
//     });
//   }


//   if (controller_name === 'experts_onboarding' && action_name === 'skills') {
//     $.ajax({
//       url: '/ajax_calls/get_my_sub_skills',
//       dataType: 'jsonp',
//       error: function (xhr, status, error) {
//         console.log(error);
//       },
//       success: function (my_services) {
//         for (var y = 0; y < my_services.services.length; ++y) {
//           document.getElementById(my_services.services[y]).checked = true;
//         }
//         for (var w = 0; w < my_services.skills.length; ++w) {
//           var name_skill = my_services.skills[w].replace(/ /g,"_");
//           document.getElementById(name_skill).checked = true;
//         }
//         if ($(".check-sub_skill:checkbox:checked").length > 0) {
//           $("#submit-eleven").fadeIn('fast');
//         } else {
//           $("#submit-eleven").fadeOut('fast');
//         }
//       }
//     });

//     $(".check-sub_skill").on("click", function () {
//       if (this.checked) {
//         $.ajax({
//           method: 'POST',
//           url: '/ajax_calls/save_sub_skill?sub_skill_id=' + $(this).attr('id')
//         });
//       } else {
//         $.ajax({
//           url: '/ajax_calls/destroy_expert_sub_skill?sub_skill_id=' + $(this).attr('id')
//         });
//       }
//       if ($(".check-sub_skill:checkbox:checked").length > 0) {
//         $("#submit-eleven").fadeIn('fast');
//       } else {
//         $("#submit-eleven").fadeOut('fast');
//       }
//     });
//   }
//   if (controller_name === 'experts_onboarding' && action_name === 'degrees') {
//     getMyDegrees();
//     $("#save-degree-from").on("ajax:success", function (e, object, status, xhr) {
//       if (object.status === 1) {
//         var obj_json = JSON.parse(object.data);

//         var degree_end_date = obj_json.end_date !== null ? obj_json.end_date : "Present";

//         $(".div-to-add").append('<div class="panel"><div class="panel-header panel-primary"><span class="text-md" style="color:white">' + obj_json.title + " - " + obj_json.school + " (" + obj_json.location + ")" + '</span><div class="panel-actions"><ul style="color:white"><li class="action degree-update" data-description="'+ obj_json.description +'" data-end='+ degree_end_date +' data-id="' + obj_json.id + '" data-location="'+ obj_json.location +'" data-school="'+obj_json.school+'" data-start="'+ obj_json.start_date +'" data-title="'+ obj_json.title +'"><span style="color:white"><i class="fa fa-pencil"></i></span></li><li class="action degree" data-action="close" data-toggle="block-option" id="' + obj_json.id + '" type="button"><span style="color:white"><i class="fa fa-close"></i></span></li></ul></div></div><div class="panel-content text-md" style="text-align:justify"><p>' + obj_json.location + "(" + obj_json.start_date + ' - ' + degree_end_date + ')' + '</p></div></div>')
//         $(".cancel").hide()
//         if (document.getElementById('degree_current').checked) {
//           $("#degree_current").trigger('click');
//         }
//         $(':input','#save-degree-from')
//         .not(':button, :submit, :reset, :hidden, :checkbox')
//         .val('')
//         .removeAttr('checked')
//         .removeAttr('selected');


//       } else {
//         var obj_json = JSON.parse(object.data);
//         $(".div-to-add").append("<p style='color: red;'>" + obj_json + "</p>")
//       }
//       $(".degree").on("click", function () {
//         $(this).closest(".panel").hide()
//         $.ajax({
//           url: 'experts/education_histories/destroy' + $(this).attr('id'),
//           success: function (result) {
//             getMyDegrees();
//           }
//         });
//       });
//       $(".degree-update").on("click", function () {
//         var school = $(this).data("school");
//         var title = $(this).data("title");
//         var location = $(this).data("location");
//         var description = $(this).data("description");
//         var start = $(this).data("start");
//         var end = $(this).data("end");
//         $("#degree").val(degree);
//         $("#field_of_study").val(field_of_study);
//         $("#location").val(location);
//         $("#description").val(description);
//         $("#from_date").val(from_date);
//         $("#to_date").val(to_date);
//         $(this).closest(".panel").hide()

//         $.ajax({
//           url: '/experts/education_histories/destroy' + $(this).data("id"),
//           success: function (result) {
//             getMyDegrees();
//           }
//         });
//       });



//       getMyDegrees();
//     });
//   }

//   $(':input').on('input', function (e) {
//     $(".cancel").show()
//     $(".continue").hide()
//   });

//   $('select').on('change', function (e) {
//     $(".cancel").show()
//     $(".continue").hide()
//   });

//   $(".cancel").click(function(){
//     $(':input')
//     .not(':button, :submit, :reset, :hidden')
//     .val('')
//     .removeAttr('checked')
//     .removeAttr('selected');
//     $(".cancel").hide();
//     getMyDegrees();
//     getMyWorkIndustries();
//     getMyPositions();
//     getMyCareerHighlights();
//   })

//   if (controller_name === 'experts_onboarding' && action_name === 'work_industries') {
//     getMyWorkIndustries();
//     $("#work-industry-from").on("ajax:success", function (e, object, status, xhr) {
//       if (object.status === 1) {
//         var obj_json = JSON.parse(object.data);
//         $(".div-to-add").append('<div class="expert_work_industry_label" id="expert_work_industry_' + obj_json.id +'"><label>' + obj_json.name + ' (' + obj_json.experience_years + ' years)' + '</label><a href="#" style="margin-left:10px;" class = "update_expert_work_industry" data-experience="'+ obj_json.experience_years +'" data-id ="' + obj_json.work_industry_id + '" data-id2 ="' + obj_json.id + '" href="#" ><i class="fa fa-pencil"></i></a><a href="#" style="margin-left:10px;" class = "destory_expert_work_industry" id ="' + obj_json.id + '" href="#" ><i class="fa fa-trash"></i></a></div>')
//         $(".cancel").hide()
//         $(':input','#work-industry-from')
//         .not(':button, :submit, :reset, :hidden')
//         .val('')
//         .removeAttr('checked')
//         .removeAttr('selected');
//       } else {
//         $(".add-industries").append('<p style="color: red;">' + obj_json + '</p>');

//       }
//       getMyWorkIndustries();
//       $(".destory_expert_work_industry").on("click", function () {
//         $("#expert_work_industry_" + $(this).attr('id')).fadeOut('fast');
//         $.ajax({
//           url: '/ajax_calls/destory_expert_work_industry?expert_work_industry_id=' + $(this).attr('id'),
//           success: function (result) {
//             getMyWorkIndustries();
//           }
//         });

//       });
//       $(".update_expert_work_industry").on("click", function () {
//         var id = $(this).data("id")
//         var years = $(this).data("experience")
//         $("#experience_years").val(years);
//         $("#work_industry").val(id);

//         $(this).closest("div").fadeOut('fast');
//         $.ajax({
//           url: '/ajax_calls/destory_expert_work_industry?expert_work_industry_id=' + $(this).data('id2'),
//           success: function (result) {
//             getMyWorkIndustries();
//           }
//         });

//       });
//     });
// //    $.ajax({
// //      url: '/ajax_calls/destory_expert_expert_type?expert_expert_type_id=' + $(this).attr('id')
// //    });
//   }

//   if (controller_name === 'experts_onboarding' && action_name === 'positions') {
//     getMyPositions();
//     $("#position-from").on("ajax:success", function (e, object, status, xhr) {
//       if (object.status === 1) {
//         var obj_json = JSON.parse(object.data);
//         var position_end_date = obj_json.end_date !== null ? obj_json.end_date : "Present";
//         $(".add-positions-posi").append('<div class="panel"><div class="panel-header panel-primary"><span class="text-md" style="color:white">' + obj_json.title + " - " + obj_json.company + " (" + obj_json.location + ")" + '</span><div class="panel-actions"><ul style="color:white"><li class="action position-update" data-company="' + obj_json.company + '" data-description="' + obj_json.description + '" data-end="' + position_end_date + '" data-id="' + obj_json.id + '" data-location="' + obj_json.location + '" data-start="' + obj_json.start_date + '" data-title="' + obj_json.title + '" data-toggle="block-option" data-website="' + obj_json.website + '" type="button"><span style="color:white"><i class="fa fa-pencil"></i></span></li><li class="action position" data-action="close" data-toggle="block-option" id="' + obj_json.id + '" type="button"><span style="color:white"><i class="fa fa-close"></i></span></li></ul></div></div><div class="panel-content text-md" style="text-align:justify"><p>' + obj_json.location + "(" + obj_json.start_date + " - "+ position_end_date +')'+'</p></div></div>')
//         getMyPositions();
//         $(".cancel").hide();
//         if ($("#degree_current").is(':checked')) {
//           $("#degree_current").trigger('click');
//         }
//         $(':input','#position-from')
//         .not(':button, :submit, :reset, :hidden, :checkbox')
//         .val('')
//         .removeAttr('checked')
//         .removeAttr('selected');

//       } else {
//         $(".add-positions-posi").append("<p style='color: red;'>" + obj_json + "</p>")
//       }
//       $(".position").on("click", function () {
//         $(this).closest(".panel").hide()
//         $.ajax({
//           url: '/ajax_calls/destroy_position?position_id=' + $(this).attr('id'),
//           success: function (result) {
//             getMyPositions();
//           }
//         });
//       });
//       $(".position-update").on("click", function () {
//         var company = $(this).data("company");
//         var title = $(this).data("title");
//         var location = $(this).data("location");
//         var description = $(this).data("description");
//         var start = $(this).data("start");
//         var end = $(this).data("end");
//         var website = $(this).data("website");
//         $("#title").val(title);
//         $("#company").val(company);
//         $("#location").val(location);
//         $("#description").val(description);
//         $("#start_date3").val(start);
//         $("#end_date3").val(end);
//         $("#website").val(website);
//         $(this).closest(".panel").hide()
//         $.ajax({
//           url: '/ajax_calls/destroy_position?position_id=' + $(this).data('id'),
//           success: function (result) {
//             getMyPositions();
//           }
//         });
//       });
//       getMyPositions();
//     });
// //    $.ajax({
// //      url: '/ajax_calls/destroy_position?position_id=' + $(this).attr('id')
// //    });
//   }

//   if (controller_name === 'experts_onboarding' && action_name === 'career_highlights') {
//     getMyCareerHighlights();
//     $("#career-highlight-from").on("ajax:success", function (e, object, status, xhr) {
//       if (object.status === 1) {
//         var obj_json = JSON.parse(object.data);
//         console.log(obj_json)
//         getMyCareerHighlights();
//         $(".add-career_highlight").append('<div class="career_highlight_label" id="career_highlight_'+ obj_json.id +'"><label>' + obj_json.name + '</label><a href="#" class = "update_career_highlight", data-id ="'+ obj_json.id +'", data-name ="'+ obj_json.name +'", data-description ="'+ obj_json.description +'", data-date ="'+ obj_json.achievement_date +'" style="margin-left:10px;" ><i class="fa fa-pencil"></i></a><a href="#" style="margin-left:10px;" class = "destory_career_highlight", id ="'+ obj_json.id +'" ><i class="fa fa-trash"></i></a></div>')
//         $(".cancel").hide()
//         $(':input','#career-highlight-from')
//         .not(':button, :submit, :reset, :hidden')
//         .val('')
//         .removeAttr('checked')
//         .removeAttr('selected');
//         if (document.getElementById('degree_highest').checked) {
//           $("#degree_highest").trigger('click');
//         }

//       } else {
//         $(".add-career_highlight").append("<p style='color: red;'>" + obj_json + "</p>")
//         getMyCareerHighlights();
//       }
//       $(".destory_career_highlight").on("click", function () {
//         $("#career_highlight_" + $(this).attr('id')).fadeOut('fast');
//         $("#career_highlight_" + $(this).attr('id')).hide();
//         $.ajax({
//           url: '/ajax_calls/destory_career_highlight?career_highlight_id=' + $(this).attr('id'),
//           success: function(result){
//             getMyCareerHighlights();
//           }
//         });
//       });
//       $(".update_career_highlight").on("click", function () {
//         var name = $(this).data("name")
//         var description = $(this).data("description")
//         var date = $(this).data("date")
//         $("#name").val(name);
//         $("#description").val(description);
//         $("#career_highlight_achievement_date").val(date);
//         $("#career_highlight_" + $(this).data('id')).fadeOut('fast');
//         $("#career_highlight_" + $(this).data('id')).hide();
//         $.ajax({
//           url: '/ajax_calls/destory_career_highlight?career_highlight_id=' + $(this).data('id'),
//           success: function(result){
//             getMyCareerHighlights();
//           }
//         });
//       });
//     });
//   }

//   $("#checkboxCustom2").change(function () {
//     if (this.checked) {
//       $("#accept-privacy-policy").prop('disabled', false);
//     } else {
//       $("#accept-privacy-policy").prop('disabled', true);
//     }
//   });

//   $(".destory_advisr_expert_type").on("click", function () {
//     $("#advisr_expert_type_" + $(this).attr('id')).fadeOut('fast');
//     $.ajax({
//       url: '/ajax_calls/destory_expert_expert_type?expert_expert_type_id=' + $(this).attr('id')
//     });
//   });

//   $(".destory_expert_last_position").on("click", function () {
//     $("#expert_last_position_" + $(this).attr('id')).fadeOut('fast');
//     $.ajax({
//       url: '/ajax_calls/destory_expert_last_position?expert_last_position_id=' + $(this).attr('id')
//     });
//   });

//   $(".destory_expert_work_industry").on("click", function () {
//     $("#expert_work_industry_" + $(this).attr('id')).fadeOut('fast');
//     $.ajax({
//       url: '/ajax_calls/destory_expert_work_industry?expert_work_industry_id=' + $(this).attr('id'),
//       success: function (result) {
//         getMyWorkIndustries();
//       }
//     });

//   });

//   $(".update_expert_work_industry").on("click", function () {
//     var id = $(this).data("id")
//     var years = $(this).data("experience")
//     $("#experience_years").val(years);
//     $("#work_industry").val(id);

//     $(this).closest("div").fadeOut('fast');
//     $.ajax({
//       url: '/ajax_calls/destory_expert_work_industry?expert_work_industry_id=' + $(this).data('id2'),
//       success: function (result) {
//         getMyWorkIndustries();
//       }
//     });

//   });

//   $(".destory_career_highlight").on("click", function () {
//     $("#career_highlight_" + $(this).attr('id')).fadeOut('fast');
//     $.ajax({
//       url: '/ajax_calls/destory_career_highlight?career_highlight_id=' + $(this).attr('id'),
//       success: function(result){
//         getMyCareerHighlights();
//       }
//     });
//   });

//   $(".update_career_highlight").on("click", function () {
//     var name = $(this).data("name")
//     var description = $(this).data("description")
//     var date = $(this).data("date")
//     $("#name").val(name);
//     $("#description").val(description);
//     $("#career_highlight_achievement_date").val(date);
//     $("#career_highlight_" + $(this).data('id')).fadeOut('fast');
//     $("#career_highlight_" + $(this).data('id')).hide();
//     $.ajax({
//       url: '/ajax_calls/destory_career_highlight?career_highlight_id=' + $(this).data('id'),
//       success: function(result){
//         getMyCareerHighlights();
//       }
//     });
//   });

//   $(".degree").on("click", function () {
//     $(this).closest(".panel").hide()
//     $.ajax({
//       url: '/ajax_calls/destroy_degree?degree_id=' + $(this).attr('id'),
//       success: function (result) {

//         getMyDegrees();
//       }
//     });
//   });

//   $(".degree-update").on("click", function () {
//     var school = $(this).data("school");
//     var title = $(this).data("title");
//     var location = $(this).data("location");
//     var description = $(this).data("description");
//     var start = $(this).data("start");
//     var end = $(this).data("end");
//     $("#title").val(title);
//     $("#school").val(school);
//     $("#location").val(location);
//     $("#description").val(description);
//     $("#start_date2").val(start);
//     $("#end_date2").val(end);
//     $(this).closest(".panel").hide()

//     $.ajax({
//       url: '/ajax_calls/destroy_degree?degree_id=' + $(this).data("id"),
//       success: function (result) {
//         getMyDegrees();
//       }
//     });
//   });

//   $(".position").on("click", function () {
//     $(this).closest(".panel").hide()
//     $.ajax({
//       url: '/ajax_calls/destroy_position?position_id=' + $(this).attr('id'),
//       success: function (result) {
//         getMyPositions();
//       }
//     });
//   });

//   $(".position-update").on("click", function () {
//     var company = $(this).data("company");
//     var title = $(this).data("title");
//     var location = $(this).data("location");
//     var description = $(this).data("description");
//     var start = $(this).data("start");
//     var end = $(this).data("end");
//     var website = $(this).data("website");
//     $("#title").val(title);
//     $("#company").val(company);
//     $("#location").val(location);
//     $("#description").val(description);
//     $("#start_date3").val(start);
//     $("#end_date3").val(end);
//     $("#website").val(website);
//     $(this).closest(".panel").hide()
//     $.ajax({
//       url: '/ajax_calls/destroy_position?position_id=' + $(this).data('id'),
//       success: function (result) {
//         getMyPositions();
//       }
//     });
//   });

//   function getMyDegrees() {
//     $.ajax({
//       url: '/ajax_calls/get_my_degrees',
//       dataType: 'json',
//       error: function (xhr, status, error) {
//         console.log(error);
//       },
//       success: function (data) {
//         console.log(data)
//         if (data > 0) {
//           $("#submit-six").fadeIn('fast');
//         } else {
//           $("#submit-six").fadeOut('fast');
//         }
//       }
//     });
//   }

//   function getMyWorkIndustries() {
//     $.ajax({
//       url: '/ajax_calls/get_my_work_industries',
//       dataType: 'jsonp',
//       error: function (xhr, status, error) {
//         console.log(error);
//       },
//       success: function (data) {
//         if (data > 0) {
//           $("#submit-eight").fadeIn('fast');
//         } else {
//           $("#submit-eight").fadeOut('fast');
//         }
//       }
//     });
//   }

//   function getMyPositions() {
//     $.ajax({
//       url: '/ajax_calls/get_my_positions',
//       dataType: 'jsonp',
//       error: function (xhr, status, error) {
//         console.log(error);
//       },
//       success: function (data) {
//         if (data > 0) {
//           $("#submit-nine").fadeIn('fast');
//         } else {
//           $("#submit-nine").fadeOut('fast');
//         }
//       }
//     });
//   }

//   function getMyCareerHighlights() {
//     $.ajax({
//       url: '/ajax_calls/get_my_career_highlights',
//       dataType: 'jsonp',
//       error: function (xhr, status, error) {
//         console.log(error);
//       },
//       success: function (data) {
//         if (data > 0) {
//           $("#submit-ten").fadeIn('fast');
//         } else {
//           $("#submit-ten").fadeOut('fast');
//         }
//       }
//     });
//   }

// });
