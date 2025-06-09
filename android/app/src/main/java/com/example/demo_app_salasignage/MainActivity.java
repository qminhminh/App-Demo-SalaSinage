package com.example.demo_app_salasignage;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    private static final String TAG = "MainActivity";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Set window flags
        getWindow().addFlags(android.view.WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED
                | android.view.WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD
                | android.view.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
                | android.view.WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON);

        // Handle intent that started this activity
        handleIntent(getIntent());
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        Log.d(TAG, "Received new intent");
        setIntent(intent);
        handleIntent(intent);
    }

    private void handleIntent(Intent intent) {
        if (intent == null) {
            Log.e(TAG, "Intent is null");
            return;
        }

        String action = intent.getAction();
        Uri data = intent.getData();
        
        Log.d(TAG, "Handling intent with action: " + action);
        if (data != null) {
            Log.d(TAG, "Intent data: " + data.toString());
        }

        if (Intent.ACTION_VIEW.equals(action) && data != null) {
            String scheme = data.getScheme();
            Log.d(TAG, "Scheme: " + scheme);
            
            if ("sala".equals(scheme)) {
                Log.d(TAG, "Received sala:// deep link");
                
                // Move task to front with new intent
                Intent newIntent = new Intent(this, MainActivity.class);
                newIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK 
                        | Intent.FLAG_ACTIVITY_SINGLE_TOP
                        | Intent.FLAG_ACTIVITY_CLEAR_TOP);
                newIntent.setAction(Intent.ACTION_MAIN);
                newIntent.addCategory(Intent.CATEGORY_LAUNCHER);
                
                Log.d(TAG, "Starting new intent with flags");
                startActivity(newIntent);
            }
        } else {
            Log.d(TAG, "Intent action is not VIEW or data is null");
        }
    }
} 