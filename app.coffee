express = require('express')
app = express()

app.configure(() ->
    app.use('/static', express.static(__dirname + "/static"))
)

app.get('/', (request, response) ->
    response.sendfile(__dirname + "/views/index.html")
)

app.get('/data', (request, response) ->
    urlFunction = (a) ->
        a.detailUrl = '#detail/' + a.id
        return a
    dudes = [
        { id: 1, name: "bro", city: "Gondor"},
        { id: 2, name: "dru", city: "Kyiv"},
    ]
    dudes = dudes.map(urlFunction)
    response.json(dudes)
)

app.listen(3000)
