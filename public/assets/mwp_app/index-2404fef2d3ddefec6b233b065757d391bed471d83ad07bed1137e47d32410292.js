Window.MWPApp={sayHello:function(){console.log("Hello I'am MWP")},notify:function(e,s,a,n,t){a=(e=e||"Title is empty")?a:"glyphicon glyphicon-warning-sign",n=n||"message Is empty",t=t||5e3,s=s||"info",$.notify({icon:a,title:e,message:n},{element:"body",position:null,type:s,allow_dismiss:!0,newest_on_top:!1,showProgressbar:!1,placement:{from:"bottom",align:"right"},offset:20,spacing:10,z_index:1031,delay:t,timer:1e3,url_target:"_blank",mouse_over:null,animate:{enter:"animated fadeInDown",exit:"animated fadeOutUp"},onShow:null,onShown:null,onClose:null,onClosed:null,icon_type:"class",template:'<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-{0}" role="alert"><button type="button" aria-hidden="true" class="close" data-notify="dismiss">\xd7</button><span data-notify="icon"></span> <span data-notify="title">{1}</span> <br><span data-notify="message">{2}</span><div class="progress" data-notify="progressbar"><div class="progress-bar progress-bar-{0}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div></div><a href="{3}" target="{4}" data-notify="url"></a></div>'})},showResponse:function(e){var s=JSON.parse(e),a=s.title,n="success",t=null,o="",i=null;s.success?(n="success",o=s.message_success):(n="danger",o=s.message_error),this.notify(a,n,t,o,i)}};var MWPApp=Window.MWPApp;