function filterSelection(e){var t,s;for(t=document.getElementsByClassName("filterDiv"),"all"==e&&(e=""),s=0;s<t.length;s++)RemoveClass(t[s],"show"),-1<t[s].className.indexOf(e)&&AddClass(t[s],"show")}function AddClass(e,t){var s,n,l;for(n=e.className.split(" "),l=t.split(" "),s=0;s<l.length;s++)-1==n.indexOf(l[s])&&(e.className+=" "+l[s])}function RemoveClass(e,t){var s,n,l;for(n=e.className.split(" "),l=t.split(" "),s=0;s<l.length;s++)for(;-1<n.indexOf(l[s]);)n.splice(n.indexOf(l[s]),1);e.className=n.join(" ")}filterSelection("all");for(var btnContainer=document.getElementById("myBtnContainer"),btns=btnContainer.getElementsByClassName("btnFilter"),i=0;i<btns.length;i++)btns[i].addEventListener("click",function(){var e=document.getElementsByClassName("activeBtn");console.log(e),e[0].className=e[0].className.replace(" activeBtn",""),this.className+=" activeBtn"});