#! /bin/bash

function update_gtags() {
	echo "1.generating file list ..."
	rg -g '*.c' \
	   -g '*.cc' \
	   -g '*.cpp' \
	   -g '*.cxx' \
	   -g '*.h' \
	   -g '*.hpp' \
	   -g '*.hxx' \
           -g '*.java' \
	   -g '*.dts' \
	   -g '*.dtsi' \
	   -g '*.conf' \
	   --files \
	   ./vendor/xiaomi/frameworks \
	   ./vendor/xiaomi/proprietary/mivifwk-ishtar \
	   ./vendor/xiaomi/proprietary/dualcamera_cal \
	   ./vendor/xiaomi/proprietary/interfaces \
	   ./vendor/qcom/proprietary/camx-ishtar \
	   ./vendor/qcom/proprietary/camx-common-ishtar \
	   ./vendor/qcom/proprietary/chi-cdk-ishtar \
	   ./vendor/qcom/proprietary/camx-api-ishtar \
	   ./frameworks/av/services/camera/libcameraservice \
	   ./frameworks/av/camera \
	   ./frameworks/base/core/jni \
       ./frameworks/base/core/java/android/hardware \
       ./device/xiaomi \
       ./hardware/libhardware \
       ./hardware/interfaces/camera \
       ./system/core/include \
       ./device/generic/goldfish/camera \
	   > gtags.files
	wc -l gtags.files

	echo "2.updating gtags ..."
	gtags -f ./gtags.files
        #global -L gtags.files -u || gtags
	echo "3.all works done!"
}

time update_gtags
