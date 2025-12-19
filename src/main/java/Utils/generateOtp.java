package Utils;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import java.security.SecureRandom;
import java.util.concurrent.TimeUnit;

public class generateOtp {

    protected Cache<String, String> otpCache = Caffeine.newBuilder().expireAfterWrite(5, TimeUnit.MINUTES).build();
    SecureRandom random = new SecureRandom();
    
    public String generateOtp(){
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }
    
    public void storeOtp(String email,String otp){
        otpCache.put(email, otp);
    }
    
    public boolean verifyOtp(String email, String otp){
        String stored = otpCache.getIfPresent(email);
        
        if(stored == null || stored.isEmpty()) return false;
        
        boolean ok = stored.equals(otp);
        if(ok) otpCache.invalidate(email);
        return ok;
    }

}
