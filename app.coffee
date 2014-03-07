express = require('express')
app = express()
twitter = require('ntwitter')
moment = require('moment')
_ = require('underscore')

twit = new twitter
    consumer_key: '6SIZkaYGJxTVGY5hjmzPw'
    consumer_secret: '718RckHzhDLO2XhjcPuXmJdqYXAzBlGVxnJgUrzkE'
    access_token_key: '1333682821-JLmzE3DAU8V3RJsCk1IOoVQcozz2OJzaBvpP5hx'
    access_token_secret: '3o22EmuEEujdVYHQFkLeO4ErsXFU6EKxjvLISThg39QjX'
tweets = {}
maxNum = 100
lastTweet = null
twit.stream 'statuses/sample', (stream)->
    stream.on('data', (data)->
        if data.retweeted_status?
            newTweet = data.retweeted_status
            sum = _.values(tweets).reduce(
                (acc, el)-> acc + el.retweet_count,
                0
            )
            if newTweet.retweet_count < sum/50
                return
            if moment.duration().subtract(moment(newTweet.created_at)).days() isnt 0
                console.log moment.duration().subtract(moment(newTweet.created_at)).days()
                return
            if not lastTweet? or lastTweet.retweet_count < newTweet.retweet_count
                lastTweet = newTweet
                if newTweet.id_str in tweets
                    tweets[newTweet.id_str] = newTweet
                    return
                else
                    tweets[newTweet.id_str] = newTweet
                    delete tweets[lastTweet.id_str]
                    lastTweet = _.chain(tweets).values().sortBy((el)-> el.retweet_count).last().value()
            if _.keys(tweets).length < maxNum
                tweets[newTweet.id_str] = newTweet
    )

app.configure(() ->
    app.use('/static', express.static(__dirname + "/static"))
)

app.get('/', (request, response) ->
    response.sendfile(__dirname + "/views/index.html")
)
app.get('/tweets', (request, response) ->
    if _.keys(tweets)
        console.assert _.values(tweets).length <= maxNum, _.values(tweets).length
        temp = _.chain(tweets).values().sortBy((el)-> el.retweet_count)
        console.log temp.first().value().retweet_count
        console.log temp.last().value().retweet_count
        console.log 'all: ', _.values(tweets).reduce(
            (acc, el)-> acc + el.retweet_count,
            0
        )
        console.log 'count: ', _.keys(tweets).length

    result = _.values(tweets)
        .sort((a,b)-> b.retweet_count-a.retweet_count)
        .map((el)->
            count: el.retweet_count
            text: el.text
        )
    response.json(result)
)

app.listen(3000)
