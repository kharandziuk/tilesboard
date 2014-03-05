express = require('express')
app = express()

app.configure(() ->
    app.use('/static', express.static(__dirname + "/static"))
)

app.get('/', (request, response) ->
    response.sendfile(__dirname + "/views/index.html")
)

app.listen(3000)
