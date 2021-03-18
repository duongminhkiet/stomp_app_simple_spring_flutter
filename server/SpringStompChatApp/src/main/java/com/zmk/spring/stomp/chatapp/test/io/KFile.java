package com.zmk.spring.stomp.chatapp.test.io;

import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import org.springframework.stereotype.Component;

import com.zmk.spring.stomp.chatapp.test.common.Resources;

@Component
public class KFile {
	public void saveFile() {
		String value = "Hello";
		String folder = Resources.pATH_SAVE_FOLDER;
		
		
		File file = new File(folder);
        if (!file.exists()) {
            if (file.mkdir()) {
                System.out.println("Directory is created!");
            } else {
                System.out.println("Failed to create directory!");
            }
        }
		
		
	    FileOutputStream fos;
		try {
			String fileName = folder+"text.txt";
			fos = new FileOutputStream(fileName);
			DataOutputStream outStream = new DataOutputStream(new BufferedOutputStream(fos));
		    outStream.writeUTF(value);
		    outStream.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	    
	 
	}
	public void readFile() {
//		String fileName = Resources.PATH_SAVE_FILE;
//		FileInputStream fis = new FileInputStream(fileName);
//	    String data = IOUtils.toString(fis, "UTF-8");
	}
}
