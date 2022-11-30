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

extern "C"
JNIEXPORT void JNICALL
Java_com_bytedance_demo_MemoryHookTestNative_mma(JNIEnv *env, jclass clazz) {
    mmapTest()
}

void mmapTest(){
    char* mapping = static_cast<char*>(
            mmap(nullptr, 4 * 1025, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
    __android_log_print(ANDROID_LOG_INFO, "hello", "%s", &"jni will crash");
}