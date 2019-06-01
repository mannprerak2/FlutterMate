const fastify = require('fastify');
const axios = require('axios');
const cors = require('cors');
const app = fastify({
    ignoreTrailingSlash: true
});
const admin = require('firebase-admin');

var serviceAccount = require('./serviceAccount.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

var db = admin.firestore();
const userCollection = db.collection('users');

async function asyncForEach(array, callback) {
    for (let index = 0; index < array.length; index++) {
        await callback(array[index]);
    }
}

app.use(cors());

app.register(require('fastify-url-data'), (err) => {});

app.addHook('preHandler', async (request, reply, next) => {
    console.log("Just received a request");
    const urlData = request.urlData();

    if (urlData.path === '/') {
        // No checking for token
        next();
    } else {
        let token = request.headers['authorisation'];
        // console.log(token);
        if (!!token) {
            try {
                const decodedToken = await admin.auth().verifyIdToken(token);
                request.decoded = decodedToken;
                console.log("Token Decoded");
                return;
            } catch (err) {
                console.log("Verification failed", err);
                reply.code(401)
                next(new Error("Token expired"));
            }
        } else {
            reply.code(401)
            console.log(token);
            next(new Error("Authentication failed"));
        }
    }
});

// Util function to generate user score on basis of Flutter repos
const generateFScore = async (uid, ghId) => {
    let result = await axios.get(`https://api.github.com/user/${ghId}/repos`);
    result = result.data.filter(
        repo => repo.language == "Dart"
    );
    let score = 0;

    await asyncForEach(result, async (repo) => {
        score += (repo.forks_count*30 + repo.stargazers_count*20 + repo.watchers*10)*0.9;
        let data = await axios.get(repo.languages_url);
        data = data.data;
        // console.log(data);
        const ts = data.Dart;
        if (ts < 100000)
            score += (Math.floor(ts/100))*0.1;
    });

    await userCollection.doc(`${uid}`).set({
        score: score
    }, {
        merge: true
    });
    console.log("Score updated successfuly", score);
}

app.get('/', async (request, res) => {
    return {
        message: 'Welcome to FlutterMate'
    }
});

// Route to handle signup of user
app.post('/signup', async (req, res) => {
    const data = req.decoded;
    const uid = data.user_id;
    const ghid = data.firebase.identities['github.com'][0];

    let profile;
    try {
        profile = await axios.get(`https://api.github.com/user/${ghid}`);
        profile = profile.data;
        // console.log(profile);
    } catch (err) {
        console.log(err);
    }
    
    let user = {
        name: data.name,
        picture: data.picture,
        email: data.email,
        username: profile.login,
        location: profile.location,
        bio: profile.bio,
        repos: profile.public_repos,
        followers: profile.followers,
        following: profile.following,
        github: ghid
    };

    console.log(user);

    try {
        const foundUser = await userCollection.doc(`${uid}`).get();
        if (foundUser.exists) {
            console.log("Login successful");
            return {
                code: 1,
                message: "Login successful"
            }
        } else {
            console.log("User does not exist");
            try {
                const createdUser = await userCollection.doc(uid).set(user);
                console.log("User created successfuly");
                generateFScore(uid, user.github);
                return {
                    code: 2,
                    message: "Signup successful"
                }
            } catch (error) {
                console.log('User creation failed');
                return res.code(500);
            }
        }
    } catch (err) {
        console.log('Network error');
        return res.code(500);
    }
});

// Util function to calculate compatibility score of two users
const getCompatibilityScore = (yourScore, myScore) => {
    let temp = (yourScore - myScore) / myScore;
    temp = 1 / temp;
    temp = temp.toFixed(4)*10;
    if (temp < 0)
        return temp*-1;
    return temp;
}

// Util function to get data
const getData = async (userScore, uid) => {
    console.log("Fetching data");
    let result = [];
    const first = await userCollection.where('score', '>=', userScore);   
    const second = await userCollection.where('score', '<=', userScore);

    return new Promise(
        async (resolve, reject) => {
            const firstSnap = await first.get();
            await firstSnap.forEach(
                doc => {
                    if (doc.id !== uid) {
                        result.push(doc.data());
                        result[result.length - 1]['compatibilty'] = getCompatibilityScore(doc.data().score, userScore);
                    }
                }
            );
            resolve(result)
        }
    ).then(
        async result => {
            console.log("First result", result);
            const secondSnap = await second.get();
            await secondSnap.forEach(
                doc => {
                    if (doc.id !== uid) {
                        result.push(doc.data());
                        result[result.length - 1]['compatibilty'] = getCompatibilityScore(doc.data().score, userScore);
                    }
                }
            );
            return result;
        }
    ).then(
        result => {
            console.log("Final result", result);
            return result;
        }
    );
}

app.get('/team', async (req, res) => {
    const data = req.decoded;
    const uid = data.user_id;

    const foundUser = await userCollection.doc(`${uid}`).get();
    if (!foundUser.exists) {
        return res.code(403);
    } else {
        return await getData(foundUser.data().score, uid);
    }
});

app.listen(8000, '0.0.0.0', function(err, address) {
    if (err) {
        console.log(err);
        process.exit(1);
    }
    console.log(`Server listening on ${address}`);
});