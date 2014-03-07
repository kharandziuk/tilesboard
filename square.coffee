_ = require('underscore')

gRatio = (Math.sqrt(5) + 1)/2

size = 20
boardArea = size * size
news = [0..9].map(->Math.floor(Math.random() * 100))
news = _.sortBy(news, (x)-> -x)
console.log news.length
while true
    all = news.reduce(
        (acc, el) -> acc + el,
        0
    )
    nextNews = _.filter(news,(el)->
        el/all > 1/(size*size))
    if nextNews.length is news.length
        news = nextNews
        break
    news = nextNews

tiles =(->
    leftMost = 0
    topMost = 0
    return (placed, ls) ->
        if ls.length is 0
            return placed
        next = ls.shift()
        area = next/all * 

)()
    

