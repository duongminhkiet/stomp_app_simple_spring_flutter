package com.zmk.spring.stomp.chatapp.test;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TestRepository2 extends MongoRepository<TestObj2, Long>{

	
	
}
