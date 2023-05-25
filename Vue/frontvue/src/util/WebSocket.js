import Stomp from 'stompjs'
import SocketJS from 'sockjs'

const SERVER_SOCKET_API = "/websockethandler"
let stompClient = null

export const WebSocket = {

    connect() {
        let socket = new SocketJS(SERVER_SOCKET_API)
        stompClient = Stomp.over(socket)
        stompClient.connect({}, function () {
            stompClient.subscribe('/topic', function () {
            })
        })
    }
}
