<template>
    <div>
        <button id="chat-button" @click="toggleChat">{{chatState}}</button>
        <div id="chat-container" v-if="showChat">
            <div id="chat-window">
                <h1>채팅</h1>
                <ul id="messages" v-for="(item, idx) in recvList" :key="idx">
                    <li>{{item.userId}} : {{item.content}}</li>
                </ul>
                <input type="text" id="message-input" v-model="message" placeholder="내용" @keyup="sendMessage">
                <button type="button" @click="sendMessage">전송</button>
                <button type="button" @click="connect">재연결</button>
            </div>
        </div>
    </div>
</template>
<script>
import Stomp from 'webstomp-client'
import SockJS from 'sockjs-client'
import {mapGetters} from "vuex";

export default {
    name: 'AppChat',
    components: {},
    data() {
        return {
            showChat : false,
            chatState : '채팅 열기',
            tempId : '',
            message: '',
            recvList: [],

            isDragging: false,
            startPosition: { x: 0, y: 0 },
            position: { x: 0, y: 0 },
            isOutOfBound: false

        };
    },
    created() {
        //appChat이 실해오디면 소켓 연결을 시도한다.
        this.connect();
    },
    computed :{
        ...mapGetters('userStore', ['getIsLogin', 'checkUserInfo'])
    },
    methods: {
        toggleChat() {
            this.showChat = !this.showChat; // showChat 값을 토글합니다.
            this.chatState = this.showChat ? '채팅 닫기' : '채팅 열기'
            // if (this.showChat) {
            //     this.getMessages();
            // }
        },
        sendMessage(event) {
            if(event.keyCode === 13 && this.getIsLogin && this.message !== ''){
                this.send()
                this.message = ''
            }
        },
        send(){
            console.log("Send message:" + this.message);
            if (this.stompClient && this.stompClient.connected) {
                const msg = {
                    userId: this.checkUserInfo.id,
                    content: this.message
                };
                this.stompClient.send("/receive", JSON.stringify(msg), {});
            }
        },
        connect() {
            const serverURL = process.env.VUE_APP_API_BASE_URL + "/chat"
            let socket = new SockJS(serverURL);
            this.stompClient = Stomp.over(socket);
            console.log(`소켓 연결을 시도합니다. 서버 주소: {}`, serverURL)
            this.stompClient.connect(
                {},
                frame => {
                    // 소켓 연결 성공
                    this.connected = true;
                    console.log('소켓 연결 성공', frame);
                    // 서버의 메시지 전송 endpoint를 구독합니다.
                    // 이런형태를 pub sub 구조라고 합니다.
                    this.stompClient.subscribe("/send", res => {
                        console.log('구독으로 받은 메시지 입니다.', res.body);

                        // 받은 데이터를 json으로 파싱하고 리스트에 넣어줍니다.
                        this.recvList.push(JSON.parse(res.body))
                    });
                },
                error => {
                    // 소켓 연결 실패
                    console.log('소켓 연결 실패', error);
                    this.connected = false;
                }
            );
        },
        // getMessages() {
        //     // this.$stomp.subscribe("/topic/chat", message => {
        //     //     this.messages.push(message);
        //     // });
        //     console.log(this.messages)
        // },
    },
    mounted() {
        // this.$stomp.connect({}, this.getMessages);
    }
};
</script>

<style scoped>
chat-comp{
    position: absolute;
    z-index: 1000;
    bottom : 0px;
}

#chat-container {
    position: absolute;
    bottom: 20px;
    right: 10px;
    width: 300px ;
    height: 500px;
    background-color: #fff;
    border: 1px solid #ccc;
    z-index: 1000;
}


#chat-window {
    padding: 10px;
}

#messages {
    list-style-type: none;
}

#message-input {
    width: 250px;
}

#send-message {
    margin-top: 10px;
}
#chat-button {
    position: relative;
    top: 10px;
    right: 10px;
    color : black;
    z-index: 1000;
}

</style>
