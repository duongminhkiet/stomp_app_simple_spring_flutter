package com.zmk.spring.stomp.chatapp.test;

import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Document(collection = "TestObj2")
public class TestObj2 {

	@Field("id")
	private long id2;
	@Field("userId")
	private String userId2;

	@Indexed(name = "username2_unique",unique = true)
	private String username2;
	private String email2;
	private String phone2;
	private int status2;

	

	public long getId2() {
		return id2;
	}



	public void setId2(long id2) {
		this.id2 = id2;
	}



	public String getUserId2() {
		return userId2;
	}



	public void setUserId2(String userId2) {
		this.userId2 = userId2;
	}



	public String getUsername2() {
		return username2;
	}



	public void setUsername2(String username2) {
		this.username2 = username2;
	}



	public String getEmail2() {
		return email2;
	}



	public void setEmail2(String email2) {
		this.email2 = email2;
	}



	public String getPhone2() {
		return phone2;
	}



	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}



	public int getStatus2() {
		return status2;
	}



	public void setStatus2(int status2) {
		this.status2 = status2;
	}



	@Override
	public String toString() {
		return "id: "+id2+" \n"
				+"userId: "+userId2+"\n"
				+"username: "+username2+"\n"
				+"email: "+email2+"\n"
				+"phone: "+phone2+"\n"
				+"status: "+status2+"\n";
	}

}
