#include <jni.h>
#include <string>
#include<android/log.h>
#include "unwind.h"
#include <errno.h>
#include <signal.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <unistd.h>
#include <vector>
#include <jni.h>
#include <jni.h>

void mmapTest() {
    char *mapping = static_cast<char *>(
            mmap(nullptr, 4 * 1025, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
    __android_log_print(ANDROID_LOG_INFO, "hello", "%s", &"jni mmap");
}

void mma(JNIEnv *env, jclass clazz) {
    mmapTest();
//    char *mapping = static_cast<char *>(
//            mmap(nullptr, 4 * 1025, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
    __android_log_print(ANDROID_LOG_INFO, "hello", "%s", &"jni will crash");
}


static const JNINativeMethod sMethods[] = {
        {
                "mma",
                "()V",
                (void *) mma
        }
};

static int registerNativeImpl(JNIEnv *env) {
    jclass clazz = env->FindClass("cn/jiguang/mylibrary/MemoryHookTestNative");
    if (clazz == NULL) {
        return JNI_FALSE;
    }

    if (env->RegisterNatives(clazz, sMethods, sizeof(sMethods) / sizeof(sMethods[0])) < 0) {
        return JNI_FALSE;
    } else {
        return JNI_TRUE;
    }
}

JNIEXPORT jint JNI_OnLoad(JavaVM *vm, void *res) {
    JNIEnv *env = NULL;
    if (vm->GetEnv((void **) &env, JNI_VERSION_1_6) != JNI_OK) {
        return -1;
    }

    if (registerNativeImpl(env) == 0) {
        return -1;
    } else {
        return JNI_VERSION_1_6;
    }
}