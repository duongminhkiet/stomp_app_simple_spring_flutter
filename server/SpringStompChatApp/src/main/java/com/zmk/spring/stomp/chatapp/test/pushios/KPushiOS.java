package com.zmk.spring.stomp.chatapp.test.pushios;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import com.eatthepath.pushy.apns.ApnsClient;
import com.eatthepath.pushy.apns.ApnsClientBuilder;
import com.eatthepath.pushy.apns.PushNotificationResponse;
import com.eatthepath.pushy.apns.auth.ApnsSigningKey;
import com.eatthepath.pushy.apns.util.ApnsPayloadBuilder;
import com.eatthepath.pushy.apns.util.SimpleApnsPayloadBuilder;
import com.eatthepath.pushy.apns.util.SimpleApnsPushNotification;
import com.eatthepath.pushy.apns.util.concurrent.PushNotificationFuture;

@Component
public class KPushiOS {
	// Production at: https://pushy.me/
	//Guide at https://pushy-apns.org/
	//"Nội dung notification - Tiêu đề - Sub tiêu đề - cb032f4fa026809531adc6957052667c702bf5fb4471ae93bb19e43ad08b7a0b - it.cpc.vn
	public void sendNotification2iOSP8(String content, String title, String subTitle, String deviceToken, String appPackageOrBundle) {
		try {
			//create apns client
			
			final ApnsClient apnsClient = new ApnsClientBuilder()
			        .setApnsServer(ApnsClientBuilder.PRODUCTION_APNS_HOST)//product or development
			        .setSigningKey(ApnsSigningKey.loadFromPkcs8File(new ClassPathResource("pushnotification/AuthKey_PT5UWS37V9.p8").getFile(),"YG9TA4H7B7", "PT5UWS37V9"))
			        .build();
			
			//create push notification 
			final SimpleApnsPushNotification pushNotification;
			final ApnsPayloadBuilder payloadBuilder = new SimpleApnsPayloadBuilder();
		    payloadBuilder.setAlertBody(content);
		    payloadBuilder.setAlertTitle(title);
		    payloadBuilder.setAlertSubtitle(subTitle);

		    final String payload = payloadBuilder.build();
		    final String token = deviceToken;// TokenUtil.sanitizeTokenString("<cb032f4fa026809531adc6957052667c702bf5fb4471ae93bb19e43ad08b7a0b>");

		    pushNotification = new SimpleApnsPushNotification(token, appPackageOrBundle, payload);
		    
		    //send 
		    final PushNotificationFuture<SimpleApnsPushNotification, PushNotificationResponse<SimpleApnsPushNotification>> sendNotificationFuture = apnsClient.sendNotification(pushNotification);
			
		    //get result 
		    try {
		        final PushNotificationResponse<SimpleApnsPushNotification> pushNotificationResponse =
		                sendNotificationFuture.get();

		        if (pushNotificationResponse.isAccepted()) {
		            System.out.println("Push notification accepted by APNs gateway.");
		        } else {
		            System.out.println("Notification rejected by the APNs gateway: " +
		                    pushNotificationResponse.getRejectionReason());

		            pushNotificationResponse.getTokenInvalidationTimestamp().ifPresent(timestamp -> {
		                System.out.println("\t…and the token is invalid as of " + timestamp);
		            });
		        }
		    } catch (final Exception e) {
		        System.err.println("Failed to send push notification.1: "+e.getMessage());
		        e.printStackTrace();
		    }
		} catch (Exception e) {
			System.err.println("Failed to send push notification.2: "+e.getMessage());
			e.printStackTrace();
		}
	}
	public void sendNotification2iOSP12(String content, String title, String subTitle, String deviceToken, String appPackageOrBundle) {
		try {
			//create apns client
			
			final ApnsClient apnsClient = new ApnsClientBuilder()
			        .setApnsServer(ApnsClientBuilder.PRODUCTION_APNS_HOST)
			        .setClientCredentials(new ClassPathResource("pushnotification/Certificates_eoffice2021.p12").getFile(), "cpcit")
			        .build();
			//create push notification 
			final SimpleApnsPushNotification pushNotification;
			final ApnsPayloadBuilder payloadBuilder = new SimpleApnsPayloadBuilder();
		    payloadBuilder.setAlertBody(content);
		    payloadBuilder.setAlertTitle(title);
		    payloadBuilder.setAlertSubtitle(subTitle);

		    final String payload = payloadBuilder.build();
		    final String token = deviceToken;// TokenUtil.sanitizeTokenString("<cb032f4fa026809531adc6957052667c702bf5fb4471ae93bb19e43ad08b7a0b>");

		    pushNotification = new SimpleApnsPushNotification(token, appPackageOrBundle, payload);
		    
		    //send 
		    final PushNotificationFuture<SimpleApnsPushNotification, PushNotificationResponse<SimpleApnsPushNotification>> sendNotificationFuture = apnsClient.sendNotification(pushNotification);
			
		    //get result 
		    try {
		        final PushNotificationResponse<SimpleApnsPushNotification> pushNotificationResponse =
		                sendNotificationFuture.get();

		        if (pushNotificationResponse.isAccepted()) {
		            System.out.println("Push notification accepted by APNs gateway.");
		        } else {
		            System.out.println("Notification rejected by the APNs gateway: " +
		                    pushNotificationResponse.getRejectionReason());

		            pushNotificationResponse.getTokenInvalidationTimestamp().ifPresent(timestamp -> {
		                System.out.println("\t…and the token is invalid as of " + timestamp);
		            });
		        }
		    } catch (final Exception e) {
		        System.err.println("Failed to send push notification.1: "+e.getMessage());
		        e.printStackTrace();
		    }
		} catch (Exception e) {
			System.err.println("Failed to send push notification.2: "+e.getMessage());
			e.printStackTrace();
		}
	}
}
