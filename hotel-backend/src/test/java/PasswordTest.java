import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordTest {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String password = "123456";
        String encoded = encoder.encode(password);
        System.out.println("Encoded password: " + encoded);
        System.out.println("Matches: " + encoder.matches(password, encoded));

        // Test with existing hash
        String existingHash = "$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.";
        System.out.println("Matches existing: " + encoder.matches(password, existingHash));
    }
}