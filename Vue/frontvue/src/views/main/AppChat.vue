<template>
    <div>
        <img :src="imgSrc" class="chat-btn" @click="toggleChat">
        <div class="show-chat-btn" v-if="showChat">

            <div class="chat-window">
                <h3>유저들과 대화를 나눠보세요</h3>
                <div class="chat-container" v-scroll-bottom>
                    <ul id="messages" v-for="(item, idx) in recvList" :key="idx">
                        <li :class="{'chat-right': item.userId === checkUserInfo.id, 'chat-left': item.userId !== checkUserInfo.id}">
                            <span class="write" v-if="item.userId !== checkUserInfo.id">{{ item.userId }}</span>
                            <span class="content">{{ item.content }}</span>
                        </li>
                    </ul>
                </div>

                <div class="chat-option">
                    <button type="button" @click="reConnect">재연결</button>
                </div>
                <div class="chat-input-container">
                    <input ref="sendInput" class="send-input" type="text" id="message-input" v-model="message"
                           placeholder="내용" @keyup="sendEnter">
                    <button class="send-btn" type="button" @click="sendBtn">전송</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import Stomp from 'webstomp-client'
import SockJS from 'sockjs-client'
import {mapGetters} from "vuex";
import axios from "@/util/axios";

export default {
    directives: {
        'scroll-bottom': {
            inserted: function (el) {
                el.scrollTop = el.scrollHeight;
            },
            componentUpdated: function (el) {
                el.scrollTop = el.scrollHeight;
            }
        }
    },
    name: 'AppChat',
    components: {},
    data() {
        return {
            showChat: false,
            imgSrc: require('@/assets/pzt-close.png'),
            tempId: '',
            message: '',
            recvList: [],

            isDragging: false,
            startPosition: {x: 0, y: 0},
            position: {x: 0, y: 0},
            isOutOfBound: false

        };
    },
    created() {
        //appChat이 실해오디면 소켓 연결을 시도한다.
        this.connect();
        axios.get('chat/init').then(response => {
            this.recvList = response.data
        })
    },
    computed: {
        ...mapGetters('userStore', ['getIsLogin', 'checkUserInfo'])
    },
    methods: {
        toggleChat() {
            if (this.checkUserInfo !== null) {
                this.showChat = !this.showChat; // showChat 값을 토글합니다.
                this.chatState = this.showChat ? '채팅 닫기' : '채팅 열기'
                this.imgSrc = this.showChat ? require('@/assets/pzt-close.png') : require('@/assets/pzt-write.png')
            } else {
                alert("로그인 하셔야 채팅방 참여가 가능하십니다.");
                return;
            }
        },
        sendBtn(){
            if (this.getIsLogin && this.message !== ''){
                if (this.message.length > 250) {
                    this.message = this.message.substring(0, 250)
                    this.$refs.sendInput.focus();
                    alert("메세지 글자수는 250자로 제한됩니다.")
                    return;
                } else {
                    this.send()
                    this.message = ''
                    this.$refs.sendInput.focus();
                }
            }
        },
        sendEnter(event) {
            if (event.keyCode === 13 && this.getIsLogin && this.message !== ''){
                if (this.message.length > 250) {
                    this.message = this.message.substring(0, 250)
                    this.$refs.sendInput.focus();
                    alert("메세지 글자수는 250자로 제한됩니다.")
                    return;
                } else {
                    this.send()
                    this.message = ''
                    this.$refs.sendInput.focus();
                }
            }
        },
        send() {
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
            const serverURL = process.env.VUE_APP_API_BASE_URL2 + "/chat"
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
                        this.recvList = JSON.parse(res.body)
                    });
                },
                error => {
                    // 소켓 연결 실패
                    console.log('소켓 연결 실패', error);
                    this.connected = false;
                    alert("다시 연결을 시도해 주세요")
                    return;
                }
            );
        },
        reConnect(){
            this.connect()
            this.recvList = null
            axios.get('chat/init').then(response => {
                this.recvList = response.data
            })
        },
    },
    mounted() {
    }
};
</script>

<style scoped>
.chat-btn {
    width: 70px;
    height: 70px;
}

.chat-window {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 10px;
}

.show-chat-btn {
    position: absolute;
    bottom: 40px;
    right: 10px;
    width: 300px;
    height: 500px;
    border-radius: 5px;
    background-color: #fff;
    border: 1px solid #ccc;
    z-index: 1000;
}

.chat-container {
    border: 1px solid black;
    border-radius: 5px;
    width: 270px;
    height: 380px;
    overflow-y: scroll;
}

.chat-input-container {
    display: flex;
    margin: 5px 0 0 0;
}

.chat-input-container .send-input {
    padding: 10px;
    border-bottom: 1px solid #555555;
    flex: 4;
}

.chat-input-container .send-btn {
    padding: 10px;
    border-bottom: 1px solid #555555;
    flex: 1;
}

.chat-input-container {
    display: flex;
}


.chat-option {
    margin: 5px 0 0 auto;
}

#messages {
    list-style-type: none;
}


.chat-right {
    display: flex;
    align-items: end;
    flex-direction: column;
    margin: 3px;
}

.chat-left {
    display: flex;
    align-items: start;
    flex-direction: column;
    margin: 6px 0 6px 6px;
}

.content{
    padding: 3px;
}

.chat-left .content{
    background-color: #d1cfea;
}
.chat-right .content{
    background-color: #efdcc2;
}
</style>
