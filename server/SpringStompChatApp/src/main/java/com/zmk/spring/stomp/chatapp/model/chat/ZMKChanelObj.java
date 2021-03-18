package com.zmk.spring.stomp.chatapp.model.chat;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;

enum TYPE_CHANEL{
	TYPE_11, TYPE_ROOM
}
public class ZMKChanelObj extends ZMKChanelParentObj{
	@Id
	private long id;
	@Indexed(unique = true)
	private String name;
	private String password;
	private int status;
	private TYPE_CHANEL typeChanel;
	private long owner_id;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public TYPE_CHANEL getTypeChanel() {
		return typeChanel;
	}
	public void setTypeChanel(TYPE_CHANEL typeChanel) {
		this.typeChanel = typeChanel;
	}
	public long getOwner_id() {
		return owner_id;
	}
	public void setOwner_id(long owner_id) {
		this.owner_id = owner_id;
	}
	
	
}
