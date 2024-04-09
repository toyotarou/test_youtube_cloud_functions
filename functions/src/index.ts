import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

const fcm = admin.messaging();

exports.checkHealth = functions.https.onCall(async(data, context) => {
    return 'the function is online';
});

exports.sendNotification = functions.https.onCall(async(data, context) => {
    const title = data.title;
    const body = data.body;
    const image = data.image;
    const token = data.token;

    try{
        const payload = {
            token: token,
            notification: {
                title: title,
                body: body,
                image: image,
            },
            data: {
                body: body,
            },
        };

        return fcm.send(payload).then((response) => {
            return {success: true, response: "success sent message" + response};
        }).catch((error) => {
            return {error: error};
        });
    } catch(error) {
        return new functions.https.HttpsError("invalid-argument", "error:" + error);
    }
});
