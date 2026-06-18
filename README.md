# un4seen
# dart fix --apply [analysis_options.yaml r rules gula automatically apply hoi]
# dart format . [auto dart code formate hoy ]
# flutter run --verbose [initially project run korle kono issue thakle seta show kre ]

socket events for send and recieve msg to a channel

RECEIVE_GROUP_MESSAGE listen for new msg
response : {
    "channel": "6a30ef957d887dc2f28102f7",
    "sender": {
        "_id": "6a262fafed4797cdf0276fa1",
        "firstName": "Rayhan",
        "lastName": "S",
        "memberNumber": "#0006",
        "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1781002249/un4seen/neivbfaq3cq2y2hnxkrj.png"
    },
    "text": "Hello MX Syndicate Group! 🏁",
    "isRead": false,
    "isReported": false,
    "_id": "6a325e68d6c52bd9288a0c1a",
    "createdAt": "2026-06-17T08:44:24.570Z",
    "updatedAt": "2026-06-17T08:44:24.570Z",
    "__v": 0
}

for send message body : {
    "channelId": "6a30ef957d887dc2f28102f7",
    "text": "Hello MX Syndicate Group! 🏁"
}
endpoint: SEND_GROUP_MESSAGE
for join channel : JOIN_CHANNEL
by passing channel id 
______
for listen online user 
GET_ONLINE_USERS here is event 
response : [
    "6a262fafed4797cdf0276fa1"
]


emit this event for sent private message 
event name : SEND_PRIVATE_MESSAGE
body: {
    "to": "6a1fe00d22f70a480eb7540c",
    "text": "Hello User B! Welcome to the Syndicate.",
     "file": "https://res.cloudinary.com/da1uxchgo/image/upload/v1781608814/un4seen/utewrzrxeabxkfzrslfa.png"
}
response of event  : RECEIVE_PRIVATE_MESSAGE

response : {
    "channel": "6a32404ff4fec1c95fc4acb0",
    "sender": {
        "_id": "6a262fafed4797cdf0276fa1",
        "firstName": "Rayhan",
        "lastName": "S",
        "memberNumber": "#0006",
        "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1781002249/un4seen/neivbfaq3cq2y2hnxkrj.png"
    },
    "text": "Hello User B! Welcome to the Syndicate.",
    "file": "https://res.cloudinary.com/da1uxchgo/image/upload/v1781608814/un4seen/utewrzrxeabxkfzrslfa.png",
    "isRead": false,
    "isReported": false,
    "_id": "6a327328f66f2fae58cdc18b",
    "createdAt": "2026-06-17T10:12:56.192Z",
    "updatedAt": "2026-06-17T10:12:56.192Z",
    "__v": 0
}
for upload file this is post method :
endpoint: /channels/upload-file
body : from data 
 file :
response : {
    "success": true,
    "message": "File uploaded successfully",
    "statusCode": 200,
    "data": "https://res.cloudinary.com/da1uxchgo/image/upload/v1781691342/un4seen/kzdm3upexkit486fosic.jpg"
}
this link will be sent to message 

for get channel meembers 
endpoint: /channels/:CHANNEL_ID/members
response : {
    "success": true,
    "message": "Channel members retrieved successfully",
    "statusCode": 200,
    "data": [
        {
            "_id": "6a262fafed4797cdf0276fa1",
            "firstName": "Rayhan",
            "lastName": "S",
            "status": "active",
            "memberNumber": "#0006",
            "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1781002249/un4seen/neivbfaq3cq2y2hnxkrj.png",
            "isOnline": false,
            "isAdmin": true
        },
        {
            "_id": "6a1fe00d22f70a480eb7540c",
            "firstName": "Jeremy",
            "lastName": "McKnight",
            "status": "active",
            "memberNumber": "#0004",
            "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1780991708/un4seen/kvax8vzttwnznpu7vxil.jpg",
            "isOnline": false,
            "isAdmin": false
        }
    ]
}
@lib/src/features/chat/presentation/pages/channel_members_page.dart here need to show who r in the channel also they gonna have remove button also functionality 
@README.md (8-78) 
when socket need to connect until app is not closed completely 
@lib/src/core/services/socket_service.dart 
