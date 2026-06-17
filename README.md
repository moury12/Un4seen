# un4seen
# dart fix --apply [analysis_options.yaml r rules gula automatically apply hoi]
# dart format . [auto dart code formate hoy ]
# flutter run --verbose [initially project run korle kono issue thakle seta show kre ]
for get my channels :
endpoint: /channels/sidebar
response : {
    "success": true,
    "message": "Joined channels retrieved successfully",
    "statusCode": 200,
    "data": [
        {
            "_id": "6a32305a0a16e8f0531430f7",
            "name": "Local Rides Canterbury 2",
            "onlineCount": 2,
            "isJoined": true
        },
        {
            "_id": "6a3230f726500e5b59362643",
            "name": "Local Rides Canterbury 1",
            "onlineCount": 2,
            "isJoined": true
        }
    ]
}
for create channel
endpoint : /channels/create
body: {
    "name": "Local Rides Canterbury 2",
    "description": "Group for local riders to coordinate meets",
    "members": ["6a1fe00d22f70a480eb7540c"],
    "isPrivate": true
}
response : {
    "success": true,
    "message": "Group created",
    "statusCode": 201,
    "data": {
        "name": "Local Rides Canterbury 2",
        "type": "group",
        "description": "Group for local riders to coordinate meets",
        "creator": "6a262fafed4797cdf0276fa1",
        "members": [
            "6a262fafed4797cdf0276fa1",
            "6a1fe00d22f70a480eb7540c"
        ],
        "admins": [
            "6a262fafed4797cdf0276fa1"
        ],
        "isDeleted": false,
        "_id": "6a325bd9d6c52bd9288a0c17",
        "createdAt": "2026-06-17T08:33:29.518Z",
        "updatedAt": "2026-06-17T08:33:29.518Z",
        "__v": 0
    }
}
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
for get all messages of channel 
endpoint: /channels/:CHANNEL_ID_HERE/messages
response: 
{
    "success": true,
    "message": "Messages retrieved",
    "statusCode": 200,
    "data": {
        "meta": {
            "page": 1,
            "limit": 10,
            "total": 10,
            "totalPage": 1
        },
        "result": [
            {
                "_id": "6a3260ecd6c52bd9288a0c1b",
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
                "createdAt": "2026-06-17T08:55:08.373Z",
                "updatedAt": "2026-06-17T08:55:08.373Z"
            },
            {
                "_id": "6a325e68d6c52bd9288a0c1a",
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
                "createdAt": "2026-06-17T08:44:24.570Z",
                "updatedAt": "2026-06-17T08:44:24.570Z"
            },
            {
                "_id": "6a325e02d6c52bd9288a0c19",
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
                "createdAt": "2026-06-17T08:42:42.601Z",
                "updatedAt": "2026-06-17T08:42:42.601Z"
            },
            {
                "_id": "6a325c57d6c52bd9288a0c18",
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
                "createdAt": "2026-06-17T08:35:35.824Z",
                "updatedAt": "2026-06-17T08:35:35.824Z"
            },
            {
                "_id": "6a3240b5f4fec1c95fc4acb4",
                "channel": "6a30ef957d887dc2f28102f7",
                "sender": {
                    "_id": "6a262fafed4797cdf0276fa1",
                    "firstName": "Rayhan",
                    "lastName": "S",
                    "memberNumber": "#0006",
                    "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1781002249/un4seen/neivbfaq3cq2y2hnxkrj.png"
                },
                "text": "Hello 🏁",
                "isRead": false,
                "isReported": false,
                "createdAt": "2026-06-17T06:37:41.453Z",
                "updatedAt": "2026-06-17T06:37:41.453Z"
            },
            {
                "_id": "6a3240a1f4fec1c95fc4acb3",
                "channel": "6a30ef957d887dc2f28102f7",
                "sender": {
                    "_id": "6a1fe00d22f70a480eb7540c",
                    "firstName": "Jeremy",
                    "lastName": "McKnight",
                    "memberNumber": "#0004",
                    "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1780991708/un4seen/kvax8vzttwnznpu7vxil.jpg"
                },
                "text": "Hello MX Syndicate Group! 🏁",
                "isRead": false,
                "isReported": false,
                "createdAt": "2026-06-17T06:37:21.184Z",
                "updatedAt": "2026-06-17T06:37:21.184Z"
            },
            {
                "_id": "6a3223d7055303b899951ade",
                "channel": "6a30ef957d887dc2f28102f7",
                "sender": {
                    "_id": "6a1fe00d22f70a480eb7540c",
                    "firstName": "Jeremy",
                    "lastName": "McKnight",
                    "memberNumber": "#0004",
                    "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1780991708/un4seen/kvax8vzttwnznpu7vxil.jpg"
                },
                "text": "Hello 🏁",
                "isRead": false,
                "isReported": false,
                "createdAt": "2026-06-17T04:34:31.650Z",
                "updatedAt": "2026-06-17T04:34:31.650Z"
            },
            {
                "_id": "6a3223b6055303b899951add",
                "channel": "6a30ef957d887dc2f28102f7",
                "sender": {
                    "_id": "6a1fe00d22f70a480eb7540c",
                    "firstName": "Jeremy",
                    "lastName": "McKnight",
                    "memberNumber": "#0004",
                    "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1780991708/un4seen/kvax8vzttwnznpu7vxil.jpg"
                },
                "text": "Hello MX Syndicate Group! 🏁",
                "isRead": false,
                "isReported": false,
                "createdAt": "2026-06-17T04:33:58.997Z",
                "updatedAt": "2026-06-17T04:33:58.997Z"
            },
            {
                "_id": "6a322394055303b899951adc",
                "channel": "6a30ef957d887dc2f28102f7",
                "sender": {
                    "_id": "6a1fe00d22f70a480eb7540c",
                    "firstName": "Jeremy",
                    "lastName": "McKnight",
                    "memberNumber": "#0004",
                    "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1780991708/un4seen/kvax8vzttwnznpu7vxil.jpg"
                },
                "text": "Hello MX Syndicate Group! 🏁",
                "isRead": false,
                "isReported": false,
                "createdAt": "2026-06-17T04:33:24.561Z",
                "updatedAt": "2026-06-17T04:33:24.561Z"
            },
            {
                "_id": "6a32238c055303b899951adb",
                "channel": "6a30ef957d887dc2f28102f7",
                "sender": {
                    "_id": "6a1fe00d22f70a480eb7540c",
                    "firstName": "Jeremy",
                    "lastName": "McKnight",
                    "memberNumber": "#0004",
                    "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1780991708/un4seen/kvax8vzttwnznpu7vxil.jpg"
                },
                "text": "Hello MX Syndicate Group! 🏁",
                "isRead": false,
                "isReported": false,
                "createdAt": "2026-06-17T04:33:16.442Z",
                "updatedAt": "2026-06-17T04:33:16.442Z"
            }
        ]
    }
}
for get message 1 to 1 
endpoint: channels/private-history/:UserId?page=1&limit=20
response: {
    "success": true,
    "message": "Private chat history retrieved",
    "statusCode": 200,
    "data": {
        "meta": {
            "page": 1,
            "limit": 20,
            "total": 4,
            "totalPage": 1
        },
        "result": [
            {
                "_id": "6a32416bf4fec1c95fc4acb6",
                "channel": "6a32404ff4fec1c95fc4acb0",
                "sender": {
                    "_id": "6a1fe00d22f70a480eb7540c",
                    "firstName": "Jeremy",
                    "lastName": "McKnight",
                    "memberNumber": "#0004",
                    "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1780991708/un4seen/kvax8vzttwnznpu7vxil.jpg"
                },
                "text": "Hey bro, check out my new decals! 🔥",
                "file": "https://res.cloudinary.com/da1uxchgo/image/upload/v1781608814/un4seen/utewrzrxeabxkfzrslfa.png",
                "isRead": false,
                "isReported": false,
                "createdAt": "2026-06-17T06:40:43.559Z",
                "updatedAt": "2026-06-17T06:40:43.559Z"
            },
            {
                "_id": "6a3240bcf4fec1c95fc4acb5",
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
                "createdAt": "2026-06-17T06:37:48.771Z",
                "updatedAt": "2026-06-17T06:37:48.771Z"
            },
            {
                "_id": "6a324069f4fec1c95fc4acb2",
                "channel": "6a32404ff4fec1c95fc4acb0",
                "sender": {
                    "_id": "6a1fe00d22f70a480eb7540c",
                    "firstName": "Jeremy",
                    "lastName": "McKnight",
                    "memberNumber": "#0004",
                    "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1780991708/un4seen/kvax8vzttwnznpu7vxil.jpg"
                },
                "text": "Hey bro, check out my new decals! 🔥",
                "file": "https://res.cloudinary.com/da1uxchgo/image/upload/v1781608814/un4seen/utewrzrxeabxkfzrslfa.png",
                "isRead": false,
                "isReported": false,
                "createdAt": "2026-06-17T06:36:25.619Z",
                "updatedAt": "2026-06-17T06:36:25.619Z"
            },
            {
                "_id": "6a32404ff4fec1c95fc4acb1",
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
                "createdAt": "2026-06-17T06:35:59.550Z",
                "updatedAt": "2026-06-17T06:35:59.550Z"
            }
        ]
    }
}

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
for add member in channel :
patch method 
endpoint: /channels/manage-members
body: {
    "channelId": "CHANNEL_ID_HERE",
    "targetUserId": "USER_ID_TO_REMOVE",
    "action": "remove"
}
for get all user for add 
endpoint : /channels/search-riders?searchTerm=0007
response : {
    "success": true,
    "message": "Riders retrieved successfully",
    "statusCode": 200,
    "data": [
        {
            "_id": "6a1fa64dd27ce6b44a20d5d8",
            "firstName": "Super",
            "lastName": "Admin",
            "fullName": "Super Admin",
            "status": "active",
            "memberNumber": "#0001"
        },
        {
            "_id": "6a1fa9889bc50b7cf015499d",
            "firstName": "Jeremy",
            "lastName": "McKnight",
            "status": "active",
            "memberNumber": "#0002",
            "fullName": "Jeremy McKnight"
        },
        {
            "_id": "6a1fabb69bc50b7cf015499e",
            "firstName": "Nahid",
            "lastName": "Hossain",
            "status": "active",
            "memberNumber": "#0003",
            "fullName": "Nahid Hossain",
            "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1780548764/el-afrik/jhfgnl8xgazozhgujk5d.png"
        },
        {
            "_id": "6a1fe00d22f70a480eb7540c",
            "firstName": "Jeremy",
            "lastName": "McKnight",
            "status": "active",
            "memberNumber": "#0004",
            "fullName": "Jeremy McKnight",
            "image": "https://res.cloudinary.com/da1uxchgo/image/upload/v1780991708/un4seen/kvax8vzttwnznpu7vxil.jpg"
        },
        {
            "_id": "6a2140ac00d51a187d575822",
            "firstName": "Jeremy",
            "lastName": "McKnight",
            "status": "active",
            "memberNumber": "#0005",
            "fullName": "Jeremy McKnight"
        },
        {
            "_id": "6a263db2c8a7c8e037061c0f",
            "firstName": "Jeremy",
            "lastName": "McKnight",
            "status": "active",
            "memberNumber": "#0007",
            "fullName": "Jeremy McKnight"
        }
    ]
}

