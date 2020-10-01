const redis = require('redis');

const REDIS_PORT = process.env.PORT || 6379;

const client = redis.createClient(REDIS_PORT);

//Cache middleware
const cache = (req, res, next) => {
    const { username } = req.params;
    client.get(username, (err, data) => {
        if (err) {
            throw err;
        }
        if (data !== null) {
            res.send(setResponse(username, data))
        }
        else {
            next();
        }
    })
}

module.exports = { cache }
