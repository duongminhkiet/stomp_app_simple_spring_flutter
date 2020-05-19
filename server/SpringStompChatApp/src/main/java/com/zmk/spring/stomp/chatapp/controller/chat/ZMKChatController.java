package com.zmk.spring.stomp.chatapp.controller.chat;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;

import com.zmk.spring.stomp.chatapp.model.chat.ZMKMessageObj;

@Controller
public class ZMKChatController {
	// start public location
	@MessageMapping("/chat.sendMessage.toPublic")
	@SendTo("/topic/chat/public")
	public ZMKMessageObj sendMessageToPubic(@Payload ZMKMessageObj chatMessage) {
		return chatMessage;
	}

	@MessageMapping("/chat.addUser.toPublic")
	@SendTo("/topic/chat/public")
	public ZMKMessageObj addUser(@Payload ZMKMessageObj chatMessage, SimpMessageHeaderAccessor headerAccessor) {
		headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
		return chatMessage;
	}
	// end public location

	// start chat room
	@MessageMapping("/zmkchat/send/message/to/testchanel") // must add app/ when want to sent (from client)
	@SendTo("/topic/zmkchat/send/message/to/testchanel")
	public ZMKMessageObj sendMessage(@Payload ZMKMessageObj chatMessage) {
		return chatMessage;
	}
}