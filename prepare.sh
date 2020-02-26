#/bin/sh

if [ -z $1 ]; then
    echo "Please specify path to NVIdia SDK downloads directory"
    echo "eg: ./prepare.sh ~/Downloads/nvidia/sdkm_downloads/"

    exit 1
fi;

L4Tv="32.1.0"
FILE_LIST="cuda-repo-l4t-10-0-local-10.0.166_1.0-1_arm64.deb libcudnn7_7.3.1.28-1+cuda10.0_arm64.deb libcudnn7-dev_7.3.1.28-1+cuda10.0_arm64.deb Jetson-210_Linux_R${L4Tv}_aarch64.tbz2 tensorrt_5.0.6.3-1+cuda10.0_arm64.deb libnvinfer5_5.0.6-1+cuda10.0_arm64.deb libnvinfer-dev_5.0.6-1+cuda10.0_arm64.deb libnvinfer-samples_5.0.6-1+cuda10.0_all.deb python3-libnvinfer_5.0.6-1+cuda10.0_arm64.deb python3-libnvinfer-dev_5.0.6-1+cuda10.0_arm64.deb graphsurgeon-tf_5.0.6-1+cuda10.0_arm64.deb uff-converter-tf_5.0.6-1+cuda10.0_arm64.deb"
DLPATH=$1

if [ ! -f "$DLPATH/Jetson-210_Linux_R${L4Tv}_aarch64.tbz2" ]; then
    echo "L4T files do not exist in specified folder! Exiting..."
fi;

if [ -d ./tmp/ ]; then
    rm -rf ./tmp/
fi

mkdir ./tmp/ 

for FILE in $FILE_LIST
do
    cp "${DLPATH}/${FILE}" ./tmp/
done

tar xjf ./tmp/Jetson-210_Linux_R${L4Tv}_aarch64.tbz2 -C ./tmp/
cp ./tmp/Linux_for_Tegra/nv_tegra/config.tbz2 ./tmp/
cp ./tmp/Linux_for_Tegra/nv_tegra/nvidia_drivers.tbz2 ./tmp/
rm -rf ./tmp/Linux_for_Tegra
rm ./tmp/Jetson-210_Linux_R${L4Tv}_aarch64.tbz2
mv ./tmp/* . && rm -rf ./tmp

echo "********************************************************************"
echo "* Done copying necessary files. You may now build the docker file. *"
echo "********************************************************************"
