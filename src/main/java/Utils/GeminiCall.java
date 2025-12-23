package Utils;

import io.github.cdimascio.dotenv.Dotenv;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONArray;
import org.json.JSONObject;

public class GeminiCall {

    private static String API_KEY;

    public static void init() {
        String apiKey = System.getenv("GOOGLE_API");

        if (apiKey != null || !apiKey.isEmpty()) {
            GeminiCall.API_KEY = apiKey;
        } else {
            Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load();
            GeminiCall.API_KEY = dotenv.get("GOOGLE_API");
        }
    }

    public final static String callGemini(String message) throws Exception {
        init();
        String modelName = "gemma-3-27b-it";

        String urlString = "https://generativelanguage.googleapis.com/v1beta/models/" + modelName + ":generateContent?key=" + GeminiCall.API_KEY;

        JSONObject contentPart = new JSONObject();
        contentPart.put("text", message);

        JSONObject parts = new JSONObject();
        parts.put("parts", new JSONArray().put(contentPart));

        JSONObject jsonBody = new JSONObject();
        jsonBody.put("contents", new JSONArray().put(parts));

        URL url = new URL(urlString);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json");
        con.setDoOutput(true);

        try (OutputStream os = con.getOutputStream()) {
            byte[] input = jsonBody.toString().getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        int responseCode = con.getResponseCode();
        if (responseCode != 200) {
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "utf-8"));
            StringBuilder errorResponse = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                errorResponse.append(line);
            }
            throw new Exception("Google API Error (" + responseCode + "): " + errorResponse.toString());
        }

        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            response.append(line.trim());
        }

        JSONObject jsonResponse = new JSONObject(response.toString());

        // Navigate JSON: candidates[0] -> content -> parts[0] -> text
        return jsonResponse.getJSONArray("candidates")
                .getJSONObject(0)
                .getJSONObject("content")
                .getJSONArray("parts")
                .getJSONObject(0)
                .getString("text");
    }
}
