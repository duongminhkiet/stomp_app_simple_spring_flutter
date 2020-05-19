package com.zmk.spring.stomp.chatapp.model.chat;

//3
public class ZMKMessageObj extends ZMKMessageParentObj{
    public enum MessageType {
        CHAT, JOIN, LEAVE
    }

    private MessageType messageType;
    private String content;
    private String sender;

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

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }
}
