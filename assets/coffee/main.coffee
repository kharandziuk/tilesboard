
COMPONENTS = '../components'

fromBower = (dir, name) ->
  name = name or dir
  return "#{COMPONENTS}/#{dir}/#{name}"

require.config(
  paths:
    jquery: fromBower 'jquery/dist', 'jquery'
    raphael: fromBower 'raphael'
)

require(['jquery', 'raphael'], ($, Raphael)->
  $(document).ready(()->
    $tiles = $('#tiles')
    paper = Raphael('tiles') #$tiles.width(), $tiles.height())
    console.log paper.width, paper.height
    circle = paper.circle(0, 0, 80)
  )
)
