package com.zmk.spring.stomp.chatapp.model.chat;

//3
public class ZMKMessageObj extends ZMKMessageParentObj{
    public enum MessageType {
        CHAT, JOIN, LEAVE
    }

    private MessageType messageType;
    private String content;
    private String senderId;

    private String receiverId;
    
    
    public MessageType getType() {
        return messageType;
    }

    public void setType(MessageType messageType) {
        this.messageType = messageType;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSenderId() {
        return senderId;
    }

    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }

	public String getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}

	@Override
	public String toString() {
		return "msgType: "+messageType+"\n"+"msgContent: "+content+"\n"+"msgSender: "+senderId+"\n"+"msgReceiver: "+receiverId+"\n";
	}
    
}
