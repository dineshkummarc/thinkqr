goog.provide('Application')

goog.require 'QRCode'
goog.require 'QRErrorCorrectLevel'

###
@ constructor
@ param {!HTMLCanvasElement} canvas
###
class Application
  constructor: (@canvas, @input) ->
    this.typeNumber = 10
    this.size = this.typeNumber * 4 + 17;
    this.scale = 5

    this._dim = this.size * this.scale;

    $(input)
      .width(this._dim - 2)
      .val('Hello, world!')
      .bind 'keyup', goog.bind(this._create, this)

    this.canvas = $(this.canvas).attr('width', this._dim).attr('height', this._dim)[0]
    this.context = this.canvas.getContext('2d')

    this._create()

  _create: () ->
    qr = new QRCode(this.typeNumber, QRErrorCorrectLevel.Q)
    value = $(this.input).val()
    qr.addData(value)
    qr.make()
    this._renderSquares(qr)
    return

  _renderSquares: (qr) ->
    this.context.fillStyle = 'white'
    this.context.fillRect(0, 0, this._dim, this._dim)

    this.context.fillStyle = 'black'

    y = 0
    while y < this.size
      x = 0
      while x < this.size
        if qr.isDark(y, x)
          this.context.fillRect(x * this.scale, y * this.scale, this.scale, this.scale)
        x++
      y++
    return

