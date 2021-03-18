package com.zmk.spring.stomp.chatapp.test;

import java.util.List;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface TestRepository extends MongoRepository<TestObj, Long>{

	TestObj findBy_id(ObjectId _id);
	
	@Query("{'content' : { $regex: ?0 }}")
	List<TestObj> findTestObjsByContent(String content);
	@Query("{ 'email' : { $regex: ?0 } }")
	List<TestObj> findUsersByRegexpName(String regexp);
	
	@Query("{ $text: { $search: \"?0\" } }")
	List<TestObj> search1(String regexp);
	
}