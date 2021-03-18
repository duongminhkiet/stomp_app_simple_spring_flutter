package com.zmk.spring.stomp.chatapp.test;

import java.util.ArrayList;

import javax.annotation.PostConstruct;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.index.TextIndexDefinition;
import org.springframework.data.mongodb.core.index.TextIndexed;
import org.springframework.data.mongodb.core.index.TextIndexDefinition.TextIndexDefinitionBuilder;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Document(collection = "TestObj")
//@DependsOn("mongoTemplate")
public class TestObj {
	//new
	/*
    @Autowired
    private MongoTemplate mongoTemplate;

    @PostConstruct
    public void initIndexes() {
		TextIndexDefinition textIndex = new TextIndexDefinitionBuilder()
				  .onField("content")
				  .build();

		mongoTemplate.indexOps(TestObj.class).ensureIndex(textIndex);
    }
    */
	//new
	enum TYPE{
		TYPE1,TYPE2
	}
	@Id
	public ObjectId _id;
	@Field("id")
	private long id;
	@Field("userId")
	private String userId;

	@Indexed(unique = true)
	private String username;
	private String email;
	private String phone;
	private int status;
	@TextIndexed String content;
	private TYPE type = TYPE.TYPE1;

	private ArrayList<TestObj2> mArrayTestObj2;
	

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public ArrayList<TestObj2> getmArrayTestObj2() {
		return mArrayTestObj2;
	}

	public void setmArrayTestObj2(ArrayList<TestObj2> mArrayTestObj2) {
		this.mArrayTestObj2 = mArrayTestObj2;
	}

	public ObjectId get_id() {
		return _id;
	}

	public void set_id(ObjectId _id) {
		this._id = _id;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUsername() {
		return username;
	}



	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public TYPE getType() {
		return type;
	}

	public void setType(TYPE type) {
		this.type = type;
	}

	String getStringFromArray() {
		String strArray = "";
		for(TestObj2 obj: mArrayTestObj2) {
			strArray+=obj.toString();
		}
		return strArray;
	}
	@Override
	public String toString() {
		
		return "id: "+id+" \n"
				+"userId: "+userId+"\n"
				+"username: "+username+"\n"
				+"content: "+content+"\n"
				+"email: "+email+"\n"
				+"phone: "+phone+"\n"
				+"status: "+status+"\n"
				+"ObjectId: "+_id.toString()+"\n"
				+"ARRAY: "+getStringFromArray()+"\n";
	}

}
