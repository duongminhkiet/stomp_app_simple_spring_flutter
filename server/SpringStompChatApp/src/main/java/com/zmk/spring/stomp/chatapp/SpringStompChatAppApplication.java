package com.zmk.spring.stomp.chatapp;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.data.mongodb.core.MongoTemplate;

import com.zmk.spring.stomp.chatapp.model.chat.ZMKUserObj;
import com.zmk.spring.stomp.chatapp.repository.ZMKUserRepository;
import com.zmk.spring.stomp.chatapp.test.AppItf1;
import com.zmk.spring.stomp.chatapp.test.TestObj;
import com.zmk.spring.stomp.chatapp.test.TestObj2;
import com.zmk.spring.stomp.chatapp.test.TestRepository;
import com.zmk.spring.stomp.chatapp.test.TestRepository2;
import com.zmk.spring.stomp.chatapp.test.io.KFile;
import com.zmk.spring.stomp.chatapp.test.pushios.KPushiOS;

//1
@SpringBootApplication
public class SpringStompChatAppApplication implements CommandLineRunner{
	
	static AppItf1 app2;
	public static void main(String[] args) {
		ApplicationContext context = 
				SpringApplication.run(SpringStompChatAppApplication.class, args);
		
		app2 = context.getBean(AppItf1.class);
		app2.functionX1();
		System.out.println("Instance: " + app2);
	}
	public static void testPush(ApplicationContext context) {
		KPushiOS kPush2 = context.getBean(KPushiOS.class);
		kPush2.sendNotification2iOSP12("Test Tuyền nhé-ko cần đọc","Test Tuyền nhé","Test Tuyền nhé","cb032f4fa026809531adc6957052667c702bf5fb4471ae93bb19e43ad08b7a0b","it.cpc.vn");
		kPush2.sendNotification2iOSP8("Nội dung notification","Tiêu đề","Sub tiêu đề","cb032f4fa026809531adc6957052667c702bf5fb4471ae93bb19e43ad08b7a0b","it.cpc.vn");
	}
	
	@Autowired
	private TestRepository2 testRepository2;
	
	@Autowired
	private TestRepository testRepository;
	
	@Autowired
	private ZMKUserRepository zMKUserRepository;
	
	private void initData() {
		testRepository.deleteAll();
		zMKUserRepository.deleteAll();
		
		for(long i = 0; i< 10; i++) {
			
			if(!testRepository.existsById(i)) {
				TestObj obj = new TestObj();
				obj.setUsername("username"+i);
				obj.setEmail("email@email."+i);
				obj.setPhone("123456789"+i);
				//obj.setId(i);
				testRepository.save(obj);
			}

			if(!zMKUserRepository.existsById(i)) {
				ZMKUserObj objx = new ZMKUserObj();
				objx.setUsername("username"+i);
				objx.setEmail("email@email."+i);
				objx.setPhone("123456789"+i);
				objx.setId(i);
				zMKUserRepository.save(objx);
			}

		}
	}
	private String getStringRandom(long i) {
		String[] strArray3 = new String[10];
		strArray3[0] = "Trước đó, hồi đầu tháng 5, Thị trưởng thành phố New York Bill de Blasio đã nhắc đến việc mua các thiết bị bảo hộ y tế từ Việt Nam. CBSNews dẫn lời ông Bill de Blasio cho biết thành phố đã đặt hàng một nhà máy ở Việt Nam sản xuất số lượng lớn các bộ quần áo bảo hộ y tế. ";
		strArray3[1] = "Thời gian đầu, bà Nguyễn Thị Bạch Điệp, Chủ tịch HĐQT FPT Retail từng tiết lộ đây là ngành hàng \"có quy mô thị trường khoảng 5 tỷ USD và chưa xác định được đối thủ dẫn đầu rõ rệt\". Thậm chí, việc M&A một số cửa hàng, vận hành thử nghiệm này mới là \"bằng tiền cá nhân\" và bà cam kết không ảnh hưởng đến hoạt động chủ lực của công ty. Nhưng một năm sau, khi quá trình này ổn định, FPT Retail đã thành lập một công ty để quản lý chuỗi nhà thuốc với vốn điều lệ 100 tỷ đồng và nắm giữ 75% cổ phần.";
		strArray3[2] = "Khi ghép phổi từ người hiến chết não, thể tích phổi người tặng phải tương đương phổi của người nhận, không được chênh lệch quá 30%. Nguồn tạng ghép cũng phải đáp ứng các điều kiện về miễn dịch và nhiều chỉ số hòa hợp khác.";
		strArray3[3] = "Trump và Ngoại trưởng Mỹ Mike Pompeo gần đây thúc đẩy giả thuyết nCoV bị rò rỉ từ Viện Virus học Vũ Hán. Cộng đồng tình báo Mỹ đang xem xét giả thuyết này nhưng họ cho rằng nCoV không phải là virus nhân tạo hoặc biến đổi gene. Trong khi đó, Viện Virus học Vũ Hán bác bỏ giả thuyết. Bắc Kinh khẳng định Ngoại trưởng Mỹ không thể chứng minh nCoV lọt từ phòng thí nghiệm bởi ông \"không có bất kỳ bằng chứng nào\"";
		strArray3[4] = "Sáng 20/5, ông Hiến bị VKS Quân chủng Hải quân đề nghị mức hình phạt 3-4 năm tù về tội Thiếu trách nhiệm gây hậu quả nghiêm trọng. Bản luận tội xác định ông không kiểm tra và chỉ đạo kiểm tra năng lực thực tế đối tác, không kiểm tra việc góp vốn bằng giá trị quyền sử dụng ba khu đất, không kiểm tra việc thực hiện ý kiến chỉ đạo của Bộ trưởng Quốc phòng. Điều này dẫn đến bị đối tác sử dụng giấy chứng nhận quyền sử dụng đất mang đi thế chấp, chuyển đổi loại hình doanh nghiệp, chuyển nhượng quyền sở hữu cho bên thứ ba... \"Hậu quả, Quân chủng Hải quân mất quyền quản lý, sử dụng ba khu đất trong thời gian 49 năm, gây thất thoát cho ngân sách nhà nước số tiền hơn 939 tỷ đồng\", bản luận tội nêu.";
		strArray3[5] = "Liên minh châu Âu (EU) trong khi đó cẩn thận chuẩn bị những công việc ngoại giao cần thiết để đạt được sự đồng thuận cho nghị quyết kêu gọi tiến hành một cuộc đánh giá độc lập, công bằng và toàn diện về phản ứng y tế toàn cầu đối với Covid-19, bao gồm việc điều tra các động thái của WHO.\n" + 
				"\n" + 
				"Ý tưởng về việc đánh giá những gì đã thực sự xảy ra ở Trung Quốc, nơi đầu tiên báo cáo các ca nhiễm nCoV, được Australia nêu lên đầu tiên từ cách đây vài tuần. Bắc Kinh đã phản ứng gay gắt trước đề xuất này.\n" + 
				"\n" + 
				"Nhưng EU đã khéo léo điều chỉnh ngôn ngữ khi kêu gọi tiến hành cuộc đánh giá đến mức Australia đã quyết định đồng bảo trợ cho nghị quyết này. Ngôn ngữ trong nghị quyết, tất nhiên mang tính ngoại giao hơn những phát ngôn hùng hồn từ Nhà Trắng, rõ ràng đã thỏa mãn mong muốn ban đầu của Australia, Bildt nhận xét.\n" + 
				"\n" + 
				"Trung Quốc hiểu rõ áp lực mà họ đang đối mặt. Muốn thể hiện mình là một bên liên quan có trách nhiệm trong nỗ lực hợp tác y tế toàn cầu, Bắc Kinh đã gạt sang một bên những lời phản đối và chấp nhận các yêu cầu đánh giá toàn diện về Covid-19 trong nghị quyết.\n" + 
				"\n" + 
				"Khoảng hơn 4 tiếng sau phát biểu của hàng loạt lãnh đạo thế giới tại WHA, Mỹ mới bắt đầu lên tiếng. Nhưng thông điệp của Washington được truyền đi qua Bộ trưởng Y tế và Dịch vụ Nhân sinh Alex Azar lại khác biệt rõ rệt với các bài phát biểu khác và nó chỉ làm tăng thêm ấn tượng rằng Mỹ hứng thú đối đầu với Trung Quốc hơn nhiều so với đấu tranh chống dịch bệnh.";
		strArray3[6] = "Đại diện bên phía nhà thầu thi công dự án, ông Trần Tuấn Anh – Công ty Vinaconex 12 cho biết, sau dịch Covid-19, đơn vị đang đẩy nhanh tiến độ thi công cả ngày lẫn đêm để kịp bàn giao theo đúng tiến độ đề ra.\n" + 
				"\n" + 
				"Tuyến đường được hoàn thành sẽ tạo điều kiện cho các phương tiện tham gia giao thông kết nối ra vào nút giao thông được thuận lợi, an toàn, rút ngắn hành trình và đồng bộ mạng lưới đường giao thông trong khu vực.";
		strArray3[7] = "Việt Nam\n" + 
				"\n" + 
				"Ngay cả trong số các nước chống dịch thành công từ sớm tại châu Á, Việt Nam vẫn là một ngoại lệ. Việt Nam không phải nước giàu có như Hàn Quốc, cũng không phải quốc gia phát triển cao như Singapore, và càng không có sức mạnh như nền kinh tế lớn thế giới Trung Quốc.\n" + 
				"\n" + 
				"Nhưng Việt Nam cho đến nay mới chỉ ghi nhận hơn 300 ca mắc Covid-19, trong đó 60 bệnh nhân đang được điều trị tại các cơ sở y tế trong cả nước. 264 bệnh nhân Covid-19 đã được chữa khỏi tại Việt Nam. Trong hơn một tháng, Việt Nam không có ca lây nhiễm cộng đồng. Đặc biệt, không có ca tử vong vì Covid-19 nào được ghi nhận tại Việt Nam.\n" + 
				"\n" + 
				"Các chuyên gia Mỹ rất ấn tượng với thành tích chống dịch của Việt Nam.";
		strArray3[8] = "Trong khi số ca mắc Covid-19 tại nước láng giềng Nga tăng chóng mặt, Georgia dường như vẫn “bình an vô sự”. Theo thống kê của Worldometers, Georgia, đất nước với 3,75 triệu dân, hiện mới chỉ ghi nhận 713 ca nhiễm và 12 ca tử vong, trong khi Nga có tới 2.972 người chết và 308.705 người nhiễm bệnh. Tổ chức Y tế Thế giới (WHO) đã dành lời khen ngợi cho nỗ lực chống dịch của Georgia.\n" + 
				"\n" + 
				"Các biện pháp chống dịch nhanh chóng của chính phủ Georgia, như kiểm tra nhiệt độ cơ thể hành khách tại các sân bay từ cuối tháng 1 hay hạn chế từ sớm các chuyến bay quốc tế, đã giúp nước này đánh bại Covid-19. Do tốc độ lây nhiễm giảm dần, Georgia sắp cho phép ngành du lịch mở cửa trở lại.\n" + 
				"\n" + 
				"Diện tích nhỏ bé cũng giúp Georgia dễ dàng kiểm soát những rủi ro từ hoạt động di chuyển trong nước. Georgia cũng trải qua nhiều khó khăn sau khi Liên Xô sụp đổ, do vậy người dân nước này sẵn sàng hy sinh vì lợi ích chung, như chấp nhận lệnh cấm đi lại hay các biện pháp kiểm soát xã hội khác.";
		strArray3[9] = "Các đối tượng được chi hỗ trợ mở rộng, gồm: Người có công, đối tượng bảo trợ xã hội đang nuôi dưỡng tại các cơ sở bảo trợ xã hội trong và ngoài công lập, gia đình có người khuyết tật đặc biệt nặng; hộ gia đình, cá nhân nhận nuôi dưỡng người khuyết tật, trẻ mồ côi không nơi nương tựa, giáo viên, nhân viên trường mầm non, phổ thông ngoài công lập…\n" + 
				"\n" + 
				"Theo Bộ LĐ-TB&XH, tổng số tiền đã chi hỗ trợ cho các đối tượng tới thời điểm ngày 20/5 là khoảng 17,5 ngàn tỷ đồng, chưa bao gồm chi trả bảo hiểm thất nghiệp 2.000 tỷ đồng.";
		
		return strArray3[(int) i];
	}
	private ArrayList<TestObj2> getTestObj2(){
		ArrayList<TestObj2> mArr = new ArrayList<TestObj2>();
		for(long i = 0; i< 10; i++) {
			TestObj2 obj = new TestObj2();
			obj.setUsername2("test2-username"+i);
			obj.setEmail2("test2-email@email."+i);
			obj.setPhone2("test2-123456789"+i);
			obj.setUserId2("test2-userId"+i);
			obj.setId2(i);
			mArr.add(obj);
			//testRepository2.save(obj);
		}
		return mArr;
	}
	void printTestObjFromArray(List<TestObj> mArr) {
		System.out.print("xxxxxxxxxxxxxxxxxxxxxx PRINT ARRAY xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
		for(int i = 0; i<mArr.size(); i++) {
			System.out.print("xxxxxxxxxxxx PRINT OBJ: "+i+" xxxxxxxxxxxxxxxx");
			System.out.print(mArr.get(i).toString());
		}
	}
	void findObj() {
		System.out.print("xxxxxxxxxxxxxxxxxxxxxx FIND xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
		long j = 1;
		Optional<TestObj> objo1 = testRepository.findById(j);
		
		if(objo1.isPresent()) {
			System.out.print(objo1.toString());
		}
		TestObj tobj = objo1.orElse(null);
		TestObj objo = testRepository.findBy_id(tobj.get_id());
		if(objo !=null) {
			System.out.print("objoobjoobjoobjoobjoobjoobjoobjoobjoobjo");
			System.out.print(objo.toString());
		}
	}
	private void initDataX() {
		testRepository.deleteAll();
		zMKUserRepository.deleteAll();

		for(long i = 0; i< 10; i++) {
			
			
				TestObj obj = new TestObj();
				obj.setUsername("username"+i);
				obj.setEmail("email@email."+i);
				obj.setPhone("123456789"+i);
				obj.setUserId("userId"+i);
				obj.setId(i);
				obj.setContent(""+i+""+getStringRandom(i));
				obj.setmArrayTestObj2(getTestObj2());
				testRepository.save(obj);
			

			
				ZMKUserObj objx = new ZMKUserObj();
				objx.setUsername("username"+i);
				objx.setEmail("email@email."+i);
				objx.setPhone("123456789"+i);
				objx.setId(i);
				zMKUserRepository.save(objx);
			

		}
		System.out.print("================ FINISHED ADD DATA ================");
	}
	

	void search1() {
		System.out.print("******************** FULL TEXT SEARCH *******************************************");
		List<TestObj> marr = testRepository.search1("Viet");
		printTestObjFromArray(marr);	
	}
	
	@Autowired
    private MongoTemplate template;
	
	void dropDm() {
		template.dropCollection("TestObj");
		template.dropCollection("ZMKUserObj");
	}
	
	@Autowired
	AppItf1 app1;
	
	@Autowired
	AppItf1 app3;
	
	@Autowired
	private KPushiOS kPush;
	
	@Autowired
	private KFile kFile1;
	
	public void saveFile() {
		kFile1.saveFile();
	}
	
	@Override
	public void run(String... args) throws Exception {
//		saveFile();
		
//		System.out.println("\n MongoTemplate: "+template);
//		System.out.println("\n TestRepository: "+testRepository+"\n");
//		dropDm();
		
		initDataX();
		search1();
//		
//		app1.functionX1();
		
//		System.out.println("Instance1: " + app1);
//		System.out.println("Instance3: " + app3);
		
		
		
		//List<TestObj> marr = testRepository.findTestObjsByContent("Việt");
		
//		TextIndexDefinition textIndex = new TextIndexDefinitionBuilder()
//				  .onField("title", 2F)
//				  .onField("content")
//				  .build();
//				template.indexOps(TestObj.class).ensureIndex(textIndex);
		

		
		
//		findObj();
		
		
		
	}

}
