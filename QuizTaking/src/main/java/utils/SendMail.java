/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import com.sendgrid.*;
import java.io.IOException;

/**
 *
 * @author ADMIN
 */
public class SendMail {

    public void send(String toEmail, String subject, String contentText) throws IOException {
        Email from = new Email("ispquiztaking@gmail.com");
        Email to = new Email(toEmail);
        Content content = new Content("text/plain", contentText);
        Mail mail = new Mail(from, subject, to, content);

        SendGrid sg = new SendGrid("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");
        Request request = new Request();
        try {
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());
            Response response = sg.api(request);
            System.out.println(response.getStatusCode());
            System.out.println(response.getBody());
            System.out.println(response.getHeaders());
        } catch (IOException ex) {
            throw ex;
        }
    }
    
    public String createCaptcha() {
        String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                + "0123456789"
                + "abcdefghijklmnopqrstuvxyz";
        StringBuilder sb = new StringBuilder(6);
        for (int i = 0; i < 6; i++) {
            int index
                    = (int) (AlphaNumericString.length() * Math.random());
            sb.append(AlphaNumericString.charAt(index));
        }

        return sb.toString();
    }

    public static void main(String[] args) throws IOException {
        SendMail s = new SendMail();
//        String toEmail = "levietanh20033002@gmail.com";
//        String subject = "Sending with SendGrid is Fun";
//        String contentText = "and easy to do anywhere, even with Java";
//
//        s.send(toEmail, subject, contentText);
        System.out.println(s.createCaptcha());
    }
}
