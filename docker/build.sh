echo 
echo "Build Docker Image"
echo "============================================================"
echo

echo "Org: engjay"
echo "Image: meson-minimal-ti-c28x-cgt"
echo "Version: 0.1.0"

echo

docker build -t ghcr.io/engjay/meson-minimal-ti-c28x-cgt:0.1.0 --progress plain .

echo
