package com.bytedance.demo;

import android.app.Application;
import android.os.Environment;
import android.widget.Toast;

import com.bytedance.raphael.Raphael;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStreamReader;

public class DemoApp extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        String space = new File(getCacheDir(), "raphael").getAbsolutePath();
        System.out.println("path " + space);
        File file = new File(space);
        file.mkdir();
        file.setExecutable(true,false);
        Raphael.start(Raphael.MAP64_MODE | Raphael.ALLOC_MODE | 0x0F0000 | 1024, space, null);
//      Raphael.start(Raphael.MAP64_MODE|Raphael.ALLOC_MODE|0x0F0000|1024, space, ".*libhwui\\.so$");
    }
}