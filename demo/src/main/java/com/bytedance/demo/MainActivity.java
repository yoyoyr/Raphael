package com.bytedance.demo;

import android.Manifest;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.bytedance.raphael.Raphael;
import com.bytedance.raphael.demo.R;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;

import cn.jiguang.mylibrary.MemoryHookTestNative;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        setContentView(R.layout.main);
        request();
        findViewById(R.id.btn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                MemoryHookTestNative.mma();
                Raphael.print();
            }
        });
        findViewById(R.id.print).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        String space = new File(getCacheDir(), "raphael/report").getAbsolutePath();
                        try {
                            Log.e("", "clcik");
                            BufferedReader reader = new BufferedReader(new FileReader(new File(space)));
                            String readStr;
                            while ((readStr = reader.readLine()) != null) {
                                Log.e("", readStr);
                                Thread.sleep(5);
                            }
                            Log.e("", "clcik");

                        } catch (FileNotFoundException e) {
                            e.printStackTrace();
                        } catch (IOException e) {
                            e.printStackTrace();
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    }
                }).start();
            }
        });
    }

//    private void requestPermission() {
//        if (ActivityCompat.shouldShowRequestPermissionRationale(MainActivity.this, Manifest.permission.WRITE_EXTERNAL_STORAGE)) {
//            Toast.makeText(MainActivity.this, "Please grante write storage permission", Toast.LENGTH_LONG).show();
//        } else {
//            ActivityCompat.requestPermissions(MainActivity.this, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, 1);
//        }
//    }

    private void request() {
        ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.READ_EXTERNAL_STORAGE}, 1);
    }
}