"use strict";var app={nanoscrolls:function(){$.isFunction($.fn.nanoScroller)&&$(".nano").nanoScroller()},tooltips:function(){$.isFunction($.fn.tooltip)&&$('[data-toggle="tooltip"]').tooltip({container:"body"})},popovers:function(){$.isFunction($.fn.popover)&&$('[data-toggle="popover"]').popover({container:"body"})},animations:function(){$.isFunction($.fn.appear)&&$("[data-animation-name]").each(function(){$(this).pluginAnimate()})},peityCharts:function(){$.isFunction($.fn.peity)&&($(".pie-chart").peity("pie"),$(".donut-chart").peity("donut"),$(".line-chart").peity("line"),$(".bar-chart").peity("bar"))}};$(function(){app.nanoscrolls(),app.tooltips(),app.popovers(),app.animations(),app.peityCharts()});