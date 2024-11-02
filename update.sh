#/bin/bash
set -e

new_Ver=$1

docker tag nginx:1.27.2 sunkarisomasekhar/nginx:$new_Ver

docker push sunkarisomasekhar/nginx:$new_Ver

tmp_dir=$(mktemp -d)

echo $tmp_dir

git clone https://github.com/SomasekharSunkari/Argocd-check.git $tmp_dir
# git clone https://github.com/SomasekharSunkari/Argocd-check.git $tmp_dir
# echo "Cloned directory contents:"
# ls -R $tmp_dir # List all contents recursively

sed -i '' -e "s/sunkarisomasekhar\/nginx:.*/sunkarisomasekhar\/nginx:$new_ver/g" $tmp_dir/myapp/1-deployment.yml
cd $tmp_dir
git add .
git commit -m "Update image to $new_ver"
git push

rm -rf $tmp_dir
