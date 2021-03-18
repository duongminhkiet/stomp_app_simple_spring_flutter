package com.zmk.spring.stomp.chatapp.configuration.websocket;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.zmk.spring.stomp.chatapp.model.chat.ZMKMessageObj;

//4
@Component
public class ZMKWebSocketEventListener {
    private static final Logger logger = LoggerFactory.getLogger(ZMKWebSocketEventListener.class);

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;

    @EventListener
    public void handleWebSocketConnectListener(SessionConnectedEvent event) {
        logger.info("Received a new web socket connection.");
    }

    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());

        String userId = (String) headerAccessor.getSessionAttributes().get("user_id");
        String roomId = (String) headerAccessor.getSessionAttributes().get("room_id");
        if (userId != null) {
            logger.info("User Id Disconnected: " + userId);

            ZMKMessageObj chatMessage = new ZMKMessageObj();
            chatMessage.setType(ZMKMessageObj.MessageType.LEAVE);
            chatMessage.setSenderId(userId);

            //messagingTemplate.convertAndSend(format("/channel/%s", roomId), chatMessage);
            messagingTemplate.convertAndSend("/topic/chat/public", chatMessage);
        }
    }
}
