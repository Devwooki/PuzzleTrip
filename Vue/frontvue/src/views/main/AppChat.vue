<template>
    <div class="draggable" :style="{ top: position.y + 'px', left: position.x + 'px' }" @mousedown="startDrag">
        <button id="chat-button" @click="toggleChat">{{chatState}}</button>
        <div id="chat-container" :class="{ 'out-of-bound': isOutOfBound }" v-if="showChat">
            <div id="chat-window">
                <h1>채팅</h1>
                <ul id="messages"></ul>
                <input type="text" id="message-input" v-model="message">
                <button id="send-message" @click="sendMessage">보내기</button>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    name: 'AppChat',
    components: {},
    data() {
        return {
            showChat : false,
            chatState : '채팅 열기',
            message: '',
            messages: [],

            isDragging: false,
            startPosition: { x: 0, y: 0 },
            position: { x: 0, y: 0 },
            isOutOfBound: false

        };
    },
    created() {
    },
    methods: {
        toggleChat() {
            this.showChat = !this.showChat; // showChat 값을 토글합니다.
            this.chatState = this.showChat ? '채팅 닫기' : '채팅 열기'
            if (this.showChat) {
                this.getMessages();
            }
        },
        sendMessage() {
            // this.$stomp.send("/app/chat", JSON.stringify({
            //     message: this.message
            // }));
            this.messages.push(this.message)
            this.message = "";
            this.getMessages()
        },
        getMessages() {
            // this.$stomp.subscribe("/topic/chat", message => {
            //     this.messages.push(message);
            // });
            console.log(this.messages)
        },


        //채팅창 드래그를 위한 이벤트
        startDrag(event) {
            this.isDragging = true;
            this.startPosition.x = event.clientX;
            this.startPosition.y = event.clientY;
            document.addEventListener('mousemove', this.handleDrag);
            document.addEventListener('mouseup', this.stopDrag);
        },
        handleDrag(event) {
            if (this.isDragging) {
                const deltaX = event.clientX - this.startPosition.x;
                const deltaY = event.clientY - this.startPosition.y;
                this.position.x += deltaX;
                this.position.y += deltaY;
                this.startPosition.x = event.clientX;
                this.startPosition.y = event.clientY;
                this.checkBoundary();
            }
        },
        stopDrag() {
            this.isDragging = false;
            document.removeEventListener('mousemove', this.handleDrag);
            document.removeEventListener('mouseup', this.stopDrag);
        },
        checkBoundary() {
            const container = document.getElementById('app');
            const containerRect = container.getBoundingClientRect();
            const chatContainer = document.getElementById('chat-container');
            const chatContainerRect = chatContainer.getBoundingClientRect();

            const isOutOfBound =
                chatContainerRect.left < containerRect.left ||
                chatContainerRect.right > containerRect.right ||
                chatContainerRect.top < containerRect.top ||
                chatContainerRect.bottom > containerRect.bottom;

            this.isOutOfBound = isOutOfBound;
        }
    },
    mounted() {
        // this.$stomp.connect({}, this.getMessages);
    }
};
</script>

<style scoped>
.draggable {
    position: absolute;
    cursor: move;
    width: 50px;
    height: 50px;
    background-color: #e86666;
    /* 기타 스타일 속성들 */
}

#chat-container {
    position: relative;
    top: 10px;
    right: 10px;
    width: 300px ;
    height: 400px;
    background-color: #fff;
    border: 1px solid #ccc;
    z-index: 1000;
}

.out-of-bound {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
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
