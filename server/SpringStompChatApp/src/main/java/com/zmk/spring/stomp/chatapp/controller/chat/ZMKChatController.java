package com.zmk.spring.stomp.chatapp.controller.chat;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.zmk.spring.stomp.chatapp.model.chat.ZMKMessageObj;
//5
@Controller
public class ZMKChatController {
	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;
	
	// start public location
	@MessageMapping("/chat.sendMessage.toPublic")
	@SendTo("/topic/chat/public")
	public ZMKMessageObj sendMessageToPubic(@Payload ZMKMessageObj chatMessage) {
		System.out.println("\n sendMessageToPubic: "+chatMessage.toString());
		return chatMessage;
	}

	@MessageMapping("/chat.addUser.toPublic")
	@SendTo("/topic/chat/public")
	public ZMKMessageObj addUser(@Payload ZMKMessageObj chatMessage, SimpMessageHeaderAccessor headerAccessor) {
		headerAccessor.getSessionAttributes().put("user_id", chatMessage.getSenderId());
		System.out.println("\n addUser: "+chatMessage.toString());
		return chatMessage;
	}
	// end public location

	// start chat room
	@MessageMapping("/zmkchat/send/message/to/testchanel") // must add app/ when want to sent (from client)
	@SendTo("/topic/zmkchat/send/message/to/testchanel")
	public ZMKMessageObj sendMessage(@Payload ZMKMessageObj chatMessage) {
		System.out.println("\n Nội dung sendMessage: \n"+chatMessage.toString());
		return chatMessage;
	}
	
	@MessageMapping("/zmkchat/send/message/to/testchanel/{room}") // must add app/ when want to sent (from client)
	@SendTo("/topic/zmkchat/send/message/to/testchanel/{room}")
	public ZMKMessageObj sendMessageRoom(@Payload ZMKMessageObj chatMessage, @DestinationVariable String room) {
		System.out.println("\n=====ROOM: "+room+" Nội dung sendMessage: \n"+chatMessage.toString());
		return chatMessage;
	}
	@MessageMapping("/secured/room")
	public void sendSpecific(
	  @Payload ZMKMessageObj chatMessage, 
	  Principal user, 
	  @Header("simpSessionId") String sessionId) throws Exception { 
//	    OutputMessage out = new OutputMessage(
//	      msg.getFrom(), 
//	      msg.getText(),
//	      new SimpleDateFormat("HH:mm").format(new Date())); 
	    simpMessagingTemplate.convertAndSendToUser("receiver_user", "/secured/user/queue/specific-user", chatMessage); 
	}
	
    @MessageMapping("/chatone")
    public void processMessage(@Payload ZMKMessageObj chatMessage) throws  Exception{
    	System.out.println("\n=====chatone \n "+" Nội dung sendMessage: \n"+chatMessage.toString());
        simpMessagingTemplate.convertAndSendToUser(
                chatMessage.getSenderId(),"/queue/messages",
                chatMessage);
    }
}