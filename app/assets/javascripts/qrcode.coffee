#= require jquery.qrcode.min

QrcodeCtrl =
  init: () ->
    options = $('.js-qrcode').data()

    $('.js-qrcode').qrcode options

$ () ->
  QrcodeCtrl.init()
