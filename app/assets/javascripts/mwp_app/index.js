

Window.MWPApp = {
  sayHello:function(){
    console.log("Hello I'am MWP" )
  },
  notify:function(title,type,icon,message,delay){
    title = !title ?'Title is empty':title;
    icon = !title ?'glyphicon glyphicon-warning-sign': icon;
    message = !message ?'message Is empty': message;
    delay = !delay ? 5000: delay;
    type = !type ? 'info': type;
    $.notify({
        // options
        icon: icon,
        title: title,
        message: message,
        // url: 'https://github.com/mouse0270/bootstrap-notify',
        // target: '_blank'
       
        },{
        // settings

        element: 'body',
        position: null,
        type: type,
        allow_dismiss: true,
        newest_on_top: false,
        showProgressbar: false,
        placement: {
          from: "bottom",
          align: "right"
        },
        offset: 20,
        spacing: 10,
        z_index: 1031,
        delay: delay,
        timer: 1000,
        url_target: '_blank',
        mouse_over: null,
        animate: {
          enter: 'animated fadeInDown',
          exit: 'animated fadeOutUp'
        },
        onShow: null,
        onShown: null,
        onClose: null,
        onClosed: null,
        icon_type: 'class',
        template: '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0}" role="alert">' +
          '<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
          '<span data-notify="icon"></span> ' +
          '<span data-notify="title">{1}</span> <br>' +
          '<span data-notify="message">{2}</span>' +
          '<div class="progress" data-notify="progressbar">' +
            '<div class="progress-bar progress-bar-{0}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>' +
          '</div>' +
          '<a href="{3}" target="{4}" data-notify="url"></a>' +
        '</div>' 
      });

  },
  showResponse:function(strResponse){
    var response  = JSON.parse( strResponse)
    var title = response.title
    var type = "success"
    var icon = null
    var message  = ""
    var delay = null
    
    if(response.success){
       type = "success"
       message  = response.message_success
    
    }else{
       type = "danger"
       message  = response.message_error
    }
    this.notify(title,type,icon,message,delay)
  }
};
var MWPApp =  Window.MWPApp
