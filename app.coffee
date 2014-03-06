express = require('express')
app = express()
twitter = require('ntwitter')

twit = new twitter
    consumer_key: '6SIZkaYGJxTVGY5hjmzPw'
    consumer_secret: '718RckHzhDLO2XhjcPuXmJdqYXAzBlGVxnJgUrzkE'
    access_token_key: '1333682821-JLmzE3DAU8V3RJsCk1IOoVQcozz2OJzaBvpP5hx'
    access_token_secret: '3o22EmuEEujdVYHQFkLeO4ErsXFU6EKxjvLISThg39QjX'

app.configure(() ->
    app.use('/static', express.static(__dirname + "/static"))
)

app.get('/', (request, response) ->
    response.sendfile(__dirname + "/views/index.html")
)
app.get('/tweets', (request, response) ->
    tweets = []
    maxNum = Math.pow(10, 1)
    twit.stream 'statuses/sample', (stream)->
        stream.on('data', (data)->
            tweets.push(data.retweeted_status) if data.retweeted_status?
            stream.destroy() if tweets.length > maxNum
        )
        stream.on('destroy', (data)->
            result = tweets
                .sort((a,b)-> b.retweet_count-a.retweet_count)[..10]
                .map((el)->
                    count: el.retweet_count
                    text: el.text
                )
            response.json(result)
        )


)

app.listen(3000)
