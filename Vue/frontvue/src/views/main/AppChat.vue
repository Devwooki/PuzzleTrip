<template>
    <div>
        <button id="chat-button" @click="toggleChat">{{chatState}}</button>
        <div class="show-chat-btn" v-if="showChat">

            <div class="chat-window">
                <h3>유저들과 대화를 나눠보세요</h3>

                <div class="chat-container"  v-scroll-bottom>
                    <ul id="messages" v-for="(item, idx) in recvList" :key="idx">
                        <li :class="{'chat-right': item.userId === checkUserInfo.id, 'chat-left': item.userId !== checkUserInfo.id}">
                            {{item.userId}} : {{item.content}}
                        </li>
                    </ul>
                </div>

                <div class="chat-input-container">
                    <input class="send-input" type="text" id="message-input" v-model="message" placeholder="내용" @keyup="sendMessage">
                    <button class="send-btn" type="button" @click="sendMessage">전송</button>
                </div>
                <div class="chat-option">
                    <button type="button" @click="connect">재연결</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import Stomp from 'webstomp-client'
import SockJS from 'sockjs-client'
import {mapGetters} from "vuex";

export default {
    directives: {
        'scroll-bottom': {
            inserted: function(el) {
                el.scrollTop = el.scrollHeight;
            },
            componentUpdated: function(el) {
                el.scrollTop = el.scrollHeight;
            }
        }
    },
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
.chat-window {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 10px;
}

.show-chat-btn {
    position: absolute;
    bottom: 20px;
    right: 10px;
    width: 300px ;
    height: 500px;
    border-radius: 5px;
    background-color: #fff;
    border: 1px solid #ccc;
    z-index: 1000;
}

.chat-container{
    border: 1px solid black;
    border-radius: 5px;
    width: 270px;
    height: 370px;
    height: 370px;
    overflow-y: scroll;
}

.chat-input-container{
    display : flex;
    margin :5px 0 0 0;
}

.chat-input-container .send-input{
    padding: 10px;
    border-bottom: 1px solid #555555;
    flex:4;
}
.chat-input-container .send-btn{
    padding: 10px;
    border-bottom: 1px solid #555555;
    flex:1;
}
.chat-input-container{
    display : flex;
}


.chat-option{
    margin :5px 0 0 auto;
}

#messages {
    list-style-type: none;
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
.chat-right {
    text-align: right;
    /* 오른쪽에 메시지 스타일링을 위한 추가적인 스타일 지정 가능 */
}

.chat-left {
    text-align: left;
    /* 왼쪽에 메시지 스타일링을 위한 추가적인 스타일 지정 가능 */
}

</style>
