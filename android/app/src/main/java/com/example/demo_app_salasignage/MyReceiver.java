package com.example.demo_app_salasignage;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import android.widget.Toast;

public class MyReceiver extends BroadcastReceiver {
    private static final String TAG = "MyReceiver";

    @Override
    public void onReceive(Context context, Intent intent) {
        Log.d(TAG, "Received broadcast intent: " + intent.getAction());

        try {
            // Create VIEW intent with sala:// scheme
            Intent viewIntent = new Intent(Intent.ACTION_VIEW);
            viewIntent.setData(Uri.parse("sala://open"));
            viewIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK 
                    | Intent.FLAG_ACTIVITY_CLEAR_TOP
                    | Intent.FLAG_ACTIVITY_SINGLE_TOP);
            
            Log.d(TAG, "Starting view intent with sala:// scheme");
            context.startActivity(viewIntent);
            
            Toast.makeText(context, "Opening Sala via deep link...", Toast.LENGTH_LONG).show();
        } catch (Exception e) {
            Log.e(TAG, "Error starting activity: " + e.getMessage());
            Toast.makeText(context, "Error: " + e.getMessage(), Toast.LENGTH_LONG).show();
            
            try {
                // Fallback to direct launch
                Intent launchIntent = context.getPackageManager().getLaunchIntentForPackage("com.example.demo_app_salasignage");
                if (launchIntent != null) {
                    launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    Log.d(TAG, "Trying fallback launch");
                    context.startActivity(launchIntent);
                    Toast.makeText(context, "Opening Sala (fallback)...", Toast.LENGTH_LONG).show();
                }
            } catch (Exception e2) {
                Log.e(TAG, "Fallback failed: " + e2.getMessage());
                Toast.makeText(context, "All attempts failed", Toast.LENGTH_LONG).show();
            }
        }
    }
} 